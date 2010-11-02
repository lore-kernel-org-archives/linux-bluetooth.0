Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=xHO1Ste4+6AEULbs91qeL6NCuYAK8exh63gqy@mail.gmail.com>
References: <1288608899-23032-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
	<1288608899-23032-2-git-send-email-ext-jablonski.radoslaw@nokia.com>
	<AANLkTi=xHO1Ste4+6AEULbs91qeL6NCuYAK8exh63gqy@mail.gmail.com>
Date: Tue, 2 Nov 2010 14:48:30 +0200
Message-ID: <AANLkTimVuAHhvB+LJ_N+T_TbcbYyZ1_U8BwZR3JQgAF0@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add support for generating pull response in many parts
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 2, 2010 at 1:56 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Did you actually check if tracker/sparql doesn't support having a byte
> limit instead of contact/row? I know this sounds crazy, but Ive seem
> some other implementations of pbap that does similar things as to
> query a number of contacts and they can cause big pauses when
> generating the responses depending on the size of the MTU being used
> and in fact doesn't completely eliminate the extra buffering on the
> plugin side. Also I think we might need to use the read callback to
> continue the queries and not do it regardless of the speed the client
> can read, otherwise we may run in the same situation as we have now
> but instead of asking all the data at once we do it in parts but we
> still don't care if the client is fetching that data at the same pace
> we buffer.

Radek and I discussed this offline and came to a conclusion that using
a temporary files to buffer the data is probably a better idea, first
because it will be difficult to synchronize the speed of client and
backend which can either cause too much buffering (OOM) or slow
transfer speed, the second reason is that if we start supporting
avatar/image then each contact will probably consume a lot more memory
than it does right now and third caching can probably be done much
more efficiently using temporary files.

-- 
Luiz Augusto von Dentz
Computer Engineer
