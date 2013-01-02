Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAE6HaMmrc9BEW-cjmw3fkZptCzvr14M0GtKwoKXuqi8or1zeWg@mail.gmail.com>
References: <1356862632-5938-1-git-send-email-g.gherdovich@gmail.com>
	<CAJdJm_PpJOVALj5xJvCRA4mC6WAMyP5RsqHVruz6xaRBDhXg5A@mail.gmail.com>
	<CAJN7YmNzo1ya34tdgyffcBf=SLt4RsJ=2QaSy3fD6meKx7wnsA@mail.gmail.com>
	<CABBYNZJxF6H7V-e=6wMYgQSM4C7FfXW9FCrdRZ=B6U1YgLQSSQ@mail.gmail.com>
	<CAE6HaMmrc9BEW-cjmw3fkZptCzvr14M0GtKwoKXuqi8or1zeWg@mail.gmail.com>
Date: Wed, 2 Jan 2013 22:35:42 +0200
Message-ID: <CABBYNZL=4ToEwR1i6bihLKWQTn6hurEwWpjQ0gF0rgkO7eExLQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] adapter, AVCTP: Replaced calls to g_queue_free_full function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: Giovanni Gherdovich <g.gherdovich@gmail.com>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Jan 2, 2013 at 10:23 PM, Vinicius Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Luiz,
>
>> In that case I would just revert back this patch, but the
>> documentation actually say g_slist_free_full is available since 2.28
>> http://developer.gnome.org/glib/2.28/glib-Singly-Linked-Lists.html#g-slist-free-full
>> so I wonder what is going on.
>>
>
> The problem now is g_queue_free_full() not the g_slist_free_full().

Right, but it is quite the same situation and I don't get why we don't
just update, by the time distros start to package BlueZ 5 glib 2.32
wont be a problem, in fact it should not be a problem right now as it
is about a year old release:

commit 816554c62bf227498cb539924e6ee2050030b4b9
Author: Matthias Clasen <mclasen@redhat.com>
Date:   Sat Mar 24 11:28:35 2012 -0400

    2.32.0

--
Luiz Augusto von Dentz
