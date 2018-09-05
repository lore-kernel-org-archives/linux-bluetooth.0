Return-Path: <climbbb.kim@gmail.com>
MIME-Version: 1.0
References: <1536115855-25744-1-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536115855-25744-1-git-send-email-climbbb.kim@gmail.com>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Date: Wed, 5 Sep 2018 15:28:12 +0900
Message-ID: <CAL6iAaKy8OAZWKSUzLp5vnsgXBLq2s3-bfgEne+0QVU_tRkdtw@mail.gmail.com>
Subject: Re: [PATCH v2] tty: Change tty_{port|standard}_install() return type
 to void
To: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
	Karsten Keil <isdn@linux-pingi.de>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Hansson <ulf.hansson@linaro.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>, David Lin <dtwlin@gmail.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Oliver Neukum <oneukum@suse.com>,
	Mathias Nyman <mathias.nyman@intel.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>,
	Quytelda Kahja <quytelda@tamalin.org>, Yisheng Xie <xieyisheng1@huawei.com>,
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nicolas Pitre <nicolas.pitre@linaro.org>,
	Adam Borowski <kilobyte@angband.pl>, Alexander Potapenko <glider@google.com>, Thomas Meyer <thomas@m3y3r.de>,
	Joe Perches <joe@perches.com>, Meng Xu <mengxu.gatech@gmail.com>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	"open list:ISDN SUBSYSTEM" <netdev@vger.kernel.org>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, "open list:S390" <linux-s390@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
	"moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
	"open list:HYPERVISOR VIRTUAL CONSOLE DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	"open list:SPARC SERIAL DRIVERS" <sparclinux@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>,
	"open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary="000000000000c791ab057519e1c6"
List-ID: <linux-bluetooth.vger.kernel.org>

--000000000000c791ab057519e1c6
Content-Type: text/plain; charset="UTF-8"

Please ignore this patch. I will drop this V2 and will be update with V3
which is made by seperate.
Sorry for the noisy again.

BR.
Jaejoong

On Wed, Sep 5, 2018 at 11:51 AM Jaejoong Kim <climbbb.kim@gmail.com> wrote:

> Many drivers with tty use the tty_stand_install(). But, there is no
> need to handle the error, since it always returns 0. So, change the
> return type of tty_standard_install() and tty_port_install() to void
> type and remove unnecessary exception handling where we use these
> functions.
>
> Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
> ---
> Changes in v2:
> - Update commit title
> - Squash other patches into one
>   https://lkml.org/lkml/2018/9/4/70
>
>  arch/um/drivers/line.c              |  7 +------
>  drivers/isdn/capi/capi.c            | 10 ++++------
>  drivers/isdn/i4l/isdn_tty.c         |  3 ++-
>  drivers/misc/pti.c                  | 28 +++++++++++++---------------
>  drivers/mmc/core/sdio_uart.c        | 11 ++++-------
>  drivers/s390/char/con3215.c         |  3 ++-
>  drivers/s390/char/tty3270.c         |  7 +------
>  drivers/staging/fwserial/fwserial.c | 22 ++++++++--------------
>  drivers/staging/gdm724x/gdm_tty.c   | 11 +++--------
>  drivers/staging/greybus/uart.c      | 10 ++--------
>  drivers/tty/hvc/hvc_console.c       |  7 ++-----
>  drivers/tty/hvc/hvcs.c              | 10 ++--------
>  drivers/tty/mips_ejtag_fdc.c        |  4 +++-
>  drivers/tty/n_gsm.c                 |  9 +--------
>  drivers/tty/nozomi.c                |  8 +++-----
>  drivers/tty/serial/kgdb_nmi.c       | 11 +----------
>  drivers/tty/synclink.c              |  3 ++-
>  drivers/tty/synclinkmp.c            |  3 ++-
>  drivers/tty/tty_io.c                | 10 ++++++----
>  drivers/tty/tty_port.c              |  4 ++--
>  drivers/tty/vcc.c                   |  5 +----
>  drivers/tty/vt/vt.c                 |  5 +----
>  drivers/usb/class/cdc-acm.c         | 10 +---------
>  drivers/usb/host/xhci-dbgtty.c      |  3 ++-
>  drivers/usb/serial/usb-serial.c     |  6 +-----
>  include/linux/tty.h                 |  4 ++--
>  net/bluetooth/rfcomm/tty.c          |  7 +------
>  27 files changed, 73 insertions(+), 148 deletions(-)
>
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index 8d80b27..47058cf 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -338,12 +338,7 @@ int line_open(struct tty_struct *tty, struct file
> *filp)
>  int line_install(struct tty_driver *driver, struct tty_struct *tty,
>                  struct line *line)
>  {
> -       int ret;
> -
> -       ret = tty_standard_install(driver, tty);
> -       if (ret)
> -               return ret;
> -
> +       tty_standard_install(driver, tty);
>         tty->driver_data = line;
>
>         return 0;
> diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
> index ef5560b..08daf3a 100644
> --- a/drivers/isdn/capi/capi.c
> +++ b/drivers/isdn/capi/capi.c
> @@ -999,13 +999,11 @@ static int
>  capinc_tty_install(struct tty_driver *driver, struct tty_struct *tty)
>  {
>         struct capiminor *mp = capiminor_get(tty->index);
> -       int ret = tty_standard_install(driver, tty);
>
> -       if (ret == 0)
> -               tty->driver_data = mp;
> -       else
> -               capiminor_put(mp);
> -       return ret;
> +       tty_standard_install(driver, tty);
> +       tty->driver_data = mp;
> +
> +       return 0;
>  }
>
>  static void capinc_tty_cleanup(struct tty_struct *tty)
> diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
> index b730037..3d6b24e 100644
> --- a/drivers/isdn/i4l/isdn_tty.c
> +++ b/drivers/isdn/i4l/isdn_tty.c
> @@ -1481,8 +1481,9 @@ static int isdn_tty_install(struct tty_driver
> *driver, struct tty_struct *tty)
>                 return -ENODEV;
>
>         tty->driver_data = info;
> +       tty_port_install(&info->port, driver, tty);
>
> -       return tty_port_install(&info->port, driver, tty);
> +       return 0;
>  }
>
>  /*
> diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
> index 41f2a9f..5c885a1 100644
> --- a/drivers/misc/pti.c
> +++ b/drivers/misc/pti.c
> @@ -462,26 +462,24 @@ static int pti_tty_install(struct tty_driver
> *driver, struct tty_struct *tty)
>  {
>         int idx = tty->index;
>         struct pti_tty *pti_tty_data;
> -       int ret = tty_standard_install(driver, tty);
>
> -       if (ret == 0) {
> -               pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
> -               if (pti_tty_data == NULL)
> -                       return -ENOMEM;
> +       tty_standard_install(driver, tty);
> +       pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
> +       if (pti_tty_data == NULL)
> +               return -ENOMEM;
>
> -               if (idx == PTITTY_MINOR_START)
> -                       pti_tty_data->mc = pti_request_masterchannel(0,
> NULL);
> -               else
> -                       pti_tty_data->mc = pti_request_masterchannel(2,
> NULL);
> +       if (idx == PTITTY_MINOR_START)
> +               pti_tty_data->mc = pti_request_masterchannel(0, NULL);
> +       else
> +               pti_tty_data->mc = pti_request_masterchannel(2, NULL);
>
> -               if (pti_tty_data->mc == NULL) {
> -                       kfree(pti_tty_data);
> -                       return -ENXIO;
> -               }
> -               tty->driver_data = pti_tty_data;
> +       if (pti_tty_data->mc == NULL) {
> +               kfree(pti_tty_data);
> +               return -ENXIO;
>         }
> +       tty->driver_data = pti_tty_data;
>
> -       return ret;
> +       return 0;
>  }
>
>  /**
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 25e1130..b727186 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -731,14 +731,11 @@ static int sdio_uart_install(struct tty_driver
> *driver, struct tty_struct *tty)
>  {
>         int idx = tty->index;
>         struct sdio_uart_port *port = sdio_uart_port_get(idx);
> -       int ret = tty_standard_install(driver, tty);
>
> -       if (ret == 0)
> -               /* This is the ref sdio_uart_port get provided */
> -               tty->driver_data = port;
> -       else
> -               sdio_uart_port_put(port);
> -       return ret;
> +       tty_standard_install(driver, tty);
> +       tty->driver_data = port;
> +
> +       return 0;
>  }
>
>  /**
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index 8c9d412..6a9f6d9 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -965,8 +965,9 @@ static int tty3215_install(struct tty_driver *driver,
> struct tty_struct *tty)
>                 return -ENODEV;
>
>         tty->driver_data = raw;
> +       tty_port_install(&raw->port, driver, tty);
>
> -       return tty_port_install(&raw->port, driver, tty);
> +       return 0;
>  }
>
>  /*
> diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
> index 5b8af27..2915f95 100644
> --- a/drivers/s390/char/tty3270.c
> +++ b/drivers/s390/char/tty3270.c
> @@ -1017,12 +1017,7 @@ static int tty3270_install(struct tty_driver
> *driver, struct tty_struct *tty)
>         raw3270_activate_view(&tp->view);
>
>  port_install:
> -       rc = tty_port_install(&tp->port, driver, tty);
> -       if (rc) {
> -               raw3270_put_view(&tp->view);
> -               return rc;
> -       }
> -
> +       tty_port_install(&tp->port, driver, tty);
>         tty->driver_data = tp;
>
>         return 0;
> diff --git a/drivers/staging/fwserial/fwserial.c
> b/drivers/staging/fwserial/fwserial.c
> index fa0dd42..5134019 100644
> --- a/drivers/staging/fwserial/fwserial.c
> +++ b/drivers/staging/fwserial/fwserial.c
> @@ -1064,27 +1064,21 @@ static void fwtty_cleanup(struct tty_struct *tty)
>  static int fwtty_install(struct tty_driver *driver, struct tty_struct
> *tty)
>  {
>         struct fwtty_port *port = fwtty_port_get(tty->index);
> -       int err;
>
> -       err = tty_standard_install(driver, tty);
> -       if (!err)
> -               tty->driver_data = port;
> -       else
> -               fwtty_port_put(port);
> -       return err;
> +       tty_standard_install(driver, tty);
> +       tty->driver_data = port;
> +
> +       return 0;
>  }
>
>  static int fwloop_install(struct tty_driver *driver, struct tty_struct
> *tty)
>  {
>         struct fwtty_port *port = fwtty_port_get(table_idx(tty->index));
> -       int err;
>
> -       err = tty_standard_install(driver, tty);
> -       if (!err)
> -               tty->driver_data = port;
> -       else
> -               fwtty_port_put(port);
> -       return err;
> +       tty_standard_install(driver, tty);
> +       tty->driver_data = port;
> +
> +       return 0;
>  }
>
>  static int fwtty_write(struct tty_struct *tty, const unsigned char *buf,
> int c)
> diff --git a/drivers/staging/gdm724x/gdm_tty.c
> b/drivers/staging/gdm724x/gdm_tty.c
> index 6e81369..d6348df 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -62,6 +62,7 @@ static int gdm_tty_install(struct tty_driver *driver,
> struct tty_struct *tty)
>                 return -ENODEV;
>
>         mutex_lock(&gdm_table_lock);
> +
>         gdm = gdm_table[ret][tty->index];
>         if (!gdm) {
>                 mutex_unlock(&gdm_table_lock);
> @@ -69,15 +70,9 @@ static int gdm_tty_install(struct tty_driver *driver,
> struct tty_struct *tty)
>         }
>
>         tty_port_get(&gdm->port);
> -
> -       ret = tty_standard_install(driver, tty);
> -       if (ret) {
> -               tty_port_put(&gdm->port);
> -               mutex_unlock(&gdm_table_lock);
> -               return ret;
> -       }
> -
> +       tty_standard_install(driver, tty);
>         tty->driver_data = gdm;
> +
>         mutex_unlock(&gdm_table_lock);
>
>         return 0;
> diff --git a/drivers/staging/greybus/uart.c
> b/drivers/staging/greybus/uart.c
> index 8a00632..182155b 100644
> --- a/drivers/staging/greybus/uart.c
> +++ b/drivers/staging/greybus/uart.c
> @@ -393,21 +393,15 @@ static void release_minor(struct gb_tty *gb_tty)
>  static int gb_tty_install(struct tty_driver *driver, struct tty_struct
> *tty)
>  {
>         struct gb_tty *gb_tty;
> -       int retval;
>
>         gb_tty = get_gb_by_minor(tty->index);
>         if (!gb_tty)
>                 return -ENODEV;
>
> -       retval = tty_standard_install(driver, tty);
> -       if (retval)
> -               goto error;
> -
> +       tty_standard_install(driver, tty);
>         tty->driver_data = gb_tty;
> +
>         return 0;
> -error:
> -       tty_port_put(&gb_tty->port);
> -       return retval;
>  }
>
>  static int gb_tty_open(struct tty_struct *tty, struct file *file)
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index 5414c4a..13fad62 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -329,7 +329,6 @@ static void hvc_unthrottle(struct tty_struct *tty)
>  static int hvc_install(struct tty_driver *driver, struct tty_struct *tty)
>  {
>         struct hvc_struct *hp;
> -       int rc;
>
>         /* Auto increments kref reference if found. */
>         hp = hvc_get_by_index(tty->index);
> @@ -337,11 +336,9 @@ static int hvc_install(struct tty_driver *driver,
> struct tty_struct *tty)
>                 return -ENODEV;
>
>         tty->driver_data = hp;
> +       tty_port_install(&hp->port, driver, tty);
>
> -       rc = tty_port_install(&hp->port, driver, tty);
> -       if (rc)
> -               tty_port_put(&hp->port);
> -       return rc;
> +       return 0;
>  }
>
>  /*
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index cb4db1b..4dfa70c 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -1140,16 +1140,10 @@ static int hvcs_install(struct tty_driver *driver,
> struct tty_struct *tty)
>                 goto err_put;
>         }
>
> -       retval = tty_port_install(&hvcsd->port, driver, tty);
> -       if (retval)
> -               goto err_irq;
> +       tty_port_install(&hvcsd->port, driver, tty);
>
>         return 0;
> -err_irq:
> -       spin_lock_irqsave(&hvcsd->lock, flags);
> -       vio_disable_interrupts(hvcsd->vdev);
> -       spin_unlock_irqrestore(&hvcsd->lock, flags);
> -       free_irq(irq, hvcsd);
> +
>  err_put:
>         tty_port_put(&hvcsd->port);
>
> diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
> index 4c1cd49..33e06b4 100644
> --- a/drivers/tty/mips_ejtag_fdc.c
> +++ b/drivers/tty/mips_ejtag_fdc.c
> @@ -763,7 +763,9 @@ static int mips_ejtag_fdc_tty_install(struct
> tty_driver *driver,
>         struct mips_ejtag_fdc_tty *priv = driver->driver_state;
>
>         tty->driver_data = &priv->ports[tty->index];
> -       return tty_port_install(&priv->ports[tty->index].port, driver,
> tty);
> +       tty_port_install(&priv->ports[tty->index].port, driver, tty);
> +
> +       return 0;
>  }
>
>  static int mips_ejtag_fdc_tty_open(struct tty_struct *tty, struct file
> *filp)
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 86b7e20..c52fa2d 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2917,7 +2917,6 @@ static int gsmtty_install(struct tty_driver *driver,
> struct tty_struct *tty)
>         unsigned int line = tty->index;
>         unsigned int mux = line >> 6;
>         bool alloc = false;
> -       int ret;
>
>         line = line & 0x3F;
>
> @@ -2949,14 +2948,8 @@ static int gsmtty_install(struct tty_driver
> *driver, struct tty_struct *tty)
>                 mutex_unlock(&gsm->mutex);
>                 return -ENOMEM;
>         }
> -       ret = tty_port_install(&dlci->port, driver, tty);
> -       if (ret) {
> -               if (alloc)
> -                       dlci_put(dlci);
> -               mutex_unlock(&gsm->mutex);
> -               return ret;
> -       }
>
> +       tty_port_install(&dlci->port, driver, tty);
>         dlci_get(dlci);
>         dlci_get(gsm->dlci[0]);
>         mux_get(gsm);
> diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
> index fed820e..479583d 100644
> --- a/drivers/tty/nozomi.c
> +++ b/drivers/tty/nozomi.c
> @@ -1555,13 +1555,11 @@ static int ntty_install(struct tty_driver *driver,
> struct tty_struct *tty)
>  {
>         struct port *port = get_port_by_tty(tty);
>         struct nozomi *dc = get_dc_by_tty(tty);
> -       int ret;
>         if (!port || !dc || dc->state != NOZOMI_STATE_READY)
>                 return -ENODEV;
> -       ret = tty_standard_install(driver, tty);
> -       if (ret == 0)
> -               tty->driver_data = port;
> -       return ret;
> +       tty_standard_install(driver, tty);
> +       tty->driver_data = port;
> +       return 0;
>  }
>
>  static void ntty_cleanup(struct tty_struct *tty)
> diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
> index 4029272..ed8f806 100644
> --- a/drivers/tty/serial/kgdb_nmi.c
> +++ b/drivers/tty/serial/kgdb_nmi.c
> @@ -234,7 +234,6 @@ static const struct tty_port_operations
> kgdb_nmi_tty_port_ops = {
>  static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_struct
> *tty)
>  {
>         struct kgdb_nmi_tty_priv *priv;
> -       int ret;
>
>         priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -245,17 +244,9 @@ static int kgdb_nmi_tty_install(struct tty_driver
> *drv, struct tty_struct *tty)
>         tty_port_init(&priv->port);
>         priv->port.ops = &kgdb_nmi_tty_port_ops;
>         tty->driver_data = priv;
> +       tty_port_install(&priv->port, drv, tty);
>
> -       ret = tty_port_install(&priv->port, drv, tty);
> -       if (ret) {
> -               pr_err("%s: can't install tty port: %d\n", __func__, ret);
> -               goto err;
> -       }
>         return 0;
> -err:
> -       tty_port_destroy(&priv->port);
> -       kfree(priv);
> -       return ret;
>  }
>
>  static void kgdb_nmi_tty_cleanup(struct tty_struct *tty)
> diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
> index fbdf4d0..6e7e4d6 100644
> --- a/drivers/tty/synclink.c
> +++ b/drivers/tty/synclink.c
> @@ -3355,8 +3355,9 @@ static int mgsl_install(struct tty_driver *driver,
> struct tty_struct *tty)
>         if (mgsl_paranoia_check(info, tty->name, "mgsl_open"))
>                 return -ENODEV;
>         tty->driver_data = info;
> +       tty_port_install(&info->port, driver, tty);
>
> -       return tty_port_install(&info->port, driver, tty);
> +       return 0;
>  }
>
>  /* mgsl_open()
> diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
> index 1e4d5b9..2d99a5b 100644
> --- a/drivers/tty/synclinkmp.c
> +++ b/drivers/tty/synclinkmp.c
> @@ -734,8 +734,9 @@ static int install(struct tty_driver *driver, struct
> tty_struct *tty)
>         }
>
>         tty->driver_data = info;
> +       tty_port_install(&info->port, driver, tty);
>
> -       return tty_port_install(&info->port, driver, tty);
> +       return 0;
>  }
>
>  /* Called when a port is opened.  Init and enable port.
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 32bc3e3..b01cec8 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1196,13 +1196,12 @@ void tty_init_termios(struct tty_struct *tty)
>  }
>  EXPORT_SYMBOL_GPL(tty_init_termios);
>
> -int tty_standard_install(struct tty_driver *driver, struct tty_struct
> *tty)
> +void tty_standard_install(struct tty_driver *driver, struct tty_struct
> *tty)
>  {
>         tty_init_termios(tty);
>         tty_driver_kref_get(driver);
>         tty->count++;
>         driver->ttys[tty->index] = tty;
> -       return 0;
>  }
>  EXPORT_SYMBOL_GPL(tty_standard_install);
>
> @@ -1221,8 +1220,11 @@ EXPORT_SYMBOL_GPL(tty_standard_install);
>  static int tty_driver_install_tty(struct tty_driver *driver,
>                                                 struct tty_struct *tty)
>  {
> -       return driver->ops->install ? driver->ops->install(driver, tty) :
> -               tty_standard_install(driver, tty);
> +       if (driver->ops->install)
> +               return driver->ops->install(driver, tty);
> +
> +       tty_standard_install(driver, tty);
> +       return 0;
>  }
>
>  /**
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 25d7368..fd8d40d 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -656,11 +656,11 @@ EXPORT_SYMBOL(tty_port_close);
>   * to a concrete tty specified by @tty. Use this or
> tty_port_register_device
>   * (or both). Call tty_port_link_device as a last resort.
>   */
> -int tty_port_install(struct tty_port *port, struct tty_driver *driver,
> +void tty_port_install(struct tty_port *port, struct tty_driver *driver,
>                 struct tty_struct *tty)
>  {
>         tty->port = port;
> -       return tty_standard_install(driver, tty);
> +       tty_standard_install(driver, tty);
>  }
>  EXPORT_SYMBOL_GPL(tty_port_install);
>
> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> index 58b454c..ce32631 100644
> --- a/drivers/tty/vcc.c
> +++ b/drivers/tty/vcc.c
> @@ -987,7 +987,6 @@ static int vcc_install(struct tty_driver *driver,
> struct tty_struct *tty)
>  {
>         struct vcc_port *port_vcc;
>         struct tty_port *port_tty;
> -       int ret;
>
>         if (unlikely(!tty)) {
>                 pr_err("VCC: install: Invalid TTY handle\n");
> @@ -997,9 +996,7 @@ static int vcc_install(struct tty_driver *driver,
> struct tty_struct *tty)
>         if (tty->index >= VCC_MAX_PORTS)
>                 return -EINVAL;
>
> -       ret = tty_standard_install(driver, tty);
> -       if (ret)
> -               return ret;
> +       tty_standard_install(driver, tty);
>
>         port_tty = kzalloc(sizeof(struct tty_port), GFP_KERNEL);
>         if (!port_tty)
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 5f1183b..cc72254 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3222,10 +3222,7 @@ static int con_install(struct tty_driver *driver,
> struct tty_struct *tty)
>                 goto unlock;
>         }
>
> -       ret = tty_port_install(&vc->port, driver, tty);
> -       if (ret)
> -               goto unlock;
> -
> +       tty_port_install(&vc->port, driver, tty);
>         tty->driver_data = vc;
>         vc->port.tty = tty;
>
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 27346d6..de6a27e 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -572,23 +572,15 @@ static void acm_softint(struct work_struct *work)
>  static int acm_tty_install(struct tty_driver *driver, struct tty_struct
> *tty)
>  {
>         struct acm *acm;
> -       int retval;
>
>         acm = acm_get_by_minor(tty->index);
>         if (!acm)
>                 return -ENODEV;
>
> -       retval = tty_standard_install(driver, tty);
> -       if (retval)
> -               goto error_init_termios;
> -
> +       tty_standard_install(driver, tty);
>         tty->driver_data = acm;
>
>         return 0;
> -
> -error_init_termios:
> -       tty_port_put(&acm->port);
> -       return retval;
>  }
>
>  static int acm_tty_open(struct tty_struct *tty, struct file *filp)
> diff --git a/drivers/usb/host/xhci-dbgtty.c
> b/drivers/usb/host/xhci-dbgtty.c
> index aff79ff..18d661c 100644
> --- a/drivers/usb/host/xhci-dbgtty.c
> +++ b/drivers/usb/host/xhci-dbgtty.c
> @@ -174,8 +174,9 @@ static int dbc_tty_install(struct tty_driver *driver,
> struct tty_struct *tty)
>         struct dbc_port         *port = driver->driver_state;
>
>         tty->driver_data = port;
> +       tty_port_install(&port->port, driver, tty);
>
> -       return tty_port_install(&port->port, driver, tty);
> +       return 0;
>  }
>
>  static int dbc_tty_open(struct tty_struct *tty, struct file *file)
> diff --git a/drivers/usb/serial/usb-serial.c
> b/drivers/usb/serial/usb-serial.c
> index f7aaa7f..5cfc2ca 100644
> --- a/drivers/usb/serial/usb-serial.c
> +++ b/drivers/usb/serial/usb-serial.c
> @@ -192,9 +192,7 @@ static int serial_install(struct tty_driver *driver,
> struct tty_struct *tty)
>         if (retval)
>                 goto error_get_interface;
>
> -       retval = tty_standard_install(driver, tty);
> -       if (retval)
> -               goto error_init_termios;
> +       tty_standard_install(driver, tty);
>
>         mutex_unlock(&serial->disc_mutex);
>
> @@ -206,8 +204,6 @@ static int serial_install(struct tty_driver *driver,
> struct tty_struct *tty)
>
>         return retval;
>
> - error_init_termios:
> -       usb_autopm_put_interface(serial->interface);
>   error_get_interface:
>         module_put(serial->type->driver.owner);
>   error_module_get:
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index c56e397..63cdac1 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -556,7 +556,7 @@ extern struct tty_struct *tty_init_dev(struct
> tty_driver *driver, int idx);
>  extern void tty_release_struct(struct tty_struct *tty, int idx);
>  extern int tty_release(struct inode *inode, struct file *filp);
>  extern void tty_init_termios(struct tty_struct *tty);
> -extern int tty_standard_install(struct tty_driver *driver,
> +extern void tty_standard_install(struct tty_driver *driver,
>                 struct tty_struct *tty);
>
>  extern struct mutex tty_mutex;
> @@ -688,7 +688,7 @@ extern int tty_port_close_start(struct tty_port *port,
>  extern void tty_port_close_end(struct tty_port *port, struct tty_struct
> *tty);
>  extern void tty_port_close(struct tty_port *port,
>                                 struct tty_struct *tty, struct file *filp);
> -extern int tty_port_install(struct tty_port *port, struct tty_driver
> *driver,
> +extern void tty_port_install(struct tty_port *port, struct tty_driver
> *driver,
>                                 struct tty_struct *tty);
>  extern int tty_port_open(struct tty_port *port,
>                                 struct tty_struct *tty, struct file *filp);
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index 5e44d84..b654420 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -710,7 +710,6 @@ static int rfcomm_tty_install(struct tty_driver
> *driver, struct tty_struct *tty)
>  {
>         struct rfcomm_dev *dev;
>         struct rfcomm_dlc *dlc;
> -       int err;
>
>         dev = rfcomm_dev_get(tty->index);
>         if (!dev)
> @@ -725,11 +724,7 @@ static int rfcomm_tty_install(struct tty_driver
> *driver, struct tty_struct *tty)
>         set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
>
>         /* install the tty_port */
> -       err = tty_port_install(&dev->port, driver, tty);
> -       if (err) {
> -               rfcomm_tty_cleanup(tty);
> -               return err;
> -       }
> +       tty_port_install(&dev->port, driver, tty);
>
>         /* take over the tty_port reference if the port was created with
> the
>          * flag RFCOMM_RELEASE_ONHUP. This will force the release of the
> port
> --
> 2.7.4
>
>

--000000000000c791ab057519e1c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Please ignore this patch. I will drop this V2 and wil=
l be update with V3 which is made by seperate.</div><div>Sorry for the nois=
y again.</div><div><br></div><div>BR.</div><div>Jaejoong</div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr">On Wed, Sep 5, 2018 at 11:51 AM Jaejoong=
 Kim &lt;<a href=3D"mailto:climbbb.kim@gmail.com">climbbb.kim@gmail.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Many drivers with tty u=
se the tty_stand_install(). But, there is no<br>
need to handle the error, since it always returns 0. So, change the<br>
return type of tty_standard_install() and tty_port_install() to void<br>
type and remove unnecessary exception handling where we use these<br>
functions.<br>
<br>
Signed-off-by: Jaejoong Kim &lt;<a href=3D"mailto:climbbb.kim@gmail.com" ta=
rget=3D"_blank">climbbb.kim@gmail.com</a>&gt;<br>
---<br>
Changes in v2:<br>
- Update commit title<br>
- Squash other patches into one<br>
=C2=A0 <a href=3D"https://lkml.org/lkml/2018/9/4/70" rel=3D"noreferrer" tar=
get=3D"_blank">https://lkml.org/lkml/2018/9/4/70</a><br>
<br>
=C2=A0arch/um/drivers/line.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 7 +------<br>
=C2=A0drivers/isdn/capi/capi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1=
0 ++++------<br>
=C2=A0drivers/isdn/i4l/isdn_tty.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
3 ++-<br>
=C2=A0drivers/misc/pti.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 28 +++++++++++++---------------<br>
=C2=A0drivers/mmc/core/sdio_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 ++++----=
---<br>
=C2=A0drivers/s390/char/con3215.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
3 ++-<br>
=C2=A0drivers/s390/char/tty3270.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
7 +------<br>
=C2=A0drivers/staging/fwserial/fwserial.c | 22 ++++++++--------------<br>
=C2=A0drivers/staging/gdm724x/gdm_tty.c=C2=A0 =C2=A0| 11 +++--------<br>
=C2=A0drivers/staging/greybus/uart.c=C2=A0 =C2=A0 =C2=A0 | 10 ++--------<br=
>
=C2=A0drivers/tty/hvc/hvc_console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 ++-=
----<br>
=C2=A0drivers/tty/hvc/hvcs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 10 ++--------<br>
=C2=A0drivers/tty/mips_ejtag_fdc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++=
-<br>
=C2=A0drivers/tty/n_gsm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 9 +--------<br>
=C2=A0drivers/tty/nozomi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 8 +++-----<br>
=C2=A0drivers/tty/serial/kgdb_nmi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +-------=
---<br>
=C2=A0drivers/tty/synclink.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 3 ++-<br>
=C2=A0drivers/tty/synclinkmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 3 ++-<br>
=C2=A0drivers/tty/tty_io.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 10 ++++++----<br>
=C2=A0drivers/tty/tty_port.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 4 ++--<br>
=C2=A0drivers/tty/vcc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 5 +----<br>
=C2=A0drivers/tty/vt/vt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 5 +----<br>
=C2=A0drivers/usb/class/cdc-acm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +--=
-------<br>
=C2=A0drivers/usb/host/xhci-dbgtty.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0drivers/usb/serial/usb-serial.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +-----<b=
r>
=C2=A0include/linux/tty.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A0net/bluetooth/rfcomm/tty.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
7 +------<br>
=C2=A027 files changed, 73 insertions(+), 148 deletions(-)<br>
<br>
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c<br>
index 8d80b27..47058cf 100644<br>
--- a/arch/um/drivers/line.c<br>
+++ b/arch/um/drivers/line.c<br>
@@ -338,12 +338,7 @@ int line_open(struct tty_struct *tty, struct file *fil=
p)<br>
=C2=A0int line_install(struct tty_driver *driver, struct tty_struct *tty,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct line *=
line)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D tty_standard_install(driver, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D line;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c<br>
index ef5560b..08daf3a 100644<br>
--- a/drivers/isdn/capi/capi.c<br>
+++ b/drivers/isdn/capi/capi.c<br>
@@ -999,13 +999,11 @@ static int<br>
=C2=A0capinc_tty_install(struct tty_driver *driver, struct tty_struct *tty)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct capiminor *mp =3D capiminor_get(tty-&gt;=
index);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D tty_standard_install(driver, tty);<=
br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data=
 =3D mp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capiminor_put(mp);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data =3D mp;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0static void capinc_tty_cleanup(struct tty_struct *tty)<br>
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c<br>
index b730037..3d6b24e 100644<br>
--- a/drivers/isdn/i4l/isdn_tty.c<br>
+++ b/drivers/isdn/i4l/isdn_tty.c<br>
@@ -1481,8 +1481,9 @@ static int isdn_tty_install(struct tty_driver *driver=
, struct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D info;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;info-&gt;port, driver, tt=
y);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return tty_port_install(&amp;info-&gt;port, dri=
ver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c<br>
index 41f2a9f..5c885a1 100644<br>
--- a/drivers/misc/pti.c<br>
+++ b/drivers/misc/pti.c<br>
@@ -462,26 +462,24 @@ static int pti_tty_install(struct tty_driver *driver,=
 struct tty_struct *tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx =3D tty-&gt;index;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pti_tty *pti_tty_data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D tty_standard_install(driver, tty);<=
br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pti_tty_data =3D km=
alloc(sizeof(struct pti_tty), GFP_KERNEL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pti_tty_data =
=3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -ENOMEM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pti_tty_data =3D kmalloc(sizeof(struct pti_tty)=
, GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pti_tty_data =3D=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (idx =3D=3D PTIT=
TY_MINOR_START)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pti_tty_data-&gt;mc =3D pti_request_masterchannel(0, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pti_tty_data-&gt;mc =3D pti_request_masterchannel(2, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (idx =3D=3D PTITTY_MINOR_START)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pti_tty_data-&gt;mc=
 =3D pti_request_masterchannel(0, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pti_tty_data-&gt;mc=
 =3D pti_request_masterchannel(2, NULL);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pti_tty_data-&g=
t;mc =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0kfree(pti_tty_data);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -ENXIO;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data=
 =3D pti_tty_data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pti_tty_data-&gt;mc =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(pti_tty_data)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENXIO;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data =3D pti_tty_data;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c<br=
>
index 25e1130..b727186 100644<br>
--- a/drivers/mmc/core/sdio_uart.c<br>
+++ b/drivers/mmc/core/sdio_uart.c<br>
@@ -731,14 +731,11 @@ static int sdio_uart_install(struct tty_driver *drive=
r, struct tty_struct *tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx =3D tty-&gt;index;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sdio_uart_port *port =3D sdio_uart_port_=
get(idx);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D tty_standard_install(driver, tty);<=
br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* This is the ref =
sdio_uart_port get provided */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data=
 =3D port;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdio_uart_port_put(=
port);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data =3D port;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c<br>
index 8c9d412..6a9f6d9 100644<br>
--- a/drivers/s390/char/con3215.c<br>
+++ b/drivers/s390/char/con3215.c<br>
@@ -965,8 +965,9 @@ static int tty3215_install(struct tty_driver *driver, s=
truct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D raw;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;raw-&gt;port, driver, tty=
);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return tty_port_install(&amp;raw-&gt;port, driv=
er, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c<br>
index 5b8af27..2915f95 100644<br>
--- a/drivers/s390/char/tty3270.c<br>
+++ b/drivers/s390/char/tty3270.c<br>
@@ -1017,12 +1017,7 @@ static int tty3270_install(struct tty_driver *driver=
, struct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 raw3270_activate_view(&amp;tp-&gt;view);<br>
<br>
=C2=A0port_install:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D tty_port_install(&amp;tp-&gt;port, drive=
r, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raw3270_put_view(&a=
mp;tp-&gt;view);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;tp-&gt;port, driver, tty)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D tp;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial=
/fwserial.c<br>
index fa0dd42..5134019 100644<br>
--- a/drivers/staging/fwserial/fwserial.c<br>
+++ b/drivers/staging/fwserial/fwserial.c<br>
@@ -1064,27 +1064,21 @@ static void fwtty_cleanup(struct tty_struct *tty)<b=
r>
=C2=A0static int fwtty_install(struct tty_driver *driver, struct tty_struct=
 *tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct fwtty_port *port =3D fwtty_port_get(tty-=
&gt;index);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D tty_standard_install(driver, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!err)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data=
 =3D port;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fwtty_port_put(port=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data =3D port;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0static int fwloop_install(struct tty_driver *driver, struct tty_struc=
t *tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct fwtty_port *port =3D fwtty_port_get(tabl=
e_idx(tty-&gt;index));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D tty_standard_install(driver, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!err)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data=
 =3D port;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fwtty_port_put(port=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data =3D port;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0static int fwtty_write(struct tty_struct *tty, const unsigned char *b=
uf, int c)<br>
diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gd=
m_tty.c<br>
index 6e81369..d6348df 100644<br>
--- a/drivers/staging/gdm724x/gdm_tty.c<br>
+++ b/drivers/staging/gdm724x/gdm_tty.c<br>
@@ -62,6 +62,7 @@ static int gdm_tty_install(struct tty_driver *driver, str=
uct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;gdm_table_lock);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gdm =3D gdm_table[ret][tty-&gt;index];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!gdm) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;g=
dm_table_lock);<br>
@@ -69,15 +70,9 @@ static int gdm_tty_install(struct tty_driver *driver, st=
ruct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty_port_get(&amp;gdm-&gt;port);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D tty_standard_install(driver, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_put(&amp;g=
dm-&gt;port);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;g=
dm_table_lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D gdm;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;gdm_table_lock);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.=
c<br>
index 8a00632..182155b 100644<br>
--- a/drivers/staging/greybus/uart.c<br>
+++ b/drivers/staging/greybus/uart.c<br>
@@ -393,21 +393,15 @@ static void release_minor(struct gb_tty *gb_tty)<br>
=C2=A0static int gb_tty_install(struct tty_driver *driver, struct tty_struc=
t *tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gb_tty *gb_tty;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int retval;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gb_tty =3D get_gb_by_minor(tty-&gt;index);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!gb_tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D tty_standard_install(driver, tty);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (retval)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D gb_tty;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-error:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_put(&amp;gb_tty-&gt;port);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return retval;<br>
=C2=A0}<br>
<br>
=C2=A0static int gb_tty_open(struct tty_struct *tty, struct file *file)<br>
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c<=
br>
index 5414c4a..13fad62 100644<br>
--- a/drivers/tty/hvc/hvc_console.c<br>
+++ b/drivers/tty/hvc/hvc_console.c<br>
@@ -329,7 +329,6 @@ static void hvc_unthrottle(struct tty_struct *tty)<br>
=C2=A0static int hvc_install(struct tty_driver *driver, struct tty_struct *=
tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hvc_struct *hp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Auto increments kref reference if found. */<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hp =3D hvc_get_by_index(tty-&gt;index);<br>
@@ -337,11 +336,9 @@ static int hvc_install(struct tty_driver *driver, stru=
ct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D hp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;hp-&gt;port, driver, tty)=
;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D tty_port_install(&amp;hp-&gt;port, drive=
r, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_put(&amp;h=
p-&gt;port);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c<br>
index cb4db1b..4dfa70c 100644<br>
--- a/drivers/tty/hvc/hvcs.c<br>
+++ b/drivers/tty/hvc/hvcs.c<br>
@@ -1140,16 +1140,10 @@ static int hvcs_install(struct tty_driver *driver, =
struct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_put;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D tty_port_install(&amp;hvcsd-&gt;port=
, driver, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (retval)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_irq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;hvcsd-&gt;port, driver, t=
ty);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-err_irq:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;hvcsd-&gt;lock, flags);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0vio_disable_interrupts(hvcsd-&gt;vdev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;hvcsd-&gt;lock, fla=
gs);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0free_irq(irq, hvcsd);<br>
+<br>
=C2=A0err_put:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty_port_put(&amp;hvcsd-&gt;port);<br>
<br>
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c<br=
>
index 4c1cd49..33e06b4 100644<br>
--- a/drivers/tty/mips_ejtag_fdc.c<br>
+++ b/drivers/tty/mips_ejtag_fdc.c<br>
@@ -763,7 +763,9 @@ static int mips_ejtag_fdc_tty_install(struct tty_driver=
 *driver,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mips_ejtag_fdc_tty *priv =3D driver-&gt;=
driver_state;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D &amp;priv-&gt;ports[tty=
-&gt;index];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return tty_port_install(&amp;priv-&gt;ports[tty=
-&gt;index].port, driver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;priv-&gt;ports[tty-&gt;in=
dex].port, driver, tty);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0static int mips_ejtag_fdc_tty_open(struct tty_struct *tty, struct fil=
e *filp)<br>
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c<br>
index 86b7e20..c52fa2d 100644<br>
--- a/drivers/tty/n_gsm.c<br>
+++ b/drivers/tty/n_gsm.c<br>
@@ -2917,7 +2917,6 @@ static int gsmtty_install(struct tty_driver *driver, =
struct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int line =3D tty-&gt;index;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int mux =3D line &gt;&gt; 6;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool alloc =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D line &amp; 0x3F;<br>
<br>
@@ -2949,14 +2948,8 @@ static int gsmtty_install(struct tty_driver *driver,=
 struct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;g=
sm-&gt;mutex);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D tty_port_install(&amp;dlci-&gt;port, dr=
iver, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (alloc)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dlci_put(dlci);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;g=
sm-&gt;mutex);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;dlci-&gt;port, driver, tt=
y);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dlci_get(dlci);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dlci_get(gsm-&gt;dlci[0]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_get(gsm);<br>
diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c<br>
index fed820e..479583d 100644<br>
--- a/drivers/tty/nozomi.c<br>
+++ b/drivers/tty/nozomi.c<br>
@@ -1555,13 +1555,11 @@ static int ntty_install(struct tty_driver *driver, =
struct tty_struct *tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct port *port =3D get_port_by_tty(tty);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct nozomi *dc =3D get_dc_by_tty(tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!port || !dc || dc-&gt;state !=3D NOZOMI_ST=
ATE_READY)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D tty_standard_install(driver, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data=
 =3D port;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty-&gt;driver_data =3D port;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0static void ntty_cleanup(struct tty_struct *tty)<br>
diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c<=
br>
index 4029272..ed8f806 100644<br>
--- a/drivers/tty/serial/kgdb_nmi.c<br>
+++ b/drivers/tty/serial/kgdb_nmi.c<br>
@@ -234,7 +234,6 @@ static const struct tty_port_operations kgdb_nmi_tty_po=
rt_ops =3D {<br>
=C2=A0static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_st=
ruct *tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct kgdb_nmi_tty_priv *priv;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!priv)<br>
@@ -245,17 +244,9 @@ static int kgdb_nmi_tty_install(struct tty_driver *drv=
, struct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty_port_init(&amp;priv-&gt;port);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 priv-&gt;port.ops =3D &amp;kgdb_nmi_tty_port_op=
s;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D priv;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;priv-&gt;port, drv, tty);=
<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D tty_port_install(&amp;priv-&gt;port, dr=
v, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;%s: ca=
n&#39;t install tty port: %d\n&quot;, __func__, ret);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-err:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_destroy(&amp;priv-&gt;port);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(priv);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
=C2=A0static void kgdb_nmi_tty_cleanup(struct tty_struct *tty)<br>
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c<br>
index fbdf4d0..6e7e4d6 100644<br>
--- a/drivers/tty/synclink.c<br>
+++ b/drivers/tty/synclink.c<br>
@@ -3355,8 +3355,9 @@ static int mgsl_install(struct tty_driver *driver, st=
ruct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mgsl_paranoia_check(info, tty-&gt;name, &qu=
ot;mgsl_open&quot;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D info;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;info-&gt;port, driver, tt=
y);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return tty_port_install(&amp;info-&gt;port, dri=
ver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/* mgsl_open()<br>
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c<br>
index 1e4d5b9..2d99a5b 100644<br>
--- a/drivers/tty/synclinkmp.c<br>
+++ b/drivers/tty/synclinkmp.c<br>
@@ -734,8 +734,9 @@ static int install(struct tty_driver *driver, struct tt=
y_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D info;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;info-&gt;port, driver, tt=
y);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return tty_port_install(&amp;info-&gt;port, dri=
ver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/* Called when a port is opened.=C2=A0 Init and enable port.<br>
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c<br>
index 32bc3e3..b01cec8 100644<br>
--- a/drivers/tty/tty_io.c<br>
+++ b/drivers/tty/tty_io.c<br>
@@ -1196,13 +1196,12 @@ void tty_init_termios(struct tty_struct *tty)<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL_GPL(tty_init_termios);<br>
<br>
-int tty_standard_install(struct tty_driver *driver, struct tty_struct *tty=
)<br>
+void tty_standard_install(struct tty_driver *driver, struct tty_struct *tt=
y)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty_init_termios(tty);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty_driver_kref_get(driver);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;count++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 driver-&gt;ttys[tty-&gt;index] =3D tty;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL_GPL(tty_standard_install);<br>
<br>
@@ -1221,8 +1220,11 @@ EXPORT_SYMBOL_GPL(tty_standard_install);<br>
=C2=A0static int tty_driver_install_tty(struct tty_driver *driver,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct tty_struct *tty)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return driver-&gt;ops-&gt;install ? driver-&gt;=
ops-&gt;install(driver, tty) :<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_instal=
l(driver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (driver-&gt;ops-&gt;install)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return driver-&gt;o=
ps-&gt;install(driver, tty);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c<br>
index 25d7368..fd8d40d 100644<br>
--- a/drivers/tty/tty_port.c<br>
+++ b/drivers/tty/tty_port.c<br>
@@ -656,11 +656,11 @@ EXPORT_SYMBOL(tty_port_close);<br>
=C2=A0 * to a concrete tty specified by @tty. Use this or tty_port_register=
_device<br>
=C2=A0 * (or both). Call tty_port_link_device as a last resort.<br>
=C2=A0 */<br>
-int tty_port_install(struct tty_port *port, struct tty_driver *driver,<br>
+void tty_port_install(struct tty_port *port, struct tty_driver *driver,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tty_struct *=
tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;port =3D port;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return tty_standard_install(driver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL_GPL(tty_port_install);<br>
<br>
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c<br>
index 58b454c..ce32631 100644<br>
--- a/drivers/tty/vcc.c<br>
+++ b/drivers/tty/vcc.c<br>
@@ -987,7 +987,6 @@ static int vcc_install(struct tty_driver *driver, struc=
t tty_struct *tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vcc_port *port_vcc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tty_port *port_tty;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(!tty)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err(&quot;VCC: i=
nstall: Invalid TTY handle\n&quot;);<br>
@@ -997,9 +996,7 @@ static int vcc_install(struct tty_driver *driver, struc=
t tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tty-&gt;index &gt;=3D VCC_MAX_PORTS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D tty_standard_install(driver, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_tty =3D kzalloc(sizeof(struct tty_port), G=
FP_KERNEL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!port_tty)<br>
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c<br>
index 5f1183b..cc72254 100644<br>
--- a/drivers/tty/vt/vt.c<br>
+++ b/drivers/tty/vt/vt.c<br>
@@ -3222,10 +3222,7 @@ static int con_install(struct tty_driver *driver, st=
ruct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unlock;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D tty_port_install(&amp;vc-&gt;port, driv=
er, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto unlock;<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;vc-&gt;port, driver, tty)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D vc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vc-&gt;port.tty =3D tty;<br>
<br>
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c<br>
index 27346d6..de6a27e 100644<br>
--- a/drivers/usb/class/cdc-acm.c<br>
+++ b/drivers/usb/class/cdc-acm.c<br>
@@ -572,23 +572,15 @@ static void acm_softint(struct work_struct *work)<br>
=C2=A0static int acm_tty_install(struct tty_driver *driver, struct tty_stru=
ct *tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct acm *acm;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int retval;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 acm =3D acm_get_by_minor(tty-&gt;index);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!acm)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D tty_standard_install(driver, tty);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (retval)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_init_ter=
mios;<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D acm;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-<br>
-error_init_termios:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_put(&amp;acm-&gt;port);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return retval;<br>
=C2=A0}<br>
<br>
=C2=A0static int acm_tty_open(struct tty_struct *tty, struct file *filp)<br=
>
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.=
c<br>
index aff79ff..18d661c 100644<br>
--- a/drivers/usb/host/xhci-dbgtty.c<br>
+++ b/drivers/usb/host/xhci-dbgtty.c<br>
@@ -174,8 +174,9 @@ static int dbc_tty_install(struct tty_driver *driver, s=
truct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dbc_port=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*port =3D driver-&gt;driver_state;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tty-&gt;driver_data =3D port;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;port-&gt;port, driver, tt=
y);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return tty_port_install(&amp;port-&gt;port, dri=
ver, tty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0static int dbc_tty_open(struct tty_struct *tty, struct file *file)<br=
>
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-seria=
l.c<br>
index f7aaa7f..5cfc2ca 100644<br>
--- a/drivers/usb/serial/usb-serial.c<br>
+++ b/drivers/usb/serial/usb-serial.c<br>
@@ -192,9 +192,7 @@ static int serial_install(struct tty_driver *driver, st=
ruct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (retval)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_get_inte=
rface;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D tty_standard_install(driver, tty);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (retval)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_init_ter=
mios;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_standard_install(driver, tty);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;serial-&gt;disc_mutex);<br>
<br>
@@ -206,8 +204,6 @@ static int serial_install(struct tty_driver *driver, st=
ruct tty_struct *tty)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;<br>
<br>
- error_init_termios:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0usb_autopm_put_interface(serial-&gt;interface);=
<br>
=C2=A0 error_get_interface:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 module_put(serial-&gt;type-&gt;driver.owner);<b=
r>
=C2=A0 error_module_get:<br>
diff --git a/include/linux/tty.h b/include/linux/tty.h<br>
index c56e397..63cdac1 100644<br>
--- a/include/linux/tty.h<br>
+++ b/include/linux/tty.h<br>
@@ -556,7 +556,7 @@ extern struct tty_struct *tty_init_dev(struct tty_drive=
r *driver, int idx);<br>
=C2=A0extern void tty_release_struct(struct tty_struct *tty, int idx);<br>
=C2=A0extern int tty_release(struct inode *inode, struct file *filp);<br>
=C2=A0extern void tty_init_termios(struct tty_struct *tty);<br>
-extern int tty_standard_install(struct tty_driver *driver,<br>
+extern void tty_standard_install(struct tty_driver *driver,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tty_struct *=
tty);<br>
<br>
=C2=A0extern struct mutex tty_mutex;<br>
@@ -688,7 +688,7 @@ extern int tty_port_close_start(struct tty_port *port,<=
br>
=C2=A0extern void tty_port_close_end(struct tty_port *port, struct tty_stru=
ct *tty);<br>
=C2=A0extern void tty_port_close(struct tty_port *port,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tty_struct *tty, struct file =
*filp);<br>
-extern int tty_port_install(struct tty_port *port, struct tty_driver *driv=
er,<br>
+extern void tty_port_install(struct tty_port *port, struct tty_driver *dri=
ver,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tty_struct *tty);<br>
=C2=A0extern int tty_port_open(struct tty_port *port,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tty_struct *tty, struct file =
*filp);<br>
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c<br>
index 5e44d84..b654420 100644<br>
--- a/net/bluetooth/rfcomm/tty.c<br>
+++ b/net/bluetooth/rfcomm/tty.c<br>
@@ -710,7 +710,6 @@ static int rfcomm_tty_install(struct tty_driver *driver=
, struct tty_struct *tty)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rfcomm_dev *dev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rfcomm_dlc *dlc;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D rfcomm_dev_get(tty-&gt;index);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!dev)<br>
@@ -725,11 +724,7 @@ static int rfcomm_tty_install(struct tty_driver *drive=
r, struct tty_struct *tty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(RFCOMM_TTY_ATTACHED, &amp;dev-&gt;flags=
);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* install the tty_port */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D tty_port_install(&amp;dev-&gt;port, dri=
ver, tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rfcomm_tty_cleanup(=
tty);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tty_port_install(&amp;dev-&gt;port, driver, tty=
);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* take over the tty_port reference if the port=
 was created with the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* flag RFCOMM_RELEASE_ONHUP. This will fo=
rce the release of the port<br>
-- <br>
2.7.4<br>
<br>
</blockquote></div></div>

--000000000000c791ab057519e1c6--
