Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44826140.5010600@xmission.com>
Date: Sat, 03 Jun 2006 22:27:44 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] ppc aku2 vs. a2recv
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

Hey

I tried a2dp via an unofficial aku2 hack on an imate jamin and things
mostly work with this config. Some of the values below are from the
bitfields (eg subbands)

Channels=2, speed=44100 channel_mode = 2 allocation_method = 1 subbands
= 1 block_length = 1 min_bitpool = 48 max_bitpool = 48

it did bail once with a message

unsupported signalling command: 9

but mostly worked other than that. fwiw, the role switch code bails with
an operation-not-permitted error.

Brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
