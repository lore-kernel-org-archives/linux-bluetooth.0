Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 18:17:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 08/12] Drop GAttrib ref if callback list is empty
Message-ID: <20110714151728.GA28921@dell.ger.corp.intel.com>
References: <1309874168-32716-9-git-send-email-claudio.takahasi@openbossa.org>
 <1309987430-10111-1-git-send-email-claudio.takahasi@openbossa.org>
 <20110714144444.GB26341@dell.ger.corp.intel.com>
 <CAJdJm_PuzO+vSjLuM=eWnjif64Ki8kcEJSgarBOizELNw-xH0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAJdJm_PuzO+vSjLuM=eWnjif64Ki8kcEJSgarBOizELNw-xH0A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Jul 14, 2011, Anderson Lizardo wrote:
> On Thu, Jul 14, 2011 at 10:44 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> >> @@ -2605,10 +2605,15 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
> >>
> >>       g_free(attio);
> >>
> >> +     if (device->attios != NULL)
> >> +             return TRUE;
> >> +
> >>       if (device->attioid) {
> >>               g_source_remove(device->attioid);
> >>               device->attioid = 0;
> >>       }
> >>
> >> +     g_attrib_unref(device->attrib);
> >> +
> >>       return TRUE;
> >>  }
> >
> > Looks like you're missing a device->attrib = NULL; after the unref.
> 
> I really don't see the point in setting a reference counted variable
> to NULL. How would we know whether this is the last usage or not?

You're not supposed to know. All you know is that device->attrib is one
reference to the GAttrib object. Calling unref is akin to saying "this
pointer is no longer valid" and since the btd_device object keeps living
after this function you should set the ->attrib pointer to NULL after
dropping this reference.

Johan
