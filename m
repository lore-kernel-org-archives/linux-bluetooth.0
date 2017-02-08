Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Bose Quiet Comfort 35 Remaining Battery Reporting
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <58989E88.4000005@gmail.com> <5899CA52.8020607@gmail.com>
 <CABBYNZ+Msa3ObRKT-fe70YitPB+OA15hoPcwT2_XSSN8jgAN3g@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Hugues <morisset.hugues@gmail.com>
Message-ID: <589B0EB7.10903@gmail.com>
Date: Wed, 8 Feb 2017 13:27:35 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+Msa3ObRKT-fe70YitPB+OA15hoPcwT2_XSSN8jgAN3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 02/08/2017 10:07 AM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Feb 7, 2017 at 3:23 PM, Hugues <morisset.hugues@gmail.com> wrote:
>> If this isn't the right place, where should I seek for more information ?
>>
>> On 02/06/2017 05:04 PM, Hugues wrote:
>>> Hello,
>>>
>>> I own a Bose QC35 bluetooth headset, sound is working great with
>>> pulseaudio, but the battery reporting does not, I believe it is a
>>> bluetooth issue because the device info doesn't say anything about
>>> battery or power.
>>> Any idea how I can make it report the remaining battery to upower so it
>>> appears in my DE ?
>>>
>>> The device info from bluetoothctl
>>> info 04:52:C7:33:23:6E
>>> Device 04:52:C7:33:23:6E
>>>         Name: BQ35 Hugues
>>>         Alias: BQ35 Hugues
>>>         Class: 0x240418
>>>         Icon: audio-card
>>>         Paired: yes
>>>         Trusted: yes
>>>         Blocked: no
>>>         Connected: yes
>>>         LegacyPairing: no
>>>         UUID: Vendor specific
>>> (00000000-deca-fade-deca-deafdecacaff)
>>>         UUID: Serial Port
>>> (00001101-0000-1000-8000-00805f9b34fb)
>>>         UUID: Headset
>>> (00001108-0000-1000-8000-00805f9b34fb)
>>>         UUID: Audio Source
>>> (0000110a-0000-1000-8000-00805f9b34fb)
>>>         UUID: Audio Sink
>>> (0000110b-0000-1000-8000-00805f9b34fb)
>>>         UUID: A/V Remote Control Target
>>> (0000110c-0000-1000-8000-00805f9b34fb)
>>>         UUID: Advanced Audio Distribu..
>>> (0000110d-0000-1000-8000-00805f9b34fb)
>>>         UUID: A/V Remote Control
>>> (0000110e-0000-1000-8000-00805f9b34fb)
>>>         UUID: Handsfree
>>> (0000111e-0000-1000-8000-00805f9b34fb)
>>>         UUID: PnP Information
>>> (00001200-0000-1000-8000-00805f9b34fb)
>>>         Modalias: bluetooth:v009Ep400Cd0129
> 
> None of these services are specific for fetching battery power, AVRCP
> and HFP do have commands for it but they are very rarely implemented
> but we could indeed use upower to attach the battery information if
> that is implemented.
> 
>>> Regards,
>>> Hugues
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
Thanks for the reply, I know the bose android application do report the
battery power of the headset, but I don't know if it is done in a
propitiatory manner. How could I check that ?
