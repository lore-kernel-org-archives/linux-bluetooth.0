Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Oct 2010 10:38:28 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Fix possible NULL pointer deference
Message-ID: <20101012093828.GA23502@jh-x301>
References: <1286870891-5862-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286870891-5862-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 12, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Variable "os->driver" tracked as NULL.
> ---
>  src/obex.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
