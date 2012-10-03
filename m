Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Oct 2012 22:39:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 BlueZ 01/27] doc: Introduce Alert API
Message-ID: <20121003193921.GA32176@x220.P-661HNU-F1>
References: <1349209490-31830-2-git-send-email-anderson.lizardo@openbossa.org>
 <1349268398-14620-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349268398-14620-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Oct 03, 2012, Anderson Lizardo wrote:
> This API will be implemented and initially used by Phone Alert Status
> and Alert Notification GATT profiles (server role).
> ---
> 
> v4: Modify enumeration strings to use "-" as word separator.
> 
>  Makefile.am       |    2 +-
>  doc/alert-api.txt |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+), 1 deletion(-)
>  create mode 100644 doc/alert-api.txt

Thanks. All patches from this set are now upstream. I also pushed one
additional coding style patch since I didn't want to bother with another
review round for such a large patch set (and please don't do these huge
sets in the future - keep them under 10 or so).

Johan
