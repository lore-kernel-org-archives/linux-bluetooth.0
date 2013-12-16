Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387199317-27438-1-git-send-email-luiz.dentz@gmail.com>
References: <1387199317-27438-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 16 Dec 2013 17:27:29 +0100
Message-ID: <CAN_7+YaOQLno_kZoi7sAk2f8Ky_natHGa1Zi-J9vErfZ5WW8ug@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ] android: Add initial Android Bluetooth Audio
 protocol API doc
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


On Mon, Dec 16, 2013 at 2:08 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This IPC is used to communicate Android BlueZ daemon and AudioFlinger
> plugin.
> ---
> v2: Rework IPC commands to match Android Audio HAL
>
>  android/Makefile.am       |  3 +-
>  android/audio-ipc-api.txt | 85 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 1 deletion(-)
>  create mode 100644 android/audio-ipc-api.txt
>
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 79f30d7..ac00bb2 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -111,4 +111,5 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
>                 android/pixit-gap.txt android/pixit-hid.txt \
>                 android/pixit-opp.txt android/pixit-pan.txt \
>                 android/pixit-pbap.txt android/pts-gap.txt android/pts-hid.txt \
> -               android/pts-opp.txt android/pts-pbap.txt
> +               android/pts-opp.txt android/pts-pbap.txt \
> +               android/audio-ipc-api.txt
> diff --git a/android/audio-ipc-api.txt b/android/audio-ipc-api.txt
> new file mode 100644
> index 0000000..e9a2136
> --- /dev/null
> +++ b/android/audio-ipc-api.txt
> @@ -0,0 +1,85 @@
> +Bluetooth Audio Plugin
> +======================
> +
> +The audio plugin happen to be in a different socket but all the rules for
> +HAL socket apply here as well, the abstract socket name is
> +"\0bluez_audio_socket" (tentative):
> +
> +       .--Android--.                             .---Audio---.
> +       |  daemon   |                             |   Plugin  |
> +       |           |          Command            |           |
> +       |           | <-------------------------- |           |
> +       |           |                             |           |
> +       |           | --------------------------> |           |
> +       |           |          Response           |           |
> +       |           |                             |           |
> +       |           |                             |           |
> +       |           |                             |           |
> +       '-----------'                             '-----------'
> +
> +
> +       Audio HAL                               Daemon
> +       ----------------------------------------------------
> +
> +       call dev->open()                    --> command 0x01
> +       return dev->open()                  <-- response 0x01
> +
> +       call dev->open_output_stream()      --> command 0x03
> +       return dev->open_output_stream()    <-- response 0x03
> +
> +       call stream_in->read()              --> command 0x05
> +       return stream_in->read()            <-- response 0x05
> +
I think it should be stream_out->write() here.

> +       call stream_in->common.standby()    --> command 0x06
> +       return  stream_in->common.standby() <-- response 0x06
> +
Also here: stream_out->common.standby()

> +       call dev->close_output_stream()     --> command 0x04
> +       return dev->close_output_stream()   <-- response 0x04
> +
> +       call dev->close()                   --> command 0x02
> +       return dev->close()                 <-- response 0x02
> +
> +Identifier: "audio" (BT_AUDIO_ID)
> +
> +       Opcode 0x00 - Error response
> +
> +               Response parameters: Status (1 octet)
> +
> +       Opcode 0x01 - Open Audio Endpoint commmand
> +
> +               Command parameters: Service UUID (16 octets)
> +                                   Codec ID (1 octets)
> +                                   Codec capabilities length (1 octets)
> +                                   Codec capabilities (variable)
> +                                   Number of codec presets (1 octets)
> +                                   Codec preset # length (1 octets)
> +                                   Codec preset # configuration (variable)
> +                                   ...
> +               Response parameters: Endpoint ID (1 octets)
> +
> +       Opcode 0x02 - Close Audio Endpoint command
> +
> +               Command parameters: Endpoint ID (1 octets)
> +               Response parameters: <none>
> +
> +       Opcode 0x03 - Open Stream command
> +
> +               Command parameters: Endpoint ID (1 octets)
> +               Response parameters: Codec configuration length (1 octets)
> +                                    Codec configuration (1 octets)
> +                                    File descriptor (inline)
> +
> +       Opcode 0x04 - Close Stream command
> +
> +               Command parameters: Endpoint ID (1 octets)
> +               Response parameters: <none>
> +
> +       Opcode 0x05 - Resume Stream command
> +
> +               Command parameters: Endpoint ID (1 octets)
> +               Response parameters: <none>
> +
> +       Opcode 0x06 - Suspend Stream command
> +
> +               Command parameters: Endpoint ID (1 octets)
> +               Response parameters: <none>
> --
> 1.8.3.1
>
Otherwise looks ok to me.

BR
Lukasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
