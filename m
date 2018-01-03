Return-Path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 3 Jan 2018 10:06:33 +0100
From: Johan Hovold <johan@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	linux-serial@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
	linux-amlogic@lists.infradead.org,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Carlo Caione <carlo@endlessm.com>,
	Daniel Drake <drake@endlessm.com>, ulrich.hecht+renesas@gmail.com
Subject: Re: [RFC v2 1/9] serdev: implement parity configuration
Message-ID: <20180103090633.GP16993@localhost>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-2-martin.blumenstingl@googlemail.com>
 <4FDCB65A-641A-4134-BAF1-4A777012FDE7@holtmann.org>
 <CAFBinCCq9mYBhzoL1XBVQNGxALg8oK5GB7Md9HJf_mchEMu3-A@mail.gmail.com>
 <CAFBinCD=iuE+ho22kihCFG=AJV5t+JtjRww8PLuq-cAJ2RkAHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAFBinCD=iuE+ho22kihCFG=AJV5t+JtjRww8PLuq-cAJ2RkAHQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 02, 2018 at 10:34:04PM +0100, Martin Blumenstingl wrote:
> On Tue, Jan 2, 2018 at 10:16 PM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> > Hi Marcel, Hi Rob,
> >
> > On Tue, Jan 2, 2018 at 12:16 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> >> Hi Martin,
> >>
> >>> Some Bluetooth modules (for example the ones found in Realtek RTL8723BS
> >>> and RTL8723DS) want to communicate with the host with even parity
> >>> enabled.
> >>> Add a new function and the corresponding internal callbacks so parity
> >>> can be configured. This supports enabling and disabling parity as well
> >>> as setting the type to odd or even.
> >>>
> >>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >>> ---
> >>> drivers/tty/serdev/core.c           | 12 ++++++++++++
> >>> drivers/tty/serdev/serdev-ttyport.c | 21 +++++++++++++++++++++
> >>> include/linux/serdev.h              |  5 +++++
> >>> 3 files changed, 38 insertions(+)
> >>>
> >>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> >>> index 1bef39828ca7..d327b02980f5 100644
> >>> --- a/drivers/tty/serdev/core.c
> >>> +++ b/drivers/tty/serdev/core.c
> >>> @@ -225,6 +225,18 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
> >>> }
> >>> EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
> >>>
> >>> +void serdev_device_set_parity(struct serdev_device *serdev, bool enable,
> >>> +                           bool odd)
> >>> +{
> >>> +     struct serdev_controller *ctrl = serdev->ctrl;
> >>> +
> >>> +     if (!ctrl || !ctrl->ops->set_parity)
> >>> +             return;
> >>> +
> >>> +     ctrl->ops->set_parity(ctrl, enable, odd);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(serdev_device_set_parity);
> >>> +
> >>
> >> this really needs Rob’s ACK before I take the patch.
> > sure
> >
> > I could even live with a NACK in case these two bool parameters are
> > considered to be ugly
> > in that case I would propose an enum with three values: DISABLED,
> > EVEN, ODD so the arguments would look like this:
> > void serdev_device_set_parity(struct serdev_device *serdev, enum parity)
> I just discovered: such a patch was already posted by Ulrich Hecht: [0]
> 
> 
> [0] https://patchwork.kernel.org/patch/9903787/

Yeah, that would be the preferred way of doing this as it's more
readable and less error prone (and more easily extended if anyone ever
needs mark and space parity).

Also, I know serdev currently fails to check for errors from
tty_set_termios, but we really need to start doing that. Not all serial
drivers support (every) parity mode so you need to check the tty termios
for the actual mode used after tty_set_termios() returns.

Thanks,
Johan
