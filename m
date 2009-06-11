Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Jun 2009 14:37:31 +0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alokbarsode@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH 1/2] Adding start_discovery to hciops plugin.
Message-ID: <20090611073731.GA23159@jh-x301>
References: <1244636441-22878-1-git-send-email-alok.barsode@azingo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244636441-22878-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Wed, Jun 10, 2009, alokbarsode@gmail.com wrote:
> From: Alok Barsode <alok.barsode@azingo.com>
> 
> ---
>  plugins/hciops.c |   42 +++++++++++++++++
>  src/adapter.c    |  133 +++++++++---------------------------------------------
>  src/adapter.h    |    3 +-
>  src/dbus-hci.c   |    5 ++-
>  4 files changed, 69 insertions(+), 114 deletions(-)

Pushed upstream. Thanks.

Johan
