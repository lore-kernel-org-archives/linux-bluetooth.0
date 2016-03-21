Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAASrBQnkyUmCBk3qNAvnbVmmyM8mSsfGPHf2O2rFFBPYNxvFww@mail.gmail.com>
References: <CAASrBQkO4oNjR9j+Yz6CcmjhDChkABwKHR_-hgZoQCcTPnaWPA@mail.gmail.com>
	<CABBYNZJJZG7guG9h8Gvp75ONbO1WO=6EKpc7E1cfG-y-CgA0FA@mail.gmail.com>
	<CAASrBQnkyUmCBk3qNAvnbVmmyM8mSsfGPHf2O2rFFBPYNxvFww@mail.gmail.com>
Date: Mon, 21 Mar 2016 11:59:07 -0600
Message-ID: <CAASrBQmO5SqhdcLyk6uTdeU4uy3GEtcpVSdo=X=zbcykWpLZaw@mail.gmail.com>
Subject: Re: Crash in src/gatt-client.c (was Re: setting indication on
 GattCharacteristic1 interface)
From: Mark Rages <markrages@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ah, never mind about this -- it was my configuration error.

Regards,
Mark


On Mon, Mar 21, 2016 at 11:49 AM, Mark Rages <markrages@gmail.com> wrote:
> On Mon, Mar 21, 2016 at 8:42 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Mark,
>>
>> The crash should now be fixed upstream, thanks for the logs.
>>
>
> It doesn't crash anymore, thanks.  But it doesn't connect either:
>
> $ ./bluetoothctl
> [NEW] Controller 00:1A:7D:DA:71:13 qountdown-0 [default]
> [NEW] Device CD:83:22:A3:1C:5E DfuTarg
> [bluetooth]# power on
> Changing power on succeeded
> [CHG] Controller 00:1A:7D:DA:71:13 Powered: yes
> [bluetooth]# connect CD:83:22:A3:1C:5E
> Attempting to connect to CD:83:22:A3:1C:5E
> Failed to connect: org.bluez.Error.Failed
>
> btmon output at
> https://www.dropbox.com/s/ex7e73c8qwr5p0k/btmon-cannot-connect.txt?dl=0
>
> Regards,
> Mark
> markrages@gmail



-- 
Regards,
Mark
markrages@gmail
