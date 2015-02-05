Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Feb 2015 12:18:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib: Fix Read Blob error responses
Message-ID: <20150205101847.GA29948@t440s.lan>
References: <1418716295-13447-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418716295-13447-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tue, Dec 16, 2014, Marcin Kraglak wrote:
> Read blob response with offset equal to value length should return
> zero length value intead of Invalid Offset Error.
> Found during qualification test case TC/GAR/SR/BV-08-C Read behind
> Long Characteristic Descriptor.
> ---
>  src/attrib-server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
