Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <563C3D4B.30102@netcommwireless.com>
References: <563C3D4B.30102@netcommwireless.com>
Date: Fri, 6 Nov 2015 12:22:00 +0200
Message-ID: <CABBYNZKcgeVoFJcNEcSpp3Kn45qM1XXRncQocSR5PCSGX=e6xQ@mail.gmail.com>
Subject: Re: ConnectProfile continuously failing with InProgress error
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alan Au <alan.au@netcommwireless.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

On Fri, Nov 6, 2015 at 7:40 AM, Alan Au <alan.au@netcommwireless.com> wrote:
> Hi,
>
> I've been writing an application that invokes Device1.ConnectProfile to
> connect to a remote device. That works fine in the normal case. But during
> development sometimes the app crashes after invoking ConnectProfile but
> before the ConnectProfile async invocation returns. In this case bluetoothd
> seems to sometimes get stuck in a bad state in which all subsequent calls to
> ConnectProfile (or Connect) for the same device will continuously return a
> org.bluez.Error.InProgress failure. I need to reboot the box to recover.
>
> This is reproducible with bluetoothctl. By running "connect" to a remote
> device that is not there and then exiting bluetoothctl before the connect
> result comes back. It may take a few tries but eventually bluetoothctl will
> show that any connects to that same device will always fail with
> org.bluez.Error.InProgress:

Please add the bluetoothd logs, the important part is to check if
there are services that don't transition to disconnected when that
happen.


-- 
Luiz Augusto von Dentz
