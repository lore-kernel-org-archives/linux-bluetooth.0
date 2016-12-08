Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <08701e98-98dd-23d5-109f-ec6c5883ee9c@intel.com>
References: <1481118263-4518-1-git-send-email-loic.poulain@gmail.com>
 <CABBYNZJFoURMqFrVd2o4gac=nqWaQMBwOf+pdeHcJR-ZB8bBTw@mail.gmail.com> <08701e98-98dd-23d5-109f-ec6c5883ee9c@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Dec 2016 12:56:43 +0200
Message-ID: <CABBYNZJp=UsDXymgf1xYhGHBg+_C7SrQFdykSfpT9E6iuX4S8Q@mail.gmail.com>
Subject: Re: [PATCH] shared/mainloop: Fix timeout data memleak
To: Loic Poulain <loic.poulain@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On Wed, Dec 7, 2016 at 5:39 PM,  <loic.poulain@gmail.com> wrote:
> Hi Luiz,
>
>> Seems valid but can you add the backtrace, I wonder how we didn't spot
>> this before so perhaps the backtrace would explain it.
>>
>
> Actually, I included this useful shared code in a different project/poc,
> don't have backtrace in a bluez context.
> This could explain why you've never met this issue (timeout/timerfd seems
> only used in emulator).

Fair enough, applied, thanks.

-- 
Luiz Augusto von Dentz
