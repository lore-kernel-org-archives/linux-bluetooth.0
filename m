Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <c9a3e4540606120325q4f460c53l3372d8421cc1ecdd@mail.gmail.com>
References: <c9a3e4540606120325q4f460c53l3372d8421cc1ecdd@mail.gmail.com>
Date: Sat, 17 Jun 2006 12:50:15 +0200
Message-Id: <1150541415.17539.48.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Ethereal/Wireshark support for bluetooth,
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

Hi Ronnie,

> I have modified and checked in most of the protocols from the affix
> patch to ethereal   into the new wireshark svn repository.
> www.wireshark.com

great. Keep on the good work.

> This is support to read hcidump files natively in wireshark and to
> decode the actual packets.

We also need to add support for the BTSnoop format that is also
supported by hcidump and actually preferred over the native hcidump
format.

> Right now what is still remaining and what I would like example
> captures to test with would be
> BNEP: bnep is currently not implemented and I would need some hcidump
> captures with this kind of traffic. Once i have example captures of
> bnep it would be easy to do the required modifications and check in
> support for it.

I have a couple of BNEP capable access points. So if you still need them
then I can take care of that next week when I am back home.

> RFCOMM: rfcomm is implemented   but what is not implemented is the
> de-escaping of ppp and dissection of ppp ontop rfcomm.

Be careful, because you can have also OBEX and a lot of other protocols
on top of RFCOMM. It is not always PPP and only the SDP database knows
what to expect.

> Would someone here have any captures they can share with me so i can
> finish off implementing bnep and rfcomm support in wireshark?
> I would need any capture with bnep traffic  as well as a capture with
> RFCOMM where ppp is transported atop RFCOMM.

Please support Ronnie in sending him sample dumps. Last time I checked I
saw that a lot of Bluetooth 1.2 and 2.0 HCI commands and events are also
not supported. If you see missing HCI decodings please forward him this
dump.

> (you guys should actually talk some with the tcpdump.org people and
> add support four your bluetooth interface to pcap, so that one could
> capture natively from pcap applications such as wireshark, tcpdump
> etc.)

Anybody who wants to look into this?

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
