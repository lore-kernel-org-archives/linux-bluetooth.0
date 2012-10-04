Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Oct 2012 17:22:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH BlueZ v4 14/15] Use DBus.Properties on Control interface
Message-ID: <20121004142210.GA9024@x220>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
 <1349335599-12443-15-git-send-email-lucas.de.marchi@gmail.com>
 <CAJdJm_PZbDinMxO4En=3XMzjnNVTWpGQ9-pOV7VyfLJOJjY9Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_PZbDinMxO4En=3XMzjnNVTWpGQ9-pOV7VyfLJOJjY9Qg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Oct 04, 2012, Anderson Lizardo wrote:
> On Thu, Oct 4, 2012 at 3:26 AM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
> > @@ -77,13 +76,11 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
> >                 if (old_state != AVCTP_STATE_CONNECTED)
> >                         break;
> >
> > -               value = FALSE;
> >                 g_dbus_emit_signal(conn, dev->path,
> >                                         AUDIO_CONTROL_INTERFACE,
> >                                         "Disconnected", DBUS_TYPE_INVALID);
> > -               emit_property_changed(dev->path,
> > -                                       AUDIO_CONTROL_INTERFACE, "Connected",
> > -                                       DBUS_TYPE_BOOLEAN, &value);
> > +               g_dbus_emit_property_changed(conn, dev->path,
> > +                                       AUDIO_CONTROL_INTERFACE, "Connected");
> 
> Out of curiosity, do you know why this API has Connected/Disconnected
> signals besides the PropertyChanged("Connected", ...) ?

I think those should have been marked as deprecated in 4.x and removed
for BlueZ 5.

Johan
