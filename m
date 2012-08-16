Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 22:00:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Henrique Dante de Almeida <hdante@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adapter: fix call to get_key_info
Message-ID: <20120816190012.GA25826@x220.P-661HNU-F1>
References: <1345140926-19076-1-git-send-email-hdante@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345140926-19076-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Henrique,

On Thu, Aug 16, 2012, Henrique Dante de Almeida wrote:
> This complements commit 85128d40f4788acb0115f09c07b716e741444406 that
> changed the "linkkeys" file format. The call to get_key_info must
> include only the address string, instead of the new combined
> address#type text.
> ---
>  src/adapter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
