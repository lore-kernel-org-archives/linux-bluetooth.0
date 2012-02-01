Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Jan 2012 18:32:56 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/3] btio: add L2ERTM type
Message-ID: <20120201023256.GB10481@x220.globalsuite.net>
References: <1328059536-6379-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328059536-6379-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jan 31, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> L2ERTM type uses L2CAP socket in SOCK_STREAM instead of SOCK_SEQPACKET
> ---
>  btio/btio.c |   17 +++++++++++++++++
>  btio/btio.h |    1 +
>  2 files changed, 18 insertions(+), 0 deletions(-)

All three patches have been applied. I also applied the btio patch to
bluez.git.

Johan
