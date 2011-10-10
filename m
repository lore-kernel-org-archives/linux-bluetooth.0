Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 10:19:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/9] Unregister Health Thermometer Interface
Message-ID: <20111010071954.GD4094@fusion.localdomain>
References: <1317303988-26310-1-git-send-email-sancane@gmail.com>
 <1317303988-26310-2-git-send-email-sancane@gmail.com>
 <1317303988-26310-3-git-send-email-sancane@gmail.com>
 <1317303988-26310-4-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317303988-26310-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, Sep 29, 2011, Santiago Carot-Nemesio wrote:
> +	l = g_slist_find_custom(thermometers, device, cmp_device);
> +	if (!l)

Same thing as I mentioned previously about comparing pointers.

Johan
