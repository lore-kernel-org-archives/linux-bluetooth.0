Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Mar 2011 18:10:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Don't disable LE scan when started by external
 tools
Message-ID: <20110329151032.GA13884@jh-x301>
References: <1301409581-16057-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301409581-16057-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Mar 29, 2011, Claudio Takahasi wrote:
> This patch removes the automatic LE scan disabling when it is not
> triggered through the StartDiscovery() method.
> ---
>  src/adapter.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Both of these patches have been pushed upstream. Thanks.

Could you next send a patch to create a proper define for this
hard-coded value 5120? That should never have made it to the upstream
tree to begin with.

Johan
