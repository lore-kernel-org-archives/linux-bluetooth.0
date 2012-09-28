Return-Path: <cyrus@holtmann.org>
Message-ID: <506599BD.4000006@linux.intel.com>
Date: Fri, 28 Sep 2012 14:36:13 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Convert storage to use per-remote device directories
References: <50642389.40107@intel.com> <20120928093729.GA1415@x220>
In-Reply-To: <20120928093729.GA1415@x220>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

On 28/09/2012 11:37, Johan Hedberg wrote:
<snip>
>> So the directory structure should be:
>>     /var/lib/bluetooth/<adapter address>/
>>         ./config
>>         ./<remote device address#type>/
>>             ./config
>>             ./linkkey
>>         ./<remote device address#type>/
>>             ./config
>>             ./linkkey
>>         ...
>
> So far this all looks good, though maybe we should follow the convention
> of having .conf suffixes like with our other INI files. Or maybe that's
> not needed?

OK, I will rename adapter config file to adapter.conf, and device config 
file to device.conf.

>> I attached sample of adapter and device config files.
>
>> [adapter]
>> name=desktop-0
>> class=0x780011
>> pairable=yes
>> onmode=discoverable
>> mode=discoverable
>
> I hope you've looked at our existing INI files like audio.conf and
> main.conf. You should have noticed that we use CamelCase for the section
> and variable names, so at least that needs fixing.

OK, I will do this.

>> [device]
>> name=MyPhone
>> alias=Fred's phone
>> class=0x180204
>> device_id=FFFF 0000 0000 0000
>> eir=040D040218
>> manufacturer=15
>> lmp_version=2
>> lmp_subversion=777
>> features=FFFE0D0008080000
>> lastseen=2012-09-26 11:19:40 GMT
>> lastused=2012-09-26 11:43:42 GMT
>> trusted=yes
>> profiles=00001101-0000-1000-8000-00805f9b34fb;00001103-0000-1000-8000-00805f9b34fb
>>
>> [00001101-0000-1000-8000-00805f9b34fb]
>> handle=10001
>> record=35470900000A000100010900013503191101090004350C350319010035051900030802090005350319100209000935083506191101090100090100250C53657269616C20506F727400
>>
>> [00001103-0000-1000-8000-00805f9b34fb]
>> handle=10002
>> record=35530900000A000100020900013503191103090004350C35031901003505190003080309000535031910020900093508350619110309010009010025134469616C2D7570204E6574776F726B696E67000903052800
>
> This looks ok too, except for the lack of CamelCase naming. One of the
> most interesting files I was waiting to see is the linkkey one since in
> the existing storage we've crammed lots of separate variables into the
> same entry. Could you send a proposal for this too in your next
> revision? Since we also need storage for LTK's maybe it'd make sense to
> have a single "keys" file with [LinkKey] and [LongTermKey] sections? Or
> do you think those should be separate files?

Current linkkeys file is only accessible by root, this is why I kept it 
separated.
Should LTKs be world readable or only accessible by root ?

Keys file should be named keys.conf and looks like:

[LinkKey]
Key=9EF4BDFA68C5438A176DF42ACD59816C
Type=0
Length=4

[LongTermKey]
Key=
Authenticated=
EncSize=
EDiv=
Rand=

> Also, it seems you've left out all LE-specific information from this
> initial proposal, like the conversion of the existing primaries file.

Currently I do not have LE devices, so I am not sure of what should be 
LE-specific infos.

I need to dig into it before I send a new proposal.

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

