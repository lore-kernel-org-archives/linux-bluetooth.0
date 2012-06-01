Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jun 2012 20:13:36 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com
Subject: Re: [PATCH] Bluetooth: Fix flags of mgmt_device_found event
Message-ID: <20120601231335.GI24769@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338577525-9182-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Jefferson,

* Jefferson Delfes <jefferson.delfes@openbossa.org> [2012-06-01 15:05:25 -0400]:

> Change flags field to matches userspace structure.
> This field needs to be converted to little endian before forward it.
> 
> Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
> ---
>  include/net/bluetooth/mgmt.h |    2 +-
>  net/bluetooth/mgmt.c         |    5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index ebfd91f..3a8a714 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -435,7 +435,7 @@ struct mgmt_ev_auth_failed {
>  struct mgmt_ev_device_found {
>  	struct mgmt_addr_info addr;
>  	__s8	rssi;
> -	__u8	flags[4];
> +	__le32	flags;

Seems we are breaking API here, MGMT API is stable now and should have such
kind of change. However I wanna see what Marcel and Johan has to say about
this.

	Gustavo
