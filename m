Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Nov 2012 10:15:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] hciconfig: Add an option to set which advertise
 type will be on
Message-ID: <20121122081512.GA3114@x220>
References: <1353506992-3371-1-git-send-email-jefferson.delfes@openbossa.org>
 <1353528971-17861-1-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353528971-17861-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

On Wed, Nov 21, 2012, Jefferson Delfes wrote:
> There are some advertise types that can be used, so we need a way to
> tell which one we want. The default one is ADV_IND.
> ---
>  tools/hciconfig.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 69 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
