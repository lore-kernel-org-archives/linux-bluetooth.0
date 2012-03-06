Return-Path: <cyrus@holtmann.org>
Message-ID: <4F5610D0.2000304@linux.intel.com>
Date: Tue, 06 Mar 2012 14:27:44 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Mike <puffy.taco@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v7 0/8] Add org.bluez.Telephony interface
References: <1325862475-11607-1-git-send-email-frederic.danis@linux.intel.com> <CAB7rCTiysL9geG266x4U5xaz7ssF8iQbMZ_izAX2CrR8LndeVQ@mail.gmail.com>
In-Reply-To: <CAB7rCTiysL9geG266x4U5xaz7ssF8iQbMZ_izAX2CrR8LndeVQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Mike,

Le 01/03/2012 22:39, Mike a écrit :
> Hello Frédéric,
>
> 2012/1/6 Frédéric Danis<frederic.danis@linux.intel.com>:
>> Hello,
>>
>> This set of patches replaces telephony drivers for HeadSet/HandsFree
>> Profiles by a new DBus interface (org.bluez.Telephony).
>
> What is the status of these patches?  There hasn't been much mailing
> list discussion, so I assume there has been some chatter on IRC?  Do
> these patches simply need testing?
>
> Thanks,
> Mike

This set of patches has been reviewed and seems to be OK.
AFAIK, this change should be integrated in next major release of BlueZ 
(5.0).

I also send RFCs to oFono mailing list, implementing the telephony agent.
This allows me to pass PTS tests. Currently most of tests pass (51), but 
some tests (9) related to audio need some changes in Pulse Audio.

Any comments or tests are welcome.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

