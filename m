Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <87d2vpv2p7.fsf@randy.site>
References: <87d2vpv2p7.fsf@randy.site>
Date: Mon, 25 Feb 2013 11:42:08 +0200
Message-ID: <CABBYNZK6iqxxrGFjDuO_VzZTvmej3d-tK+U4dO3irZyfXQUZMQ@mail.gmail.com>
Subject: Re: RequestDisconnection() Operation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Randy Yates <yates@digitalsignallabs.com>
Cc: Bluez Mailing List <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Randy,

On Sun, Feb 24, 2013 at 11:09 PM, Randy Yates
<yates@digitalsignallabs.com> wrote:
> The following question is regarding bluez 5.2:
>
> There are at least two cases in which a remote bluetooth device "client"
> connected to a profile managed by a local bluetooth device "server"
> (via bluez) would disconnect:
>
>   1. The remote bluetooth device client initiates a disconnect.
>
>   2. The remote bluetooth device goes out of range.
>
> Would a RequestDisconnection() method be invoked by the bluez stack in
> both these cases?

If the remote device start the disconnection there is nothing you can
do, so no RequestDisconnection is not called in any of these cases.
Also note that in case of link loss it might take a while until the
controller notify it has lost the link, usually it will only report
after a timeout specified by link supervision timeout (20 seconds by
default). RequestDisconnection is for connection cleanup when the
disconnection is started locally, so it is called before the link is
disconnected, because of this you might want to watch the events on
the fd that you got in the NewConnection directly so you can react to
e.g. HUP or ERR. Another important detail is that if you want to force
a disconnection you should use shudown, close will just release the
process reference to the fd but bluetoothd has another one to track
which profiles are connected.

--
Luiz Augusto von Dentz
