Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140125221203.GA14531@x220.p-661hnu-f1>
References: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
	<20140125221203.GA14531@x220.p-661hnu-f1>
Date: Sat, 25 Jan 2014 18:48:01 -0400
Message-ID: <CAJdJm_PPeA-DHfFPKi=iwjb_Kc4rrU8zY6SgX-G_O9ts3wCaZw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] Basic [sg]etsockopt() testing in l2cap-tester
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sat, Jan 25, 2014 at 6:12 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> I pushed your first patch and a slightly different version of the
> second one which is more thorough in its checks. I also sent fixes for
> the kernel side so you don't need to spend more time on that (unless you
> disagree with the fixes I sent).

Thanks! I looked at the patches and I have no comments. Will do tests
and report problems (if any).

What about the suggestion to make l2cap-tester check if LE CoC is
enabled on the kernel and skip the the tests that depend on it? Right
now, the tests simply fail which is misleading (at first I thought it
was a regression).

Another option is to change the test name to mention that they require
enabling LE CoC.

Best Regards,
-- 
Anderson Lizardo
INdT - Manaus - Brazil
