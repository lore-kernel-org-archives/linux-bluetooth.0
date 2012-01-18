Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jan 2012 14:27:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] client: fix not being able to read apparams when
 transfer is complete
Message-ID: <20120118122706.GB11023@x220>
References: <1326886657-10264-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326886657-10264-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jan 18, 2012, Luiz Augusto von Dentz wrote:
> Transfer id/xfer is set to zero when it is completed which should not
> prevent the profiles to read the apparam of the last response.
> ---
>  client/transfer.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
