Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJxF6H7V-e=6wMYgQSM4C7FfXW9FCrdRZ=B6U1YgLQSSQ@mail.gmail.com>
References: <1356862632-5938-1-git-send-email-g.gherdovich@gmail.com>
	<CAJdJm_PpJOVALj5xJvCRA4mC6WAMyP5RsqHVruz6xaRBDhXg5A@mail.gmail.com>
	<CAJN7YmNzo1ya34tdgyffcBf=SLt4RsJ=2QaSy3fD6meKx7wnsA@mail.gmail.com>
	<CABBYNZJxF6H7V-e=6wMYgQSM4C7FfXW9FCrdRZ=B6U1YgLQSSQ@mail.gmail.com>
Date: Wed, 2 Jan 2013 17:23:35 -0300
Message-ID: <CAE6HaMmrc9BEW-cjmw3fkZptCzvr14M0GtKwoKXuqi8or1zeWg@mail.gmail.com>
Subject: Re: [PATCH 1/1] adapter, AVCTP: Replaced calls to g_queue_free_full function
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Giovanni Gherdovich <g.gherdovich@gmail.com>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> In that case I would just revert back this patch, but the
> documentation actually say g_slist_free_full is available since 2.28
> http://developer.gnome.org/glib/2.28/glib-Singly-Linked-Lists.html#g-slist-free-full
> so I wonder what is going on.
>

The problem now is g_queue_free_full() not the g_slist_free_full().

>
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
--
Vinicius
