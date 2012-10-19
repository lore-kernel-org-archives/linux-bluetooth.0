Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Oct 2012 10:34:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] gdbus: Remove connection from pending_property
 functions
Message-ID: <20121019073438.GA2243@x220>
References: <1350486869-5020-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350486869-5020-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Oct 17, 2012, Lucas De Marchi wrote:
> The reply to a DBus.Properties.Set() method call should go through the
> same D-Bus connection. Thus remove the DBusConnection parameter from the
> following functions:
> 
>     - g_dbus_pending_property_success()
>     - g_dbus_pending_property_error_valist()
>     - g_dbus_pending_property_error()
> ---
>  gdbus/gdbus.h  | 13 +++++--------
>  gdbus/object.c | 24 ++++++++++++------------
>  2 files changed, 17 insertions(+), 20 deletions(-)

Both patches have been applied. Thanks.

Johan
