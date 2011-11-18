Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111118220848.GA17225@samus.indt.org>
References: <4EC6B482.1070106@codeaurora.org>
	<20111118220848.GA17225@samus.indt.org>
Date: Sat, 19 Nov 2011 00:30:12 +0200
Message-ID: <CAP2aRG+ucEsp0MOKs+r7ZcmWT8WvzNYu+BtyBDisu3FTVs5E3Q@mail.gmail.com>
Subject: Re: [RFC] LE based Remote Name Request
From: Chen Ganir <chen.ganir@ti.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Brian Gix <bgix@codeaurora.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Brian, Vinicius,

On Sat, Nov 19, 2011 at 00:08, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Brian,
>
> On 11:39 Fri 18 Nov, Brian Gix wrote:
>>
>> LE does not have a Remote Name Request like BR/EDR has.  It does
>> have the ability to fairly efficiently request the remote device
>> name, however, which we should implement.  Currently the only
>> support we offer for obtaining the remote device name is to pluck it
>> out of the Advertising packets (Formatted identically to EIR) which
>> works for most devices, but as with BR/EDR, there is no requirement
>> that devices include their name in their advertising data.
>>
>> The Device Name characteristic is Mandatory, and may only exist once
>> for a device.  If it is less than 20 bytes may therefore be read
>> with a single ReadByType GATT command (uuid16: 0x2a00) over the full
>> 1-0xFFFF range. It must also be readable without security, so can be
>> done without first going through SMP.
>>
>> We may not want to featurize this particular functionality at all,
>> since all of the components to obtain this info is already
>> available: We just need to set up an ATT socket in BlueZ, and make
>> the request.  However, when we talk about Scanning for devices, and
>> automatically forwarding the Remote Name via a MGMT evevnt, the
>> precedence is there to supply it from the kernel.  And if we were to
>> go down that path, we would also want to simultaneously offer access
>> to the equally Mandatory and Unsecured "Appearance" Characteristic
>> (uuid16: 0x2a01) which is LE's sort-of equivilent to the BR/EDR
>> Class-Of-Device.
>>
>> So: What are the feelings about doing Remote Name (And Appearance)
>> discovery in the kernel, probably as part of the LE Discovery
>> mechanism?  I favor putting it in the kernel, due to the equivalent
>> functionality available to BR/EDR there.
>
> I am in favor of this, more because of the Appearance than the Name
> discovery. The Name most well behaved devices will provide through
> the Advertising Data, Appearance we can only discover via GATT and
> it is very useful for the user.
>
>>
>> Also, there is no coincidence that I offer this RFC at the same time
>> as I bring up the Write Signed Command functionality from earlier
>> today. Both concern usages of GATT (or at least ATT) in a way not
>> currently supported. It is also a case where ideally, we would use a
>> low-latency connect-read-disconnect methodology.
>>
>> --
>> Brian Gix
>> bgix@codeaurora.org
>> Employee of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> Cheers,
> --
> Vinicius
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

I really do not think this is a good idea. Forcing a connection while
scanning for devices is not a good idea for LE devices, which may
require a push button or some other user intervention to get
discoverable/connectable. Trying to connect to it while scanning may
cause it to stop being discoverable/connectable (if the device does
not become discoverable after disconnection), which will result in the
device either becoming non connectable, or require the user to press
the button again, which is making things more difficult and
complicated. I would suggest relying on the advertising data, and get
the remote name, or every other GAP related GATT characteristics once
a connection is established for the purpose it was supposed to be.

Best regards,
Chen Ganir
