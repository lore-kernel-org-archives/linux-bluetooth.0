Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Dec 2011 12:00:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] attrib-server: Initial steps towards multi-adapter
 GATT server support
Message-ID: <20111227100059.GA5379@x220.P-661HNU-F1>
References: <1324396681-27276-1-git-send-email-sancane@gmail.com>
 <1324396681-27276-2-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324396681-27276-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Dec 20, 2011, Santiago Carot-Nemesio wrote:
> +struct gatt_adapter {
> +	struct btd_adapter *adapter;
> +	GIOChannel *l2cap_io;
> +	GIOChannel *le_io;
> +};

Could we just call this struct attrib_server? That would be less
confusing than having different types of adapters when in reality you
only have one adapter. What we have here is an attrib server running on
a specific adapter, so struct attrib_server would make most sense to me.
Also update the corresponding function names to reflect this.

Johan
