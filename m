Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357164488.19248.92.camel@aeonflux>
References: <1357162287-14216-1-git-send-email-g.gherdovich@gmail.com>
	<1357164488.19248.92.camel@aeonflux>
Date: Thu, 3 Jan 2013 20:36:30 +0100
Message-ID: <CAJN7YmPJf9Yo6B-UFdpDrgDF5=CLcmXYJ-5S87B_4X2YG_MxHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] core: Replace calls to g_queue_free_full function
From: Giovanni Gherdovich <g.gherdovich@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Luiz, Vinicius, Anderson,

2013/1/2 Marcel Holtmann <marcel@holtmann.org>:
> [...]
>
> I would have done this:
>
>         static void free_service_auth(gpointer data, gpointer user_data)
>         {
>                 struct service_auth *auth = data;
>
>                 g_free(auth);
>         }


> change pending_destroy() to this:
>
>         static void pending_destroy(gpointer data, gpointer user_data)
>         {
>                 ...
>         }
>
> And then fix the callers to add an extra NULL.

I am about to send the modified patch.

I also had to revert another GLib function, g_slist_free_full,
to g_slist_foreach + g_slist_free, since having changed the signature
of pending_destroy, i didn't suit any more the second argument of
g_slist_free_full.
I hope that's not a big deal.


2013/1/2 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> [...]
>
> There is something off here, in the past we did have an implementation
> of g_slist_free_full to overcome this dependency problem but it was
> removed in this commit:
>
> commit 84156dadb25ec0973752d34d84fc9ffb3c720988
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date:   Mon Apr 16 18:22:24 2012 +0200
>
>     build: Remove glib-compat.h support
>

yes, here a link to the gitweb
http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=84156dadb25ec0973752d34d84fc9ffb3c720988;hp=1a79248e6be548696715f3bb2ddcf01630cf2c69

2013/1/2 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi Vinicius,
>
> On Wed, Jan 2, 2013 at 10:23 PM, Vinicius Gomes
>> [...]
>> The problem now is g_queue_free_full() not the g_slist_free_full().
>
> Right, but it is quite the same situation  [...]

It is exactly the same situation.
In the commit where the GLib team added g_queue_free_full,
they mentioned that they wanted to align the API for GQueue
to what they had for GSList and GList.

2013/1/3 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> [...]
>
> Anyway regardless if we do update or not, I don't see why
> g_queue_free_full is different than g_slist_free_full, so instead of
> converting everything to g_queue_foreach + g_queue_free why we don't
> bring back glib-compat and do this in one place as we did for
> g_slist_free_full?

If you bring back that code, you bring back the evil cast of

void (*) (void *)

to

void (*) (void *, void *)

which I am trying to avoid.

Regards,
Giovanni
