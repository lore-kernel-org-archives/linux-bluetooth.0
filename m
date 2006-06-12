Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <c9a3e4540606120325q4f460c53l3372d8421cc1ecdd@mail.gmail.com>
Date: Mon, 12 Jun 2006 10:25:07 +0000
From: "ronnie sahlberg" <ronniesahlberg@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Ethereal/Wireshark support for bluetooth,
	developer needs sample captures
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

Hi again list.

I have modified and checked in most of the protocols from the affix
patch to ethereal   into the new wireshark svn repository.
www.wireshark.com

(wireshark is the new name for ethereal. no drama. simple trademark issue)

This is support to read hcidump files natively in wireshark and to
decode the actual packets.


Right now what is still remaining and what I would like example
captures to test with would be
BNEP: bnep is currently not implemented and I would need some hcidump
captures with this kind of traffic. Once i have example captures of
bnep it would be easy to do the required modifications and check in
support for it.

RFCOMM: rfcomm is implemented   but what is not implemented is the
de-escaping of ppp and dissection of ppp ontop rfcomm.



Would someone here have any captures they can share with me so i can
finish off implementing bnep and rfcomm support in wireshark?
I would need any capture with bnep traffic  as well as a capture with
RFCOMM where ppp is transported atop RFCOMM.


best regards
ronnie s


(you guys should actually talk some with the tcpdump.org people and
add support four your bluetooth interface to pcap, so that one could
capture natively from pcap applications such as wireshark, tcpdump
etc.)


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
