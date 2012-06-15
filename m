Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jun 2012 12:30:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/8] audio: Fix handling of a2dp suspend indication
Message-ID: <20120615093013.GA28900@x220>
References: <1339747468-31639-1-git-send-email-luiz.dentz@gmail.com>
 <1339747468-31639-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339747468-31639-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jun 15, 2012, Luiz Augusto von Dentz wrote:
> @@ -985,6 +985,9 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
>  				void *user_data)
>  {
>  	struct a2dp_sep *a2dp_sep = user_data;
> +	struct a2dp_setup *setup;
> +	gboolean start;
> +	int perr;

Could you just call this start_err?

Why isn't err used in this function?

> +	perr = avdtp_start(session, a2dp_sep->stream);
> +	if (perr < 0) {
> +		error("Error on avdtp_start %s (%d)", strerror(-perr), -perr);
> +		finalize_setup_errno(setup, -EIO, finalize_resume);

Why aren't you passing perr instead of -EIO to finalize_setup_errno? If
there's a valid reason for ignoring the specific value you should at
least add a code comment for it.

Johan
