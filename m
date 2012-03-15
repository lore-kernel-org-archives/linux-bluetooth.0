Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+XVXfeGvTtJyQvj4R-Xmqt_s6jZRZopy01PVE1qnzhFWK9ZVw@mail.gmail.com>
References: <1331808559-12880-1-git-send-email-arik@wizery.com>
	<1331808559-12880-7-git-send-email-arik@wizery.com>
	<CAJdJm_N-BfUN3FUjDx0kv3+-uQ=L+uhXGzXM9ec+qH-frQMk_Q@mail.gmail.com>
	<CA+XVXfeGvTtJyQvj4R-Xmqt_s6jZRZopy01PVE1qnzhFWK9ZVw@mail.gmail.com>
Date: Thu, 15 Mar 2012 09:32:05 -0400
Message-ID: <CAJdJm_P0n3M3QMzHhM1zXJW_GRt0Os7EGEmYFdjVZGyWZb=OyA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] proximity: reporter: implement D-Bus API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Thu, Mar 15, 2012 at 8:17 AM, Arik Nemtsov <arik@wizery.com> wrote:
>>> +       .name = "Proximity GATT Reporter Device Tracker Driver",
>>
>> And "Proximity GATT Reporter Device Driver"
>>
>>> +       .uuids = BTD_UUIDS(GATT_UUID),
>>> +       .probe = gatt_device_probe,
>>> +       .remove = gatt_device_remove,
>>
>> And using reporter_probe() / reporter_remove()
>
> This is very similar to reporter_init()/reporter_exit() defined for in
> reporter_server_driver, and the distinction is not clear. How about
> reporter_device_probe/remove?

Well, these functions are static anyway, so it is no problem that they
are similarly named (IMHO) within other Proximity files. My concern is
just that "gatt_device_" prefix is too generic and may be confusing.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
