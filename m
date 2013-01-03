Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357170124.19248.98.camel@aeonflux>
References: <1356862632-5938-1-git-send-email-g.gherdovich@gmail.com>
	<CAJdJm_PpJOVALj5xJvCRA4mC6WAMyP5RsqHVruz6xaRBDhXg5A@mail.gmail.com>
	<CAJN7YmNzo1ya34tdgyffcBf=SLt4RsJ=2QaSy3fD6meKx7wnsA@mail.gmail.com>
	<CABBYNZJxF6H7V-e=6wMYgQSM4C7FfXW9FCrdRZ=B6U1YgLQSSQ@mail.gmail.com>
	<CAE6HaMmrc9BEW-cjmw3fkZptCzvr14M0GtKwoKXuqi8or1zeWg@mail.gmail.com>
	<CABBYNZL=4ToEwR1i6bihLKWQTn6hurEwWpjQ0gF0rgkO7eExLQ@mail.gmail.com>
	<1357170124.19248.98.camel@aeonflux>
Date: Thu, 3 Jan 2013 12:27:22 +0200
Message-ID: <CABBYNZ+VTFatmSUaXD=4-8K9eYj__z4X1vzCUXMo=9CLyjcSjQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] adapter, AVCTP: Replaced calls to g_queue_free_full function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Vinicius Gomes <vinicius.gomes@openbossa.org>,
	Giovanni Gherdovich <g.gherdovich@gmail.com>, Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 3, 2013 at 1:42 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> >> In that case I would just revert back this patch, but the
>> >> documentation actually say g_slist_free_full is available since 2.28
>> >> http://developer.gnome.org/glib/2.28/glib-Singly-Linked-Lists.html#g-slist-free-full
>> >> so I wonder what is going on.
>> >>
>> >
>> > The problem now is g_queue_free_full() not the g_slist_free_full().
>>
>> Right, but it is quite the same situation and I don't get why we don't
>> just update, by the time distros start to package BlueZ 5 glib 2.32
>> wont be a problem, in fact it should not be a problem right now as it
>> is about a year old release:
>
> because every new GLib release drags in more dependencies. It is a bit
> out of control. So requiring the 2.32 comes at a cost that I am not
> willing to pay right now. We already have seen this with ConnMan where I
> accidentally used a newer GLib function that was not present in a 2.28
> and before. It is pretty hard for embedded system to do these kind of
> upgrades when their dependencies and thus footprint and memory
> consumption increases for just a simple convenience function.

It seems the mandatory glib dependencies are restricted to libffi,
pkg-config and Python:
http://www.linuxfromscratch.org/blfs/view/svn/general/glib2.html

Anyway regardless if we do update or not, I don't see why
g_queue_free_full is different than g_slist_free_full, so instead of
converting everything to g_queue_foreach + g_queue_free why we don't
bring back glib-compat and do this in one place as we did for
g_slist_free_full?

--
Luiz Augusto von Dentz
