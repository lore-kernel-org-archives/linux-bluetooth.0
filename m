Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Apr 2011 19:48:19 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix check for valid SCO socket before shutdown
Message-ID: <20110405024819.GA29805@jh-x301>
References: <BANLkTi=ce+qfeS14zX-k0qrt75iGP1d7ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTi=ce+qfeS14zX-k0qrt75iGP1d7ig@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Fri, Apr 01, 2011, Daniel Örstadius wrote:
> To prevent a crash in the event that there is a request to remove
> the audio connection when it has already been disconnected by the
> remote.
> 
> Set headset state to connected directly if there is no SCO socket.
> ---
>  audio/headset.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
