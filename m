Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Mar 2013 09:50:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Bluetooth: Check req->err in hci_req_add
Message-ID: <20130308075009.GB817@x220>
References: <1362692892-28716-1-git-send-email-andre.guedes@openbossa.org>
 <1362692892-28716-7-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362692892-28716-7-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Mar 07, 2013, Andre Guedes wrote:
> +	if (req->err)
> +		return;

Same thing here with the error check, I think if (err < 0) is more
consistent.

Johan
