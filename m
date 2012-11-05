Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Nov 2012 10:30:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Enable reconnection in Proximity monitor
Message-ID: <20121105083011.GA18838@x220>
References: <1352061107-23757-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352061107-23757-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Sun, Nov 04, 2012, Andre Guedes wrote:
> According to Proximity Profile spec, when a connection is terminated
> due to link loss a Proximity Monitor should attempt to reconnect.
> ---
>  profiles/proximity/monitor.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
