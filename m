Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jan 2012 12:54:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] gobex: fix not disabling SRM when dealing with
 GET responses
Message-ID: <20120123105427.GB13100@x220>
References: <1327266423-1033-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327266423-1033-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Jan 22, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> While sending the final bit can be changed during encoding.
> ---
>  gobex/gobex.c |  218 ++++++++++++++++++++++++++++++---------------------------
>  1 files changed, 115 insertions(+), 103 deletions(-)

Both patches have been applied. Thanks.

Johan
