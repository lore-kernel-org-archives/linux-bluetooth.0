Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7c5ca1d4dd4aac0e52ee10ec7d9b81ba@integralblue.com>
References: <7c5ca1d4dd4aac0e52ee10ec7d9b81ba@integralblue.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Jun 2016 15:51:21 +0300
Message-ID: <CABBYNZLtSHL=+94W9DtP6KHP0H8g-Yy1nP_JC7Kg2a7uovqvxg@mail.gmail.com>
Subject: Re: systemd service hardening
To: Craig Andrews <candrews@integralblue.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Craig,

On Thu, Jun 30, 2016 at 12:07 AM, Craig Andrews
<candrews@integralblue.com> wrote:
> I've been on a bit of a mission lately to improve the hardening of systemd
> services wherever I can find them. Today, I ran across this one.
>
> I believe the hardening of the bluetooth.service (
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/src/bluetooth.service.in
> ) can be easily improved by adding these 2 lines:
> PrivateTmp=true
> NoNewPrivileges=true
>
> If there is agreement, can a committer please make this change?

I don't see any problems in doing it, how long have them been introduced?

-- 
Luiz Augusto von Dentz
