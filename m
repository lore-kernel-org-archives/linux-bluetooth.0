Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Nov 2013 16:49:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio/A2DP: Return -ENOPROTOOPT if record doesn't
 exist
Message-ID: <20131113144924.GB18127@x220.p-661hnu-f1>
References: <1384349196-18190-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384349196-18190-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Nov 13, 2013, Luiz Augusto von Dentz wrote:
> In case record is not registered it means no endpoint is available so
> return -ENOPROTOOPT to indicate that it is currently not available.
> ---
>  profiles/audio/a2dp.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Applied. Thanks.

Johan
