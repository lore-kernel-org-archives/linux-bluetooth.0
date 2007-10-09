Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <470BB918.5010509@k-i-s.net>
Date: Tue, 09 Oct 2007 19:23:36 +0200
From: Balint Kis <balint@k-i-s.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] A2DP and HFP profiles for bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello Everybody,

I am trying to implement a HFP and a A2DP profile on top of bluez. I did check out the bluez-utils/audio stuff, but I couldn't get it working, so I decided to write my own, and publish it for your review so that you can pull it into bluez if you like it.

The HFP profile is ready, but I failed to get up the L2CAP Transport Layer so I cannot get any audio out of L2CAP socket. My setup is the following:

Device: a2dp capable phone (SonyEricsson W850i and an MDA with windows mobile)
PC: usb bluetooth dongle with latest bluez stack (kernel 2.6.20-2936.fc7xen)

I implemented the L2CAP signaling layer, and the Device hooks up nicely with the PC and starts streaming the audio data. I can see the audio data with hcidump:

> ACL data: handle 1 flags 0x02 dlen 665
    L2CAP(d): cid 0x0041 len 661 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 726 time 9478796 ssrc 1

But I don't know how to extract this data through the L2CAP socket which I opened for signaling. Is there some socket option that I need to set up in order to get the audio data? Or do I need to set up an other socket once the AVDTP state machine enters into OPEN state?

Any help is appreciated!

Many thanks in advance
Balint



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
