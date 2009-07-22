Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Jul 2009 15:26:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alokbarsode@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH] Removing the service_classes_callback mechanism.
Message-ID: <20090722122635.GA5701@jh-x301>
References: <1248264414-16998-1-git-send-email-alok.barsode@azingo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1248264414-16998-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Wed, Jul 22, 2009, alokbarsode@gmail.com wrote:
> From: Alok Barsode <alok.barsode@azingo.com>
> 
> ---
>  src/main.c         |   46 +---------------------------------------------
>  src/manager.c      |   25 ++++++++++---------------
>  src/manager.h      |    3 +--
>  src/sdpd-service.c |   13 +++++--------
>  src/sdpd.h         |    3 ---
>  5 files changed, 17 insertions(+), 73 deletions(-)

Pushed upstream with some minor cosmetic changes. Thanks.

Johan
