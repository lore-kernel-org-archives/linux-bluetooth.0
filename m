Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 20:44:12 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Remove IMTU and OMTU properties and return its
 values on Acquire reply
Message-ID: <20110119151412.GD2112@jh-x301>
References: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jan 18, 2011, Luiz Augusto von Dentz wrote:
> This should make Acquire blocking friendly since the client no longer has
> to call GetProperties to discover how much it can write/read when using
> the acquired file descriptor.
> ---
>  audio/transport.c |   56 +++++++++++++++++++++++++++++++---------------------
>  doc/media-api.txt |   13 ++---------
>  2 files changed, 36 insertions(+), 33 deletions(-)

Pushed upstream. Thanks.

Johan
