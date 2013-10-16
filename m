Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 23:35:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] l2test: Set CID due to socket restrictions for LE
Message-ID: <20131016203518.GA947@x220.p-661hnu-f1>
References: <1381950307-7155-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381950307-7155-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Oct 16, 2013, Claudio Takahasi wrote:
> Bluetooth kernel now restricts LE L2CAP sockets to ATT channels only.
> For LE L2CAP socket bind, ATT CID is now mandatory. Reference: kernel patch
> bfe4655f05d7ec4a7c0c1c7e4051862f824cd8ec
> ---
>  tools/l2test.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied thanks.

Btw, I didn't realize that this check wasn't there before. It seems like
it shouldn't cause any "real life" issues as our btio has always done a
bind with the correct CID. Can you confirm that this should only be an
issue for l2test?

Johan
