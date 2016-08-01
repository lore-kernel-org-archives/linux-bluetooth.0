Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.00.1608011427420.69212@toad.stack.nl>
References: <alpine.BSF.2.00.1608011427420.69212@toad.stack.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Aug 2016 17:13:32 +0300
Message-ID: <CABBYNZJMMSrgRO8EsZ78yOv0R5cwfpz65EQ+-zSV67mX2ee4Dw@mail.gmail.com>
Subject: Re: Registering profile or making discoverable resets adapter class
To: Serge van den Boom <serge@vdboom.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Serge,

On Mon, Aug 1, 2016 at 3:34 PM, Serge van den Boom <serge@vdboom.org> wrote:
> Hi,
>
> When a new profile is registered, or an adapter is make discoverable,
> the device class of the adapter is reset to the value set in
> /etc/bluetooth/main.conf.
>
> The test case below (to be run as root) demonstrates the issue. For this
> demonstration, there should be no 'Class = ...' setting in
> /etc/bluetooth/main.conf.

This is a classical problem of using hci* tools along with bluetoothd,
they both are trying to control the same thing and then you got a
conflict, it shall be one or the other but not both. If you are
curious to look at the bluetoothd source code you will see that the we
derive the class of the device from the registered services so there
is no point in doing anything with hcitool.
