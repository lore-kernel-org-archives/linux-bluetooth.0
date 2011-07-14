Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBe6Qqgd7h=tQ4EfVVq9NkTWRzQE25Rn8tJT5NYrOWf0Hg@mail.gmail.com>
References: <1310497518-19526-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110714133706.GB2770@dell.ger.corp.intel.com>
	<CAKT1EBe6Qqgd7h=tQ4EfVVq9NkTWRzQE25Rn8tJT5NYrOWf0Hg@mail.gmail.com>
Date: Thu, 14 Jul 2011 10:47:49 -0400
Message-ID: <CAJdJm_MbUeYRZmja6z08GAG8vU_iGLqot0i1AUFOXS1DAKb0SQ@mail.gmail.com>
Subject: Re: [PATCH] Move attrib server init/exit declaration to hcid.h
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 14, 2011 at 10:24 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> BTW: maybe we could create another header for main_opts or try to move
> it to main.c. hciops and gatt servers implementations are including
> it, which looks wrong to me.

Or we can make accessor functions instead of exporting main_opts
directly. (e.g. like btd_device_* functions for struct btd_device).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
