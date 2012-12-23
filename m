Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: anamtsov@gmail.com
In-Reply-To: <1356264452-21200-1-git-send-email-chen.ganir@ti.com>
References: <1356264452-21200-1-git-send-email-chen.ganir@ti.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Sun, 23 Dec 2012 16:11:21 +0200
Message-ID: <CA+XVXfcm5k7qN_tgbX6zVtWjxo_5w+FNmmbhthw3+UtrH3tnYg@mail.gmail.com>
Subject: Re: [PATCH hcidump] Add TI Logger dump support
To: chen.ganir@ti.com
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Dec 23, 2012 at 2:07 PM,  <chen.ganir@ti.com> wrote:
> From: Chen Ganir <chen.ganir@ti.com>
>
> Texas Instruments controllers can be configured to send the
> internal firmware log through a vendor specific HCI event on
> the hci transport.
> This patch allows capturing those log events, and writing them
> to a file, which can then be used with the latest TI Logger
> application to read and show the logs.
>
> This is usefull in case there is no other way to get the TI log
> (for example, the lack of a connection to the controller Log TX
> hardware line).
[...]
> @@ -300,7 +308,24 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
[...]
> +                                       char out[2];
> +                                       int i;
> +
> +                                       for(i = 0;i < tp->size-2;i++) {
> +                                               sprintf(out,"%02X",tp->data[i]);
> +                                               if (write_n(fd, out, 2) < 0) {

Seems to me this can overflow when tp->size - 2 > sizeof(out) ?

Arik
