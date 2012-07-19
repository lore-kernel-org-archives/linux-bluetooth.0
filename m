Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 14:22:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] AVCTP: Make use of sendmsg to avoid copying data
Message-ID: <20120719112253.GA17617@x220>
References: <1342694975-9184-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342694975-9184-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jul 19, 2012, Luiz Augusto von Dentz wrote:
> This use sendmsg to send headers and operands in separated buffers
> avoiding memcpy.
> ---
>  audio/avctp.c |   21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Applied. Thanks.

Johan
