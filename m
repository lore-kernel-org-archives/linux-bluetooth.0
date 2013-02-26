Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Feb 2013 16:30:34 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Karl Relton <karllinuxtest.relton@ntlworld.com>
Cc: linux-bluetooth@vger.kernel.org, dh.herrmann@gmail.com,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH v2] hidp: Make hidp_get_raw_report abort if the session
 is terminating.
Message-ID: <20130226193034.GC4176@joana>
References: <1361384179.5261.15.camel@dellpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361384179.5261.15.camel@dellpc>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karl,

* Karl Relton <karllinuxtest.relton@ntlworld.com> [2013-02-20 18:16:19 +0000]:

> From: Karl Relton <karllinuxtest.relton@ntlworld.com>
> 
>  After linux 3.2 the hid_destroy_device call in hidp_session
>  cleaning up invokes a hook to the power_supply code which
>  in turn tries to read the battery capacity. This read will
>  trigger a call to hidp_get_raw_report which is bound to fail
>  because the device is being taken away - so rather than
>  wait for the 5 second timeout failure this changes enables
>  it to fail straight away.
> 
> Signed-off-by: Karl Relton <karllinuxtest.relton@ntlworld.com>
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  net/bluetooth/hidp/core.c |    4 ++++
>  1 file changed, 4 insertions(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
