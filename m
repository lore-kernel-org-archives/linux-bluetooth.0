Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44BF9B15.1020607@uen.org>
Date: Thu, 20 Jul 2006 09:02:45 -0600
From: Brad Midgley <bmidgley@uen.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] verizon locking out dialout linux
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Guys,

Verizon Wireless here in the US is intentionally locking out linux and
other standards-based clients from its dialup networking. There may be a
technical solution, like ignoring sdp and scanning for open rfcomm
channels but I really would rather have them give me back the feature.
I'm really bugged.

In any case, bluetooth.org shouldn't let them advertise this as the
bluetooth dialup profile! This is the message as I sent to the
bluetooth.org "contact us" page:

=======================================================================

Verizon Wireless (VZW) advertises the use of Bluetooth Dialup Networking
profile but in many cases substitutes a proprietary protocol.

The profile is mentioned by name here:

http://support.vzw.com/faqs/Bluetooth/faq.html#item13

excerpt:
======================================================================
What is the Bluetooth Dial-up Networking (DUN) profile?

The Bluetooth dial-up networking profile allows the use of the Bluetooth
handset as a modem (please consult the Bluetooth functionality charts to
see if a specific Verizon Wireless device supports Bluetooth DUN). In
this configuration, Bluetooth acts as a replacement for the cable that
is used to connect the computer to the handset in tethered mode. The
user has several steps to take before Bluetooth dial-up networking can
occur:

   1. The laptop/computer must have Bluetooth capability (typically by
using a PCMCIA card or USB dongle for hardware and the associated
Bluetooth client for software).
   2. The laptop/computer must be paired to the handset
   3. A dial-up networking profile must be created on the
laptop/computer (e.g., manually created using the Microsoft wizard or
automatically created by the VZAccess client software).
======================================================================

and relates that to support in several of its phones:

http://dts.vzw.com/pdf/BT_Chart_Handsets.pdf

However, on a growing body of their phones, what they are actually
offering is a proprietary networking protocol that requires the use of
VZW's "VZAccess" software. Standards-based implementations of the dialup
profile client will not be able to connect.

I discovered this after an upgrade to the latest software version for
the VZW-branded Motorola e815. Before the upgrade, the phone supported
the dialup profile perfectly but now the phone does not even properly
advertise SDP records for the dialup profile. "Mike" in the VZW level-2
data services group was able to confirm that standards-based dialup was
intentionally disabled.

Obviously this situation dilutes the strength of the Bluetooth
trademark. Please encourage them to come up with a new term for their
proprietary wireless networking protocol or bring their phones back into
technical compliance.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
