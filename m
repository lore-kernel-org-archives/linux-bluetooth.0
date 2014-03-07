Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Mar 2014 20:13:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peng Chen <pengchen@qca.qualcomm.com>
Cc: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH] Fix endian safe issue, make driver work on both little
 and big endian cpu.
Message-ID: <20140307181317.GA24435@localhost.P-661HNU-F1>
References: <1346931043-11541-1-git-send-email-pengchen@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346931043-11541-1-git-send-email-pengchen@qca.qualcomm.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Sep 06, 2012, Peng Chen wrote:
> Signed-off-by: Peng Chen <pengchen@qca.qualcomm.com>
> ---
>  drivers/bluetooth/ath3k.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
