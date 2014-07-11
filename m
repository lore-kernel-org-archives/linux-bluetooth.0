Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Jul 2014 13:59:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Move struct sco_pinfo into
 net/bluetooth/sco.c
Message-ID: <20140711105941.GF14378@t440s.P-661HNU-F1>
References: <1405052384-5981-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405052384-5981-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 11, 2014, Marcel Holtmann wrote:
> There exists no external user of struct sco_pinfo and sco_pi and
> thus move it into the one place that is actually using it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/sco.h | 12 ------------
>  net/bluetooth/sco.c         | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 12 deletions(-)

All four patches have been applied to bluetooth-next. Thanks.

Johan
