Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJLTA8iznaG+ma0sHn967nSyhf-OM=xCm9nFZ_+isYKz9pyxhQ@mail.gmail.com>
References: <1416252138-17477-1-git-send-email-armansito@chromium.org>
	<1416252138-17477-2-git-send-email-armansito@chromium.org>
	<CABBYNZK6jjuhLwwHZYPSJGPqhMjXpm3VFMx2xfq5SOyeygjGJg@mail.gmail.com>
	<CAJLTA8iznaG+ma0sHn967nSyhf-OM=xCm9nFZ_+isYKz9pyxhQ@mail.gmail.com>
Date: Wed, 19 Nov 2014 17:54:50 +0200
Message-ID: <CABBYNZJPWmsJPN_Dd4m9UbA8-2JBxoMxJ90QVp-eP8y1Qeb17w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/12] attrib/gattrib: Add g_attrib_get_att.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@google.com>
Cc: Arman Uguray <armansito@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman, Michael,

On Wed, Nov 19, 2014 at 5:15 PM, Michael Janssen <jamuraa@google.com> wrote:
> Hi Arman, Luiz:
>
> On Wed Nov 19 2014 at 7:05:50 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Arman,
>>
>> On Mon, Nov 17, 2014 at 9:22 PM, Arman Uguray <armansito@chromium.org> wrote:
>> > Added the g_attrib_get_att function which returns the underlying bt_att
>> > structure associated with a GAttrib.
>> > ---
>> >  attrib/gattrib.c | 8 ++++++++
>> >  attrib/gattrib.h | 3 +++
>> >  2 files changed, 11 insertions(+)
>> >
>> > diff --git a/attrib/gattrib.c b/attrib/gattrib.c
>> > index ce7f7b3..a446ae6 100644
>> > --- a/attrib/gattrib.c
>> > +++ b/attrib/gattrib.c
>> > @@ -166,6 +166,14 @@ GIOChannel *g_attrib_get_channel(GAttrib *attrib)
>> >         return attrib->io;
>> >  }
>> >
>> > +struct bt_att *g_attrib_get_att(GAttrib *attrib)
>> > +{
>> > +       if (!attrib)
>> > +               return NULL;
>> > +
>> > +       return attrib->att;
>> > +}
>> > +
>> >  gboolean g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
>> >                                                         gpointer user_data)
>> >  {
>> > diff --git a/attrib/gattrib.h b/attrib/gattrib.h
>> > index 2ed57c1..374bac2 100644
>> > --- a/attrib/gattrib.h
>> > +++ b/attrib/gattrib.h
>> > @@ -31,6 +31,7 @@ extern "C" {
>> >  #define GATTRIB_ALL_REQS 0xFE
>> >  #define GATTRIB_ALL_HANDLES 0x0000
>> >
>> > +struct bt_att;  /* Forward declaration for compatibility */
>> >  struct _GAttrib;
>> >  typedef struct _GAttrib GAttrib;
>> >
>> > @@ -47,6 +48,8 @@ void g_attrib_unref(GAttrib *attrib);
>> >
>> >  GIOChannel *g_attrib_get_channel(GAttrib *attrib);
>> >
>> > +struct bt_att *g_attrib_get_att(GAttrib *attrib);
>> > +
>> >  gboolean g_attrib_set_destroy_function(GAttrib *attrib,
>> >                 GDestroyNotify destroy, gpointer user_data);
>> >
>> > --
>> > 2.1.0.rc2.206.gedb03e5
>>
>> Im not following you here, why you want to expose bt_att via GAttrib,
>> isn't it better to just have a g_attrib_get_fd if you just need to
>> access the fd?
>>
>>
>> --
>> Luiz Augusto von Dentz
>
> It's my understanding that the g_attrib_get_att function is needed in
> the transition from GAttrib to bt_att.  For now the GAttrib creates
> the bt_att, but eventually device_attach_attrib will create the bt_att
> on it's own once GAttrib is not needed anymore.  I don't have an issue
> with the reference semantics as long as it's clear.

I see, we might just return a void pointer here instead, although I
still believe this is a bit too soon to start changing things directly
on the core without proper unit tests.


-- 
Luiz Augusto von Dentz
