Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGNHVkPiJ_PzeQsJ-Xn4sVq3mj1y-OSwZ3c3dGt-zTwNkw@mail.gmail.com>
References: <CAEZxfGMGixpTkyyc_dyR+NuzGo_wuns9b=y8_A4TWvvve6xFXQ@mail.gmail.com>
	<CAEZxfGNHVkPiJ_PzeQsJ-Xn4sVq3mj1y-OSwZ3c3dGt-zTwNkw@mail.gmail.com>
Date: Tue, 1 Dec 2015 13:55:54 +0200
Message-ID: <CABBYNZLr588sBy2hyhQnPiV-Gm6n0o7ScmZnH13wz4GTHA-Kgw@mail.gmail.com>
Subject: Re: Is the GattServices property still updated?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François,

On Tue, Dec 1, 2015 at 12:06 PM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> For info, here's some background:
> https://code.google.com/p/chromium/issues/detail?id=560277
>
> On Tue, Dec 1, 2015 at 11:03 AM, François Beaufort
> <beaufort.francois@gmail.com> wrote:
>> I'm not sure to understand what is happening and I'd love your help there.
>>
>> Is the "GattServices" device property still supposed to be updated
>> once all remote GATT services of the device
>> have been discovered and exported over D-Bus as mentioned in
>> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/device-api.txt#n215
>>
>> If so, does this DBUS messages trace looks good to you:
>> http://pastebin.com/emxWB4w1?
> --

It is a regression caused by restoring the attributes from storage,
Ive send a patch for that. Btw, it is not recommended to mess up with
the storage manually if someone is doing this please advise to remove
the device properly.


-- 
Luiz Augusto von Dentz
