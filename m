Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417689400-128063-5-git-send-email-marcel@holtmann.org>
References: <1417689400-128063-5-git-send-email-marcel@holtmann.org>
Date: Thu, 4 Dec 2014 09:31:47 -0800
Message-ID: <CAD0=r8zfKBdu8=ZJj9Z-OLVjyUJoZ3iZ6bVjhPL_sVzU3qZ61w@mail.gmail.com>
Subject: Re: [RFC v2 5/7] Bluetooth: Add definitions for MGMT_OP_START_SERVICE_DISCOVERY
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 4, 2014 at 2:36 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> From: Jakub Pawlowski <jpawlowski@google.com>
>
> This patch adds the opcode and structure for Start Service Discovery
> operation.
>
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 9b382ea34fd9..95c34d5180fa 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -498,6 +498,15 @@ struct mgmt_cp_set_public_address {
>  } __packed;
>  #define MGMT_SET_PUBLIC_ADDRESS_SIZE   6
>
> +#define MGMT_OP_START_SERVICE_DISCOVERY        0x003A
> +struct mgmt_cp_start_service_discovery {
> +       __u8 type;

Maybe we should get rid of type ? service discovery based on
advertisement content makes sense only for LE

> +       __s8 rssi;
> +       __le16 uuid_count;
> +       __u8 uuids[0][16];
> +} __packed;
> +#define MGMT_START_SERVICE_DISCOVERY_SIZE 4
> +
>  #define MGMT_EV_CMD_COMPLETE           0x0001
>  struct mgmt_ev_cmd_complete {
>         __le16  opcode;
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
