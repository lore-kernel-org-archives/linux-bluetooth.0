Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 13:01:24 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix removing inotify watch whenever an adapter is
 removed
Message-ID: <20110726100124.GD28891@dell>
References: <1311153142-6165-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311153142-6165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jul 20, 2011, Luiz Augusto von Dentz wrote:
> This sometimes cause bluetoothd to burn cpu when an adapter is removed
> from the system.
> 
> Since the watch is not really bond to any adapter, in fact it is added on
> plugin .init, its removal is now moved to plugin .exit.
> ---
>  plugins/adaptername.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
