Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jul 2009 23:46:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alokbarsode@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH 1/1] Fixing bluetoothd to avoid passing device
	descriptor
Message-ID: <20090707204621.GA13353@jh-x301>
References: <1246964577-25157-1-git-send-email-alok.barsode@azingo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246964577-25157-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Tue, Jul 07, 2009, alokbarsode@gmail.com wrote:
> From: Alok Barsode <alok.barsode@azingo.com>
> 
> ---
>  plugins/hal.c  |    4 +-
>  src/adapter.c  |  131 ++++++++++++++++++++++++++++++++++++++++++--------------
>  src/adapter.h  |    5 ++-
>  src/dbus-hci.c |   45 +------------------
>  src/dbus-hci.h |    4 --
>  5 files changed, 107 insertions(+), 82 deletions(-)

The patch has been pushed upstream. Thanks!

Johan
