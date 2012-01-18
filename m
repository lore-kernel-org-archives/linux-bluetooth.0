Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jan 2012 14:26:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v3] client: fix parsing of apparam on pbap driver
Message-ID: <20120118122652.GA11023@x220>
References: <1326886574-10210-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326886574-10210-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jan 18, 2012, Luiz Augusto von Dentz wrote:
> Both hdr and size need to be updated otherwise no parameters will be
> parsed.
> ---
> v3: fix invalid read caused by updating hdr before size
> 
>  client/pbap.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
