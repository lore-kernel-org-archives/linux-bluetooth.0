Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "Hedberg, Johan" <johan.hedberg@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 27 Jul 2011 11:05:13 +0800
Subject: RE: [PATCH] fixing crash in irmc.c when vcard=0
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473697B5976@shsmsx501.ccr.corp.intel.com>
References: <1310714442-14565-1-git-send-email-wu.zheng@intel.com>
 <20110726092909.GB28891@dell>
In-Reply-To: <20110726092909.GB28891@dell>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

For your comments, I will send the patch again after modifying git settings.

Best regards
Zheng wu

> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@intel.com]
> Sent: Tuesday, July 26, 2011 5:29 PM
> To: Zheng, Wu
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] fixing crash in irmc.c when vcard=0
> 
> Hi,
> 
> On Fri, Jul 15, 2011, zheng wu wrote:
> > When using sync profile, if getting the number of vcard is 0 in
> server,obexd will crash.
> > The reason is that the null point is used in query_result of
> irmc.c.The patch is for fixing it.
> > Signed-off-by: wu.zheng@intel.com
> > ---
> >  plugins/irmc.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> The patch itself seems ok to me, but you need to fix your git settings:
> 
> 1. Don't use Signed-off-by (this is only used for kernel patches).
> 2. Format your commit message lines to max 72 characters
> 3. Fix your git author name (first letter capitalized, etc.)
> 
> Johan
