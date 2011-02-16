Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Feb 2011 12:01:59 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] telephony-maemo6: fix not cleaning up active calls
 list on exit
Message-ID: <20110216150159.GB21777@jh-x301>
References: <1297861505-22296-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297861505-22296-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Feb 16, 2011, Luiz Augusto von Dentz wrote:
> This can cause problem if the adapter is reset in the middle of a call
> the indicators won't be update properly.
> ---
>  audio/telephony-maemo6.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
