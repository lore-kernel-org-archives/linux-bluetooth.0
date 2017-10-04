Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1507120856.23708.18.camel@hadess.net>
Subject: Re: [PATCH 8/9] plugins/sixaxis: Add support for DualShock 4/PS4
 cable pairing
From: Bastien Nocera <hadess@hadess.net>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org,
        Juha Kuikka <juha.kuikka@gmail.com>
Date: Wed, 04 Oct 2017 14:40:56 +0200
In-Reply-To: <8659915.mKjsMy947m@ix>
References: <20170904181212.5639-1-hadess@hadess.net>
         <20170904181212.5639-8-hadess@hadess.net> <8659915.mKjsMy947m@ix>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-09-27 at 11:12 +0200, Szymon Janc wrote:
> Hi Bastien,
> 
> On Monday, 4 September 2017 20:12:11 CEST Bastien Nocera wrote:
> > From: Juha Kuikka <juha.kuikka@gmail.com>
> > 
> > This patch adds support for "pairing" a Dualshock4 controller over
> > USB
> > into the sixaxis plugin, similarly to what the Sixaxis/PS3
> > controller
> > supported.
> > 
> > Actual bonding happens on first connection, but the device will be
> > marked as trusted when the agent replies.
> > 
> > This patch is based on DS4 supprt for sixpair tool by t0xicCode:
> > https://github.com/t0xicCode/sixpair/commit/975c38cb6cd61a2f0be3507
> > 14f0f64ce
> > f5f0432c ---
> >  plugins/sixaxis.c | 73
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file
> > changed, 72
> > insertions(+), 1 deletion(-)
> > 
> > diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> > index b62834d72..eb15acb92 100644
> > --- a/plugins/sixaxis.c
> > +++ b/plugins/sixaxis.c
> > @@ -83,10 +83,34 @@ static int sixaxis_get_device_bdaddr(int fd,
> > bdaddr_t
> > *bdaddr) return 0;
> >  }
> > 
> > +static int ds4_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
> > +{
> > +	uint8_t buf[7];
> > +	int ret;
> > +
> > +	memset(buf, 0, sizeof(buf));
> > +
> > +	buf[0] = 0x81;
> > +
> > +	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> > +	if (ret < 0) {
> > +		error("ds4: failed to read device address (%s)",
> > +		      strerror(errno));
> 
> Lets prefix all sixaxis error/info logs with "sixaxis:"

Sure, I'll make some changes to mention whether the sixaxis or DS4
variant of the call was made.

Nothing else?
