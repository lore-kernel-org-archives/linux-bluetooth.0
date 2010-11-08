Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Nov 2010 18:15:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix possible crash when removing disconnect watches
Message-ID: <20101108161501.GA5805@jh-x301>
References: <1289227432-13354-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289227432-13354-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Nov 08, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> The callback may have remove itself before returning.
> ---
>  src/device.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
