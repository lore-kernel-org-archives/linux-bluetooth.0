Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EC6ECAE.3010403@codeaurora.org>
References: <4EC6B482.1070106@codeaurora.org>
	<20111118220848.GA17225@samus.indt.org>
	<CAKT1EBf8cE8=09rqHZR+8xzC3HhsGvWv_BJBBWVKE-=fHB9-Uw@mail.gmail.com>
	<4EC6ECAE.3010403@codeaurora.org>
Date: Sat, 19 Nov 2011 07:28:47 +0200
Message-ID: <CAP2aRG+Wfvs-gEAjR5aKYx1FfMF69LmfMaHgRZnoxEbqUaYDGg@mail.gmail.com>
Subject: Re: [RFC] LE based Remote Name Request
From: Chen Ganir <chen.ganir@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Nov 19, 2011 at 01:39, Brian Gix <bgix@codeaurora.org> wrote:
> Hi Chen, Claudio,
>
> On 11/18/2011 2:30 PM, Claudio Takahasi wrote:
>>
>> Hi Brian/Vinicius,
>>
>> On Fri, Nov 18, 2011 at 7:08 PM, Vinicius Costa Gomes
>> <vinicius.gomes@openbossa.org>  wrote:
>>>
>>> Hi Brian,
>>>
>>> On 11:39 Fri 18 Nov, Brian Gix wrote:
>>>>
>>>> LE does not have a Remote Name Request like BR/EDR has.  It does
>>>> have the ability to fairly efficiently request the remote device
>>>> name, however, which we should implement.  Currently the only
>>>> support we offer for obtaining the remote device name is to pluck it
>>>> out of the Advertising packets (Formatted identically to EIR) which
>>>> works for most devices, but as with BR/EDR, there is no requirement
>>>> that devices include their name in their advertising data.
>>>>
>>>> The Device Name characteristic is Mandatory, and may only exist once
>>>> for a device.  If it is less than 20 bytes may therefore be read
>>>> with a single ReadByType GATT command (uuid16: 0x2a00) over the full
>>>> 1-0xFFFF range. It must also be readable without security, so can be
>>>> done without first going through SMP.
>>>>
>>>> We may not want to featurize this particular functionality at all,
>>>> since all of the components to obtain this info is already
>>>> available: We just need to set up an ATT socket in BlueZ, and make
>>>> the request.  However, when we talk about Scanning for devices, and
>>>> automatically forwarding the Remote Name via a MGMT evevnt, the
>>>> precedence is there to supply it from the kernel.  And if we were to
>>>> go down that path, we would also want to simultaneously offer access
>>>> to the equally Mandatory and Unsecured "Appearance" Characteristic
>>>> (uuid16: 0x2a01) which is LE's sort-of equivilent to the BR/EDR
>>>> Class-Of-Device.
>>>>
>>>> So: What are the feelings about doing Remote Name (And Appearance)
>>>> discovery in the kernel, probably as part of the LE Discovery
>>>> mechanism?  I favor putting it in the kernel, due to the equivalent
>>>> functionality available to BR/EDR there.
>>>
>>> I am in favor of this, more because of the Appearance than the Name
>>> discovery. The Name most well behaved devices will provide through
>>> the Advertising Data, Appearance we can only discover via GATT and
>>> it is very useful for the user.
>>
>> IMO, the first attempt needs to be in the userspace. Name, Appearance
>> and *ServiceChanged* can be read on every reconnection. Appearance
>> will be exposed though adv data also, it is being discussed by the BT SIG.
>>
>> If we implement the characteristic storage properly, I don't think we need
>> to read the Name and Appearance always since it will not change.
>>
>> Another aspect against do it in the kernel as part of the discovery
>> procedure is "connectable and bondable mode", probably we will have
>> problems to re-connect. Peripherals may leave the bondable mode or
>> doesn't send advertises automatically after disconnection.
>
> Those are otherwise good points (not all devices will automatically start
> advertising again) however ServiceChanged should never be attempted to be
> read.  We should only obtain this via an Indication from the remote device,
> and at any rate it is only shared with Trusted devices, so we would have to
> be Bonded.
>
> However, I would definitely NOT try to re-read Name/Appearance at every
> connection.  Those should definitely be cached, and not re-read unless we
> get the ServiceChanged Indication.
>
ServiceChanged is irrelevant here. ServiceChanged will only notify you
if the handles changed, not if the value changed. Name and appearance
can and should be read, since we may get only the short name in the
advertising data, and we wil need the full name. In addition, a device
may change its name, and we will not be notified of this (GAP name
characteristic does not notify/indicate). Name may change just like it
does in BR/EDR.

> Does anyone object to permanently deciding to NOT do Remote Name/Appearance
> request at device discovery time? Or in the kernel at all?  Particularly if
> the SIG is heading towards exposing the Appearance in Advertising data, this
> whole thing becomes nearly moot.  I agree with Chen and Claudio that
> attempting this at Discovery will likely cause the rare IOP problem, and the
> only drawback to Not doing it would be the rare BD Addr and no Appearance
> shown during scanning.
>
> --
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



Chen Ganir
chen.ganir@gmail.com
