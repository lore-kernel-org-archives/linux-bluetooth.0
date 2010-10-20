Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Oct 2010 12:02:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] audio/device.h: use lower case in profile UUIDs
Message-ID: <20101020090249.GA7955@jh-x301>
References: <AANLkTinAybAb8Kyux0keA26_ASVDFZFMu3vAB_5ke2zo@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTinAybAb8Kyux0keA26_ASVDFZFMu3vAB_5ke2zo@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Wed, Oct 20, 2010, Daniel Örstadius wrote:
> BlueZ seems to use lower case when emitting signals containing
> UUIDs retrived from a remote device.
> 
> The definitions affected by this patch look to be used for example
> if the remote connects an audio profile which BlueZ has not
> discovered (perhaps it had not yet browsed the service records of
> the remote).
> 
> In that case the format of the stored and emitted UUID should be
> consistent with the UUIDs received during service discovery.
> ---
>  audio/device.h |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)

Looks fine to me. Pushed upstream. Thanks.

Johan
