Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <c70f1ac50611251559m5d3c5d02n6cd99fb0cbdcc9d3@mail.gmail.com>
Date: Sat, 25 Nov 2006 17:59:53 -0600
From: "Buck Golemon" <workitharder@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <c70f1ac50611251551j2350c812s3d3dd55532c161f@mail.gmail.com>
MIME-Version: 1.0
References: <c70f1ac50611251551j2350c812s3d3dd55532c161f@mail.gmail.com>
Subject: [Bluez-devel] Fwd: Advice on starting BT project
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

We would like to create a system that can emulate AVDTP/A2DP to the
point that you may play MP3 from Windows Media onto a Bluetooth
device.

Does anyone have definate suggestions on how to proceed?

Here's my plan thus far:

>>Obtain a Bluetooth module that implements up to the HCI interface.
I would like to also have the L2CAP and SDP modules in hardware, but
this does not seem to be available as such. Any modules that do
implement these seem to also force you to use the SPP module (LMX9830
for example).

>>Port an early version of the Axis stack to a dsPIC microcontroller.
I am most familiar with the dsPIC and its tools. From what I gather,
the Bluez/Linux kernel driver use threading and Linux-specific code,
so it is easiest to port from the original Axis release. Also I prefer
this approach to a full-fledged embedded Linux for cost and complexity
reasons.

>>Tack onto the driver the bare minimum to establish a connection and
initiate streaming.
The Core, AVDTP, and A2DP specifications are quite detailed and I have
become familiar enough with them that I believe this is possible,
given the correct interface to the lower levels.


Thanks in advance,
Buck Golemon
golemon@uiuc.edu

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
