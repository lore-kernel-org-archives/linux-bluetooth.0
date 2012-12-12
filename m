Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_M6cors5nxsbx7RCAiSTQsMscYGhPFXWZmDstrEab5hQw@mail.gmail.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
	<1355308088-9080-12-git-send-email-szymon.janc@tieto.com>
	<CAJdJm_NryAHYHPXBTFfy7Z-p7r4peH5Lr6qQgKdV8-9zeMx-=w@mail.gmail.com>
	<CAJdJm_M6cors5nxsbx7RCAiSTQsMscYGhPFXWZmDstrEab5hQw@mail.gmail.com>
Date: Wed, 12 Dec 2012 09:03:04 -0400
Message-ID: <CAJdJm_MsHj8B3vSu3bHbstgYs0j7tYM9Dm16XK6p3jC1o0cHvw@mail.gmail.com>
Subject: Re: [PATCH 11/16] avctp: Convert register/unregister to accept btd_adapter
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 12, 2012 at 8:55 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Ignore that, now I see "manager_get_device()" returns a audio device,
> not btd_device :)

As a side note, it is unfortunate that profiles/audio/manager.c has
manager_get_device(), manager_find_device() etc. and src/manager.c has
manager_find_adapter() , manager_get_default_adapter() etc. It gets
confusing sometimes to follow code mixing these functions.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
