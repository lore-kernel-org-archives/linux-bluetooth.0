Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1236303372.30602.1.camel@localhost.localdomain>
References: <a172fe730903031953r60e50248n5188455d98424e5c@mail.gmail.com>
	 <1236200738.6670.14.camel@localhost.localdomain>
	 <a172fe730903042032q405554f5x924cf1b0d999a2e1@mail.gmail.com>
	 <1236303372.30602.1.camel@localhost.localdomain>
Date: Fri, 6 Mar 2009 10:57:39 +0800
Message-ID: <a172fe730903051857n2bb80733j6984c9d44b62cbf0@mail.gmail.com>
Subject: Re: bluez kernel patch for 2.6.25
From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
      I have migrated 2.6.29 BlueZ driver and protocol to 2.6.25. The
oops is caused by hci_sysfs.c. The majar reason is the arguments of
registing sysfs is different between 2.6.25 and 2.6.27 (or 28/29) in
function hci_register_sysfs and hci_conn_add_sysfs. Thanks for your
help.


2009/3/6 Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
> we don't do top posting on the mailing list. Please respect this and
> follow proper mailing list behavior.
>

I'm sorry for it.

>>      I only charge the bluetooth in my team, and i can't let others
>> migrate their drivers to 2.6.28 or 2.6.29 for me. So, i should proting
>> the lastest bluez drivers and protocol to the current kernel(2.6.25).
>> The bluetooth chipset is stlc2500c. I think the bluez in 2.6.27 is
>> better than 2.6.25, but after porting them to 2.6.25, there's some
>> error such as the listed in the last email. So, i would like to try
>> 2.6.25 first. Thus, is theare a kernel patch for 2.6.25? Thanks.
>
> Sorry, but I don't see how anybody here can help you. If you wanna stick
> with an old kernel that is your choice.
>
> Regards
>
> Marcel
>
>
>

Regards
LeiBian
