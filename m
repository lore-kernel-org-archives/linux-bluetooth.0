Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Jan 2013 17:54:37 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Giovanni Gherdovich <g.gherdovich@gmail.com>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] adapter, AVCTP: Replaced calls to g_queue_free_full
 function
Message-ID: <20130102205437.GA2334@samus>
References: <1356862632-5938-1-git-send-email-g.gherdovich@gmail.com>
 <CAJdJm_PpJOVALj5xJvCRA4mC6WAMyP5RsqHVruz6xaRBDhXg5A@mail.gmail.com>
 <CAJN7YmNzo1ya34tdgyffcBf=SLt4RsJ=2QaSy3fD6meKx7wnsA@mail.gmail.com>
 <CABBYNZJxF6H7V-e=6wMYgQSM4C7FfXW9FCrdRZ=B6U1YgLQSSQ@mail.gmail.com>
 <CAE6HaMmrc9BEW-cjmw3fkZptCzvr14M0GtKwoKXuqi8or1zeWg@mail.gmail.com>
 <CABBYNZL=4ToEwR1i6bihLKWQTn6hurEwWpjQ0gF0rgkO7eExLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZL=4ToEwR1i6bihLKWQTn6hurEwWpjQ0gF0rgkO7eExLQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> 
> Right, but it is quite the same situation and I don't get why we don't
> just update, by the time distros start to package BlueZ 5 glib 2.32
> wont be a problem, in fact it should not be a problem right now as it
> is about a year old release:

I agree with you here. And that was the suggestion that I gave to
Giovanni on IRC when he found the problem.

> 
> commit 816554c62bf227498cb539924e6ee2050030b4b9
> Author: Matthias Clasen <mclasen@redhat.com>
> Date:   Sat Mar 24 11:28:35 2012 -0400
> 
>     2.32.0
> 
> --
> Luiz Augusto von Dentz


Cheers,
-- 
Vinicius
