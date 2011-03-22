Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Mar 2011 12:43:55 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add release all sessions when adapter is switched off
Message-ID: <20110322104355.GC28726@jh-x301>
References: <1300721959-5913-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300721959-5913-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Mon, Mar 21, 2011, Dmitriy Paliy wrote:
> All sessions should be released when adapter is switched off. Then a new
> RequestSession method call always results in change from power off to power
> on such ensuring operational mode. Otherwise, it is possible to end up in
> adapter state being powered off after RequestSession succeded.
> ---
>  src/adapter.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index cc4f43e..f1c0e2a 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2507,6 +2507,10 @@ static void set_mode_complete(struct btd_adapter *adapter)
>  
>  	DBG("");
>  
> +	if (adapter->mode == MODE_OFF)
> +		g_slist_foreach(adapter->mode_sessions, (GFunc)  session_free,
> +									NULL);
> +

Don't you have to do g_slist_free() and adapter->mode_sessions = NULL
too? Oh, and you've got two spaces between (GFunc) and session_free :)

Johan
