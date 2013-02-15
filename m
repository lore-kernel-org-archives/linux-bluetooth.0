Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2013 10:46:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: Re: [PATCH 09/14] neard: Use path instead of boolean to track if
 registered to neard
Message-ID: <20130215084600.GB5750@x220>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
 <1360224844-12280-10-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360224844-12280-10-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Feb 07, 2013, Szymon Janc wrote:
> ---
>  plugins/neard.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)

Patches 1-8 have been applied but this one had something that imo needs
fixing:

> -static gboolean agent_registered = FALSE;
> +static char *neard_path = NULL;
>  static gboolean agent_register_postpone = FALSE;
>  
>  /* For NFC mimetype limits max OOB EIR size */
> @@ -115,7 +115,7 @@ static void register_agent_cb(DBusPendingCall *call, void *user_data)
>  	}
>  
>  	dbus_message_unref(reply);
> -	agent_registered = TRUE;
> +	neard_path = g_strdup(dbus_message_get_sender(reply));

If you're going to store the neard D-Bus name in this variable then
please don't call it "path". That's just confusing. Use neard_name or
neard_service instead.

Johan
