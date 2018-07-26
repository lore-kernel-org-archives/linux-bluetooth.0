Return-Path: <johan.hedberg@gmail.com>
Date: Thu, 26 Jul 2018 15:19:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: Re: [PATCH BlueZ] emulator: Fix unsupported command for
 WRITE_LE_HOST_SUPPORTED
Message-ID: <20180726121934.GA5196@x1c.home>
References: <1532604209-32633-1-git-send-email-jaganathx.kanakkassery@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532604209-32633-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Jul 26, 2018, Jaganath Kanakkassery wrote:
> WRITE_LE_HOST_SUPPORTED command needs check for BTDEV_TYPE_LE as well.
> ---
>  emulator/btdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index f8289d0..ae30950 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -2960,6 +2960,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
>  
>  	case BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED:
>  		if (btdev->type != BTDEV_TYPE_BREDRLE &&
> +				btdev->type != BTDEV_TYPE_LE &&
>  				btdev->type != BTDEV_TYPE_BREDRLE50)
>  			goto unsupported;
>  		wlhs = data;

Applied. Thanks.

FWIW, the alternative solution would have been to remove the command
from the supported commands bitmap, since it's an optional command for
single-mode controllers. Additionally, the call to
bthost_write_le_host_supported() from mgmt-tester.c should have been
removed when the tests sets enable_le=true for data->type ==
HCIEMU_TYPE_LE, since this is where it's comming from (it's not the
kernel that's sending it).

Johan
