Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 May 2012 23:44:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Blueooth: Remove hlen variable
Message-ID: <20120503204410.GA21912@x220.P-661HNU-F1>
References: <1336031661-29266-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336031661-29266-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, May 03, 2012, Gustavo Padovan wrote:
> hlen has a fixed size of L2CAP_HDR_SIZE, use this instead.
> 
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
>  net/bluetooth/l2cap_core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to bluetooth-next (after doing s/Blueooth/Bluetooth/)

Johan
