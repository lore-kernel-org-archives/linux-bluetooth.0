Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Apr 2012 12:57:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 1/1] core: Fix adapter mode inconsistency
Message-ID: <20120423095716.GA6922@x220>
References: <1335170075-12363-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1335170075-12363-2-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335170075-12363-2-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Apr 23, 2012, Mikel Astiz wrote:
> The mode change in btd_adapter_start() doesn't check if the adapter is
> discoverable, creating an inconsistency between the plugin and the core.
> 
> Using the management interface it is easy to reproduce the problem, by
> starting BlueZ while the adapter is discoverable. After this, the state
> cannot be changed.
> ---
>  src/adapter.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Thanks. Applied, but I really wish we could clean up and simplify this
code. Probably adapter->mode and adapter->scan_mode should be completely
removed and new connectable and discoverable boolean variables added
(since this is how the mgmt API anyway presents these settings).

Johan
