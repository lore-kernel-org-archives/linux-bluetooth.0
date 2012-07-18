Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Joohi RASTOGI <joohi.rastogi@stericsson.com>,
	Vani <vani273@gmail.com>
Date: Wed, 18 Jul 2012 12:30:33 +0200
Subject: RE: [PATCH BlueZ 3/5] AVRCP: Add browsing channel support
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B234AABDE5F@EXDCVYMBSTM005.EQ1STM.local>
References: <1341912961-24600-1-git-send-email-vani.patel@stericsson.com>
 <CABBYNZLBc2Jq8wMhxYB9G3GZu9xbE8WnKWSGk88K9kx_7cedzQ@mail.gmail.com>
In-Reply-To: <CABBYNZLBc2Jq8wMhxYB9G3GZu9xbE8WnKWSGk88K9kx_7cedzQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Tuesday, July 17, 2012 3:39 PM
> To: Vani-dineshbhai PATEL X
> Cc: User Name; Lucas De Marchi; Joohi RASTOGI; Vani
> Subject: Re: [PATCH BlueZ 3/5] AVRCP: Add browsing channel support
> 
> Hi Vani,
> 
> On Tue, Jul 10, 2012 at 12:36 PM, Vani-dineshbhai PATEL
> <vani.patel@stericsson.com> wrote:
> > +static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition
> cond,
> > +                               gpointer data) {
> > +       struct avctp *session = data;
> > +       uint8_t  *buf;
> > +       struct avctp_header *avctp;
> > +       int ret, sock;
> > +
> > +       buf = (uint8_t *)malloc(session->browsing_mtu);
> > +       if (!(cond & G_IO_IN))
> > +               return FALSE;
> > +
> > +       sock = g_io_channel_unix_get_fd(session->browsing_io);
> > +       ret = read(sock, buf, session->browsing_mtu);
> > +
> > +       if (ret <= 0)
> > +               return FALSE;
> > +
> > +       if ((unsigned int) ret < sizeof(struct avctp_header)) {
> > +               error("Too small AVRCP packet on browsing channel");
> > +               return FALSE;
> > +       }
> > +
> > +       avctp = (struct avctp_header *) buf;
> > +
> > +       if (avctp->packet_type != AVCTP_PACKET_SINGLE)
> > +               return FALSE;
> > +
> > +
> > +       return TRUE;
> > +}
> 
> buf is probably leaking here, besides I don't think we really need to have
> browsing channel being handled in a separated function, most of the code
> should actually be similar the only difference is that the handler list is
> different.
> 
I will rectify this. Also, buf is actually used in patch 5/5. 

> >  static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
> >                                 gpointer data)  { @@ -613,6 +663,47 @@
> > static void init_uinput(struct avctp *session)
> >                 DBG("AVRCP: uinput initialized for %s", address);  }
> >
> > +static void avctp_connect_browsing_cb(GIOChannel *chan,
> > +                                       GError *err,
> > +                                       gpointer data) {
> > +       struct avctp *session = data;
> > +       char address[18];
> > +       uint16_t imtu;
> > +       GError *gerr = NULL;
> > +
> > +       if (err) {
> > +               error("Browsing: %s", err->message);
> > +               g_io_channel_shutdown(chan, TRUE, NULL);
> > +               g_io_channel_unref(chan);
> > +               session->browsing_io = NULL;
> > +               return;
> > +       }
> > +
> > +       bt_io_get(chan, BT_IO_L2CAP, &gerr,
> > +                       BT_IO_OPT_DEST, &address,
> > +                       BT_IO_OPT_IMTU, &imtu,
> > +                       BT_IO_OPT_INVALID);
> > +       if (gerr) {
> > +               error("%s", err->message);
> 
> Why you are printing err if the check is about gerr? Please fix this.
Honest mistake. I will correct this.
> 
> > +static void avctp_confirm_browsing_cb(GIOChannel *chan, gpointer
> > +data) {
> > +       struct avctp *session;
> > +       struct audio_device *dev;
> > +       char address[18];
> > +       bdaddr_t src, dst;
> > +       GError *err = NULL;
> > +
> > +       bt_io_get(chan, BT_IO_L2CAP, &err,
> > +                       BT_IO_OPT_SOURCE_BDADDR, &src,
> > +                       BT_IO_OPT_DEST_BDADDR, &dst,
> > +                       BT_IO_OPT_DEST, address,
> > +                       BT_IO_OPT_INVALID);
> > +       if (err) {
> > +               g_error_free(err);
> > +               g_io_channel_shutdown(chan, TRUE, NULL);
> > +               return;
> > +       }
> > +
> > +       session = avctp_get_internal(&src, &dst);
> > +       if (!session)
> > +               goto drop;
> > +
> > +       dev = manager_get_device(&src, &dst, FALSE);
> > +       if (!dev) {
> > +               dev = manager_get_device(&src, &dst, TRUE);
> > +               if (!dev) {
> > +                       error("Browsing: Unable to get audio dev object for %s",
> > +                                                                address);
> > +                       goto drop;
> > +               }
> > +       }
> > +
> > +       if (dev->control == NULL) {
> > +               btd_device_add_uuid(dev->btd_dev, AVRCP_REMOTE_UUID);
> > +               if (dev->control == NULL)
> > +                       goto drop;
> > +       }
> > +
> > +       if (!session->control_io) {
> > +               error("Browsing: Refusing unexpected connect from %s",
> address);
> > +               goto drop;
> > +       }
> > +
> > +       if (session->browsing_io) {
> > +               error("Browsing channel already exist %s", address);
> > +               goto drop;
> > +       }
> > +
> > +       session->browsing_io = g_io_channel_ref(chan);
> > +
> > +       if (audio_device_request_authorization(dev, AVRCP_TARGET_UUID,
> > +                                               auth_browsing_cb, session) < 0)
> > +               goto drop;
> > +       return;
> > +
> > +drop:
> > +       if (!session || !session->control_io || !session->browsing_io)
> > +               g_io_channel_shutdown(chan, TRUE, NULL);
> > +
> > +       if (session && session->browsing_io)
> > +               g_io_channel_unref(session->browsing_io);
> > +}
> > +
> 
> Again here the code is very similar to control, perhaps we can have different
> functions after we are done with common checks to avoid duplicating too
> much code.
> 
I was thinking of keeping control channel and browsing channel separate. But
you are right, we should avoid duplication. I shall modify the functions to reuse
the code as much as possible.
> --
> Luiz Augusto von Dentz

Thanks & Regards,
Vani Patel
