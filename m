Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1411383708-28621-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1411383708-28621-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Thu, 2 Oct 2014 22:49:13 +0200
Message-ID: <CAN_7+YamDRmKV4-cOus2emQSHvr3D+Q4AhWEPHQvPShnOoSU7g@mail.gmail.com>
Subject: Re: [PATCH 1/6] android/hal-ipc-api: Add MCE HAL
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>,
	Szymon Janc <szymon.janc@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz, Szymon

On Mon, Sep 22, 2014 at 1:01 PM, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@tieto.com> wrote:
> ---
>  android/hal-ipc-api.txt | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
> index f6e1680..38f75e6 100644
> --- a/android/hal-ipc-api.txt
> +++ b/android/hal-ipc-api.txt
> @@ -2396,3 +2396,54 @@ Notifications:
>         Opcode 0x95 - Ring Indication notification
>
>                 Notification parameters: <none>
> +
> +
> +Bluetooth MCE HAL (ID 11)
> +=========================
> +
> +Android HAL name: "map_client" (BT_PROFILE_MAP_CLIENT_ID)
> +
> +Structures:
> +
> +       MAS instance: Instance ID (1 octet)
> +                     Channel (1 octet)
> +                     Message type (1 octet)
> +                     Name (string)
> +
> +       Valid Message type: 0x01 = EMAIL
> +                           0x02 = SMS_GSM
> +                           0x04 = SMS_CDMA
> +                           0x08 = MMS
> +
> +Commands and responses:
> +
> +       Opcode 0x00 - Error response
> +
> +               Response parameters: Status (1 octet)
> +
> +               Valid status values: 0x01 = Fail
> +                                    0x02 = Not ready
> +                                    0x03 = No memory
> +                                    0x04 = Busy
> +                                    0x05 = Done (already completed)
> +                                    0x06 = Unsupported
> +                                    0x07 = Parameter invalid
> +                                    0x08 = Unhandled
> +                                    0x09 = Authentication failure
> +                                    0x0a = Remote device down
> +
> +       Opcode 0x01 - Get Remote MAS Instances
> +
> +               Command parameters: Remote address (6 octets)
> +               Response parameters: <none>
> +
> +               In case of an error, the error response will be returned.
> +
> +Notifications:
> +
> +       Opcode 0x81 - Remote MAS Instances notification
> +
> +               Notification parameters: Status (1 octet)
> +                                        Remote address (6 octets)
> +                                        Number of instances (1 octet)
> +                                        MAS instance (variable)
> --
> 1.9.3
>
> --

Looks like we forgot about this set, or ? :)

BR
\Łukasz

> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
