Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Jul 2010 10:28:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lennart Poettering <lennart@poettering.net>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] systemd: install systemd unit files
Message-ID: <20100722072848.GA10401@jh-x301>
References: <20100721220828.GA7799@tango.0pointer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100721220828.GA7799@tango.0pointer.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lennart,

On Thu, Jul 22, 2010, Lennart Poettering wrote:
> This also enables bus activation for bluetoothd, but only if systemd is
> running. Only if that's the case we can make sure in a race-free fashion
> that bluetoothd is not started twice at the same time.
> ---
>  Makefile.am                  |   21 ++++++++++++++++++---
>  configure.ac                 |    9 +++++++++
>  scripts/.gitignore           |    1 +
>  scripts/bluetooth.service.in |   12 ++++++++++++
>  scripts/org.bluez.service    |    5 +++++
>  5 files changed, 45 insertions(+), 3 deletions(-)
>  create mode 100644 scripts/.gitignore
>  create mode 100644 scripts/bluetooth.service.in
>  create mode 100644 scripts/org.bluez.service

Looks fine to me, but I'll let Marcel handle pushing it upstream since
he had issues with the previous version (on IRC) that I didn't see
myself.

Johan
