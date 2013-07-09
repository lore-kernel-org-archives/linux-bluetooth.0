Return-Path: <cyrus@holtmann.org>
Message-ID: <51DBD9BA.10909@linux.intel.com>
Date: Tue, 09 Jul 2013 11:36:58 +0200
From: =?windows-1252?Q?Fr=E9d=E9ric_DALLEAU?=
 <frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 5/8] Bluetooth: Use voice setting in defered SCO connection
 request
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-6-git-send-email-frederic.dalleau@linux.intel.com> <9F18507A-5260-4B81-AF57-0EF2D8BC3A0C@holtmann.org>
In-Reply-To: <9F18507A-5260-4B81-AF57-0EF2D8BC3A0C@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

Le 08/07/2013 21:12, Marcel Holtmann a écrit :
> Hi Fred,

+				__constant_cpu_to_le16(SCO_AIRMODE_TRANSP);
> why do we hardcode here …
>
>> +			cp.retrans_effort = 0x02;
>> +			break;
>> +		case SCO_AIRMODE_CVSD:
>> +			cp.max_latency    = __constant_cpu_to_le16(0xffff);
>> +			cp.content_format = cpu_to_le16(setting);
>
> … and use setting here.
>

SCO_AIRMODE_CVSD needs some additional bits describing Input coding and 
Data format. There is no additional bits for SCO_AIRMODE_TRANSP.

But having it common will fix this ugly line break :)

Fred
