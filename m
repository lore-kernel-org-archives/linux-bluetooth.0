Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Jun 2009 14:38:30 +0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alokbarsode@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH 2/2] Adding stop_discovery to hciops.
Message-ID: <20090611073830.GB23159@jh-x301>
References: <1244636452-22901-1-git-send-email-alok.barsode@azingo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244636452-22901-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Wed, Jun 10, 2009, alokbarsode@gmail.com wrote:
> From: Alok Barsode <alok.barsode@azingo.com>
> 
> ---
>  plugins/hciops.c |   27 ++++++++++
>  src/adapter.c    |   42 +++++----------
>  src/adapter.h    |    1 +
>  src/dbus-hci.c   |  153 ------------------------------------------------------
>  src/dbus-hci.h   |    5 --
>  5 files changed, 42 insertions(+), 186 deletions(-)

This one is also pushed upstream. Thanks.

Johan
