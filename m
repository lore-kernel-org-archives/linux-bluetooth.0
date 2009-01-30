Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <c2a31c480901300157r42a9e8a6w3162b5080f9d634a@mail.gmail.com>
References: <c2a31c480901272116y2bd70ed3yf1c02009c1ec0fd0@mail.gmail.com>
	 <20090128082323.GA8865@jh-x301>
	 <c2a31c480901280142n2cb0c2bbh9eb3a96075d21f21@mail.gmail.com>
	 <20090128112504.GA22536@localhost>
	 <c2a31c480901300157r42a9e8a6w3162b5080f9d634a@mail.gmail.com>
Date: Fri, 30 Jan 2009 17:48:01 +0530
Message-ID: <c2a31c480901300418m39d18545m80d7203d6404c0ef@mail.gmail.com>
Subject: Re: Disconnect eSCO link from Command line
From: sreevani medhahal <sreevani.medhahal@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi ,
> thanks for the kind update
>> On Wed, Jan 28, 2009, sreevani medhahal wrote:
>>> > On Wed, Jan 28, 2009, sreevani medhahal wrote:
>>> >>   After the headset has created the eSCO link. The Profile Tuning
>>> >> Suite asks for Closing the Audio Connection from AG. Is there any
>>> >> command line utiility to disable the eSCO link & not the service level
>>> >> connection(ACL).[The eSCO link is visible on giving hcitool con ]
>>> >
>>> > You can do that by calling the Stop D-Bus method call on the
>>> > org.bluez.Headset interface of the corresponding device object. You can
>>> > e.g. use the test/test-telephony python script for this:
>>> > ./test-telephony stop <remote address>
>>> >
>>> The above method does not close the eSCO link ,because the
>>> sco_connect_cb has reported connection timed out. but the hcitool con
>>> still lists the eSCO link.
>>> I have another query bluez4.2x is compatible with which linux kernel
>>> version. does it have any strict requirement that it works best only
>>> if the kernel version is >= 2.6.27 .
>>
>> You might want to try Marcel's bluetooth-testing tree. I think that
>> issue might be fixed by the following patch:
>> http://git.kernel.org/?p=linux/kernel/git/holtmann/bluetooth-testing.git;a=commitdiff;h=d7461bfbd48bb76a1126a4f05bb16e4bb0187d31
>
> i cannot use the above git tree as i am on ubuntu hardy with kernel
> 2.6.24-19. Is there a repository of bluetooth kernel patches for
> version 2.6.24 . So that i can if any higher versions work for me...I
> am not allowed to use higher kernel versions due to other driver
> dependancy in 2.6.24.

one hack in the net/bluetooth/sco.c by disabling esco on AG ,passes
the PTS tests & the sco_connect does not report connection timed out ,
& now i can use the test-telephony stop to close the sco connection to
the headset.

thanks & regards,
Sreevani
