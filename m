Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMPA5gfZg+7UGdKiwnumTHbeL6y32aYmo0DoHnoaRbDyj-S5SQ@mail.gmail.com>
References: <D1972028.9E66%dacullen@cisco.com>
	<CABBYNZ+6+KV4Arfr4wAVra4_GXk9WMQy7WPVrqEjyiF+Zz1WZw@mail.gmail.com>
	<CAMPA5gfZg+7UGdKiwnumTHbeL6y32aYmo0DoHnoaRbDyj-S5SQ@mail.gmail.com>
Date: Fri, 5 Jun 2015 14:07:03 -0400
Message-ID: <CAMPA5gfd2hbGoekW1VCkSyXtjK8p2Czm5MsjBBUXGDf+19Q90w@mail.gmail.com>
Subject: Re: Distro for Bluez Development
From: Joshua Kramer <joskra42.list@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am working on an embedded device.  So, I have a custom-built image
on my Raspberry Pi 2 that consists of RedSleeve Enterprise Linux 7 and
a hard real-time kernel that I took from Emlid.  RedSleeve is a
rebuild of RHEL for 32 bit ARM architectures; there is a version of
both EL6 and EL7.

I am not hacking the latest Bluez code.  And I'm not using the version
that is included with the distro.  However, BlueZ 5.30 seems to work
great with this combo.

On Fri, Jun 5, 2015 at 2:05 PM, Joshua Kramer <joskra42.list@gmail.com> wrote:
> I am working on an embedded device.  So, I have a custom-built image
> on my Raspberry Pi 2 that consists of RedSleeve Enterprise Linux 7 and
> a hard real-time kernel that I took from Emlid.  RedSleeve is a
> rebuild of RHEL for 32 bit ARM architectures; there is a version of
> both EL6 and EL7.
>
> I am not hacking the latest Bluez code.  And I'm not using the version
> that is included with the distro.  However, BlueZ 5.30 seems to work
> great with this combo.
>
> On Fri, Jun 5, 2015 at 10:13 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi David,
>>
>> On Fri, Jun 5, 2015 at 4:45 PM, David Cullen (dacullen)
>> <dacullen@cisco.com> wrote:
>>> Hello, Folks,
>>>
>>> What distros do people use for working with the latest bluez code?
>>
>> Im using fedora 21, but with custom kernel image, for the userspace
>> part the distro should not matter much since you can compile and run
>> directly from source.
>>
>>
>> --
>> Luiz Augusto von Dentz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
