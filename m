Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3520047b-7832-35e2-d1fa-fb7f5c0d058d@jp.fujitsu.com>
References: <3520047b-7832-35e2-d1fa-fb7f5c0d058d@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Jun 2017 11:17:56 +0300
Message-ID: <CABBYNZKTLGxtvdJxELo9ut5YGbZ9rVDb+B02bOpiFabnLb-rgg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] client: Improve help command
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Thu, Jun 15, 2017 at 2:35 PM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> This adds alias-related help messages and makes more readable in whole.
> The help command outputs the following messages before applying these
> patches:
>
> [bluetooth]# help
> Available commands:
>   list                       List available controllers
>   show [ctrl]                Controller information
>   select <ctrl>              Select default controller
>   devices                    List available devices
>   paired-devices             List paired devices
>   power <on/off>             Set controller power
>   pairable <on/off>          Set controller pairable mode
>   discoverable <on/off>      Set controller discoverable mode
>   agent <on/off/capability>  Enable/disable agent with given capability
>   default-agent              Set agent as the default one
>   advertise <on/off/type>    Enable/disable advertising with given type
>   set-advertise-uuids [uuid1 uuid2 ...] Set advertise uuids
>   set-advertise-service [uuid][data=[xx xx ...] Set advertise service data
>   set-advertise-manufacturer [id][data=[xx xx ...] Set advertise
> manufacturer data
>
>
> As below after applying this patches:
>
> [bluetooth]# help
> Available commands:
>   list                       List available controllers
>   show [ctrl]                Controller information
>   select <ctrl>              Select default controller
>   devices                    List available devices
>   paired-devices             List paired devices
>   system-alias <name>        Set controller alias
>   reset-alias                Reset controller alias
>   power <on/off>             Set controller power
>   pairable <on/off>          Set controller pairable mode
>   discoverable <on/off>      Set controller discoverable mode
>   agent <on/off/capability>  Enable/disable agent with given capability
>   default-agent              Set agent as the default one
>   advertise <on/off/type>    Enable/disable advertising with given type
>   set-advertise-uuids [uuid1 uuid2 ...]
>                              Set advertise uuids
>   set-advertise-service [uuid][data=[xx xx ...]
>                              Set advertise service data
>   set-advertise-manufacturer [id][data=[xx xx ...]
>                              Set advertise manufacturer data
>

It seems the patches don't apply upstream:

Applying: client: Compare a input string and each command only once
error: patch failed: client/main.c:1854
error: client/main.c: patch does not apply

Could you please rebase them and resend.


> ERAMOTO Masaya (3):
>   client: Compare a input string and each command only once
>   client: Add a description to all commands
>   client: Output a long message by two lines
>
>  client/main.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
