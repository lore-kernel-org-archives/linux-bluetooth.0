Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Dec 2012 19:22:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] l2test: Add support to test auto select PSM
Message-ID: <20121205172255.GA18564@x220.P-661HNU-F1>
References: <1354724501-5368-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354724501-5368-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Wed, Dec 05, 2012, Syam Sidhardhan wrote:
> This patch enable us to test the auto select PSM by passing
> PSM value as 0.
> 
> Ex: l2test -d -P 0
> l2test[2585]: Waiting for connection on psm 4099 ...
> ---
> v2 -> Retain the interoperability issue mentioned by Gustavo.

Applied. Thanks.

Johan
