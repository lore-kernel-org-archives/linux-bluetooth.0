Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jan 2013 16:18:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] unit: Fix compilation issue with ignored return
 value
Message-ID: <20130104141833.GB8761@x220>
References: <1357307222-4563-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1357307222-4563-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Jan 04, 2013, Anderson Lizardo wrote:
> Fix this compilation warning:
> 
> unit/test-sdp.c: In function ‘send_pdu’:
> unit/test-sdp.c:600:7: error: ignoring return value of ‘write’, declared
> with attribute warn_unused_result [-Werror=unused-result]
> ---
>  unit/test-sdp.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
