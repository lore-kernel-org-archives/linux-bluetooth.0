Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <44508B48.7050105@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Capture HCI traffic between an embeddec BlueCore
 and Host
References: <1146125380.8784.39.camel@localhost>
In-Reply-To: <1146125380.8784.39.camel@localhost>
Content-Type: text/plain; charset=UTF-8
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
Date: Thu, 27 Apr 2006 10:13:44 +0100

Ruud Beukema wrote:
>>>From a CSR powerpoint presentation I found out the BCSP packet header's
> "protocol type nibble" can hold the following values (with their
> meanings):
> Protocol 0 is for ACK=E2=80=99s only
> Protocol 1 is for Link Establishment
> Protocol 5 is for Commands/Events
> Protocol 6 is for ACL Data
> Protocol 7 is for SCO Data
>=20
> The HCI packet types defined are these
> HCI_COMMAND_PKT 0x01
> HCI_ACLDATA_PKT 0x02
> HCI_SCODATA_PKT 0x03
> HCI_EVENT_PKT   0x04
> HCI_VENDOR_PKT  0xFF
>=20
> I have BCSP header information available in my program and I have to
> give this packet type byte a value. The problem here is that when I see
> a protocol 5 (for COMMANDS and EVENTS) I still don't know whether it's =
a
> HCI_COMMAND_PKT or a HCI_EVENT_PKT.

This is easy. Packets going from the host to the controller on channel
5 are commands. Packets going from the controller to the host are
events.

As a double check, HCI commands start with the following byte
sequence:

  opcode_low opcode_high param_len

whereas events start with:

  event_code param_len

So, for commands, the BCSP payload length is payload[2] + 3 whereas for
events it's payload[1] + 2. This can allow you to detect traces which
are the wrong way round.

	- Steven
--=20


To access the latest news from CSR copy this link into a web browser:  ht=
tp://www.csr.com/email_sig.php


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
