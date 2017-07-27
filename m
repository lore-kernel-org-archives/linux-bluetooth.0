Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
References: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Jul 2017 17:24:37 +0300
Message-ID: <CABBYNZJBAwdhZTbaUSdq0jdkQsn=nxYVxkJB_a=njXFtjZc1dQ@mail.gmail.com>
Subject: Re: [PATCH Bluez 0/6] core: Add checking for Policy/GATT in main.conf
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Thu, Jul 27, 2017 at 2:18 PM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> This patches add checking for Policy/GATT in main.conf as below:
>   bluetoothd[XXXX]: Unknown key Cache for group Policy in main.conf
>   bluetoothd[XXXX]: Unknown key Timeout for group GATT in main.conf
>
> ERAMOTO Masaya (6):
>   core: Add group information to warning message for main.conf
>   core: Split check_config() function
>   core: Fix General options in main.conf
>   core: Add checking for unknown Policy options
>   core: Add checking for unknown GATT options
>   core: Make easier to manage checked groups
>
>  src/main.c | 81 ++++++++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 23 deletions(-)
>
> --
> 2.7.4

Great set, applied.

-- 
Luiz Augusto von Dentz
