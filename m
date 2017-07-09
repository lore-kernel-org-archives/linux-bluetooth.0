Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH 4/4] bluetooth: Add HCI_QUIRK_INVALID_BDADDR for
 BCM43430A0
From: Ian Molton <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
References: <20170708161228.24324-1-ian@mnementh.co.uk>
 <20170708161228.24324-4-ian@mnementh.co.uk>
 <F521381C-C901-483E-B84D-0E297A45222C@holtmann.org>
 <eb27abd9-c15a-5204-c5d0-0eea504b0ff4@mnementh.co.uk>
Message-ID: <c170db9b-674a-fd59-4976-1cec316febbf@mnementh.co.uk>
Date: Sun, 9 Jul 2017 10:01:27 +0100
MIME-Version: 1.0
In-Reply-To: <eb27abd9-c15a-5204-c5d0-0eea504b0ff4@mnementh.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Resent [to list only] because Thunderbird insists on converting UTF8
into top bit set ASCII.

 On 08/07/17 18:40, Marcel Holtmann wrote:
> Hi Ian,
> 
>> +#define BDADDR_BCM43430A0 (&(bdaddr_t) {{0xf8, 0x1a, 0x08, 0xca, 
>> 0x25, 0x00}})
> 
> isn't this a valid address? I do not see the point here. At least to
> me this is not one of the Broadcom default addresses that you get
> when no EEPROM address is configured.

 Yeah, this one was sent out by mistake - thats why there are only 3
 patches in the later series you've applied - I managed to test it on
 another device and it turns out that the original code I had was
 changing the bdaddr for no reason - these addresses are valid, as you
 say.

 I have no idea why this used to be set up this way, for some reason
 the init scripts for the device would set the BDADDR up to == the MAC
 of the Ethernet port. I assumed the devices were coming with invalid
 MACs but I was wrong.

 Is it intended behaviour that you cannot change the address via
 btmgmt if the device started with a valid bdaddr? obviously this
 patch is incorrect, but without it, btmgmt public-addr <foo> fails.

 OTOH, bdaddr does not fail - which seems inconsistent to me. Surely
 either both should work, or both fail?

 This brings up a secondary issue - currently, some drivers *need*
 help from userspace to get some things done, but it seems like it
 would be a good idea if we filtered the command stream such that the
 internal state of the device cannot be messed with from userspace,
 except via approved APIs?

 eg. - there is *no* legitimate reason for userspace to send a
 firmware load command to the chip via my driver, since its already
 handled by the kernels firmware mechanism - attempting to do so
 should fail, IMO

 -Ian


