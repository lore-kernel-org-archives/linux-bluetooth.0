Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 4/4] client: Print LEAddress type in show and info commands
Date: Mon, 11 Dec 2017 13:40:25 +0100
Message-ID: <3027942.EkYWvo1UAH@ix>
In-Reply-To: <CABBYNZK+5JGmazDyGM771=RZhkYKbnDMFupZWk+23k4u6z06LQ@mail.gmail.com>
References: <20171211103837.25150-1-szymon.janc@codecoup.pl> <20171211103837.25150-4-szymon.janc@codecoup.pl> <CABBYNZK+5JGmazDyGM771=RZhkYKbnDMFupZWk+23k4u6z06LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Monday, 11 December 2017 13:10:28 CET Luiz Augusto von Dentz wrote:
> Hi Szymon,
> 
> On Mon, Dec 11, 2017 at 8:38 AM, Szymon Janc <szymon.janc@codecoup.pl> 
wrote:
> > ---
> > 
> >  client/main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/client/main.c b/client/main.c
> > index f3369e89a..a1d941e30 100644
> > --- a/client/main.c
> > +++ b/client/main.c
> > @@ -872,6 +872,7 @@ static void cmd_show(int argc, char *argv[])
> > 
> >         print_property(proxy, "Powered");
> >         print_property(proxy, "Discoverable");
> >         print_property(proxy, "Pairable");
> > 
> > +       print_property(proxy, "LEAddressType");
> > 
> >         print_uuids(proxy);
> >         print_property(proxy, "Modalias");
> >         print_property(proxy, "Discovering");
> > 
> > @@ -1447,6 +1448,7 @@ static void cmd_info(int argc, char *argv[])
> > 
> >         print_property(proxy, "Blocked");
> >         print_property(proxy, "Connected");
> >         print_property(proxy, "LegacyPairing");
> > 
> > +       print_property(proxy, "LEAddressType");
> > 
> >         print_uuids(proxy);
> >         print_property(proxy, "Modalias");
> >         print_property(proxy, "ManufacturerData");
> > 
> > --
> > 2.14.3
> 
> Another alternative to adding the LE specific type would be to add it
> as Manufacturer string so we can add the information of OUI if public
> or add the information of "Static Random", "Resolvable Random", etc.

I'd keep it simple - this should simply match to address type that needs to be 
passed when connecting L2CAP socket.

-- 
pozdrawiam
Szymon Janc
