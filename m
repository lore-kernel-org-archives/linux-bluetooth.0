Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100303033233.GA20411@jh-x301>
References: <2d5a2c101003021309o34b63249ub5940f67112eab6a@mail.gmail.com>
	 <20100303033233.GA20411@jh-x301>
Date: Wed, 3 Mar 2010 10:25:32 +0200
Message-ID: <2d5a2c101003030025v40b2ca4ma985e5a544d7e707@mail.gmail.com>
Subject: Re: [PATCH] Fix using invalid data from previous headset connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 3, 2010 at 5:32 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Tue, Mar 02, 2010, Luiz Augusto von Dentz wrote:
>> Data notiated in a session should be reset once disconnected, to fix
>> this a new structure is introduced called headset_session is
>> introduced to hold the session data which is freed when disconnected.
>
> In general the idea of the patch is good, but there are a few things
> that need some further thinking.
>
> First of all could we just call a "session" what the HFP spec calls it,
> i.e. a Service Level Connection, e.g. hs->slc? Or do you have some
> better suggestion?

I suggested session since it represents the connection itself, even
the at comands buffer is in the new structure so I guess it doesn't
really represents slc, maybe connection is more suitable since there
could be only one.

> Secondly you need to be careful when doing one-to-one replacements of
> existing hs->foo statements with hs->session->foo statements. What if
> hs->session is NULL? Are there some valid use cases when a function that
> can access hs->session could get called while hs->session is NULL?

Afaik no there aren't, the session represent the lifetime of the
rfcomm connection and the only thing that are accessible are the gains
via dbus interface but we protect them by checking the state and if by
some reason we don't have a session then there is probably a bug so
checking hs->session would probably hide those.

-- 
Luiz Augusto von Dentz
Computer Engineer
