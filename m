Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: rohan16garg@gmail.com
In-Reply-To: <CAEb1Zdj3637etSVcCpLHC_JfR91kpX0eFeNthzRdwHG892s2Jw@mail.gmail.com>
References: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
 <1326705845.6454.274.camel@aeonflux> <1326708597.3360.133.camel@pohly-mobl1.fritz.box>
 <1328439363.32199.20.camel@pohly-mobl1.fritz.box> <1328439464.32199.22.camel@pohly-mobl1.fritz.box>
 <CAEb1ZdjO3W5xUkU3t+CSpVn1u=OCGwBLLeUyvfG-_WMR5AXWxQ@mail.gmail.com>
 <1328441601.321.1.camel@pohly-mobl1.fritz.box> <CAEb1Zdj3637etSVcCpLHC_JfR91kpX0eFeNthzRdwHG892s2Jw@mail.gmail.com>
From: Rohan Garg <rohangarg@ubuntu.com>
Date: Sun, 5 Feb 2012 17:53:24 +0530
Message-ID: <CAEb1Zdhr7x9GPru_XvaTG=rVuWwJWiCFEpXO81+bRhk-dJogNA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth.h: fix compile issue in C++ with ifdef
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Milan Crha <mcrha@redhat.com>, ying.an.deng@intel.com, ulf.hofemeier@intel.com,
	ning.w.wang@intel.com, Tino Keitel <tino.keitel+syncevolution@tikei.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Seems like your patch causes a build failiure : http://paste.ubuntu.com/829971/

Best
Rohan Garg



On Sun, Feb 5, 2012 at 5:03 PM, Rohan Garg <rohangarg@ubuntu.com> wrote:
> Ah, understood :)
>
> Best
> Rohan Garg
>
>
>
> On Sun, Feb 5, 2012 at 5:03 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
>> On Sun, 2012-02-05 at 16:37 +0530, Rohan Garg wrote:
>>> I've not gone through the entire patch, but if the problem is merely
>>> the fact that one cannot convert a void* to anything in C++, why not
>>> use a static_cast in syncevolution wherever the struct is used?
>>
>> The problem is not in the way how SyncEvolution uses the structs. The
>> problem is in the header files; it also occurs in any other C++ app
>> including the bluetooth.h file.
>>
>> --
>> Best Regards, Patrick Ohly
>>
>> The content of this message is my personal opinion only and although
>> I am an employee of Intel, the statements I make here in no way
>> represent Intel's position on the issue, nor am I authorized to speak
>> on behalf of Intel on this matter.
>>
>>
