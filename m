Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 14:47:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] client: Fix sending GET while SRM is active
Message-ID: <20120214124733.GB19427@x220.ger.corp.intel.com>
References: <1329128142-26867-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329128142-26867-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Feb 13, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If SRM is active remote will be generating responses automatically
> ---
>  client/transfer.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
