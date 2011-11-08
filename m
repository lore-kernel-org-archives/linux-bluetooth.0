Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111108085256.GA9733@fusion.localdomain>
References: <1320700419-4665-1-git-send-email-johan.hedberg@gmail.com>
	<1320700419-4665-3-git-send-email-johan.hedberg@gmail.com>
	<4EB86A27.1030403@codeaurora.org>
	<20111108085256.GA9733@fusion.localdomain>
Date: Tue, 8 Nov 2011 07:39:27 -0400
Message-ID: <CAJdJm_NF07-4F+qkdLAbfG-sdXNRmXUY4Bhn9Bk0BrXy9jH3kw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Add address type fields to mgmt messages
 that need them
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan/Brian,

On Tue, Nov 8, 2011 at 4:52 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Brian,
>
> On Mon, Nov 07, 2011, Brian Gix wrote:
>> >+#define MGMT_ADDR_BREDR                     0x00
>> >+#define MGMT_ADDR_LE                        0x01
>> >+#define MGMT_ADDR_BREDR_LE          0x02
>> >+#define MGMT_ADDR_INVALID           0xff
>>
>> What would you think about overloading this Address type with the
>> Public/Random flag?
>>
>> We are already seeing devices in the marketplace with Random
>> Addresses, effectively giving LE addresses 7 significant octets of
>> address information, rather than the standard 6 octet "MAC"
>> addresses.
>>
>>
>> >+
>> >+struct mgmt_addr_info {
>> >+    bdaddr_t bdaddr;
>> >+    __u8 type;
>>
>> I would also support adding an additional octet here, which would be
>> essentially the "Address Type" as used in the HCI LE Connect
>> Command, and in the SMP LE Pairing protocol.

Brian: note that this address type is being used only on mgmt
messages. So it will be mostly useful (in LE context) for discovery
command and events.

For creating connections, we still do not have a way to indicate the
address type from userspace (currently we rely on the advertising
cache).

>> I have stated elsewhere, that I think this to be crucial information
>> to store with Long Term KEYs (LTKs) as well as future LE Signing
>> keys, and in future Address Resolution solutions. The earlier we get
>> this bit of information into the MGMT interface, the better IMO.
>
> This is the same impression I got also when looking into this several
> months ago. Thanks for reminding me!
>
> The BREDR_LE option is there for the updated start_discovery command.
> You'll be able to specify whether you want BR/EDR-only, LE-only or
> interleaved discovery. I wouldn't add a completely new octet for public
> vs random information though but reuse the existing one instead. To be
> able to reuse our address type definitions for all purposes, how about
> making each value orthogonal to the others, e.g.:
>
>        ADDR_BREDR      0x01
>        ADDR_LE_PUBLIC  0x02
>        ADDR_LE_RANDOM  0x04
>
> For events like connected, found, etc you'd only have one of the bits
> set whereas for the start_discovery you could have any (but at least
> one).

Johan: how would link_to_mgmt() in your code work in this case?

I see this will help simplifying how do we identify LE devices on
BlueZ (currently it is done by parsing AD flags, but broken devices
may lack the correct "BR/EDR not supported" flag, and thus we
incorrectly identify then as BR/EDR). Unfortunately, it will still not
allow us to correctly connect to LE devices without relying on the
kernel's advertising cache.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
