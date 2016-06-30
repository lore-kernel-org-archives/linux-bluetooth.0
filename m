Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 30 Jun 2016 10:02:07 -0400
From: Craig Andrews <candrews@integralblue.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: systemd service hardening
In-Reply-To: <CABBYNZLtSHL=+94W9DtP6KHP0H8g-Yy1nP_JC7Kg2a7uovqvxg@mail.gmail.com>
References: <7c5ca1d4dd4aac0e52ee10ec7d9b81ba@integralblue.com>
 <CABBYNZLtSHL=+94W9DtP6KHP0H8g-Yy1nP_JC7Kg2a7uovqvxg@mail.gmail.com>
Message-ID: <51eccf324d4335c514d0fdc3cddc02db@integralblue.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 30.06.2016 08:51, Luiz Augusto von Dentz wrote:
> Hi Craig,
> 
> On Thu, Jun 30, 2016 at 12:07 AM, Craig Andrews
> <candrews@integralblue.com> wrote:
>> I've been on a bit of a mission lately to improve the hardening of 
>> systemd
>> services wherever I can find them. Today, I ran across this one.
>> 
>> I believe the hardening of the bluetooth.service (
>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/src/bluetooth.service.in
>> ) can be easily improved by adding these 2 lines:
>> PrivateTmp=true
>> NoNewPrivileges=true
>> 
>> If there is agreement, can a committer please make this change?
> 
> I don't see any problems in doing it, how long have them been 
> introduced?

Going by https://github.com/systemd/systemd/blob/master/NEWS :
PrivateTmp has been around since at least systemd 183
NoNewPrivileges has been around since at least systemd 227

However, I don't think that matters very much. Quoting 
https://www.freedesktop.org/software/systemd/man/systemd.unit.html :
---
Unit files may contain additional options on top of those listed here. 
If systemd encounters an unknown option, it will write a warning log 
message but continue loading the unit.
---

So if a user is using a version of systemd that doesn't yet have 
NoNewPrivileges, for example, there's no negative consequence.

Thanks,
~Craig
