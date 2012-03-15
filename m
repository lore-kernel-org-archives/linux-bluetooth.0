Return-Path: <cyrus@holtmann.org>
From: <james.steele@accenture.com>
To: <steffen.becker@tu-ilmenau.de>
CC: <linux-bluetooth@vger.kernel.org>
Subject: RE: Encrypting problem while sending data via bluetooth
Date: Thu, 15 Mar 2012 11:08:35 +0000
Message-ID: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323DFFD72@048-CH1MPN1-101.048d.mgd.msft.net>
References: <4F60B259.5040800@tu-ilmenau.de>
	<1331747344.14217.105.camel@aeonflux>	<4F61AF8B.3020300@tu-ilmenau.de>
 <CAHBqpz8=MoK9LFMJp1N8K7iv98hCwG3nU47vh9eyNN+AbunLmA@mail.gmail.com>
In-Reply-To: <CAHBqpz8=MoK9LFMJp1N8K7iv98hCwG3nU47vh9eyNN+AbunLmA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steffen

> But now i got another problem regarding to this:
> I use a third PC with the "BPA500" (it's for bluetooth sniffing).
> When i use again the command
>
>
> PC1: # echo "test" > /dev/rfcomm0
>
> then the BPA500 software says:
> "100% Payload/CRC Errors"
> and it can't go after "start_encrypt_req" (that's the last Opcode in the Link
> Management Protocol).
>
> That's why i still think i have an encryption problem.
> But the manpage only shows me how to ENable the encryption.
>
> So i hope somebody can help me a second time.

>From what you've said it appears that there is no problem with encryption - after the start_encrypt_req LMP message if the decoder is failing to decode the sniffed data then that is a good sign that encryption is working correctly.

If you want to decode the encrypted sniffed data then you have to configure your sniffing set-up appropriately.  Normally this requires observing the pairing process so that the sniffer can also compute the link key (and therefore encryption key).  If using Bluetooth v2.0 and earlier you may be able to enter the PIN code you are going to use in the sniffing tool prior to performing pairing.  If using Bluetooth v2.1 and later you will need to configure one of the Bluetooth devices to enter "SSP debug mode".

For the latter (Bluetooth v2.1 and later) case, we have a patch that adds the ability to enable/disable SSP debug mode using the hciconfig tool - I'll push it out to the mailing list as soon as possible, as it appears it would be useful for others.

Regards,
James

________________________________
Subject to local law, communications with Accenture and its affiliates including telephone calls and emails (including content), may be monitored by our systems for the purposes of security and the assessment of internal compliance with Accenture policy.
______________________________________________________________________________________

www.accenture.com

