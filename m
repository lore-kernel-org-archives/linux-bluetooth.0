Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCTjUL2_Kae186QgXa2csf-p-cuGH2US38a7S436uBY93Pw@mail.gmail.com>
References: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
	<CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
	<CAB7rCThwZxQQoKHfEszX3sZPpE_cp5+XS_fEBYiAmnR1n0d9Sg@mail.gmail.com>
	<CAB7rCTjUL2_Kae186QgXa2csf-p-cuGH2US38a7S436uBY93Pw@mail.gmail.com>
Date: Fri, 23 Mar 2012 14:49:51 +0100
Message-ID: <CA+QXtDvhJ401c9FfkPhqMT4SbwTcCF0wzNLFKzCYkxpdbQodog@mail.gmail.com>
Subject: Re: media transport -- when is acquire ok to call?
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: Mike <puffy.taco@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike, Luiz,

> I think I've figured out why I didn't see the SEP error print out.
> The function resume_a2dp calls a2dp_sep_lock.  The only place this
> ever gets unlocked is in a suspend call.  If a2dp_resume returns an
> error code, the sep remains forever locked.  And it seems, the SEP
> will no longer let acquire happen on future A2DP connections,
> requiring bluetoothd to be restarted for this to work.

I'm experimenting similar issues right now on hfgw.
Could it be because the endpoint is crashing after acquiring?

Frédéric
