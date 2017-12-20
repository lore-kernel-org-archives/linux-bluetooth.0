Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 20 Dec 2017 09:54:12 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: sbrown@cortland.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mesh: meshctl: Make composition-get argument optional
Message-ID: <20171220085412.GA26006@x1c>
References: <20171219212759.19918-1-sbrown@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219212759.19918-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Tue, Dec 19, 2017, sbrown@cortland.com wrote:
> It can't be both optional and required.
> 
> [config: Target = 0100]# composition-get 0
> Unable to parse optional command arguments
> ---
>  mesh/config-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
