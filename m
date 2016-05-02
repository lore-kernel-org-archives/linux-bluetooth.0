Return-Path: <hannes@stressinduktion.org>
Subject: Re: [PATCHv2 bluetooth-next 03/10] 6lowpan: remove ipv6 module
 request
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
References: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
 <1461140382-4784-4-git-send-email-aar@pengutronix.de>
Cc: kernel@pengutronix.de, marcel@holtmann.org,
 jukka.rissanen@linux.intel.com, stefan@osg.samsung.com, mcr@sandelman.ca,
 werner@almesberger.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <95742016-d41a-c62b-d77a-ea35671be931@stressinduktion.org>
Date: Mon, 2 May 2016 21:06:59 +0200
MIME-Version: 1.0
In-Reply-To: <1461140382-4784-4-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 20.04.2016 10:19, Alexander Aring wrote:
> Since we use exported function from ipv6 kernel module we don't need to
> request the module anymore to have ipv6 functionality.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>

Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
