Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Dec 2010 16:00:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Check the security level on a per request base
Message-ID: <20101209140050.GA27789@jh-x301>
References: <1291900153-8541-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291900153-8541-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Thu, Dec 09, 2010, Bruna Moreira wrote:
> Check security level on attribute server on each request, and update the
> "encrypted" flag.
> ---
>  attrib/gattrib.c    |   13 +++++++++++++
>  attrib/gattrib.h    |    2 ++
>  src/attrib-server.c |    7 ++-----
>  3 files changed, 17 insertions(+), 5 deletions(-)

Pushed upstream. Thanks.

Johan
