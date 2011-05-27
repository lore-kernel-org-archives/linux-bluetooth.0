Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1306497803.2553.5.camel@dp-x301>
References: <1306495584-9518-1-git-send-email-dmitriy.paliy@nokia.com>
	<BANLkTi=UYTbJ+P0C0DhB24SOGT2DffJ5Vw@mail.gmail.com>
	<1306497803.2553.5.camel@dp-x301>
Date: Fri, 27 May 2011 16:03:25 +0300
Message-ID: <BANLkTimGTZE=fXYbK0WHpyUdn82WyWNGog@mail.gmail.com>
Subject: Re: [PATCH] Fix invalid read and possible memory leaks
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Fri, May 27, 2011 at 3:03 PM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
> Hi Luiz,
>
> On Fri, 2011-05-27 at 14:56 +0300, ext Luiz Augusto von Dentz wrote:
>> Hi Dmitry,
>>
>> On Fri, May 27, 2011 at 2:26 PM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
>> > Fixed incorrect update of transport->owners GSlist in media_transport_free.
>> > Removal of list entries within 'for' loop leads to invalid read of memory
>> > (l = l->next) and memory leaks.
>> > ---
>> >  audio/transport.c |   15 +++++++++++----
>> >  1 files changed, 11 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/audio/transport.c b/audio/transport.c
>> > index aa3308d..4047d80 100644
>> > --- a/audio/transport.c
>> > +++ b/audio/transport.c
>> > @@ -805,14 +805,21 @@ static GDBusSignalTable transport_signals[] = {
>> >        { }
>> >  };
>> >
>> > +static void media_transport_remove_helper(gpointer data, gpointer user_data)
>> > +{
>> > +       struct media_transport *transport = user_data;
>> > +       struct media_owner *owner = data;
>> > +
>> > +       media_transport_remove(transport, owner);
>> > +}
>> > +
>> > +
>> >  static void media_transport_free(void *data)
>> >  {
>> >        struct media_transport *transport = data;
>> > -       GSList *l;
>> > -
>> > -       for (l = transport->owners; l; l = l->next)
>> > -               media_transport_remove(transport, l->data);
>> >
>> > +       g_slist_foreach(transport->owners, media_transport_remove_helper,
>> > +                                                               transport);
>> >        g_slist_free(transport->owners);
>> >
>> >        if (transport->session)
>> > --
>> > 1.7.4.1
>>
>> Usually we should just use while (list) and do the list = list->next
>> before item removal.
>
> This is how it is done in the g_slist_foreach function. Therefore, may
> be it is better to use ready function without exposing implementation
> details of this loop.

Well normally it is more code to do it via g_slist_foreach than on
while loop, it is probably more expensive too since it has to call a
callback for each element and obviously the g_slist_foreach has to
take care of prefetch next element.

-- 
Luiz Augusto von Dentz
Computer Engineer
