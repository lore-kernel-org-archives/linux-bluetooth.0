Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Feb 2011 15:28:06 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix DBG() calls with bogus messages
Message-ID: <20110224182806.GB16528@jh-x301>
References: <1298467707-11121-1-git-send-email-anderson.lizardo@openbossa.org>
 <1298484663-19369-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298484663-19369-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Feb 23, 2011, Anderson Lizardo wrote:
> Remove unnecessary trailing newlines (already added by DBG()) and
> rewrite debug messages to become more useful.
> ---
>  audio/telephony-ofono.c |    2 +-
>  plugins/service.c       |    5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
