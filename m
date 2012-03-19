Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OD7D=tfjF534nRmLegfYDK3PGRC9hPP8gt2VQdEcrWgQ@mail.gmail.com>
References: <1331891164-24588-1-git-send-email-arik@wizery.com>
 <1331891164-24588-5-git-send-email-arik@wizery.com> <CAJdJm_OD7D=tfjF534nRmLegfYDK3PGRC9hPP8gt2VQdEcrWgQ@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Mon, 19 Mar 2012 10:53:38 +0200
Message-ID: <CA+XVXffWrE1tNdw=f1fH7a+0Hf0V-63=xVDOrUWKbug5pMk=jA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] proximity: link loss: implement link loss server
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 16, 2012 at 13:49, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Arik,
>
> On Fri, Mar 16, 2012 at 5:46 AM, Arik Nemtsov <arik@wizery.com> wrote:
>> +static void link_Loss_local_disc(struct btd_device *device, gboolean removal,
>> +                                void *user_data)
>
> Not sure if this was already on the original series (sorry if I missed
> it), but there is a typo here:
>
> link_Loss_local_disc -> link_loss_local_disc
>

Sure i'll change it (and the other comment as well), but let's make
other wording related changes on top of upstream (it's easier).

Arik
