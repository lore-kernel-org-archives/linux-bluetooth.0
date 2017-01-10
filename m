Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Date: Tue, 10 Jan 2017 19:50:49 +0000
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann
 <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>,
        Sebastian Reichel
 <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Dr . H . Nikolaus
 Schaller" <hns@goldelico.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain
 <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>,
        NeilBrown
 <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 6/9] dt/bindings: Add a serial/UART attached device
 binding
Message-ID: <20170110195049.47c4122e@lxorguk.ukuu.org.uk>
In-Reply-To: <20170106162635.19677-7-robh@kernel.org>
References: <20170106162635.19677-1-robh@kernel.org>
	<20170106162635.19677-7-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri,  6 Jan 2017 10:26:32 -0600
Rob Herring <robh@kernel.org> wrote:

> Add a common binding for describing serial/UART attached devices. Common
> examples are Bluetooth, WiFi, NFC and GPS devices.
> 
> Serial attached devices are represented as child nodes of a UART node.
> This may need to be extended for more complex devices with multiple
> interfaces, but for the simple cases a child node is sufficient.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/serial/slave-device.txt    | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/slave-device.txt b/Documentation/devicetree/bindings/serial/slave-device.txt
> new file mode 100644
> index 000000000000..9b7c2d651345
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/slave-device.txt
> @@ -0,0 +1,34 @@
> +Serial Slave Device DT binding
> +
> +This documents the binding structure and common properties for serial
> +attached devices. Common examples include Bluetooth, WiFi, NFC and GPS
> +devices.
> +
> +qSerial

Stray 'q' ??
