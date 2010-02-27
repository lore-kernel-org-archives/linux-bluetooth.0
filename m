Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1265396410.615373.5159.nullmailer@galant.ukfsn.org>
References: <f6c5b8d91001170441m1d0d8755x15147f92b85b477f@mail.gmail.com>
	 <f6c5b8d91001170450n415bf083l5044e193014d8f85@mail.gmail.com>
	 <1263760863.5591.59.camel@localhost.localdomain>
	 <f6c5b8d91001172139q5f23201fnd2ab2193ebc9a33f@mail.gmail.com>
	 <1264261518.596186.16656.nullmailer@galant.ukfsn.org>
	 <f6c5b8d91002050759s3968fa13ka3ee4bfaab4b8b4@mail.gmail.com>
	 <1265396410.615373.5159.nullmailer@galant.ukfsn.org>
Date: Sun, 28 Feb 2010 01:12:27 +0530
Message-ID: <f6c5b8d91002271142u32966edbga0beea9a9b6060a8@mail.gmail.com>
Subject: Re: A2DP multiple sink support
From: Anil Sasidharan <anilvpr@gmail.com>
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Feb 6, 2010 at 12:30 AM, Iain Hibbert <plunky@rya-online.net> wrote:
> On Fri, 5 Feb 2010, Anil Sasidharan wrote:
>
>> Thanks a lot for the inputs. Based on this I've tried some experiments.
>> 1. A2DP src has been paired and connected to the A2DP sink
>> 2. While the connection with first SINK is active, I've tried to pair
>> and connect to another A2DP sink
>> 3. Pairing with the second SINK gets done, however while trying to
>> connect I'm encountering an error from D-Bus "Stream Setup Failed".
>> What could be wrong
>>
>> It would be really great if you could throw some light on this. BTW
>> I'm using Bluez v3.36
>
> Anil I can throw no more light on that as I don't use BlueZ at all. And, I
> think the only advice you will get on that list is to try the latest BlueZ
> version..  they don't really provide support for outdated versions.
>
> regards,
> iain
>
>
>

Hi Iain,

          Thanks for the inputs. I was able to resolve the "Stream
Setup" error and got the connection established with 2 SNKs. However
while trying stream audio to the second SNK, I'm not getting any
audio-output though the debug messages shows that the AVDTP sends out
"audio chunks". Any thoughts?

Warm Regards,
Anil
