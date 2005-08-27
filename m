Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] skype_bt_hijacker released/updated
Message-ID: <20050827193154.GA7618@uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
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
Date: Sat, 27 Aug 2005 21:31:54 +0200


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

I've played around with integrating skype and btsco a little further,
and now it starts making some sense to publish the current state:

First of all, I updated the skype_pickup script at

http://www.acs.uni-duesseldorf.de/~becka/download/skype/skype_pickup.py

It features better parsing of the call IDs (thanks to Whoopie for the
idea) and cooperation with the skype_bt_hijacker library at

http://www.acs.uni-duesseldorf.de/~becka/download/skype/skype_bt_hijacker-0.1b.tgz

it is included in this tarball as well, so no need to download both.


Now what does that stuff do?

I wanted to use my headset as a handsfree unit for skype. Actually 
this works, without any extra software, but it has some inconveniences
for me.

First of all, I don't want to wear the headset all day, just when using
it. Thus I want skype to ring on the speakers, and then switch it over 
to the headset when I want to.

Secondly, I don't even want to leave the headset on all the time. So I
need something that connects the headset when it is available and also
tells the rest of the system about that.

Third I'd like to pick up and hang up calls using the headset buttons.

Forth skype has a nasty programming glitch, which will occasionally hang
it, as it forgets to close down the audio device.


Now how does the skype_bt_hijacker stuff overcome these obstacles?

1. There is a btscorunner script that will in a loop try to find
   a known headset (most headsets are undiscoverable, unless explicitly 
   set to pairing mode) and start up btsco if it does.
   As btsco terminates, if it looses connection, the loop will then
   again seek for the headset.
   I know btsco has the reconnect mode, but that defeats autodetection
   of the channel. Maybe that should be done there. 
   Or maybe it should be done via some kind of Plug'n'Play stuff.
   Comments welcome.

2. A patch to btsco which will create a file for as long as the headset
   is available. This should probably rather be integrated in the
   "action" stuff. I'd suggest to push some fixed strings into the
   action parser (which should be put into its own function for this
   to work nicely) that will cause "system" commands being run via
   .btscorc. This is easier to customize and more generic than my
   simplistic patch.
   I can probably work out a patch for this, but I'd like to hear, if 
   you think it's a worthwhile addition.

3. A LD_PRELOAD-able library that will intercept skype calls to open,
   close, ioctl and write will fix the skype bug and will also allow
   to switch the audio device by just creating or removing a file.
   and running scripts when skype opens or closes its audio device.

4. Skype_pickup, which will be run by .btscorc will handle switching
   the audio device, picking up and hanging up calls.


All in all, it causes the following behaviour:

You just start btscorunner and the skype_bt_hijacker (which starts
skype).

If the configured headset is turned on, btscorunner will fire up btsco 
to link it up.

If skype originates or receives a call, the headset will play a short
ringtone and then skype continues ringing on the main audio device.
You can use it normally there.

However if you press a button on the headset, skype_pickup will either
cause skype to pick up the call and transfer it to the headset, or just
do the latter, if the call is already in progress.

If you press the button again, Skype will be instructed to hang up the
call. If you want to transfer back, you need to remove a file. So if you
have more than one working button on the headset, you can map that
action there as easily.

So if you like that, go ahead, get it, test it, have fun.


CU, Andy

PS: The wrapper might work with other OSS apps, too. So test that, if
    you like.

-- 
= Andreas Beck                    |  Email :  <becka-sig@bedatec.de>         =

--mP3DRpeJDSE+ciuQ
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

--mP3DRpeJDSE+ciuQ--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
