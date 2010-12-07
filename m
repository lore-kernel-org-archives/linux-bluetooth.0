Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 23:03:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/9] Add btd_error_not_supported()
Message-ID: <20101207210339.GA25558@jh-x301>
References: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-2-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-3-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291662648-10651-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Dec 06, 2010, Gustavo F. Padovan wrote:
> -		return g_dbus_create_error(msg,
> -					ERROR_INTERFACE ".NotSupported",
> -					"Kernel lacks blacklist support");
> +		return btd_error_not_supported(msg);

I'm not sure I agree with this. The specific error message would give
hints to the user that he might need to update his kernel but the
generic one doesn't give any such hints. Couldn't you have the
btd_error_not_supported function take one extra cont char *msg
parameter? I had a little bit similar feelings about the ALREADY_EXISTS
patch (which I already pushed) but here the issue of loosing the
specifics of the error is more obvious.

Johan
