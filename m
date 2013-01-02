Return-Path: <cyrus@holtmann.org>
Message-ID: <1357170124.19248.98.camel@aeonflux>
Subject: Re: [PATCH 1/1] adapter, AVCTP: Replaced calls to g_queue_free_full
 function
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinicius Gomes <vinicius.gomes@openbossa.org>,
	Giovanni Gherdovich <g.gherdovich@gmail.com>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 02 Jan 2013 15:42:04 -0800
In-Reply-To: <CABBYNZL=4ToEwR1i6bihLKWQTn6hurEwWpjQ0gF0rgkO7eExLQ@mail.gmail.com>
References: <1356862632-5938-1-git-send-email-g.gherdovich@gmail.com>
	 <CAJdJm_PpJOVALj5xJvCRA4mC6WAMyP5RsqHVruz6xaRBDhXg5A@mail.gmail.com>
	 <CAJN7YmNzo1ya34tdgyffcBf=SLt4RsJ=2QaSy3fD6meKx7wnsA@mail.gmail.com>
	 <CABBYNZJxF6H7V-e=6wMYgQSM4C7FfXW9FCrdRZ=B6U1YgLQSSQ@mail.gmail.com>
	 <CAE6HaMmrc9BEW-cjmw3fkZptCzvr14M0GtKwoKXuqi8or1zeWg@mail.gmail.com>
	 <CABBYNZL=4ToEwR1i6bihLKWQTn6hurEwWpjQ0gF0rgkO7eExLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> In that case I would just revert back this patch, but the
> >> documentation actually say g_slist_free_full is available since 2.28
> >> http://developer.gnome.org/glib/2.28/glib-Singly-Linked-Lists.html#g-slist-free-full
> >> so I wonder what is going on.
> >>
> >
> > The problem now is g_queue_free_full() not the g_slist_free_full().
> 
> Right, but it is quite the same situation and I don't get why we don't
> just update, by the time distros start to package BlueZ 5 glib 2.32
> wont be a problem, in fact it should not be a problem right now as it
> is about a year old release:

because every new GLib release drags in more dependencies. It is a bit
out of control. So requiring the 2.32 comes at a cost that I am not
willing to pay right now. We already have seen this with ConnMan where I
accidentally used a newer GLib function that was not present in a 2.28
and before. It is pretty hard for embedded system to do these kind of
upgrades when their dependencies and thus footprint and memory
consumption increases for just a simple convenience function.

Regards

Marcel


