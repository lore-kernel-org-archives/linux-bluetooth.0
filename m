Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Apr 2012 12:38:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org, naresh.gupta@stericsson.com
Subject: Re: [PATCH] Bluetooth: Link Keys should be stored if MITM is not
 required
Message-ID: <20120403093803.GA21118@x220>
References: <1333444794-27148-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333444794-27148-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 03, 2012, Vishal Agarwal wrote:
> If MITM protection is not required then except for Debug Keys, all
> link keys should be persistent. And they should be stored for future
> use.
> 
> Change-Id: Id438d424b999e9a30f29193d02ac266bee5f672b
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  net/bluetooth/hci_core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index c5ee97c..bcb68dd 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1246,6 +1246,10 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
>  	if (conn->remote_auth == 0x02 || conn->remote_auth == 0x03)
>  		return 1;
>  
> +	/* If MITM is not required then store the Link Key */
> +	if (!(conn->auth_type & 0x01))
> +		return 1;
> +
>  	/* If none of the above criteria match, then don't store the key
>  	 * persistently */
>  	return 0;

Nack.

This doesn't make much sense to me. Why should the MITM flag have
anything to do with the persistency of the key?

This looks more like a workaround for some device that is incorrectly
having a no-bonding requirement (which means that we should *not* store
the key). Please describe what kind of setup you've seen this with and
include a hcidump for it showing the local and remote authentication
requirement and IO capabilities.

Johan
