Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090128082323.GA8865@jh-x301>
References: <c2a31c480901272116y2bd70ed3yf1c02009c1ec0fd0@mail.gmail.com>
	 <20090128082323.GA8865@jh-x301>
Date: Wed, 28 Jan 2009 15:12:17 +0530
Message-ID: <c2a31c480901280142n2cb0c2bbh9eb3a96075d21f21@mail.gmail.com>
Subject: Re: Disconnect eSCO link from Command line
From: sreevani medhahal <sreevani.medhahal@gmail.com>
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,
On Wed, Jan 28, 2009 at 1:53 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Wed, Jan 28, 2009, sreevani medhahal wrote:
>>   After the headset has created the eSCO link. The Profile Tuning
>> Suite asks for Closing the Audio Connection from AG. Is there any
>> command line utiility to disable the eSCO link & not the service level
>> connection(ACL).[The eSCO link is visible on giving hcitool con ]
>
> You can do that by calling the Stop D-Bus method call on the
> org.bluez.Headset interface of the corresponding device object. You can
> e.g. use the test/test-telephony python script for this:
> ./test-telephony stop <remote address>
>
The above method does not close the eSCO link ,because the
sco_connect_cb has reported connection timed out. but the hcitool con
still lists the eSCO link.
I have another query bluez4.2x is compatible with which linux kernel
version. does it have any strict requirement that it works best only
if the kernel version is >= 2.6.27 .
Regards,
Sreevani M
