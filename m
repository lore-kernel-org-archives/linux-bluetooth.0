Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Nov 2010 14:32:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Fix not canceling pending calls on maemo6
 telephony driver exit
Message-ID: <20101130123245.GB9714@jh-x301>
References: <1291119975-9460-1-git-send-email-luiz.dentz@gmail.com>
 <1291119975-9460-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291119975-9460-3-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Nov 30, 2010, Luiz Augusto von Dentz wrote:
> +	g_slist_foreach(pending, (GFunc) remove_pending, NULL);
> +	g_slist_free(pending);

Maybe GLib can handle removing the items in the foreach callback, but I
think it'd be better to just use pending_call_unref in this case.

Johan
