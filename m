Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336083713-8417-1-git-send-email-teg@jklm.no>
References: <1336083713-8417-1-git-send-email-teg@jklm.no>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 4 May 2012 17:54:55 -0300
Message-ID: <CAMOw1v7kLQRosSt3FTmD0kdSCwN+1Rk6N_+iejp_ZsZyavfZDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] systemd: don't order against syslog.target
To: Tom Gundersen <teg@jklm.no>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom

On Thu, May 3, 2012 at 7:21 PM, Tom Gundersen <teg@jklm.no> wrote:
> This was only needed in old versions of systemd. All messages are logged
> by default to the journal now, no ordering required.
>
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> ---
>  src/bluetooth.service.in |    2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
> index 02b6707..8a9edb6 100644
> --- a/src/bluetooth.service.in
> +++ b/src/bluetooth.service.in
> @@ -1,12 +1,10 @@
>  [Unit]
>  Description=Bluetooth service
> -After=syslog.target
>
>  [Service]
>  Type=dbus
>  BusName=org.bluez
>  ExecStart=@prefix@/sbin/bluetoothd -n
> -StandardOutput=syslog
>
>  [Install]
>  WantedBy=bluetooth.target
> --
> 1.7.10.1


Ack
