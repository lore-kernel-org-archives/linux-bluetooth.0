Return-Path: <cyrus@holtmann.org>
Reply-To: <wyrles@ytram.com>
From: "Tom Allebrandi" <wyrles@ytram.com>
To: "'Steffen Becker'" <steffen.becker@tu-ilmenau.de>
Cc: <linux-bluetooth@vger.kernel.org>
References: <4F7349EC.8080706@tu-ilmenau.de> <4F755663.1050508@tu-ilmenau.de> <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E12DC1@048-CH1MPN1-101.048d.mgd.msft.net> <4F75BB73.2010708@tu-ilmenau.de> <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E12E14@048-CH1MPN1-101.048d.mgd.msft.net> <4F7BE3A8.9010801@tu-ilmenau.de> <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E13D11@048-CH1MPN1-101.048d.mgd.msft.net> <4F7C4BCD.6070904@tu-ilmenau.de> <04dd01cd12af$1b279c90$5176d5b0$@ytram.com> <4F7D9848.6060202@tu-ilmenau.de>
In-Reply-To: <4F7D9848.6060202@tu-ilmenau.de>
Subject: RE: problem with ssp debug mode & pand
Date: Fri, 6 Apr 2012 10:00:40 -0700
Message-ID: <026a01cd1416$d11235c0$7336a140$@ytram.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

That is correct behavior. 

SSP Debug Mode was created specifically to allow people to use air sniffers.

Unfortunately, there is no way to know when you are being sniffed, meaning that there is also no way to know if a person who might be sniffing is a friend or foe. SSP Debug Mode defeats the reasons that SSP was created in the first place, so there are some strings attached.

One of those strings is that the debug link keys that result from SSP Debug Mode are not supposed to be persistent. If a host has a debug key in hand that has already been used for LMP Authentication, it is supposed to discard it and pair again.

Debug link keys should always be considered insecure since you don't know who might have been listening during a Debug Mode pairing.

So, you need to always run with SSP Debug Mode enabled, or pair the devices once and enter the link key into the air sniffer.

Cheers!

--- tom

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Steffen Becker
> Sent: Thursday, April 05, 2012 6:04 AM
> To: wyrles@ytram.com
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: problem with ssp debug mode & pand
> 
> To b)
> Thanks, this worked!
> I deleted the file /var/lib/bluetooth/<local-bdaddr>/linkkeys
> then enabled sspdebug and the captures worked!
> But I have a question to that (it's no problem for what I want to do, I'm just
> interested):
> Even if I disable the sspdebug mode and reboot the PCs, and than connect
> again (with disabled SSP debug mode!) the devices ALWAYS create a new
> Link Key. Before I deleted the "linkkeys"-file, the devices used everytime the
> same linkkey from this file. So why is no new "linkkeys"-file being created
> now?
> 
> Cheers,
> Steffen
> 
> 
> Am 05.04.2012 00:05, schrieb Tom Allebrandi:
> > a) Maybe the link key between the devices is not "strong" enough? There
> are three levels of link key:
> >
> > 1) Authenticated - This is the strongest type of key and should be used with
> profiles that carry sensitive data. The SSP process was executed with "man in
> the middle" protection enabled.
> >
> > 2) Unauthenticated - This is a weaker key and should be used with profiles
> where data sensitivity may not be much of an issue. These occur when the
> SSP process was executed with "man in the middle" protection disabled.
> >
> > 3) Debug - The key resulted from executing SSP with debug mode enabled.
> The resulting link key is considered to be unsecure since an unfriendly air
> sniffer could have picked up the data needed to compute the link key.
> >
> > -----
> >
> > b) I've been carrying on a direct conversation with Steffen about getting
> the sniffer working by using the link key. A little while ago I sent him a note
> about SSP Debug Mode and thought that others might find this information
> helpful:
> >
> > SSP stands for Secure Simple PAIRING. It is only used during the pairing
> (aka bonding) process.
> >
> > Here is an important piece of information:
> >
> > 1) SSP Debug Mode is of value when pairing is taking place.
> >
> > 2) SSP Debug Mode is of NO value when NO pairing happens -- in other
> words, the devices are already paired.
> >
> > SSP Debug Mode allows an air sniffer to compute the correct link key
> WHEN IT SNIFFS the pairing operation between two devices. If no pairing is
> sniffed, then the air sniffer has no useful link key and you have to resort to
> other means to get it into the air sniffer -- like entering it manually.
> >
> > So, I would
> >
> > 1) Unpair the devices. You can do this by deleting the stored link key on
> one or both devices.
> > 2) Set sspdebug mode on one or both of the devices;
> > 3) Make sure that the sniffer is running when you pair the devices;
> >
> > (I've forgotten, is there an hciconfig or hcitool subcommand to unpair
> > two devices? I don't have a Linux system handy to check.)
> >
> > If you unpair and then sniff the pairing, the sniffer should have the correct
> link key.
> >
> > Remember
> >
> > 1) One set of au_rand/sres messages in the sniffer trace: No pairing
> occurred.
> > 2)Two sets of au_rand/sres messages in the sniffer trace (one set in
> > each
> > direction): Pairing occurred.
> >
> > That's a quick check to see if the sniffer might have gotten the right
> > link key. (Other important messages may have been missed but at least
> > you know that the sniffer was active during the pairing process.)
> >
> > Of course the best check for having the right link key is if things are being
> decoded properly after encryption is enabled.
> >
> >
> > Cheers!
> >
> > --- tom
> >
> >
> >
> >
> >> -----Original Message-----
> >> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> >> owner@vger.kernel.org] On Behalf Of Steffen Becker
> >> Sent: Wednesday, April 04, 2012 6:26 AM
> >> To: james.steele@accenture.com; linux-bluetooth@vger.kernel.org
> >> Subject: problem with ssp debug mode&  pand
> >>
> >> Now I installed hcidump, hope this helps you supporting me.
> >> So again my 2 problems are:
> >>
> >> a)
> >> pand-connection doesn't work. "Connection refused".
> >> hcidump at the device which is listening when I try to connect:
> >>
> >> <  ACL data: handle 11 flags 0x00 dlen 16
> >>       L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
> >>       Connection refused - security block
> >>
> >>   >  HCI Event: Disconn Complete (0x05) plen 4
> >>       status: 0x00 handle 11 reason 0x13
> >>       Reason: Remote User Terminated Connection
> >>
> >>
> >> I see "security block" but... what can i do?
> >>
> >>
> >> b)
> >> It's possible to create a RFCOMM-connection between two Bluetooth3.0-
> >> Devices. For that I use a Sniffing-Tool (BPA500). When I enter the
> >> Link Key into the sniffing software, the connection can be captured
> >> by the sniffer. But if I don't use the link key and enable the
> >> sspdebug mode instead, the sniffer can't capture it. So maybe
> >> something's wrong with enabling the sspdebug mode.
> >> hcidump when I enable the sspdebug mode:
> >> <  HCI Command: Write Simple Pairing Debug Mode (0x06|0x0004) plen 1
> >>       mode 0x01
> >>   >  HCI Event: Command Complete (0x0e) plen 4
> >>       Write Simple Pairing Debug Mode (0x06|0x0004) ncmd 1
> >>       status 0x00
> >>
> >>
> >> I see "status 0x00", i think that means sspdebug mode is enabled. So
> >> why can't the sniffer capture it?
> >>
> >> If you need more information, just tell me.
> >> Hope someone can help me :-)
> >>
> >> Cheers,
> >> Steffen
> >>
> >>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

