Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Mar 2014 18:55:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] autopair: Remove time(NULL) fallback when seeding
 rand()
Message-ID: <20140305165523.GA1684@localhost.P-661HNU-F1>
References: <1381179924-19529-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381179924-19529-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Oct 07, 2013, Anderson Lizardo wrote:
> If /dev/urandom cannot be opened or read, just fail the plugin
> initialization, as it is very unlikely that a fully working Linux system
> does not have a working /dev/urandom. This also simplifies the code
> logic.
> ---
>  plugins/autopair.c |   27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)

Applied. Thanks.

Johan
