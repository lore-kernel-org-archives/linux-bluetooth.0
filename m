Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130102205437.GA2334@samus>
References: <1356862632-5938-1-git-send-email-g.gherdovich@gmail.com>
	<CAJdJm_PpJOVALj5xJvCRA4mC6WAMyP5RsqHVruz6xaRBDhXg5A@mail.gmail.com>
	<CAJN7YmNzo1ya34tdgyffcBf=SLt4RsJ=2QaSy3fD6meKx7wnsA@mail.gmail.com>
	<CABBYNZJxF6H7V-e=6wMYgQSM4C7FfXW9FCrdRZ=B6U1YgLQSSQ@mail.gmail.com>
	<CAE6HaMmrc9BEW-cjmw3fkZptCzvr14M0GtKwoKXuqi8or1zeWg@mail.gmail.com>
	<CABBYNZL=4ToEwR1i6bihLKWQTn6hurEwWpjQ0gF0rgkO7eExLQ@mail.gmail.com>
	<20130102205437.GA2334@samus>
Date: Wed, 2 Jan 2013 22:43:20 +0100
Message-ID: <CAJN7YmMYKGedFxaS_1wV3gXBYqnQKfc7+Ebnz4yf5gD=kz-H+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] adapter, AVCTP: Replaced calls to g_queue_free_full function
From: Giovanni Gherdovich <g.gherdovich@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius and Luiz,

2013/1/2 Vinicius Costa Gomes <vinicius.gomes@openbossa.org>:
> [...]
>>
>> Right, but it is quite the same situation and I don't get why we don't
>> just update, by the time distros start to package BlueZ 5 glib 2.32
>> wont be a problem, in fact it should not be a problem right now as it
>> is about a year old release:
>
> I agree with you here. And that was the suggestion that I gave to
> Giovanni on IRC when he found the problem.

I just resubmitted an amended patch, since I had already prepared it.
BTW I will run a quick check on what GLib versions the various
major distros are packaging right now, just to have some data to add
to the poll.

Regards,
Giovanni
