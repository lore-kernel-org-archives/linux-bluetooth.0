Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Mar 2010 00:32:33 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix using invalid data from previous headset connection
Message-ID: <20100303033233.GA20411@jh-x301>
References: <2d5a2c101003021309o34b63249ub5940f67112eab6a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2d5a2c101003021309o34b63249ub5940f67112eab6a@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Mar 02, 2010, Luiz Augusto von Dentz wrote:
> Data notiated in a session should be reset once disconnected, to fix
> this a new structure is introduced called headset_session is
> introduced to hold the session data which is freed when disconnected.

In general the idea of the patch is good, but there are a few things
that need some further thinking.

First of all could we just call a "session" what the HFP spec calls it,
i.e. a Service Level Connection, e.g. hs->slc? Or do you have some
better suggestion?

Secondly you need to be careful when doing one-to-one replacements of
existing hs->foo statements with hs->session->foo statements. What if
hs->session is NULL? Are there some valid use cases when a function that
can access hs->session could get called while hs->session is NULL?

Johan
