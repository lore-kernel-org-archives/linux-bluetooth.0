Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Mar 2014 10:51:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core/profile: Fix failing to accept connections
 without a service
Message-ID: <20140327085142.GA26762@t440s.lan>
References: <1395909259-2154-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395909259-2154-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Mar 27, 2014, Luiz Augusto von Dentz wrote:
> For incoming connections it is not mandatory to have a service since the
> profile may be a server only (enable_client is false) therefore it does
> not need to track connection status.
> ---
>  src/profile.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)

Applied. Thanks.

Johan
