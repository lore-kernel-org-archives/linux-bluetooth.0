Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331891164-24588-5-git-send-email-arik@wizery.com>
References: <1331891164-24588-1-git-send-email-arik@wizery.com>
	<1331891164-24588-5-git-send-email-arik@wizery.com>
Date: Fri, 16 Mar 2012 07:49:30 -0400
Message-ID: <CAJdJm_OD7D=tfjF534nRmLegfYDK3PGRC9hPP8gt2VQdEcrWgQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] proximity: link loss: implement link loss server
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Fri, Mar 16, 2012 at 5:46 AM, Arik Nemtsov <arik@wizery.com> wrote:
> +static void link_Loss_local_disc(struct btd_device *device, gboolean removal,
> +                                void *user_data)

Not sure if this was already on the original series (sorry if I missed
it), but there is a typo here:

link_Loss_local_disc -> link_loss_local_disc

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
