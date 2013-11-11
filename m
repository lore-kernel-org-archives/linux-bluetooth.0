Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Nov 2013 18:50:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] audio/AVDTP: Remove avdtp_init and avdtp_exit
Message-ID: <20131111165053.GA17151@x220.p-661hnu-f1>
References: <1384186675-14940-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384186675-14940-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Nov 11, 2013, Luiz Augusto von Dentz wrote:
> This is now done on demand by avdtp_register_sep and avdtp_unregister_sep
> so the server socket is only registered when there is an endpoint
> available and the record is properly registered.
> ---
> v2: Fix return of avdtp_server_init
> 
>  profiles/audio/a2dp.c  |  11 -----
>  profiles/audio/avdtp.c | 118 +++++++++++++++++++++++++------------------------
>  profiles/audio/avdtp.h |   3 --
>  3 files changed, 60 insertions(+), 72 deletions(-)

Applied. Thanks.

Johan
