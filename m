Return-Path: <Steven.Singer@csr.com>
Message-ID: <4064174E.1050409@csr.com>
Date: Fri, 26 Mar 2004 11:43:10 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: zubiwat <zubiwat@poczta.onet.pl>,
   BlueZ Mailing List
    <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Strange answer from HCI
References: <000a01c41299$f48241d0$fcca010a@lysydziadek>
    <1080258434.2283.52.camel@pegasus>
In-Reply-To: <1080258434.2283.52.camel@pegasus>
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Maciej Zubilewicz wrote:
>> I'm programming a microchip to work with BT and when I send some bits
>> I get in the answer sth like this: 04 10 01 FE.
>
> it is all in the Bluetooth HCI specification. You should really read and
> understand it. Your bytes mean
>
> 	HCI event, hardware error, error code 0xfe
>
> The error codes are vendor specific, so I don't know what 0xfe means.

I'm going to take a wild stab in the dark. On CSR devices, hardware
error code 0xfe is used only with the H4 (UART) host transport. It means
that the chip received a message from the host that it couldn't
understand. Typically, it means the message didn't start with 0x01, 0x02
or 0x03. The most common causes of this are a miscalculated (or
mis-encoded) length inside the previous PDU or failing to put the
appropriate H4 prefix on this PDU.

If you were unable to decode even a simple four byte message from the
chip then that indicates you're failing to understand even the basics of
how the protocol works. You need to reread the Bluetooth specifications
for the UART host transport and for the HCI. Until you understand those
you're going to get nowhere.

>> How to set parameteres like pscan or read BD ADDR by sending bits to
>> BT dongle. Does any one knows what bits are coresponding to what
>> commends while setting parameteres of BT because I know bits for
>> transmition from Specification.

This is all completely defined in the Bluetooth specification. The
part you need is only about 250 pages (in the 1.1 spec - you'll
probably get away with just 1.1 at the moment). The full spec is
available for download from https://www.bluetooth.org/spec/ and is
about 7 MB.

Are these really BlueZ questions? It looks to me like you're trying
to write your own host stack. I think you'd be better off finding
another forum.

	- Steven
-- 




**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************
