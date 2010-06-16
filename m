Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Jun 2010 13:34:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Add SetProperty method and Debug property
Message-ID: <20100616103444.GB6587@jh-x301>
References: <1276673478-9273-1-git-send-email-gustavo@padovan.org>
 <1276673478-9273-2-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276673478-9273-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Jun 16, 2010, Gustavo F. Padovan wrote:
> +static DBusMessage *set_debug(DBusConnection *conn, DBusMessage *msg,
> +					const char *debug_string, void *data)
> +{
> +	char *old_string;
> +
> +	if (!g_utf8_validate(debug_string, -1, NULL)) {
> +		error("DebugString change failed: supplied string "
> +							"isn't valid UTF-8");
> +		return invalid_args(msg);
> +	}
> +
> +	old_string = __btd_get_debug();
> +
> +	if (strcmp((char *)debug_string, old_string) == 0)

At least according to my manpage of strcmp the input is already const so
the case is unnecessary here. You might also want to use g_str_equal in
this case.

> +	if (!__btd_set_debug((char *)debug_string))

Since __btd_set_debug g_strdup's the input the right fix is to declare
its input parameter as const, and then the need to do a cast here goes
away.

Johan
