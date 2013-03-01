Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCVEffBVaGGuHZf6+A7cmVmbDaR23YMV2ais120NrYAB7A@mail.gmail.com>
References: <1362140773-13672-1-git-send-email-luiz.dentz@gmail.com>
	<CANT-zCVEffBVaGGuHZf6+A7cmVmbDaR23YMV2ais120NrYAB7A@mail.gmail.com>
Date: Fri, 1 Mar 2013 16:48:00 +0200
Message-ID: <CABBYNZLCmRVAopvF5djHq1oMgbiqQ-VSyqjtsx0jZOXiVnUbSQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] audio: Remove profile enabling/disabling logic
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Mar 1, 2013 at 3:48 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> Enabling all profiles by default is one thing but dropping the enable
> flags is IMO too much. Beyond the desktop setups, e.g. in automotive
> (or probably even for phones), some roles would be disabled.

For that reason 2/3 introduces DisableProfiles in the main.conf, so it
is generic for any profile.

> What I'm missing is how external profiles would fit for this purpose.
> Would BlueZ care at all or would for example oFono require similar
> flags?

In theory we could disable even external profiles, but that doesn't
mean this couldn't be disabled directly on the component so for now I
left it out.

--
Luiz Augusto von Dentz
