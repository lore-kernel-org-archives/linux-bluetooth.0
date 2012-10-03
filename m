Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Oct 2012 11:12:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v9 1/8] core: Mutually exclude concurrent
 connections
Message-ID: <20121003081215.GA12564@x220>
References: <1349198578-2818-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1349198578-2818-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 02, 2012, João Paulo Rechi Vita wrote:
> Since controllers don't support more than one ongoing connection
> procedure at the same time, new connection attempts needs to yield if
> there is an ongoing connection procedure already.
> ---
>  src/adapter.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  src/device.c  |  6 +++---
>  src/device.h  |  2 +-
>  3 files changed, 62 insertions(+), 12 deletions(-)

After a couple of minor coding style cleanups this patch-set has now
been applied. Thanks.

Johan
