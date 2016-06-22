Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGMMcjSQdoXd=W+mSO+xVV1Gwqrcc0+x=2PSZX3V+vEi2Q@mail.gmail.com>
References: <CAEZxfGOiiBs_eCGsgsm=CvoJSsGtEsFENr8uxEbzSnt400f6qg@mail.gmail.com>
 <CAEZxfGMMcjSQdoXd=W+mSO+xVV1Gwqrcc0+x=2PSZX3V+vEi2Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Jun 2016 12:48:48 +0300
Message-ID: <CABBYNZLz5yYDFb-GjoZbSPHyrBsEBBw0Vr9WgtEAKfqnF=31Kg@mail.gmail.com>
Subject: Re: Cached device in a weird place
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François,

On Tue, Jun 21, 2016 at 11:34 PM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> And sometimes, when I run "remove *" command and make sure "devices"
> returns nothing, I still can see this device in
> /var/lib/bluetooth/A4\:17\:31\:78\:A6\:04/.
> Any idea?

This is an adapter storage, the information of the controller is
persisted so once you plug it back it restores the last configuration
so I guess you don't really want to remove adapters just devices.

> On Tue, Jun 21, 2016 at 10:27 PM, François Beaufort
> <beaufort.francois@gmail.com> wrote:
>> As I was explaining to sjanc in #bluez, I've noticed some weird
>> behaviour regarding some cached device and I think I found one reason
>> today.
>> As you can see below, a device called tis9E is found in "devices"
>> command while I have removed all devices with "remove *" command
>> previously and not seen this device for a long time.
>>
>> I wonder now where this comes from.
>> How such an old device would come back from the dead like that?
>>
>> Thanks in advance,
>> Francois.
>>
>> ---
>>
>> localhost / # bluetoothctl
>> [NEW] Controller A4:17:31:78:A6:04 Chromebook_0A65 [default]
>> [NEW] Device C7:78:B4:5F:FA:DF tis9E
>> [bluetooth]# devices
>> Device C7:78:B4:5F:FA:DF tis9E
>>
>> ---
>>
>> localhost bluetooth # more
>> /var/lib/bluetooth/A4\:17\:31\:78\:A6\:04/C7\:78\:B4\:5F\:FA\:DF/info
>> [General]
>> Name=tis9E
>> AddressType=static
>> SupportedTechnologies=LE;
>> Trusted=false
>> Blocked=false
>>
>> ---
>>
>> localhost bluetooth # more
>> /var/lib/bluetooth/A4\:17\:31\:78\:A6\:04/cache/C7\:78\:B4\:5F\:FA\:DF/
>> more: stat of /var/lib/bluetooth/A4:17:31:78:A6:04/cache/C7:78:B4:5F:FA:DF/
>> failed: No such file or directory
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
