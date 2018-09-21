Return-Path: <andy.shevchenko@gmail.com>
MIME-Version: 1.0
References: <20180920223436.202454-1-mka@chromium.org> <20180920223436.202454-2-mka@chromium.org>
 <20180921071312.gg7xshwa2ro3hiix@kekkonen.localdomain>
In-Reply-To: <20180921071312.gg7xshwa2ro3hiix@kekkonen.localdomain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 21 Sep 2018 15:47:54 +0300
Message-ID: <CAHp75Vc-evA6MCxGN+Ho+XQkBqtQ_JpMEpPUmMGxMxUSmL1LMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] device property: Add device_get_bd_address() and fwnode_get_bd_address()
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Matthias Kaehlcke <mka@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, mw@semihalf.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>,
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org,
	bgodavar@codeaurora.org, Loic Poulain <loic.poulain@linaro.org>,
	Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Sep 21, 2018 at 10:16 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Matthias,
>
> On Thu, Sep 20, 2018 at 03:34:35PM -0700, Matthias Kaehlcke wrote:
> > Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
> > address (BD_ADDR) for a device. If the device node has a property
> > 'local-bd-address' the BD address is read from this property.
> >

I have nothing to object for the idea and agree fully on Sakari's comments.

After addressing them, fill free to add my

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/base/property.c  | 49 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/property.h |  4 ++++
> >  2 files changed, 53 insertions(+)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 240ab5230ff6..8fe546b9805a 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -18,6 +18,8 @@
> >  #include <linux/etherdevice.h>
> >  #include <linux/phy.h>
> >
> > +#define BD_ADDR_LEN  6
> > +
> >  struct property_set {
> >       struct device *dev;
> >       struct fwnode_handle fwnode;
> > @@ -1315,6 +1317,53 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
> >  }
> >  EXPORT_SYMBOL(device_get_mac_address);
> >
> > +/**
> > + * fwnode_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) from the
> > + *                         firmware node
> > + * @fwnode:  Pointer to the firmware node
> > + * @addr:    Address of buffer to store the BD address in
> > + * @alen:    Length of the buffer pointed to by addr, should be BD_ADDR_LEN
> > + *
> > + * Search the firmware node for 'local-bd-address'.
> > + *
> > + * All-zero BD addresses are rejected, because those could be properties
> > + * that exist in the firmware tables, but were not updated by the firmware. For
> > + * example, the DTS could define 'local-bd-address', with zero BD addresses.
> > + */
> > +int fwnode_get_bd_address(struct fwnode_handle *fwnode, u8 *addr, int alen)
>
> How about using bdaddr_t instead? The original caller was casting it to u8
> probably just because there was no function specifically for this purpose.
>
> I wonder if this also should be made depend on CONFIG_BT. The fwnode
> framework is unconditionally a part of the kernel and it's not very big at
> the moment but adding stuff little by little will add up eventually.
>
> > +{
> > +     u8 buf[BD_ADDR_LEN];
> > +     int ret;
> > +
> > +     if (alen != BD_ADDR_LEN)
> > +             return -EINVAL;
> > +
> > +     ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> > +                                         buf, alen);
> > +     if (ret < 0)
> > +             return ret;
> > +     if (is_zero_ether_addr(buf))
> > +             return -ENODATA;
> > +
> > +     memcpy(addr, buf, BD_ADDR_LEN);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(fwnode_get_bd_address);
> > +
> > +/**
> > + * device_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) for a
> > + *                         given device
> > + * @dev:     Pointer to the device
> > + * @addr:    Address of buffer to store the BD address in
> > + * @alen:    Length of the buffer pointed to by addr, should be BD_ADDR_LEN
> > + */
> > +int device_get_bd_address(struct device *dev, u8 *addr, int alen)
> > +{
> > +     return fwnode_get_bd_address(dev_fwnode(dev), addr, alen);
> > +}
> > +EXPORT_SYMBOL(device_get_bd_address);
> > +
> >  /**
> >   * fwnode_irq_get - Get IRQ directly from a fwnode
> >   * @fwnode:  Pointer to the firmware node
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index ac8a1ebc4c1b..4e2f1b276f4f 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -287,9 +287,13 @@ int device_get_phy_mode(struct device *dev);
> >
> >  void *device_get_mac_address(struct device *dev, char *addr, int alen);
> >
> > +int device_get_bd_address(struct device *dev, u8 *addr, int alen);
> > +
> >  int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
> >  void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
> >                            char *addr, int alen);
> > +int fwnode_get_bd_address(struct fwnode_handle *fwnode,
> > +                       u8 *addr, int alen);
>
> This would be a good opportunity to add a newline here, and avoid adding
> one after device_get_mac_address().
>
> >  struct fwnode_handle *fwnode_graph_get_next_endpoint(
> >       const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
> >  struct fwnode_handle *
>
> --
> Regards,
>
> Sakari Ailus
> sakari.ailus@linux.intel.com



-- 
With Best Regards,
Andy Shevchenko
