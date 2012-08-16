Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 10:36:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] mgmt: Fix Set LE command complete
Message-ID: <20120816073640.GA26600@x220>
References: <1345065240-9250-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345065240-9250-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Aug 15, 2012, Andre Guedes wrote:
> Once we get a Set LE command complete event, we should update
> current_settings from the controller_info. Otherwise, features
> which depend on that, such as device discovery, will not work
> properly.
> ---
>  src/mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both patches have been applied. Thanks.

Johan
