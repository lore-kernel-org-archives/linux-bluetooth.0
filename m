Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Jan 2014 12:20:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] tester: Remove test timeout for setup failure
Message-ID: <20140120102042.GA9704@x220.p-661hnu-f1>
References: <1390212008-5376-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390212008-5376-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Jan 20, 2014, Jakub Tyszkowski wrote:
> If setup fails, timeout function is not removed and still can be called,
> causing random subsequent case failure.
> ---
>  src/shared/tester.c | 5 +++++
>  1 file changed, 5 insertions(+)

Both patches have been applied. Thanks.

Johan
