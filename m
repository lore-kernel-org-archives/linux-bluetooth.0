Return-Path: <cyrus@holtmann.org>
From: Tadas Dailyda <tadas@dailyda.com>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 18 Aug 2008 17:31:32 +0300
Message-Id: <1219069892.8801.31.camel@VAIO>
Mime-Version: 1.0
Subject: [Bluez-devel] [GSoC2008] BIP final report
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Intro

This year my project was Extending obex-data-server with partial BIP
support (Image Push and Remote Display features). BIP also defines other
features: Image Pull, Advanced Image Printing, Automatic Archive and
Remote Camera features. AFAIK there are no devices supporting the latter
ones mainly because they were originally targeted at digital cameras and
there were only 2 Bluetooth equipped cameras ever produced (and only one
of them has partial BIP support). This happened because WLAN superseeded
Bluetooth as the wireless solution for digital cameras.

Implementation

BIP client and server side support is now available in obex-data-server
subversion trunk (svn://muiline.com/obex-data-server/trunk). There are
two apps in test directory which can be used for testing.
Fer testing server (Imaging Responder):
ods-server-test.py bip /path/to/dir
For testing client (Imaging Initiator):
ods-bip-test.py <target_bluetooth_addr> <images_to_send>..
Some of options for ods-bip-test are: -p (send in format preferred by
remote device), -r (use Remote Display mode, after sending images remote
display commands can be issued interactively)

Devices

KODAK EasyShare V610
I bought this one in the beginning of summer hoping that it would
support BIP. It turned out to only support OPP which was a total
disappointment.
Sony Ericsson K700i
Surprisingly, some high-end Sony Ericsson phones support BIP (only Image
Push) Imaging Responder. I mostly tested with this one. Phone also has
an interesting feature called "Remote Screen". I was hoping it would use
BIP Remote Display by default, but as it turns out, it used OPP.
Disappointment once again.
Nokia SU-5
This is called Bluetooth Digital Image Viewer. It definitely supports
BIP, but it's not clear what features exactly. Bought it, but it hasn't
shipped yet.
Parrot Photo Viewer
Also definitely supports BIP, but hasn't shipped yet. Never thought I
would by a photo frame, cause it's so lame :D

Some Symbian based phones also support BIP and that's pretty much it.

Outro

obex-data-server BIP support will be available in 0.4 version. There are
still some things to be fixed and a lot of infrastructure changes needed
to be made so we'll have to wait for this release a little bit.


Cheers,
Tadas Dailyda


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
