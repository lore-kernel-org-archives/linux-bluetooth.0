Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jun 2012 17:02:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Ruslan N. Marchenko" <me@ruff.mobi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] pcm_bluetooth: accept BT_A2DP_SBC_SOURCE codec
Message-ID: <20120629140203.GA29045@x220>
References: <4FE44DAD.90004@ruff.mobi>
 <CABBYNZLKfMYfuk=N2qwh4skzffM5PT5hu5HXCPiZOZiAgdj=Eg@mail.gmail.com>
 <4FE5D57B.7090603@ruff.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FE5D57B.7090603@ruff.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruslan,

On Sat, Jun 23, 2012, Ruslan N. Marchenko wrote:
> Anyway - does it make sense to port pcm_bluetooth to Media API
> (media.c)? Or BlueZ team is going to abandon it in favour of PA in
> any case? I mean if someone submit patches for pcm on Media API is
> there chance for patches to be accepted?

I doubt this would make it in time for BlueZ 5, but I don't think
there'd be any objections to accepting a patch later that adds an ALSA
user space plugin with a clean implementation for the Media interface.

Johan
