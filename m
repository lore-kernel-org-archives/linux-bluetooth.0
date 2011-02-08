Return-Path: <cyrus@holtmann.org>
Message-ID: <4D51AE5C.5020006@codeaurora.org>
Date: Tue, 08 Feb 2011 12:58:04 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Read Characteristic Value vs. Read Long Characteristic Values
References: <AANLkTikrjgmAK9pzoJtnNJwQHraiaCnb8XVP55gAEKeH@mail.gmail.com>	<1295984785.2656.98.camel@ubuntuLab1>	<AANLkTi=4HoUKdda-GCrTQEtLSScuxB4D+btoRy+QsMG_@mail.gmail.com>	<AANLkTi=gZQ2Ps2yoXT7+08E3AruB5pAAy+ib+wBcQY4S@mail.gmail.com>	<1296064762.2656.137.camel@ubuntuLab1>	<AANLkTinbmiew-MBN7PxK5ePuObzBbHbqdteaB2nS3nty@mail.gmail.com>	<1296071867.2656.202.camel@ubuntuLab1> <AANLkTi=6fNu_2jH8_KijR-a_U+DbkRiz6C667N7NBQLV@mail.gmail.com>
In-Reply-To: <AANLkTi=6fNu_2jH8_KijR-a_U+DbkRiz6C667N7NBQLV@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On 2/8/2011 12:46 PM, Anderson Lizardo wrote:
> Hi Brian,
>
> On Wed, Jan 26, 2011 at 4:57 PM, Brian Gix<bgix@codeaurora.org>  wrote:
>> I will talk to the PTS guys at UPF, and make sure that the PIXIT lists
>> are setup such that the tests required for qualification correctly
>> mandate the correct subset of test cases as required by the ruling
>> specification.
>
> Did you manage to get some input from PTS guys on these tests? I did
> not check the recently released 4.2.0 yet.
>
> Regards,


I was talking to the guy who wrote most of the GATT tests, and he said 
that the test for "Read Long" in particular should Pass wether it was 
initiated with a standard READ or READ_BLOB.  He said that if the test 
does not work that way, to send him a PTS log of the particular test 
session that did not work as expected (that test or any other).

I will try to get the exact email address to use for PTS log submissions 
and get back to you.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
