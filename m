Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050822185341.GA18549@uni-duesseldorf.de>
References: <20050819193855.GA25514@uni-duesseldorf.de> <43078EF3.4050702@xmission.com> <20050821192634.GA10231@uni-duesseldorf.de> <430954A6.40107@xmission.com> <20050822120911.GA5397@uni-duesseldorf.de> <20050822183820.GA18410@uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
In-Reply-To: <20050822183820.GA18410@uni-duesseldorf.de>
Subject: [Bluez-devel] AGC and anti-noise patch for btsco kernel module
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
Date: Mon, 22 Aug 2005 20:53:41 +0200


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now for the patch (against CVS) described in the previous mail ...

Have fun with it, 

Andy

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="btsco.diff"

Index: btsco.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/kernel/btsco.c,v
retrieving revision 1.6
diff -c -r1.6 btsco.c
*** btsco.c	19 Mar 2005 14:28:59 -0000	1.6
--- btsco.c	22 Aug 2005 18:12:39 -0000
***************
*** 21,26 ****
--- 21,33 ----
   *
   */
  
+ /* Autoadjust mic at most this often in 1/8000s */
+ #define GRABSAMPLES 400
+ /* Maximum push for the mike 16= 1:1 - default 20:1 = 320*/
+ #define COMPRESSION_MAX_16 320
+ /* Minimum push for the mike  1= 1:16*/
+ #define COMPRESSION_MIN_16 1
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
--- 100,108 ----
  	snd_card_t *card;
  	spinlock_t mixer_lock;
  	int mixer_volume[MIXER_ADDR_LAST + 1];
! 	snd_kcontrol_t *mixer_controls[MIXER_ADDR_LAST + 2 + 1];	/* also loopback and agc */
  	volatile int loopback;
+ 	volatile int agc;
  	atomic_t playback_count, capture_count;
  	volatile int count_changed;
  	spinlock_t count_changed_lock;
***************
*** 569,574 ****
--- 577,611 ----
  	return changed;
  }
  
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
+ 
  #define BT_SCO_CONTROLS (sizeof(snd_bt_sco_controls)/sizeof(snd_kcontrol_new_t))
  
  static snd_kcontrol_new_t snd_bt_sco_controls[] = {
***************
*** 580,585 ****
--- 617,629 ----
  	 .info = snd_bt_sco_boolean_info,
  	 .get = snd_bt_sco_loopback_get,
  	 .put = snd_bt_sco_loopback_put,
+ 	 },
+ 	{.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+ 	 .name = "AGC Switch",
+ 	 .index = 0,
+ 	 .info = snd_bt_sco_boolean_info,
+ 	 .get = snd_bt_sco_agc_get,
+ 	 .put = snd_bt_sco_agc_put,
  	 }
  };
  
***************
*** 790,795 ****
--- 834,844 ----
  	struct msghdr msg;
  	struct iovec iov;
  	sigset_t unblocked;
+ 	int i;
+ 	static int factor=16;
+ 	static int maxvalsmoothed=0;
+ 	static int maxvalgrablen=GRABSAMPLES; /* adjust volume at most 4 times/second */
+ 	static int swap=0;
  
  	lock_kernel();
  
***************
*** 839,844 ****
--- 888,954 ----
  		len = sock_recvmsg(sock, &msg, BUF_SIZE, 0);
  		if (len > 0) {
  
+ 			int lostatcnt;
+ 
+ 			lostatcnt=0;
+ 			if (len&1) dprintk("odd len %d\n",len);
+ 			for(i=0;i<len-1;i+=2) {
+ 				short int j;
+ 				int k;
+ 				
+ 				if (swap) j=(buf[i]<<8)|buf[i+1];
+ 				else j=(buf[i+1]<<8)|buf[i];
+ 
+ 				/* occasionally the Headset will loose a byte
+ 				 * on startup. Thus swapping lo/hi.
+ 				 * counting, if _all_ lo bytes (which are 
+ 				 * actually high bytes) are 0 or -1
+ 				 * will detect this with a very high probability
+ 				 */
+ 				if ((j&0xff)==0||(j&0xff)==0xff) {
+ 					lostatcnt++;
+ 				}
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
+ 				buf[i+1]=(k>>8)&0xff;
+ 				buf[i  ]=k&0xff;
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
+ 			}
+ 			if (lostatcnt==len/2&&len>32&&maxvalgrablen>GRABSAMPLES-len) {
+ 				dprintk("SWAP problem detected! Fixing.\n");
+ 				swap=!swap;
+ 			}
  			down(&bt_sco->capture_sem);
  			if (bt_sco->capture) {
  				snd_card_bt_sco_pcm_receive

--tThc/1wpZn/ma/RB--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
