Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 4/9] tools/btpclient: Store index along with adapter proxy
Date: Fri, 08 Dec 2017 11:12:55 +0100
Message-ID: <79623423.t27RlUlLFK@ix>
In-Reply-To: <CABBYNZ+Nw0KLgbEfU6F9f6kE4FAgTPspphFO5yW3Qs47hh05Sg@mail.gmail.com>
References: <20171207142143.27324-1-szymon.janc@codecoup.pl> <20171207142143.27324-5-szymon.janc@codecoup.pl> <CABBYNZ+Nw0KLgbEfU6F9f6kE4FAgTPspphFO5yW3Qs47hh05Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thursday, 7 December 2017 18:42:55 CET Luiz Augusto von Dentz wrote:
> Hi Szymon,
> 
> On Thu, Dec 7, 2017 at 12:21 PM, Szymon Janc <szymon.janc@codecoup.pl> 
wrote:
> > ---
> > 
> >  tools/btpclient.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/tools/btpclient.c b/tools/btpclient.c
> > index c7ff239b0..3a4971eeb 100644
> > --- a/tools/btpclient.c
> > +++ b/tools/btpclient.c
> > @@ -37,6 +37,7 @@
> > 
> >  struct btp_adapter {
> >  
> >         struct l_dbus_proxy *proxy;
> > 
> > +       unsigned int index;
> > 
> >  };
> >  
> >  struct btp_device {
> > 
> > @@ -157,9 +158,18 @@ static void proxy_added(struct l_dbus_proxy *proxy,
> > void *user_data)> 
> >         if (!strcmp(interface, "org.bluez.Adapter1")) {
> >         
> >                 struct btp_adapter *adapter;
> > 
> > +               unsigned int index;
> > +
> > +               /* TODO should we rely on path for index or use other
> > mapping +                * like queue size?
> > +                */
> > +               if (sscanf(l_dbus_proxy_get_path(proxy),
> > "/org/bluez/hci%u", +                                                    
> >           &index) != 1) +                       return;
> 
> Usually, we don't operate by index over D-Bus so if all operation are
> over D-Bus knowing the index shall not be needed, if this is for BTP
> then we could perhaps just map directly to the queue directly but Im
> not sure why would BTP have an adapter index?

This is only for BTP to identify adapter, I'll just simple counter. If adapter 
is gone we terminate anyway. And index is part of BTP header for historical 
reasons:)

> 
> >                 adapter = l_new(struct btp_adapter, 1);
> >                 adapter->proxy = proxy;
> > 
> > +               adapter->index = index;
> > 
> >                 l_queue_push_tail(adapters, adapter);
> >                 return;
> > 
> > --
> > 2.14.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
pozdrawiam
Szymon Janc
