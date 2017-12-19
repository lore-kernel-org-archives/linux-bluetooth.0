Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 19 Dec 2017 20:25:20 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gatt: Mark AcquireWrite and AcquireNotify as stable
Message-ID: <20171219192520.GA13151@x1c>
References: <20171219170601.24722-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219170601.24722-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Dec 19, 2017, Luiz Augusto von Dentz wrote:
> AcquireWrite and AcquireNofify are required by meshctl.
> ---
>  doc/gatt-api.txt  |  4 ++--
>  src/gatt-client.c | 10 ++++------
>  2 files changed, 6 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
