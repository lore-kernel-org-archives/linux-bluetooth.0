Return-Path: <cyrus@holtmann.org>
Date: Sun, 3 Feb 2013 18:51:07 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/2] device: use device_set_trusted() in
 set_trust()
Message-Id: <20130203185107.0dcdfc4271d63c9e5403d697@studenti.unina.it>
In-Reply-To: <CAJdJm_OFBu_gtgBz8+RFSS8cDVbtVH9DfuRtnimOd8auh8zDgw@mail.gmail.com>
References: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
	<1359908071-15024-3-git-send-email-ospite@studenti.unina.it>
	<CAJdJm_OFBu_gtgBz8+RFSS8cDVbtVH9DfuRtnimOd8auh8zDgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 3 Feb 2013 13:32:12 -0400
Anderson Lizardo <anderson.lizardo@openbossa.org> wrote:

> Hi Antonio,
> 
> On Sun, Feb 3, 2013 at 12:14 PM, Antonio Ospite
> <ospite@studenti.unina.it> wrote:
> > @@ -724,17 +724,7 @@ static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
> >  {
> >         struct btd_device *device = data;
> >
> > -       if (device->trusted == value) {
> > -               g_dbus_pending_property_success(id);
> > -               return;
> > -       }
> > -
> > -       device->trusted = value;
> > -
> > -       store_device_info(device);
> > -
> > -       g_dbus_emit_property_changed(dbus_conn, device->path,
> > -                                               DEVICE_INTERFACE, "Trusted");
> > +       device_set_trusted(device, value);
> >
> >         g_dbus_pending_property_success(id);
> 
> g_dbus_pending_property_success() is now called always (whether the
> property changed or not). Not sure if this is an issue, but it is a
> change that needs at least a clarification on the commit message.
> 

The logic is equivalent to the previous one, as device_set_trusted()
returns without doing anything when (device->trusted == trusted), and
the previous implementation was already calling
g_dbus_pending_property_success() just before returning in any exit
path. Or was it meant to be g_dbus_pending_property_error() in the
first exit path? I don't know about that.

The previous set_trust() code didn't consider the !device case so we
should be OK if this function assumes the device is always defined.

If the code is OK I can improve the commit message, yes.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
