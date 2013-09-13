Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Sep 2013 15:33:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/8] sap: Keep reference to btd_adapter in struct
 sap_server
Message-ID: <20130913123344.GA28908@x220.p-661hnu-f1>
References: <1379071852-10094-1-git-send-email-szymon.janc@tieto.com>
 <1379071852-10094-3-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1379071852-10094-3-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Sep 13, 2013, Szymon Janc wrote:
> Path and adapter address can be obtained easily from btd_adapter
> and there is no need to keep local copy.
> ---
>  profiles/sap/manager.c |  6 ++----
>  profiles/sap/server.c  | 23 +++++++++++++----------
>  profiles/sap/server.h  |  2 +-
>  3 files changed, 16 insertions(+), 15 deletions(-)

I've applied patches 1-3 but for the rest I'm waiting for a v2 or some
more discussion (on IRC or here).

Johan
