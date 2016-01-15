Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <D2BD8E35.1AB78%adam.moore@savant.com>
References: <D2BD8E35.1AB78%adam.moore@savant.com>
Date: Fri, 15 Jan 2016 10:32:40 -0300
Message-ID: <CABBYNZJpn6RFweF4GigtzRV1bdy6Nv+BNA3FbW4D9xe6CYdoLA@mail.gmail.com>
Subject: Re: LE Reverse Service Discovery
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Adam Moore <adam.moore@savantsystems.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

On Thu, Jan 14, 2016 at 10:41 PM, Adam Moore
<adam.moore@savantsystems.com> wrote:
> Iıve noticed that since around BlueZ 5.27, GATT client functionality is
> enabled for all devices.
>
> From a LE Peripheral's perspective, this results in unconditional reverse
> service discovery of a Central's GATT services.
>
> It seems like this will not always be necessary depending on the use case,
> and disabling GATT client functionality should save energy and time.  My
> iPhone, for example, has about 8 services that my Peripheral doesnıt care
> about.

This is only considerable for the very first time you connect, after
that Read By Group should return matching cached services so no extra
commands would be needed.

> Iım considering making an attempt to disable this, as the BT spec says
> GATT clients are optional for LE peripherals. (BT 4.2, Vol 3, Part C,
> Table 15.1), but I first would like to ask if anyone has any insight on
> why it may be desirable to keep the client functionality enabled.

There are important services behind GATT, such as GAP and DIS, that
are relevant even for a peripheral. We could perhaps disable the
discovery if there are no drivers available to probe, but currently we
have no means to detect if the driver UUID is GATT or not.


-- 
Luiz Augusto von Dentz
