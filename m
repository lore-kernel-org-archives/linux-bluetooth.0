Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Aug 2012 12:36:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH BlueZ] mgmt: Add LE scanning callback
Message-ID: <20120814093605.GA5352@x220>
References: <CAJdJm_PyZa_0K-5nZOo_D796x5cwiZ6GKMb7-Jey48CYPys88Q@mail.gmail.com>
 <1344010717-4529-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1344010717-4529-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 03, 2012, João Paulo Rechi Vita wrote:
> From: Claudio Takahasi <claudio.takahasi@openbossa.org>
> 
> This patch adds a new callback to allow the adapter to control LE
> scanning. The current approach uses the active scanning with default
> windows and intervals defined by the core spec without any filtering.
> ---
>  src/mgmt.c | 32 ++++++++++++++++++++++++++++++++
>  src/mgmt.h |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/src/mgmt.c b/src/mgmt.c
> index 8ae86d3..5ceeaa8 100644
> --- a/src/mgmt.c
> +++ b/src/mgmt.c
> @@ -1999,6 +1999,38 @@ int mgmt_start_discovery(int index)
>  	return 0;
>  }
>  
> +int mgmt_start_scanning(int index)
> +{
> +	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_start_discovery)];
> +	struct mgmt_hdr *hdr = (void *) buf;
> +	struct mgmt_cp_start_discovery *cp = (void *) &buf[sizeof(*hdr)];
> +	struct controller_info *info = &controllers[index];
> +
> +	DBG("index %d", index);
> +
> +	info->discov_type = 0;
> +
> +	if (mgmt_low_energy(info->current_settings)) {
> +		hci_set_bit(BDADDR_LE_PUBLIC, &info->discov_type);
> +		hci_set_bit(BDADDR_LE_RANDOM, &info->discov_type);
> +	}

Shouldn't you just return an error here (e.g. -ENOTSUP) if LE is not
supported/enabled?

Have there been any patches sent that would use this API? At least I
didn't see any after a quick scan of the mailing list.

Johan
