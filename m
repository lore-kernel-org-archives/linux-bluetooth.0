Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Dec 2012 07:45:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] hog: Rename prepend_id variable
Message-ID: <20121211054504.GB19828@x220.P-661HNU-F1>
References: <1355172866-3144-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355172866-3144-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Dec 10, 2012, Andre Guedes wrote:
> This patch renames the hog_device prepend_id field by has_report_id
> as long as it is more suitable.
> 
> This variable indicates if we should consider the report id (adding
> or removing it) before sending it to device or uhid driver.
> ---
>  profiles/input/hog_device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
