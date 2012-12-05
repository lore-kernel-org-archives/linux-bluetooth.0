Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Dec 2012 17:25:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] hciconfig: Remove putkey command
Message-ID: <20121205152506.GB15812@x220>
References: <1354705606.1815.6.camel@aeonflux>
 <1354707834-30972-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1354707834-30972-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Wed, Dec 05, 2012, Frédéric Danis wrote:
> With new storage architecture legacy storage "linkkeys"
> file doesn't exist anymore.
> ---
>  tools/hciconfig.8 |    5 -----
>  tools/hciconfig.c |   64 -----------------------------------------------------
>  2 files changed, 69 deletions(-)

Applied. Thanks.

Johan
