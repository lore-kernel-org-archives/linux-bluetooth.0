Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] Bluetooth: RPN negotiation fix
From: Marcel Holtmann <marcel@holtmann.org>
To: Yuri Kululin <ext-yuri.kululin@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6a577b5627b8388489a21fd49f5c9d2b85a2bbef.1279866739.git.ext-yuri.kululin@nokia.com>
References: <1279879032-27955-1-git-send-email-ext-yuri.kululin@nokia.com>
	 <6a577b5627b8388489a21fd49f5c9d2b85a2bbef.1279866739.git.ext-yuri.kululin@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Aug 2010 13:31:57 -0400
Message-ID: <1281547917.12579.239.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yuri,

> According to the ETSI 3GPP TS 07.10 the default bit rate value for RFCOMM
> is 9600 bit/s. Return this bit rate in case of RPN request and accept other
> sane bit rates proposed by the sender in RPM command.
> 
> Signed-off-by: Yuri Kululin <ext-yuri.kululin@nokia.com>
> ---
>  net/bluetooth/rfcomm/core.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


