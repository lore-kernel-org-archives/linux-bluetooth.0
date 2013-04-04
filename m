Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Apr 2013 14:51:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] attrib: Fix memory leak on low memory condition
Message-ID: <20130404115151.GA9444@x220.ger.corp.intel.com>
References: <1364915265-4191-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364915265-4191-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Apr 02, 2013, Anderson Lizardo wrote:
> If g_try_new0() fails due to low memory condition, "list" should be
> freed before returning from primary_all_cb().
> ---
>  attrib/gatt.c |    1 +
>  1 file changed, 1 insertion(+)

All three patches in this set have been applied. Thanks.

Johan
