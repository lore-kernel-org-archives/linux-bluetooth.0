Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1320834266-2476-1-git-send-email-radoslawjablonski@gmail.com>
References: <1320834266-2476-1-git-send-email-radoslawjablonski@gmail.com>
Date: Wed, 9 Nov 2011 11:53:59 +0100
Message-ID: <CADUB2Y5k7+4cqasnsgmDCfu_Eor70kaag=fXTrdQr3X+PNZr-w@mail.gmail.com>
Subject: Re: [PATCH obexd] Add cleanup of '.pcsuite' file on pcsuite_init
From: Radek <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI,

On Wed, Nov 9, 2011 at 11:24 AM, Radoslaw Jablonski
<radoslawjablonski@gmail.com> wrote:
> File named '.pcsuite' is used to show to other applications
> that PC-Suite connection is active - some operations shouldn't
> be performed on device when synchronization is in progress.
> In scenario when obexd will be killed or crashed during PC-Suite
> connection this file will stay forever in filestystem, because
> pcsuite_disconnect won't be called to do clean-up.
>
> This patch adds function which will remove '.pcsuite' file
> in such problematic scenarios on pcsuite_init.
> ---
>  plugins/pcsuite.c |   24 +++++++++++++++++++++++-
>  1 files changed, 23 insertions(+), 1 deletions(-)

I've forgot to add (void) as param for pcsuite_file_cleanup func.
Please ignore this one - I'll send second version of patch for this in a minute.

BR,
Radek
