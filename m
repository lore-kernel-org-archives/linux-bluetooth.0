Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Device class not writeable via dbus
From: Marcus Redeker <marcus@openremote.org>
In-Reply-To: <CABBYNZ+_kxPquUwh3AQedu+m70PBjC=jwz0X73G6bj8DvJyssQ@mail.gmail.com>
Date: Thu, 16 Apr 2015 10:53:44 +0200
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <BF008F71-1F11-49B1-ADFF-B883B0C19666@openremote.org>
References: <16972ECC-114B-4CA0-A2B1-1BE0FB115199@openremote.org> <1815811.8ZlaWYb6CG@leonov> <A1432115-C15B-4A07-BB90-E6A731C20B3B@openremote.org> <5181722.aJ0IxrIXHx@uw000953> <CABBYNZ+_kxPquUwh3AQedu+m70PBjC=jwz0X73G6bj8DvJyssQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On 16.04.2015, at 10:15, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> 
> Hi Szymon, Marcus,
> 
> On Thu, Apr 16, 2015 at 11:01 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> Hi Marcus,
>> 
>> On Thursday 16 of April 2015 09:09:28 Marcus Redeker wrote:
>>> True, but  I would like todo that through dbus and not manually and have to restart bluetoothd afterwards.
>>> Any chance this can be done in the near future?
>>> -Marcus
>>> 
>> 
>> Class of Device is rather static configuration as those describe form factor
>> and that usually doesn't change.
>> 
>> Why do you need to change CoD on the fly?
> 
> It is possible to change at runtime by using systemd hostname plugin
> then change the org.freedesktop.hostname1.Chassis property, but Im not
> sure how easy is to change that. Anyway the point is that this should
> not changed by applications at will as it could break discovery
> filtering, even thought filtering by class is probably broken by
> design.
> 
> -- 
> Luiz Augusto von Dentz

This would allow to change the name of the bluetooth adapter but not the device class.
The name can already be changed using the read/write alias property which is no problem.
-Marcus

