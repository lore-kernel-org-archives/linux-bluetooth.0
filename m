Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 25 Dec 2017 21:06:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: sbrown@cortland.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mesh: meshctl: Correct display security
Message-ID: <20171225190631.GA10438@x1c.home>
References: <20171222102954.14960-1-sbrown@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171222102954.14960-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Fri, Dec 22, 2017, sbrown@cortland.com wrote:
> The case of a security command without an argument is not handled
> and throws a segv.
> ---
>  mesh/main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
