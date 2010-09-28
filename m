Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Sep 2010 11:10:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix not detecting errors when transferring the last
 part of the buffer
Message-ID: <20100928081040.GA20782@jh-x301>
References: <1285660345-1819-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285660345-1819-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Sep 28, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> The last part has to be flushed in order to sent the remaining buffer as
> a obex packet and detect possible errors.
> ---
>  client/transfer.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
