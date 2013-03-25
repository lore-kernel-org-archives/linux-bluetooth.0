Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Mar 2013 12:46:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH bluez] sdptool: fix recursive search
Message-ID: <20130325104645.GA12997@x220.ger.corp.intel.com>
References: <1363628462-3421-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363628462-3421-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Mon, Mar 18, 2013, David Herrmann wrote:
> When doing recursive SDP searches, we must not overwrite our own values
> after we retrieved them from SDP. Otherwise, the UUID test will always we
> false.
> ---
>  tools/sdptool.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
