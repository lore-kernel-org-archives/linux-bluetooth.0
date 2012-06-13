Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jun 2012 17:57:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] mgmtops: Handle EBUSY status from MGMT_OP_ADD_UUID
 commands
Message-ID: <20120613145718.GA8894@x220.P-661HNU-F1>
References: <1339596233-16643-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339596233-16643-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jun 13, 2012, Szymon Janc wrote:
> MGMT_OP_ADD_UUID may fail with EBUSY due to ongoing CoD update. In case
> of EBUSY error wait for Class Of Device changed event before adding
> more UUIDs.
> ---
>  plugins/mgmtops.c |   59 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 50 insertions(+), 9 deletions(-)

Both patches have been applied. Thanks.

Johan
