Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Oct 2012 13:48:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] AVCTP: Fix scope of transactions to be per channel
Message-ID: <20121031114858.GA28554@x220>
References: <1351677897-2580-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351677897-2580-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 31, 2012, Luiz Augusto von Dentz wrote:
> As per AVRCP spec:
> 
>   "It should be noted that transaction labels are scoped to an AVCTP
>   channel, so an AVRCP specific AV/C command and an AVRCP specific
>   browsing command may be outstanding at the same time with the same
>   transaction label."
> ---
>  audio/avctp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
