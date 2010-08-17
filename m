Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Aug 2010 11:28:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Add mode callback to btd_adapter
Message-ID: <20100817082818.GA19380@jh-x301>
References: <AANLkTi=Jh5fsqye6-Ry+VSNWftufDFCdyNEn6fcNrW84@mail.gmail.com>
 <20100813124102.GA3546@jh-x301>
 <AANLkTi=afUGqbZy1fRmHsPFQQyFWkEUwi+4tYT22N2az@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=afUGqbZy1fRmHsPFQQyFWkEUwi+4tYT22N2az@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Fri, Aug 13, 2010, Daniel Örstadius wrote:
> From: Daniel Orstadius <daniel.orstadius@nokia.com>
> Date: Fri, 13 Aug 2010 16:38:08 +0300
> Subject: [PATCH] Add powered callback to btd_adapter
> 
> With this patch callback functions can be registered to the
> btd_adapter struct. The functions are then called when the powered
> state of the adapter changes, with a boolean argument indicating
> the new state. The reason for adding the functionality is that the
> Maemo6 MCE plugin needs to be notified when the adapter is powered
> on or off.
> ---
>  src/adapter.c |   32 ++++++++++++++++++++++++++++++++
>  src/adapter.h |    7 +++++++
>  2 files changed, 39 insertions(+), 0 deletions(-)

Thanks. This patch is now pushed upstream.

Johan
