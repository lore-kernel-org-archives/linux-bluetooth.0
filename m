Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 May 2013 16:02:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH BlueZ v0 1/2] cyclingspeed: Fix D-Bus registration error
 case
Message-ID: <20130529130241.GA18206@x220.ger.corp.intel.com>
References: <1369831104-23363-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369831104-23363-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, May 29, 2013, Mikel Astiz wrote:
> If g_dbus_register_interface() fails, the struct csc_adapter memory will
> be freed and therefore the csc_adapters list cannot contain such an
> invalid pointer.
> ---
>  profiles/cyclingspeed/cyclingspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Both patches have been applied. Thanks.

Johan
