Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Mar 2015 12:48:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Drake <drake@endlessm.com>
Cc: marcel@holtmann.org, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: btusb: Add helper for READ_LOCAL_VERSION
 command
Message-ID: <20150313104852.GA23835@t440s.lan>
References: <1424737007-4791-1-git-send-email-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424737007-4791-1-git-send-email-drake@endlessm.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Mon, Feb 23, 2015, Daniel Drake wrote:
> Multiple codepaths duplicate some simple code to read and
> sanity-check local version information. Before I add a couple more
> such codepaths, add a helper to reduce duplication.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
>  drivers/bluetooth/btusb.c | 60 ++++++++++++++++++++++-------------------------
>  1 file changed, 28 insertions(+), 32 deletions(-)
> 
> v3:
>  - rebase on top of latest bluetooth-next
> 
> v2:
>  - drop log message (let callers do that)
>  - avoid long assignment in variable declaration

Applied to bluetooth-next. Thanks.

Johan
