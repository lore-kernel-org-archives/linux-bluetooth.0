Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AGC and anti-noise patch for btsco kernel module
Message-ID: <20050823150410.GA6678@uni-duesseldorf.de>
References: <20050819193855.GA25514@uni-duesseldorf.de> <43078EF3.4050702@xmission.com> <20050821192634.GA10231@uni-duesseldorf.de> <430954A6.40107@xmission.com> <20050822120911.GA5397@uni-duesseldorf.de> <20050822183820.GA18410@uni-duesseldorf.de> <20050822185341.GA18549@uni-duesseldorf.de> <430A4D5F.7090201@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
In-Reply-To: <430A4D5F.7090201@xmission.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 23 Aug 2005 17:04:10 +0200


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Brad Midgley <bmidgley@xmission.com> wrote:
> Converting our kernel module to an alsa userspace driver is on the 
> roadmap and I believe your approach could be used there as well.

Yeah. I like such copying-around much better in Userspace. Much less you
can do wrong and _really_ mess things up.

> Marcel will probably ask why we don't fix the problem in the bluez 
> layers if that's where it is, so every SCO app benefits.

He's right. Depending on how the problem is created, my fix is actually
flawed anyway, though it will mask the problem quite well.

I handle it, as if it were an endianness problem. However it is probably 
a loosing data problem. As I just swap endianness, I group the data
wrongly. This is probably only noticeable on high-pitched tones.

Example:

orig data: 1L 1H 2L 2H 3L 3H
lost 1L:      1H 2L 2H 3L 3H
with swap:    2L 1H 3L 2H ...

Thus we will get 1H2L as a value. I group together bytes that don't
belong together.

We really should fix that in the SCO layer if possible.

But I can as well think about a better fix. The downside of a better fix
would be, that I need to keep around a byte for the next round of
copying, as the last byte in a packet and the first in the next form 
a pair.

How does the SCO socket react to short reads? I suppose it would give
1 byte and the 47 on the next, if I tried, right? It will usually 
give out the data packets just as they arrive - right?

In that case I really only see one other fix: keeping around the byte
from the last round.

> Can you surround the adaptive stuff and swapping stuff with two 
> different macros so we can select them independently? Like USE_ADAPTIVE 
> and USE_AUTOSWAP or something?

I have tried that. Attached. It makes the patch rather unwieldy, though,
as I use the same mechanism to efficiently check the swap stuff and 
do the AGC. The patch should work for the none-defined and for the
both-defined case. If it does for mixed cases, I just hope.

I could probably make it more readable at the expense of speed by 
splitting the analysis loop in two.

I'll think about a better swapping fix. Maybe I can make the stuff
nicer to understand as well.

Interim patch attached.


CU, Andy

-- 
= Andreas Beck                    |  Email :  <becka-sig@bedatec.de>         =

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="btsco.diff"

Index: btsco.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/kernel/btsco.c,v
retrieving revision 1.6
diff -c -r1.6 btsco.c
*** btsco.c	19 Mar 2005 14:28:59 -0000	1.6
--- btsco.c	23 Aug 2005 15:01:19 -0000
***************
*** 21,26 ****
--- 21,46 ----
   *
   */
  
+ 
+ /* note: defining these two independently is not tested, 
+  * thus not recommended
+  */
+ 
+ /* enable dynamic compression */
+ #define DYNAMIC_COMPRESSION
+ /* enable automatic endianness fixup */
+ #define AUTO_FIXUP_ENDIANNESS
+ 
+ 
+ #ifdef DYNAMIC_COMPRESSION
+ /* Autoadjust mic at most this often in 1/8000s */
+ #define GRABSAMPLES 400
+ /* Maximum push for the mike 16= 1:1 - default 20:1 = 320 */
+ #define COMPRESSION_MAX_16 320
+ /* Minimum push for the mike  1= 1:16 */
+ #define COMPRESSION_MIN_16 1
+ #endif
+ 
  #define chip_t snd_card_bt_sco_t
  
  #include <sound/driver.h>
***************
*** 93,100 ****
  	snd_card_t *card;
  	spinlock_t mixer_lock;
  	int mixer_volume[MIXER_ADDR_LAST + 1];
! 	snd_kcontrol_t *mixer_controls[MIXER_ADDR_LAST + 2];	/* also loopback */
  	volatile int loopback;
  	atomic_t playback_count, capture_count;
  	volatile int count_changed;
  	spinlock_t count_changed_lock;
--- 113,127 ----
  	snd_card_t *card;
  	spinlock_t mixer_lock;
  	int mixer_volume[MIXER_ADDR_LAST + 1];
! #ifdef DYNAMIC_COMPRESSION
! 	snd_kcontrol_t *mixer_controls[MIXER_ADDR_LAST + 2 + 1];	/* also loopback and agc */
! #else
! 	snd_kcontrol_t *mixer_controls[MIXER_ADDR_LAST + 2 ];	/* also loopback */
! #endif
  	volatile int loopback;
+ #ifdef DYNAMIC_COMPRESSION
+ 	volatile int agc;
+ #endif
  	atomic_t playback_count, capture_count;
  	volatile int count_changed;
  	spinlock_t count_changed_lock;
***************
*** 569,574 ****
--- 596,632 ----
  	return changed;
  }
  
+ #ifdef DYNAMIC_COMPRESSION
+ static int snd_bt_sco_agc_get(snd_kcontrol_t * kcontrol,
+ 				   snd_ctl_elem_value_t * ucontrol)
+ {
+ 	snd_card_bt_sco_t *bt_sco = snd_kcontrol_chip(kcontrol);
+ 	unsigned long flags;
+ 
+ 	spin_lock_irqsave(&bt_sco->mixer_lock, flags);
+ 	ucontrol->value.integer.value[0] = bt_sco->agc;
+ 	spin_unlock_irqrestore(&bt_sco->mixer_lock, flags);
+ 	return 0;
+ }
+ 
+ static int snd_bt_sco_agc_put(snd_kcontrol_t * kcontrol,
+ 				   snd_ctl_elem_value_t * ucontrol)
+ {
+ 	snd_card_bt_sco_t *bt_sco = snd_kcontrol_chip(kcontrol);
+ 	unsigned long flags;
+ 	int changed;
+ 	int agc;
+ 
+ 	agc = !!ucontrol->value.integer.value[0];
+ 
+ 	spin_lock_irqsave(&bt_sco->mixer_lock, flags);
+ 	changed = bt_sco->agc != agc;
+ 	bt_sco->agc = agc;
+ 	spin_unlock_irqrestore(&bt_sco->mixer_lock, flags);
+ 	return changed;
+ }
+ #endif
+ 
  #define BT_SCO_CONTROLS (sizeof(snd_bt_sco_controls)/sizeof(snd_kcontrol_new_t))
  
  static snd_kcontrol_new_t snd_bt_sco_controls[] = {
***************
*** 581,586 ****
--- 639,654 ----
  	 .get = snd_bt_sco_loopback_get,
  	 .put = snd_bt_sco_loopback_put,
  	 }
+ #ifdef DYNAMIC_COMPRESSION
+ 	,
+ 	{.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+ 	 .name = "AGC Switch",
+ 	 .index = 0,
+ 	 .info = snd_bt_sco_boolean_info,
+ 	 .get = snd_bt_sco_agc_get,
+ 	 .put = snd_bt_sco_agc_put,
+ 	 }
+ #endif
  };
  
  int __init snd_card_bt_sco_new_mixer(snd_card_bt_sco_t * bt_sco)
***************
*** 790,795 ****
--- 858,874 ----
  	struct msghdr msg;
  	struct iovec iov;
  	sigset_t unblocked;
+ #if defined(DYNAMIC_COMPRESSION) || defined(AUTO_FIXUP_ENDIANNESS)
+ 	int i;
+ #endif
+ #ifdef DYNAMIC_COMPRESSION
+ 	static int factor=16;
+ 	static int maxvalsmoothed=0;
+ 	static int maxvalgrablen=GRABSAMPLES; /* adjust volume at most 4 times/second */
+ #endif
+ #ifdef AUTO_FIXUP_ENDIANNESS
+ 	static int swap=0;
+ #endif
  
  	lock_kernel();
  
***************
*** 839,844 ****
--- 918,1000 ----
  		len = sock_recvmsg(sock, &msg, BUF_SIZE, 0);
  		if (len > 0) {
  
+ #if defined (AUTO_FIXUP_ENDIANNESS) || defined (DYNAMIC_COMPRESSION)
+ 			int lostatcnt;
+ 			lostatcnt=0;
+ 
+ 			if (len&1) dprintk("odd len %d\n",len);
+ 			for(i=0;i<len-1;i+=2) {
+ 				short int j;
+ 				int k;
+ 				
+ #ifdef AUTO_FIXUP_ENDIANNESS
+ 				if (swap) j=(buf[i]<<8)|buf[i+1];
+ 				else j=(buf[i+1]<<8)|buf[i];
+ #else
+ 				j=(buf[i+1]<<8)|buf[i];
+ #endif
+ 
+ #ifdef AUTO_FIXUP_ENDIANNESS    
+ 				/* occasionally the Headset will loose a byte
+ 				 * on startup. Thus swapping lo/hi.
+ 				 * counting, if _all_ lo bytes (which are 
+ 				 * actually high bytes) are 0 or -1
+ 				 * will detect this with a very high probability
+ 				 */
+ 				if ((j&0xff)==0||(j&0xff)==0xff) {
+ 					lostatcnt++;
+ 				}
+ #endif
+ #ifdef DYNAMIC_COMPRESSION
+ 				/* scale the mic input - we do some kind
+ 				 * of dynamics compression
+ 				 */
+ 				k=((int)j*factor)/16;
+ 				/* clip overshoot. Better than just letting
+ 				 * it wrap around. Immediately adjust factor.
+ 				 */
+ 				if (k>0x7fff) {
+ 					k=0x7fff;
+ 					if (bt_sco->agc&&factor>COMPRESSION_MIN_16) factor--;
+ 				} else if (k<-0x8000) {
+ 					k=0x8000;
+ 					if (bt_sco->agc&&factor>COMPRESSION_MIN_16) factor--;
+ 				}
+ #else
+ 				k=j;
+ #endif
+ 				buf[i+1]=(k>>8)&0xff;
+ 				buf[i  ]=k&0xff;
+ #ifdef DYNAMIC_COMPRESSION
+ 				/* find the highest absolute value in a 
+ 				 * GRABSAMPLES long interval.
+ 				 */
+ 				if (k<0) k=-j;
+ 				if (k>maxvalsmoothed) maxvalsmoothed=k;
+ 				/* if the interval is over, recalculate
+ 				 * the compression factor. Move it slowly.
+ 				 */
+ 				if (maxvalgrablen--<=0) {
+ 					maxvalgrablen=GRABSAMPLES;
+ 					/* If the noise goes up over 1000, we stop
+ 					 * pushing the software gain 
+ 					 */
+ 					if (maxvalsmoothed<1000&&factor<COMPRESSION_MAX_16) {
+ 						factor++;
+ 						// dprintk("Up to %d\n",factor);
+ 					}
+ 					if (!bt_sco->agc) factor=16;
+ 					maxvalsmoothed=0;
+ 				}
+ #endif
+ 			}
+ #ifdef AUTO_FIXUP_ENDIANNESS
+ 			if (lostatcnt==len/2&&len>32&&maxvalgrablen>GRABSAMPLES-len) {
+ 				dprintk("SWAP problem detected! Fixing.\n");
+ 				swap=!swap;
+ 			}
+ #endif
+ #endif /* any of them */
  			down(&bt_sco->capture_sem);
  			if (bt_sco->capture) {
  				snd_card_bt_sco_pcm_receive

--wac7ysb48OaltWcw--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
