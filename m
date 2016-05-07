Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8737pug8ea.fsf@intel.com>
References: <CADrC6Gxef2A=EsVLxG-izD4xBKvrBW85wOzybuZCrr-OL52VSw@mail.gmail.com>
	<8737pug8ea.fsf@intel.com>
Date: Sat, 7 May 2016 07:58:43 +0300
Message-ID: <CADrC6GwdZ7n9jnOvxiOF890yVDL_S5hjCXFrs6gkDt9KT9T2pg@mail.gmail.com>
Subject: Re: bluez dbus ble connection problem when a filter is set
From: =?UTF-8?B?SGFra8SxIEfDtsOnZW/En2x1?= <hakki@bir618.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

pi@raspberrypi:~ $ uname -a

Linux raspberrypi 4.1.19-v7+ #858 SMP Tue Mar 15 15:56:00 GMT 2016
armv7l GNU/Linux

would you need additional info?

On Sat, May 7, 2016 at 12:54 AM, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> Hi hakkig,
>
> Hakkı Göçeoğlu <hakki@bir618.com> writes:
>
>> Hi All,
>>
>> raspberry pi 3
>> bluez v5.39
>> testing platform client/bluetoothctl
>
> Which kernel version are you running?
>
>>
>> I have a ble peripheral device advertising a custom uuid.
>> Within bluetoothctl when I try to connect to it after a filter is set,
>> one third of the time I get an error.
>> There is no problem if no filter is set, turning scanning off before
>> the connect command does not help.
>>
>> Here is an example flow within bluetoothctl
>>
>> [bluetooth]# set-scan-filter-uuids f655b638-fead-4268-b07c-e5d79d09b22b
>> SetDiscoveryFilter success
>> [bluetooth]# scan on
>> Discovery started
>> [CHG] Controller B8:27:EB:37:3F:CD Discovering: yes
>> [NEW] Device CF:05:30:F2:6F:5E CF-05-30-F2-6F-5E
>> [bluetooth]# connect CF:05:30:F2:6F:5E
>> Attempting to connect to CF:05:30:F2:6F:5E
>> [CHG] Device CF:05:30:F2:6F:5E Connected: yes
>> Failed to connect: org.bluez.Error.Failed
>> [CHG] Device CF:05:30:F2:6F:5E Connected: no
>
> I couldn't reproduce this, can you provide the btmon output when this
> happens?
>
>>
>>
>> Any ideas? Thanks in advance, cheers
>>
>> hakkig
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> Cheers,
> --
> Vinicius
