Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
        Nishant Sarmukadam
	<nishants@marvell.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>, Ganapathi Bhat
	<gbhat@marvell.com>
Subject: RE: [PATCH v2] Bluetooth: hci_uart: Support firmware download for
 Marvell
Date: Tue, 1 Mar 2016 17:08:38 +0000
Message-ID: <b7d52fc731a14f28b207ccf4470f6a43@SC-EXCH04.marvell.com>
References: <1455627233-6928-1-git-send-email-akarwar@marvell.com>
 <273F0F9E-5E5C-4F21-A503-027A83B7F61E@holtmann.org>
In-Reply-To: <273F0F9E-5E5C-4F21-A503-027A83B7F61E@holtmann.org>
Content-Type: multipart/mixed;
	boundary="_002_b7d52fc731a14f28b207ccf4470f6a43SCEXCH04marvellcom_"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

--_002_b7d52fc731a14f28b207ccf4470f6a43SCEXCH04marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > +
> > +	kfree(skb);
> > +	BT_INFO("leave dnld_fw\n");
> > +
> > +	return ret;
> > +}
>=20
> I think it would help if you explain on how the firmware download for
> your UART devices work. I have the feeling we need a bit better core
> handling in this case and not end up hacking it in this way.
>=20
> > +

I have explained our firmware download mechanism in attached text file.
I will shortly send V3 patch which address your review comments. Let me kno=
w if you have any suggestions.

Regards,
Amit

--_002_b7d52fc731a14f28b207ccf4470f6a43SCEXCH04marvellcom_
Content-Type: text/plain; name="Marvell_UART_FW_download.txt"
Content-Description: Marvell_UART_FW_download.txt
Content-Disposition: attachment; filename="Marvell_UART_FW_download.txt";
	size=1592; creation-date="Tue, 01 Mar 2016 15:47:40 GMT";
	modification-date="Tue, 01 Mar 2016 15:47:40 GMT"
Content-Transfer-Encoding: base64

RmlybXdhcmUgZG93bmxvYWQgd29ya3Mgb24gdGhlIGZlZWRiYWNrIG1lY2hhbmlzbSBiZXR3ZWVu
CmRyaXZlciBhbmQgdGhlIGRldmljZS4gRm9yIGV2ZXJ5IGNodW5rIG9mIGZpcm13YXJlIGRvd25s
b2FkZWQsCnRoZSBkZXZpY2Ugd2lsbCBzZW5kIGFuIEFDSyBhbmQgYXBwZW5kIHRoZSBuZXh0IGxl
bmd0aCAoaW4gYnl0ZXMpCnRvIGJlIGRvd25sb2FkZWQuIERyaXZlciB3aWxsIGRlY29kZSB0aGlz
IGluZm8gYW5kIGRvd25sb2FkIGJ5dGVzCmFjY29yZGluZ2x5LgoKT24gcG93ZXIgb24sIHRoZSBk
ZXZpY2Ugc3RhcnRzIHNlbmRpbmcgYmVsb3cgaGVhcnRiZWF0IHNlcXVlbmNlOgoKaGVhcnRiZWF0
ICg1IGJ5dGVzKSA6IHxIRFJ8WFh8WFh8WFh8WFh8CgpIRFIgMHhBNTogSGVhZGVyIGluZGljYXRp
bmcgQUNLCgpJZiBIRFIgaXMgQUNLKDB4QTUpIHRoZW4gcmVzdCBvZiB0aGUgYnl0ZXMgYXJlIGRl
Y29kZWQgYXMgYmVsb3c6Cgp8MHhBNXxMMXxMMnxDTDF8Q0wyfAoKTDEgOiBMU0Igb2YgbGVuZ3Ro
IG9mIHRoZSBmaXJtd2FyZSBieXRlcyB0byBiZSBzZW50IGZyb20gdGhlIGhvc3QKTDIgOiBNU0Ig
b2YgbGVuZ3RoIG9mIHRoZSBmaXJtd2FyZSBieXRlcyB0byBiZSBzZW50IGZyb20gdGhlIGhvc3QK
Q0wxOiBDb21wbGVtZW50IG9mIEwxCkNMMjogQ29tcGxlbWVudCBvZiBMMgoKRHJpdmVyIHdpbGwg
ZGVjb2RlIHRoZSBsZW5ndGggZnJvbSBhYm92ZSBzZXF1ZW5jZSBhbmQgZG93bmxvYWQgCmJ5dGVz
IGFjY29yZGluZ2x5LiBEZXZpY2Ugd2lsbCBhY2tub3dsZWRnZSB0aGUgc2FtZSBhbmQgYXBwZW5k
CmxlbnRoIHRvIGJlIGRvd25sb2FkZWQgaW4gbmV4dCB0cmFuc21pc3Npb24uCgpIRFIgMHhBQTog
SGVhZGVyIGluZGljYXRpbmcgY2hpcCBpZCBhbmQgcmV2aXNpb24KSWYgSERSIGlzIGNoaXAgaW5m
bygweEFBKSB0aGVuIHJlc3Qgb2YgdGhlIGJ5dGVzIGFyZSBkZWNvZGVkIGFzIGJlbG93OgoKfDB4
QTV8Q0hJUF9JRHxDSElQX1JFVnxDQ0hJUF9JRHxDQ0hJUF9SRVZ8CgpDSElQIElEICA6IElkIG9m
IHRoZSBjaGlwCkNISVBfUkVWIDogQ2hpcCByZXZpc2lvbgpDQ0hJUF9JRCA6IENvbXBsZW1lbnQg
b2YgY2hpcCBpZApDQ0hJUF9SRVY6IENvbXBsZW1lbnQgb2YgY2hpcCByZXZpc2lvbgoKVGhlIGRl
dmljZSB3aWxsIHN0YXJ0IHNlbmRpbmcgYWJvdmUgMHhBQSBzZXF1ZW5jZSBvbmNlIGhlbHBlcgpm
aWxlIGdldHMgZG93bmxvYWRlZC4gSGVscGVyIGZpbGUgaXMgbmVlZGVkIHRvIG1ha2UgZGV2aWNl
Cndvcmsgd2l0aCBoaWdoZXIgYmF1ZCByYXRlLgoKQWZ0ZXIgZG93bmxvZGluZyB0aGUgaGVscGVy
LCBkcml2ZXIgd2lsbCBjaGFuZ2UgdGhlIGJhdWRyYXRlCmluIGRldmljZSBhbmQgc3RhcnQgZG93
bmxvYWRpbmcgdGhlIGZpcm13YXJlLiBUaGlzIHJlZHVjZXMgdGhlCnRpbWUgbmVlZGVkIHRvIGRv
d25sb2FkIHRoZSBmaXJtd2FyZS4gRm9yIGVhY2ggYmF1ZCByYXRlIHRoZXJlCmV4aXN0cyBkaWZm
ZXJlbnQgaGVscGVyIGZpbGVzLiBJbiB0aGUgZ2l2ZW4gcGF0Y2ggd2UgYXJlCnVzaW5nIGhlbHBl
ciBmaWxlIHdoaWNoIGVuYWJsZWQgZmlybXdhcmUgZG93bmxvYWQgaW4gM01CIHNwZWVkLgo=

--_002_b7d52fc731a14f28b207ccf4470f6a43SCEXCH04marvellcom_--
