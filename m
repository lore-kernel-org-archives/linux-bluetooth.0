Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Feb 2015 09:59:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] doc/mgmt-api: Add security level to new CSRK events
Message-ID: <20150227075943.GA15199@t440s.lan>
References: <1424966397-24650-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424966397-24650-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 26, 2015, Johan Hedberg wrote:
> In order to distinguish between LE Security Mode 2 levels 1 and 2 we
> need to know whether a CSRK is authenticated or unauthenticated. So far
> this information wasn't available in the New CSRK event from the kernel.
> 
> This patch renames the Master parameter of the event to Type and adds
> two new values to it. The two old values 0x00 and 0x01 still have the
> same meaning as before from the local/remote CSRK perspective. Since we
> so far have not known anything about the security level these values
> must be assumed to be unauthenticated.
> 
> The consequence of this update is that authenticated keys with new
> kernels will simply be ignored by existing code (which only accepts
> values 0x00 and 0x01), however since we haven't really had any code
> doing real signing so far this should be an acceptable compromise.
> ---
>  doc/mgmt-api.txt | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

As no-one raised any objections I went ahead and pushed this patch. Next
I'll work on kernel and user-space patches to implement the changes.

Johan
