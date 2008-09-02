Return-Path: <cyrus@holtmann.org>
Message-ID: <5e088bd90809012200t1d4d6d1ft72b32f1593eecdbb@mail.gmail.com>
Date: Mon, 1 Sep 2008 22:00:24 -0700
From: "Steve Sakoman" <sakoman@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Difficulties with hciattach and W2CBW003-001 module
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

I am working to bring up new embedded hardware using the wi2wi
W2CBW003-001 module.

The -001 version of the module communicates via uart at 921600 baud.

My kernel is 2.6.27-rc3 and I am using bluez 3.33.  Kernel options are:

CONFIG_BT=y
CONFIG_BT_L2CAP=y
CONFIG_BT_SCO=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=y
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y

When launching hciattach I get a timeout error:

root@overo:~# hciattach -n ttyS1 csr
Initialization timed out.

By adding a few debug printf's I determined that hciattach is timing
out in read_hci_event waiting for a valid response from the module.

Digging a little deeper I discovered that as the module comes out of
reset it sends 3 valid HCI event packets:

04 0f 04 00 01 00 00
04 30 01 77
04 ff 1b 83 02 00 0d 00 0d 00 00 10 00  00 77 00 03 00 00 f9 01 00 00
00 00 00 00 00 00 00

These are "eaten" by hciattach during its serial port flush
operations.  Then hciattach sends a command to read the build ID of
the module, and the module responds with these 6 bytes:

80, 47, 00, 00, ff,  fc , fc

and then silence.  There is approximately a 2 second delay between the
first fc byte and the second.  Further commands elicit no response.

I don't have specs for the module so I am not able to fully decode all
3 packets the module sends after reset.  The first (Command Status
event) seems to make sense, the second (Encryption Key Refresh
Complete event) seems to not have the right number of parameters, and
the since the third is a vendor specific event I have no clue what it
means :-)

The 6 bytes sent in response to the command seem to make no sense at all.

Any suggestions on where to go from here?  This has me quite baffled!

Steve

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
