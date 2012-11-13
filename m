Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Nov 2012 13:32:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] neard: Set device name in cache
Message-ID: <20121113113201.GA23974@x220>
References: <1352299230-6201-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1352299230-6201-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Wed, Nov 07, 2012, Frédéric Danis wrote:
> If device existed previously, it has been removed before calling of
> btd_event_remote_name(), so this just update storage cache and name
> property change of device object is not emitted.
> ---
>  plugins/neard.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
