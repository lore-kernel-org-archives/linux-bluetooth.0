Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Dec 2012 17:42:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH] test: Fix test-device using wrong interface
Message-ID: <20121206154211.GA9449@x220>
References: <1354800883-31456-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354800883-31456-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Dec 06, 2012, Mikel Astiz wrote:
> The property getter and setter belong to org.freedesktop.DBus.Properties
> and therefore fix this code using the wrong interface since commit
> 67dab2d2aeec9ab895da6afd528ec0c63e657ff4.
> ---
>  test/test-device | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Applied. Thanks.

Johan
