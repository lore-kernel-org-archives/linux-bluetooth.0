Return-Path: <cyrus@holtmann.org>
Message-ID: <4F1FB808.8000400@invoxia.com>
Date: Wed, 25 Jan 2012 09:06:32 +0100
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Dmitriy Paliy <dmitriy.paliy@nokia.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 0/4] Add hciops_allow_sniff to disable and restore
 LMP_SNIFF bit
References: <1327409936-6709-1-git-send-email-dmitriy.paliy@nokia.com> <CABBYNZJ99t68PrYwi57KPuJXrJpu76Rt-6KNwwZuxwy39uA8GA@mail.gmail.com>
In-Reply-To: <CABBYNZJ99t68PrYwi57KPuJXrJpu76Rt-6KNwwZuxwy39uA8GA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Indeed, the kernel has already something to manage sniff mode 
automatically, especially when SCO is part of the question:
  get a look at:
     /sys/class/bluetooth/hci0/idle_timeout
     /sys/class/bluetooth/hci0/sniff_min_interval
     /sys/class/bluetooth/hci0/sniff_max_interval

arnaud


On 01/24/2012 02:23 PM, Luiz Augusto von Dentz wrote:
> Hi Dmitriy,
>
> On Tue, Jan 24, 2012 at 2:58 PM, Dmitriy Paliy<dmitriy.paliy@nokia.com>  wrote:
>> Hi,
>>
>> The following set of patches introduces disabling/enabling sniff bit
>> in link policy settings. Further, the sniff mode is than disallowed
>> while SCO channel is open.
>>
>> This helps to avoid problems in instability in some of TI controllers
>> firmware when sniff request comes from remote device during an active
>> call. Real impact is that controller becomes unconnectable eventhough
>> page scan is enabled.
>>
>> Any comments, and possibly ideas, would be highly appreciated.
> It looks like we would need a new command/operation to support it on
> mgmt which is not addressed by your patches, in the other hand perhaps
> this could be done automatically by the kernel when SCO is active.
>

