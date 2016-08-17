Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160816232855.qgempm64zgp36ufd@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-4-git-send-email-sre@kernel.org> <20160816135155.GA20948@rob-hp-laptop>
 <20160816232855.qgempm64zgp36ufd@earth>
From: Rob Herring <robh@kernel.org>
Date: Wed, 17 Aug 2016 08:11:03 -0500
Message-ID: <CAL_JsqLcDzTZ++h+e7D-n0xbt7LgryK6jfGJDNEcAaU=Dn4b0w@mail.gmail.com>
Subject: Re: [RFC 3/7] dt: bindings: Add nokia-bluetooth
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>,
	=?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-bluetooth@vger.kernel.org,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 16, 2016 at 6:28 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi Rob,
>
> On Tue, Aug 16, 2016 at 08:51:55AM -0500, Rob Herring wrote:
>> On Sat, Aug 13, 2016 at 05:14:34AM +0200, Sebastian Reichel wrote:
>> > ---
>> >  .../devicetree/bindings/net/nokia-bluetooth.txt    | 43 ++++++++++++++++++++++
>> >  1 file changed, 43 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/net/nokia-bluetooth.txt b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>> > new file mode 100644
>> > index 000000000000..a0fceabb4cce
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>> > @@ -0,0 +1,43 @@
>> > +Nokia bluetooth UART devices
>> > +------
>> > +
>> > +Some vendors have custom versions of their chips, that can be found in Nokia
>> > +devices. These chips are controlled differently, than the non-Nokia version,
>> > +so a different binding is required. All chips listed here implement the Nokia
>> > +H4+ protocol.
>> > +
>> > +Required properties:
>> > +
>> > +  - compatible: should be one of the following:
>> > +   * "nokia,brcm,bcm2048"
>> > +   * "nokia,ti,wl1271-bluetooth"
>>
>> Perhaps these should be 2 separate strings. Something like
>> '"nokia,n900-bt", "brcm,bcm2048"'. However, if they are in no way
>> compatible with the default version from the vendors, then just a single
>> string is fine, but it doesn't need to be aligned to the vendor
>> compatible string. So just "nokia,n900-bcm2048" or similar is fine.
>
> The default bcm2048 variant uses different initialization process
> and does not use word alignment as far as I know. I think having
> "brcm,bcm2048" in the compatible string is wrong.

Okay.

> I guess "brcm,bcm2048-nokia" would also be an option, since the
> chip has been built buy broadcom, but it has a custom Nokia
> interface.

That would be okay. Though, in theory Nokia could have different
products with bcm2048 all with different versions.

I was going with defining it as a board level compatible string. Even
if chips are the same, s/w can need to know board level differences so
using the board vendor and name are common.

>> > +  - reset-gpios:           Should specify the gpio for bluetooth reset
>> > +  - host-wakeup-gpios:             Should specify the gpio for host wakeup
>>
>> Should be interrupt instead?
>
> Yes this is mostly an interrupt, but I need to read the current
> line state.

When? If the interrupt is level triggered, then you can get the line
state based on whether you get an interrupt or not. If this needs to
be a wakeup source (see the wakeup source binding), then it needs to
be an interrupt.

Reading the line state is a common problem. It would be nice if the
irq API provided a function to read the line state though that is not
always possible.

>
>> > +  - bluetooth-wakeup-gpios:        Should specify the gpio for bluetooth wakeup
>>
>> State direction and active state for gpios.
>
> ok.
>
>> > +  - clock-names:           Should be "sysclk"
>> > +  - clocks:                        Should contain a clock phandle for system clock
>> > +
>> > +Example:
>> > +
>> > +/ {
>> > +   /* controlled (enabled/disabled) directly by wl1271 */
>> > +   vctcxo: vctcxo {
>> > +           compatible = "fixed-clock";
>> > +           #clock-cells = <0>;
>> > +           clock-frequency = <38400000>;
>> > +   };
>> > +};
>> > +
>> > +&uart2 {
>>
>> I want to see a common serial device binding doc before accepting any
>> device bindings. It's not going to say much initially other than devices
>> are child nodes of uarts. Perhaps something on baudrate settings.
>
> Neil added a short sentence about this in "[RFC 2/7] tty: add
> support for "tty slave" devices". I just took the unmodified patch
> from Neil (*), so it's not in its own patch.

But that is in the 8250 binding. It needs to be a common binding.

Rob
