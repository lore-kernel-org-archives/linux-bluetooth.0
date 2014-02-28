Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OnnyvMvLmCtYuLGOvUL0igK22gOCAP1G5KBvcJseaayw@mail.gmail.com>
References: <1393571362-27898-1-git-send-email-adam8157@gmail.com>
	<04802ECE-6B8D-4DF4-BFFD-EABBD42BD30F@holtmann.org>
	<20140228073113.GA3771@adam-laptop>
	<CAJdJm_OnnyvMvLmCtYuLGOvUL0igK22gOCAP1G5KBvcJseaayw@mail.gmail.com>
Date: Fri, 28 Feb 2014 15:10:41 +0100
Message-ID: <CABBYNZLP8oPywHhMDK1D9FATFi=gMAgdfde+SjwzCp=VSGy05A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: retry connect_dbus() several times
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Adam Lee <adam8157@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

On Fri, Feb 28, 2014 at 1:22 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Adam,
>
> On Fri, Feb 28, 2014 at 3:31 AM, Adam Lee <adam8157@gmail.com> wrote:
>> connect_dbus() fails sometimes with Intel 7260 bluetooth, sleeping 0.5s
>> before executing bluetoothd workarounds it. I assume the firmware
>> patching slows down hardware initialization then fails to connect.
>>
>> Any other possibility? I'm not a D-Bus guru :)
>
> Please provide more details, e.g. the bluetoothd logs showing the
> problems, btmon output and which steps you are using to reproduce it.
> If you are using bluetoothctl, tell us which commands you are using.

My guess is that either your driver is not using .setup hook to do the
firmware patching or it is returning before it has fully initialize
the hardware, so please also add more information what is happening on
the driver side.


-- 
Luiz Augusto von Dentz
