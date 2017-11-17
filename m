Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1510291473.2624.81.camel@hadess.net>
References: <20171110052329.477-1-hadess@hadess.net> <1510291473.2624.81.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Nov 2017 16:11:33 +0200
Message-ID: <CABBYNZKScfob4+kXWYr=aZUTmf1v6ZFjVbkg=6sjKioyuU3nBQ@mail.gmail.com>
Subject: Re: [PATCH] device: Fix possible run-time warning
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Fri, Nov 10, 2017 at 7:24 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Fri, 2017-11-10 at 06:23 +0100, Bastien Nocera wrote:
>> When a reconnect timeout has previously run for a device, setting a
>> new
>> one will throw a warning as the timeout id is not reset when the
>> timeout
>> is cancelled from within its callback.
>
> Note that this is the 2nd patch I send with the same subject. They're
> not the same patches, and fix 2 different bugs in that part of the
> code.

Both patches, applied.

-- 
Luiz Augusto von Dentz
