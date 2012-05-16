Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 11:01:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add dbus service file that references the systemd unit
Message-ID: <20120516080134.GA27987@x220>
References: <6c5b002c86eeb1c83d4b7ca771e0f43ffaded710.1337072284.git.eternaleye@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6c5b002c86eeb1c83d4b7ca771e0f43ffaded710.1337072284.git.eternaleye@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Tue, May 15, 2012, Alex Elsayed wrote:
> This allows bluez to be bus-activated.
> ---
>  Makefile.am              |    2 ++
>  configure.ac             |    2 +-
>  src/org.bluez.service.in |    6 ++++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>  create mode 100644 src/org.bluez.service.in

The patch looks ok'ish to me but you have to clean it up since it
doesn't apply:

Applying: Add dbus service file that references the systemd unit
/home/jh/src/bluez/.git/rebase-apply/patch:44: new blank line at EOF.
+
fatal: 1 line adds whitespace errors.
Patch failed at 0001 Add dbus service file that references the systemd unit

If you wanna catch this kind of stuff yourself in the future add the
following to your .gitconfig:

[apply]
	whitespace = error

Johan
