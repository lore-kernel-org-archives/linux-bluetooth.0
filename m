Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Matteo Centonza <matteo@sif.it>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1132493286.5669.6.camel@stout.metatype.it>
Mime-Version: 1.0
Subject: [Bluez-users] problems with dtl1_cs
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 20 Nov 2005 14:28:06 +0100

Hi,

i'm using a legacy nokia dtl-4 connectivity card with bluez to link to
my 3g phone (nokia 6680).

The card binds, the pppd link come up, but after few minutes the system
freeze and i need to power cycle the notebook. I haven't been able to
narrow it down to a particular usage pattern. I've not managed to
reproduce in terminal only mode
(no X) but maybe it's probably a matter of time.

After the reset, the syslog shows usually:

Nov 20 10:10:22 stout kernel: dtl1_interrupt: RLSI
Nov 20 10:10:22 stout kernel: rfcomm_recv_frame: bad checksum in packet

but one time:

Nov 19 17:24:08 stout kernel: dtl1_interrupt: RLSI
Nov 19 17:24:08 stout kernel: dtl1_receive: Unknown HCI packet with type
0x13 received


Few specs:
Fedora core 4
kernel 2.6.13-1.1626_FC5

bluez-libs-devel-2.22-1
bluez-pin-0.24-2
bluez-utils-2.22-1
bluez-libs-2.22-1
bluez-bluefw-1.0-6
bluez-hcidump-1.27-1

Thanks for any insight,

-m


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
