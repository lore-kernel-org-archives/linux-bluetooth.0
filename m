Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Oct 2012 11:09:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] heartrate: Always write measurement CCC on discovery
Message-ID: <20121017080914.GA1277@x220.ger.corp.intel.com>
References: <1350460293-31316-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350460293-31316-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, Oct 17, 2012, Andrzej Kaczmarek wrote:
> Measurement CCC is written during discovery only in case watcher is
> registered and notifications shall be enabled. However, it may happen
> that (e.g. during reconnection scenario) notifications are already
> enabled on remote but watcher is no longer registered and we will
> be receiving unwanted notifications.
> 
> This patch makes sure measurement CCC is written to proper value
> every time it's discovered during connection.
> ---
>  profiles/heartrate/heartrate.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)

Applied. Thanks.

Johan
