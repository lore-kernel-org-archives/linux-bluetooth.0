Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Dec 2014 14:14:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 1/3] lib: Add start service discovery
Message-ID: <20141204121436.GA22490@t440s.lan>
References: <1417218663-5406-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417218663-5406-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Fri, Nov 28, 2014, Jakub Pawlowski wrote:
> This patch adds start service discovery definition for new kernel
> method.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  lib/mgmt.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

These three patches have been applied now so we can proceed with getting
the kernel patches tested and upstream (regardless of whether we go with
your original ones or the new ones from Marcel).

I did have to remove the Signed-off-by lines first however since we
don't use that for user space patches.

Johan
