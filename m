Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Feb 2010 11:04:19 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix double free on AVDTP Abort response
Message-ID: <20100223140419.GA11524@jh-x301>
References: <eb7933e21002190820x7b2b0ea3v3f48ce96a5d11a1e@mail.gmail.com>
 <20100219173257.GA12855@jh-x301>
 <eb7933e21002210454r4b3805e1pec3f4f58440191bf@mail.gmail.com>
 <20100221134631.GA25639@jh-x301>
 <2d5a2c101002210953l4ef26078j25f4cc31758b80a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2d5a2c101002210953l4ef26078j25f4cc31758b80a7@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Feb 21, 2010, Luiz Augusto von Dentz wrote:
> While discussing this problem we find out that our timeout doesn't
> really work as we imagine due to the possibility of abort being
> rejected, so either we don't call any callback on timeout and do it on
> abort response while changing to aborting state (which probably means
> 4-8 sec before we are really able to abort/cancel) or we disconnect as
> the other end seems to not cooperate on aborting.
> 
> Btw, we probably should have a smaller timeout for avdtp_abort anyway
> and make sure we call it upon RequestDisconnect not avdtp_close which
> has no priority over the others commands.

Makes sense. Feel free to propose a patch (or multiple patches) for all
this ;)

Johan
