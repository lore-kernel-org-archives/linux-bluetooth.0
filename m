Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130314204149.GF2649@samus>
References: <1363285326-20089-1-git-send-email-deymo@chromium.org>
 <1363285326-20089-4-git-send-email-deymo@chromium.org> <20130314200055.GE2649@samus>
 <CAGd9gwjK_9pJ2ooRT2NLDRxwk4mToZ3cPxEjPj1mz8n0P_52Aw@mail.gmail.com> <20130314204149.GF2649@samus>
From: Alex Deymo <deymo@chromium.org>
Date: Thu, 14 Mar 2013 15:08:48 -0700
Message-ID: <CAGd9gwico28=29MmSLbj2+JRvreH-=TYOxQWtjydiw0-bs_mOQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] "agent" command capability argument and autocompletion
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, keybuk <keybuk@chromium.org>,
	marcel <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

>> I'm not sure if I properly understand this comment. If arg is NULL it
>> will fall in the first return FALSE, not calling any strcmp() because
>> of the lazy or operator, right?
>
> I was referring to the fact that in BlueZ (userspace code) the idiom
> "strcmp(x, y) == 0" is more common than "!strcmp(x, y)". But I agree that
> I wasn't clear enough.

Ok, I'll include this fix. I basically copied this style from
parse_argument_on_off(), but I can change it if you want.

Alex.
