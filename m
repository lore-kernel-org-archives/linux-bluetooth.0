Return-Path: <cyrus@holtmann.org>
Message-ID: <540844F1.1070801@tieto.com>
Date: Thu, 04 Sep 2014 12:54:41 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/8] emulator/btdev: Overwrite default feature mask when
 SPP is toggled
References: <1409734969-10716-1-git-send-email-jakub.tyszkowski@tieto.com> <1409734969-10716-5-git-send-email-jakub.tyszkowski@tieto.com> <20140903093938.GA23986@t440s.lan> <540718F0.3070506@tieto.com>
In-Reply-To: <540718F0.3070506@tieto.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 09/03/2014 03:34 PM, Tyszkowski Jakub wrote:
> Hi Johan,
>
> On 09/03/2014 11:39 AM, Johan Hedberg wrote:
>> Hi Jakub,
>>
>> On Wed, Sep 03, 2014, Jakub Tyszkowski wrote:
>>> Without this we cannot test the legacy HID Device reconnection, as L2Cap
>>> connection is refused when SSP is reported in remote device's features.
>>> ---
>>>   emulator/btdev.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/emulator/btdev.c b/emulator/btdev.c
>>> index 86fd3d9..8aebb8f 100644
>>> --- a/emulator/btdev.c
>>> +++ b/emulator/btdev.c
>>> @@ -2332,6 +2332,13 @@ static void default_cmd(struct btdev *btdev,
>>> uint16_t opcode,
>>>               goto unsupported;
>>>           wspm = data;
>>>           btdev->simple_pairing_mode = wspm->mode;
>>> +
>>> +        /* set SSP feature mask */
>>> +        if (wspm->mode)
>>> +            btdev->features[6] |= 0x08;
>>> +        else
>>> +            btdev->features[6] &= ~0x08;
>>> +
>>
>> This looks suspicious to me. The only thing that should matter is
>> whether the host features bit is set on or not. That already looks
>> correct to me in the btdev_get_host_features() function. I.e. isn't your
>> problem with some piece of code higher up in the stack that's not
>> keeping SSP properly disabled? (since what you're now doing is not just
>> disabling SSP but making it look like SSP was never supported to begin
>> with as soon as you disable it).
>>
>> Johan
>>
>
> I'm trying to mimic reconnecting legacy HID device (which was previously
> paired with PIN) to check if security level will be raised when keyboard
> subclass is being found in remotes SDP records. To get the SDP records
> we need to trigger SDP search when remote connects the control channel.
> But we block such incoming connection with 'security block'.
>
> If I get the emulator code right, host and remote uses the same array of
> features which is reason for this patch. When emulated remote tries to
> connect l2cap on PSM other than the SDP one, it's being rejected if it
> reports SSP in features.

Maybe the correct way to fix this is to make remote_features_complete() 
also use btdev_get_host_features() instead of directly copying 
"btdev->conn->features"? With this we wouldn't need to overwrite the 
->features.

Regards,
Jakub

