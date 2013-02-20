Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Feb 2013 10:01:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] tools: btmgmt: Add missing return after
 g_main_loop_quit()
Message-ID: <20130220080132.GC14731@x220>
References: <1361307604-4764-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361307604-4764-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Feb 19, 2013, Anderson Lizardo wrote:
> This change keeps semantic of previous code that used to call exit()
> directly.
> ---
>  tools/btmgmt.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Both patches have been applied. Thanks.

Johan
