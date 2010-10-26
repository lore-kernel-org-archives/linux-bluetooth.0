Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1288103093.3613.21.camel@aeonflux>
References: <1287644956-12602-1-git-send-email-haijun.liu@atheros.com> <1288103093.3613.21.camel@aeonflux>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Tue, 26 Oct 2010 22:33:54 +0800
Message-ID: <AANLkTimA2-8ZLwOGqkt+V_Dmp=zLcK3oad3tpZDDa17q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Fix system crash caused by del_timer()
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Haijun Liu <haijun.liu@atheros.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> At UPF37, during test session of bt3.0 with Marvel, found that in
>> l2cap_chan_del() using del_timer() caused l2cap_monitor_timeout()
>> be called after the sock was freed, so it raised a system crash.
>> So I just replaced del_timer() with del_timer_sync() to solve it.
>>
>> Signed-off-by: Haijun Liu <haijun.liu@atheros.com>
>
> looks good to me and if Gustavo agrees, then
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>

Sorry, I should note this patch has been discard, please look at

<[PATCH 1/2 v2] Bluetooth: Fix system crash caused by del_timer() >
<[PATCH 2/2 v2] Bluetooth: Fix system crash bug of no send queue protect>

Thank you.

-- 
Haijun Liu
