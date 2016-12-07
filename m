Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH] shared/mainloop: Fix timeout data memleak
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Loic Poulain <loic.poulain@gmail.com>
References: <1481118263-4518-1-git-send-email-loic.poulain@gmail.com>
 <CABBYNZJFoURMqFrVd2o4gac=nqWaQMBwOf+pdeHcJR-ZB8bBTw@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: loic.poulain@gmail.com
Message-ID: <08701e98-98dd-23d5-109f-ec6c5883ee9c@intel.com>
Date: Wed, 7 Dec 2016 16:39:28 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZJFoURMqFrVd2o4gac=nqWaQMBwOf+pdeHcJR-ZB8bBTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Seems valid but can you add the backtrace, I wonder how we didn't spot
> this before so perhaps the backtrace would explain it.
>

Actually, I included this useful shared code in a different project/poc, 
don't have backtrace in a bluez context.
This could explain why you've never met this issue (timeout/timerfd 
seems only used in emulator).

Regards,
Loic
