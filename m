Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+XVXffwWs8XYNT30NeRCT1hUGg-q5VD7X9k-NJfm6T9p8YjXw@mail.gmail.com>
References: <1331214279-27521-1-git-send-email-arik@wizery.com>
	<CAJdJm_Ph1Ax_BJUVz3UsLvzLQnA1uH5n8p=ihNc-KHuxoCVoHw@mail.gmail.com>
	<CA+XVXffwWs8XYNT30NeRCT1hUGg-q5VD7X9k-NJfm6T9p8YjXw@mail.gmail.com>
Date: Wed, 14 Mar 2012 08:49:05 -0400
Message-ID: <CAJdJm_P=6Q+bgaNs9df+HHaNvDBV0fORS7tyXdEQT-fCY0noXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] device: don't auto-connect on disc-cb attio callback registration
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Wed, Mar 14, 2012 at 8:09 AM, Arik Nemtsov <arik@wizery.com> wrote:
>> Can you explain why you need it?
>
> Before this patch, if we register a disconnect-only attio callback
> (cfunc is NULL) when the device is connected, it will cause this line
> to be called:
>
>                device->auto_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
>                                                att_connect, device,
>                                                att_connect_dispatched);
>
> I guess the code wasn't really tested with a disconnect-only attio
> callback. I think I added the first such callback in the proximity
> reporter profiles.

Ok, so the problem is actually the " && cfunc" condition which makes
the wrong branch to be followed if only a disconnect callback is
registered.

So the patch makes sense and looks good.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
