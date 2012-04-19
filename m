Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Apr 2012 12:26:46 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Remove not needed status parameter
Message-ID: <20120419152646.GF4127@joana>
References: <y>
 <1334844749-13441-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1334844749-13441-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334844749-13441-2-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

* Lukasz Rymanowski <lukasz.rymanowski@tieto.com> [2012-04-19 16:12:28 +0200]:

> Sco_conn_add is called from two places and always with status = 0.
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
>  net/bluetooth/sco.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to the bluetooth-next tree. Thanks.

	Gustavo
