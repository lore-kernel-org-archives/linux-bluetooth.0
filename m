Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Feb 2011 01:22:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix sending HCIDEVUP when adapter is already up
Message-ID: <20110201232213.GA6375@jh-x301>
References: <1296575248-20185-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296575248-20185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Feb 01, 2011, Luiz Augusto von Dentz wrote:
> There is no need for HCIDEVUP/fork in such cases it will just consume
> more resources for no reason.
> 
> To fix this HCI_DEV_REG is no longer generate for adapter already up
> instead init_device is called directly which simplify the code path.
> ---
>  plugins/hciops.c |   15 +++++++++++----
>  1 files changed, 11 insertions(+), 4 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
