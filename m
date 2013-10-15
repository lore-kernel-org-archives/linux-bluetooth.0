Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 09:58:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio/AVCTP: Fix sending requests with same
 transaction id
Message-ID: <20131015065819.GB21914@x220.p-661hnu-f1>
References: <1381754763-27278-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381754763-27278-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 14, 2013, Luiz Augusto von Dentz wrote:
> If a request is outstanding in the processed list its transaction shall
> not be reused as it can cause the wrong callback to be called.
> 
> This can be reproduced in very rare occasions where e.g. a notification
> using the same transaction of the current request arrives before the
> response itself.
> ---
>  profiles/audio/avctp.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Applied. Thanks.

Johan
