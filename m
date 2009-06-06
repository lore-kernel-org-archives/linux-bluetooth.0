Return-Path: <cyrus@holtmann.org>
Message-ID: <4A2A3D7B.60701@Atheros.com>
Date: Sat, 6 Jun 2009 15:27:15 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "Waldemar.Rymarkiewicz@tieto.com" <Waldemar.Rymarkiewicz@tieto.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>,
	"joakim.xj.ceder@stericsson.com" <joakim.xj.ceder@stericsson.com>,
	"arunkr.singh@stericsson.com" <arunkr.singh@stericsson.com>
Subject: Re: Sim Access profile server implementation
References: <1285657515.12097.7.camel@atheros013-desktop>	 <1286265730.17473.29.camel@aeonflux>	 <99B09243E1A5DA4898CDD8B700111448097D01B371@EXMB04.eu.tieto.com> <1286280767.17473.89.camel@aeonflux> <99B09243E1A5DA4898CDD8B700111448097D01B6CF@EXMB04.eu.tieto.com> <99B09243E1A5DA4898CDD8B700111448097D01B814@EXMB04.eu.tieto.com>
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448097D01B814@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On 10/6/2010 3:02 PM, Waldemar.Rymarkiewicz@tieto.com wrote:
>
> Hi Marcel,
>
>>>
>>> Can you share that code with us. And also hardware if you. We
>> are still
>>> having hard time to find proper hardware to test this on.
>>
>> Will send a patch soon. I use
>> http://www.stericsson.com/platforms/U8500.jsp hw, but need to
>> check if I can share one with you.
>>
>
> Here you are the patch. Just note that it is based on an old bluez 4.4x
> If you consider to accept the design I will update the patch upon the latest release.
>
> Will appreciate any comments.
>
> Thanks,
> /Waldek


Which part of this is the driver and which is the agent here?

If I am not mistaken, you are sending the responses directly from code 
here, how can we extend this to another hardware/agent without source 
code change?

I don't see D-bus being used other than for set/get property.

Correct me if my understanding is wrong.

Regards
Suraj
