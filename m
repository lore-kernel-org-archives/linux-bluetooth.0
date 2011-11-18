Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111118220848.GA17225@samus.indt.org>
References: <4EC6B482.1070106@codeaurora.org>
	<20111118220848.GA17225@samus.indt.org>
Date: Fri, 18 Nov 2011 19:30:30 -0300
Message-ID: <CAKT1EBf8cE8=09rqHZR+8xzC3HhsGvWv_BJBBWVKE-=fHB9-Uw@mail.gmail.com>
Subject: Re: [RFC] LE based Remote Name Request
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Brian Gix <bgix@codeaurora.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian/Vinicius,

On Fri, Nov 18, 2011 at 7:08 PM, Vinicius Costa Gomes
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

IMO, the first attempt needs to be in the userspace. Name, Appearance
and *ServiceChanged* can be read on every reconnection. Appearance
will be exposed though adv data also, it is being discussed by the BT SIG.

If we implement the characteristic storage properly, I don't think we need
to read the Name and Appearance always since it will not change.

Another aspect against do it in the kernel as part of the discovery
procedure is "connectable and bondable mode", probably we will have
problems to re-connect. Peripherals may leave the bondable mode or
doesn't send advertises automatically after disconnection.

BR,
Claudio

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
