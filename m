Return-Path: <konrad.zapalowicz@canonical.com>
Date: Mon, 8 May 2017 13:45:09 +0200
From: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
To: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] tools: add logitech diNovo rules for hid2hci
Message-ID: <20170508114509.GA31067@annapurna>
References: <1494241210-27307-1-git-send-email-bergo.torino@gmail.com>
 <CACumGOKUj=FZOr99KyjJqu2bjdFpF73t1VBcLo6v1PScDV80sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CACumGOKUj=FZOr99KyjJqu2bjdFpF73t1VBcLo6v1PScDV80sA@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/08, Von Dentz, Luiz wrote:
> Hi Konrad,
> 
> On Mon, May 8, 2017 at 2:00 PM, Konrad Zapalowicz
> <konrad.zapalowicz@canonical.com> wrote:
> > From: Konrad Zapałowicz <konrad.zapalowicz@canonical.com>
> >
> > It has been reported that th Lenovo diNovo set of BT wireless devices
> > works only when is managed by hidraw instead of hiddev. This patch adds
> > vendor and product ids for these devices so that it is possible to use.
> >
> > This patch is based on work provided by:
> >  * Tommy <mesilliac@gmail.com>
> >  * Martin G Miller <mgmiller@optonline.net>
> > ---
> >  tools/hid2hci.rules | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/hid2hci.rules b/tools/hid2hci.rules
> > index db6bb03..7273167 100644
> > --- a/tools/hid2hci.rules
> > +++ b/tools/hid2hci.rules
> > @@ -13,6 +13,12 @@ ATTR{bInterfaceClass}=="03", ATTR{bInterfaceSubClass}=="01", ATTR{bInterfaceProt
> >  # Logitech devices
> >  KERNEL=="hiddev*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c70[345abce]|c71[34bc]", \
> >    RUN+="hid2hci --method=logitech-hid --devpath=%p"
> > +# Logitech, Inc. diNovo Edge Keyboard
> > +KERNEL=="hidraw*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c714", \
> > +  RUN+="hid2hci --method=logitech-hid --devpath=%p"
> > +# Logitech, Inc. diNovo 2
> > +KERNEL=="hidraw*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c704", \
> > +  RUN+="hid2hci --method=logitech-hid --devpath=%p"
> >
> >  ENV{DEVTYPE}!="usb_device", GOTO="hid2hci_end"
> >
> > --
> > 2.7.4
> 
> Interesting, is this preferable than creating a kernel driver that
> does the same thing? hid2hci was initially intended to switch the
> controller from hid mode to hci mode, but in this case there is
> nothing related to hci, or bluetooth, if it is just doing hiddev to
> hidraw.

Hey,

Interesting suggestion. The reason I have proposed it this way is that
we have already a patch that we ship for a while now and know that it
works. Also this way is a bit easier for spreading the fix around as
updating bluez is simpler than the kernel. Last but not least I do not
have the diNovo set to work on the module. Having said that I understand
your point and I agree.

Thanks,
Konrad
