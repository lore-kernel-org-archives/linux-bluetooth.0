Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4278DE0C.3070608@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed;
 boundary="------------060709000103060103030209"
Subject: [Bluez-devel] btsco vs. swsusp
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
Date: Wed, 04 May 2005 08:37:00 -0600

This is a multi-part message in MIME format.
--------------060709000103060103030209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hey

Itay was tracking down why he couldn't software-suspend with btsco 
loaded. I wanted to get his result out there in case someone wanted to 
run with it.

I've only used s3 suspend which works as long as the daemon isn't running...

Brad

--------------060709000103060103030209
Content-Type: message/rfc822;
 name="Re: bluetooth-alsa for Debian"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: bluetooth-alsa for Debian"

Envelope-to: bmidgley@xmission.com
Received: from mgr9.xmission.com ([198.60.22.209])
	by mailstore.xmission.com with esmtp (Exim 3.36 #1)
	id 1DT7e4-0002DF-00
	for bmidgley@xmission.com; Tue, 03 May 2005 18:21:44 -0600
Received: from [144.92.166.90] (helo=lcyoung.math.wisc.edu)
	by mgr9.xmission.com with esmtp (Exim 4.44)
	id 1DT7e2-0007c3-SZ
	for bmidgley@xmission.com; Tue, 03 May 2005 18:21:44 -0600
Received: from vv617.math.wisc.edu (vv617.math.wisc.edu [144.92.166.88])
	by lcyoung.math.wisc.edu (8.11.7/8.11.7) with ESMTP id j440JOw07395
	for <bmidgley@xmission.com>; Tue, 3 May 2005 19:19:24 -0500 (CDT)
Received: from pezz by vv617.math.wisc.edu with local (Exim 4.50)
	id 1DT7bo-0004Yg-AB
	for bmidgley@xmission.com; Tue, 03 May 2005 19:19:24 -0500
From: Itay Ben-Yaacov <pezz@math.wisc.edu>
To: Brad Midgley <bmidgley@xmission.com>
In-Reply-To: <4277E170.9030502@xmission.com>
References: <1114729927.10714.4.camel@phichsa.pizzim.org>
	 <42716F39.3060402@xmission.com>
	 <1115150171.10152.4.camel@vv617.math.wisc.edu>
	 <4277E170.9030502@xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: UW Madison Math Dept
Date: Tue, 03 May 2005 19:19:24 -0500
Message-Id: <1115165964.14560.25.camel@vv617.math.wisc.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-UWMath-MailScanner: Found to be clean
Received-SPF: none (mgr9.xmission.com: 144.92.166.90 is neither permitted nor denied by domain of math.wisc.edu) client-ip=144.92.166.90; envelope-from=pezz@math.wisc.edu; helo=lcyoung.math.wisc.edu;
Subject: Re: bluetooth-alsa for Debian
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on mgr9.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=8.0 tests=BAYES_00,
	T_TM2_M_HEADER_IN_MSG autolearn=disabled version=3.0.2
X-SA-Exim-Connect-IP: 144.92.166.90
X-SA-Exim-Mail-From: pezz@math.wisc.edu
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on mgr9.xmission.com)

In fact, I added some debug messaging to the module.
What I gather from that is that when there is nothing happening, the
thread blocks at the wait_event_interruptible(...), which makes sense.
Once swsusp2 starts freezing stuff, the thread unblocks and repeats the
thread main loop up to 

		if (!sock)
			continue;

where it "continue"s back to the beginning.
This loop just repeats itself indefinitely, until the freezer times out
and gives up.
Then swsusp2 prints the following to dmesg:

Software Suspend 2.1.8: Initiating a software suspend cycle.
Stopping tasks failed.
Tasks that refused to be refrigerated and haven't since exited:
 - snd-bt-scod (#19820) signalled but didn't enter refrigerator.
snd-bt-scod   S F705E000     0 19820      1         20337 17497 (L-TLB)
f705fe58 00000046 00000003 f705e000 00000000 00000286 f705fe44 00000286
       00000000 00000000 f4cc35a0 000000a8 78898b98 00000031 d0abb674
d505acec
       d505ac80 f705e000 f705fea0 f8c74ed6 f8c755c0 f705fe84 00200096
f705e000
Call Trace:
 [<f8c74ed6>] snd_card_bt_sco_thread+0x116/0x320 [snd_bt_sco]
 [<c0125ce0>] autoremove_wake_function+0x0/0x50
 [<c0125ce0>] autoremove_wake_function+0x0/0x50
 [<c01457a3>] clear_page_range+0x1b3/0x1f0
 [<c016c18e>] dput+0x1e/0x210
 [<c010ed97>] recalc_task_prio+0x87/0x140
 [<c011481b>] exit_notify+0x2eb/0x820
 [<c011bb51>] free_uid+0x11/0x60
 [<c010f2f5>] schedule_tail+0x15/0x50
 [<c01028f2>] ret_from_fork+0x6/0x14
 [<f8c74dc0>] snd_card_bt_sco_thread+0x0/0x320 [snd_bt_sco]
 [<f8c74dc0>] snd_card_bt_sco_thread+0x0/0x320 [snd_bt_sco]
 [<c0100d3d>] kernel_thread_helper+0x5/0x18
Please include the following information in bug reports:
- SUSPEND core   : 2.1.8
- Kernel Version : 2.6.11-phichsa-5
- Compiler vers. : 3.3
- Attempt number : 4
- Parameters     : 17 2048 0 1 0 5
- Limits         : 262062 pages RAM. Initial boot: 257795.
- Overall expected compression percentage: 0.
- LZF Compressor enabled.
  Compressed 1021337600 bytes into 359458978 (64 percent compression).
- Swapwriter active.
  Swap available for image: 487964 pages.
- Preemptive kernel.
- Highmem Support.


And the btsco thread blocks again at wait_event_interruptible(...).


So, my uneducated guess: swsusp2 sends some freezing signal to the
thread, but that signal is not handled correctly (or at all).  Does this
make any sense?

Also, any idea why does the thread appear three times on the stack?

Cheers,
Itay

--------------060709000103060103030209--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
