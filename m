Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Jun 2012 11:41:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] AVDTP: Fix rejecting AVDTP_START if starting flag
 is set
Message-ID: <20120618084155.GA23069@x220>
References: <1339836447-3100-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339836447-3100-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sat, Jun 16, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This is now handled by checking if the command collided.
> ---
>  audio/avdtp.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
