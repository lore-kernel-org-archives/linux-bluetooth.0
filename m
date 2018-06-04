Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180531121906.21140-1-luiz.dentz@gmail.com>
References: <20180531121906.21140-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Jun 2018 13:06:49 +0300
Message-ID: <CABBYNZJ8ks=OZoGKbviGZFKnHxtaqgXnV1FW8K1NsphJRCtHRg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Allow sending to org.mpris.MediaPlayer2.Player
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 31, 2018 at 3:19 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds a policy to allow sending to org.mpris.MediaPlayer2.Player
> interface since that is used when the player supports it.
> ---
>  src/bluetooth.conf | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/bluetooth.conf b/src/bluetooth.conf
> index 0c0b221bb..b67a954a2 100644
> --- a/src/bluetooth.conf
> +++ b/src/bluetooth.conf
> @@ -19,6 +19,7 @@
>      <allow send_interface="org.bluez.LEAdvertisement1"/>
>      <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
>      <allow send_interface="org.freedesktop.DBus.Properties"/>
> +    <allow send_interface="org.mpris.MediaPlayer2.Player"/>
>    </policy>
>
>    <policy at_console="true">
> --
> 2.17.0


Applied.



-- 
Luiz Augusto von Dentz
