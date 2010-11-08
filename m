Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Nov 2010 14:33:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/9] Fixing DBus error system in BlueZ
Message-ID: <20101108123330.GA1751@jh-x301>
References: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Nov 08, 2010, Gustavo F. Padovan wrote:
> Here are some patches that try to fix the mess of reporting error to
> DBus inside BlueZ. It follows the oFono and ConnMan error system.
> 
> The goal is to get ride of any directly call to g_dbus_create_error()
> inside bluez code, changing that to __btd_error_*. This patch set
> doesn't fix all of them yet, but is a very good start. Please review.
> 
> 
> Gustavo F. Padovan (9):
>   Create __btd_error_invalid_args()
>   Add __btd_error_already_exists()
>   Add __btd_error_not_supported()
>   Add __btd_error_not_connected()
>   Add __btd_error_in_progress()
>   Add __btd_error_not_available()
>   Add __btd_error_busy()
>   Add __btd_error_does_not_exist()
>   Add __btd_error_not_authorized()

The patches seem fine to me, but before pushing upstream I'd like to
understand the reason for prefixing these with  with __btd instead of
btd. What's the criteria used to decide what to use and when and why is
__btd the correct choice for these new functions? My first guess would
have been that __btd is for things only accessible by the core-daemon
whereas btd is for functions exported to plugins, but that doesn't seem
to be the case with your patches since many of these __btd functions get
called from plugins.

Johan
