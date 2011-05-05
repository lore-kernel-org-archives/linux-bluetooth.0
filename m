Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 May 2011 12:16:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH 1/3] Remove connectable checking when creating a device
Message-ID: <20110505091603.GA3017@jh-x301>
References: <1304518429-8527-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304518429-8527-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, May 04, 2011, Anderson Lizardo wrote:
> Kernel advertising cache will be used to infer the LE address type
> and if it is connectable. For kernels without cache patches, only
> LE public address is supported and if the remote is non-connectable,
> the connection will fail after the L2CAP timeout(~40s).
> 
> Note: currently, CreateDevice misbehaves when LE Create Connection
> command times out for any reason (e.g. peer device left connectable
> mode). This is being investigated and will be fixed in a separate patch.
> ---
>  src/adapter.c |   30 +++---------------------------
>  1 files changed, 3 insertions(+), 27 deletions(-)

All three patches have been pushed upstream. Thanks.

Johan
