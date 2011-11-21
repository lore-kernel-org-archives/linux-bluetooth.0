Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 14:18:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] gobex: fix removing wrong id on transfer_free
Message-ID: <20111121121840.GA12137@fusion.localdomain>
References: <1321876791-30239-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321876791-30239-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Nov 21, 2011, Luiz Augusto von Dentz wrote:
> If statement checks for get_id handle but was removing req_id.
> ---
>  gobex/gobex-transfer.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
