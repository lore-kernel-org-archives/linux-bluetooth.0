Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 14:10:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] tools: Fix update_compids.sh to avoid non-ASCII
 output
Message-ID: <20131002111002.GB26752@x220.p-661hnu-f1>
References: <1380642366-5726-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380642366-5726-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Oct 01, 2013, Anderson Lizardo wrote:
> Some distros have html2text patches that may generate non-ASCII output
> even when -ascii is used. This patch adds another case (seen in Fedora)
> where HTML entity &#160; (non-breaking space) is converted into a
> multibyte whitespace.
> 
> Also add a sanity check to make sure non-ASCII text is not introduced in
> lib/bluetooth.c.
> ---
>  tools/update_compids.sh |   17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
