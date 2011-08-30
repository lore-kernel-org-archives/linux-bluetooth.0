Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Aug 2011 13:13:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Burt Silverman <burtms@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Print an error message if g_dbus_setup_bus fails.
Message-ID: <20110830101330.GA20724@dell>
References: <1314398341-2733-1-git-send-email-burtms@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314398341-2733-1-git-send-email-burtms@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Burt,

On Fri, Aug 26, 2011, Burt Silverman wrote:
> That is standard processing when dbus_error_is_set() returns true, according to
> dbus/dbus/dbus-errors.c.
> In this case of g_dbus_setup_bus(), it provides extra help for determing the
> specific cause of the error.
> ---
>  src/main.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Applied (after I made the message prefix a bit more descriptive).
Thanks.

Johan
