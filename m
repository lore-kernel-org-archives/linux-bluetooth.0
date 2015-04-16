Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5181722.aJ0IxrIXHx@uw000953>
References: <16972ECC-114B-4CA0-A2B1-1BE0FB115199@openremote.org>
	<1815811.8ZlaWYb6CG@leonov>
	<A1432115-C15B-4A07-BB90-E6A731C20B3B@openremote.org>
	<5181722.aJ0IxrIXHx@uw000953>
Date: Thu, 16 Apr 2015 11:15:43 +0300
Message-ID: <CABBYNZ+_kxPquUwh3AQedu+m70PBjC=jwz0X73G6bj8DvJyssQ@mail.gmail.com>
Subject: Re: Device class not writeable via dbus
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Marcus Redeker <marcus@openremote.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon, Marcus,

On Thu, Apr 16, 2015 at 11:01 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Marcus,
>
> On Thursday 16 of April 2015 09:09:28 Marcus Redeker wrote:
>> True, but  I would like todo that through dbus and not manually and have to restart bluetoothd afterwards.
>> Any chance this can be done in the near future?
>> -Marcus
>>
>
> Class of Device is rather static configuration as those describe form factor
> and that usually doesn't change.
>
> Why do you need to change CoD on the fly?

It is possible to change at runtime by using systemd hostname plugin
then change the org.freedesktop.hostname1.Chassis property, but Im not
sure how easy is to change that. Anyway the point is that this should
not changed by applications at will as it could break discovery
filtering, even thought filtering by class is probably broken by
design.

-- 
Luiz Augusto von Dentz
