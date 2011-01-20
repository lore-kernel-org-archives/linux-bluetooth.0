Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Jan 2011 15:02:32 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, vinicius.gomes@openbossa.org,
	claudio.takahasi@openbossa.org, padovan@profusion.mobi,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 1/3] Fix default GATT/ATT MTU sizes
Message-ID: <20110120093232.GB540@jh-x301>
References: <1295474453-8495-1-git-send-email-bgix@codeaurora.org>
 <1295474453-8495-2-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295474453-8495-2-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Wed, Jan 19, 2011, Brian Gix wrote:
> +	if (io == le_io)
> +		channel->mtu = ATT_DEFAULT_LE_MTU;
> +	else
> +		channel->mtu = ATT_DEFAULT_L2CAP_MTU;
> +

I don't think that will work. le_io is the server socket and io is the
new client socket. So they will never be one and the same. Did you
actually test this code?

Johan
