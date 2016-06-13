Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 13 Jun 2016 12:11:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] core/service: Allow disconnected -> connected state
 change
Message-ID: <20160613091100.GA10852@t440s>
References: <20160610132139.GA2514@mkoskar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160610132139.GA2514@mkoskar.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Miroslav,

On Fri, Jun 10, 2016, Miroslav Koskar wrote:
> By ignoring case where service->state == BTD_SERVICE_STATE_DISCONNECTED
> in btd_service_connecting_complete(), state_callbacks don't get
> executed. Such case occurs when e.g., phone using a2dp-source profile
> connects to the bluez. Because no state_callbacks are executed
> (including one added by policy plugin) no reconnection is attempted
> after connection timeout, although if situation is reversed (bluez
> connects to the phone) reconnection works.
> ---
>  src/service.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
