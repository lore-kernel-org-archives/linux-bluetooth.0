Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1511540634.18754.8.camel@ewol.com>
Subject: Re: [RFC]Mesh: meshctl configuration output fails in
 gatt.c:pipe_write
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 24 Nov 2017 09:23:54 -0700
In-Reply-To: <CABBYNZKLGjucdGxWJ-771MPc6xZnE9GWnaPUpdqbUX=vCaz1aA@mail.gmail.com>
References: <1511534342.16445.52.camel@ewol.com>
         <CABBYNZKLGjucdGxWJ-771MPc6xZnE9GWnaPUpdqbUX=vCaz1aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, 2017-11-24 at 17:10 +0200, Luiz Augusto von Dentz wrote:
> Hi Steve,
> 
> On Fri, Nov 24, 2017 at 4:39 PM, Steve Brown <sbrown@cortland.com>
> wrote:
> > If the first command output in a new connection exceeds 20 bytes,
> > mesh_gatt_write sets the SAR to FIRST as the write_mtu is initially
> > 0
> > and the default is GATT_MTU-3 (20).
> > 
> > When pipe_write gets called, a new larger write_mtu has been set,
> > but
> > the SAR is still set to FIRST. It's assumed that data->gatt_len >
> > max_len. However, it's not which causes lots of bogus output.
> > 
> > I've added code to reset the SAR and length in acquire_write_reply
> > in
> > case write_mtu might have changed.
> > 
> > This seems to work, but I'm sure there is a better way.
> > 
> > Steve
> > 
> > ---
> > 
> > 
> > diff --git a/mesh/gatt.c b/mesh/gatt.c
> > index 001eb17a8..3f59268f2 100644
> > --- a/mesh/gatt.c
> > +++ b/mesh/gatt.c
> > @@ -358,6 +362,7 @@ static void acquire_write_reply(DBusMessage
> > *message, void *user_data)
> >         struct write_data *data = user_data;
> >         DBusError error;
> >         int fd;
> > +       uint8_t max_len;
> > 
> >         dbus_error_init(&error);
> > 
> > @@ -383,6 +388,18 @@ static void acquire_write_reply(DBusMessage
> > *message, void *user_data)
> > 
> >         write_io = pipe_io_new(fd);
> > 
> > +       /* Reset type and length as write_mtu may have changed */
> > +       max_len = write_mtu ? write_mtu - 3 : GATT_MTU - 3;
> > +       data->gatt_data[0] &= GATT_TYPE_MASK;
> 
> Ive never really liked the idea of putting the SAR byte into data but
> it was required due to use of WriteValue, now perhaps we can even
> remove that since AcquireWrite is stable the sar byte can be set in
> an
> independent variable in pipe_write so we can move this logic there.
> 
> > +       if (max_len < data->gatt_len) {
> > +               data->iov.iov_len = max_len;
> > +               data->gatt_data[0] |= GATT_SAR_FIRST;
> > +       }
> > +
> > +       else
> > +               data->iov.iov_len = data->gatt_len;
> > +
> >         pipe_write(write_io, data);
> >  }
> > 

Thanks for your quick response.

I've just started reading the gatt-api doc. I might be ready to have at
this sometime in the spring. 

I discovered the problem while trying to configure the new zephyr
mesh_shell. It should probably be fixed sooner than later. I best defer
to somebody more experienced.

Steve
