Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 10:24:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/9] Add handler function to manage GATT indications
Message-ID: <20111010072414.GF4094@fusion.localdomain>
References: <1317303988-26310-1-git-send-email-sancane@gmail.com>
 <1317303988-26310-2-git-send-email-sancane@gmail.com>
 <1317303988-26310-3-git-send-email-sancane@gmail.com>
 <1317303988-26310-4-git-send-email-sancane@gmail.com>
 <1317303988-26310-5-git-send-email-sancane@gmail.com>
 <1317303988-26310-6-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317303988-26310-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, Sep 29, 2011, Santiago Carot-Nemesio wrote:
> @@ -40,6 +40,7 @@ struct thermometer {
>  	GAttrib			*attrib;	/* GATT connection */
>  	struct att_range	*svc_range;	/* Thermometer range */
>  	gint                    attioid;	/* Att watcher id */
> +	gint			attindid;	/* Att incications id */

I suspect this should also be a guint?

> +	if (t->attindid)

attindid > 0

> +	if (t->attindid) {
> +		g_attrib_unregister(t->attrib, t->attindid);
> +		t->attindid = 0;
> +	}

attindid > 0

Johan
