Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Dec 2014 12:22:26 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix dead code warnings
Message-ID: <20141219102224.GB5094@aemeltch-MOBL1>
References: <1418981080-19796-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1729627.57WACxufJO@uw000953>
 <20141219101448.GA5094@aemeltch-MOBL1>
 <1971447.3gPWfdfUJW@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1971447.3gPWfdfUJW@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Dec 19, 2014 at 11:15:43AM +0100, Szymon Janc wrote:
> Hi Andrei,
> 
> On Friday 19 of December 2014 12:14:50 Andrei Emeltchenko wrote:
> > Hi Szymon,
> > 
> > On Fri, Dec 19, 2014 at 11:07:55AM +0100, Szymon Janc wrote:
> > > Hi Andrei,
> > > 
> > > On Friday 19 of December 2014 11:24:40 Andrei Emeltchenko wrote:
> > > > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > > 
> > > > gatt_db_attribute_get_permissions() used everywhere without check since
> > > > those conditions are checked already.
> > > > ---
> > > >  android/gatt.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/android/gatt.c b/android/gatt.c
> > > > index 0258d91..169f6db 100644
> > > > --- a/android/gatt.c
> > > > +++ b/android/gatt.c
> > > > @@ -6311,8 +6311,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
> > > >  	if (!attrib)
> > > >  		return;
> > > >  
> > > > -	if (!gatt_db_attribute_get_permissions(attrib, &permissions))
> > > > -		return;
> > > > +	gatt_db_attribute_get_permissions(attrib, &permissions);
> > > >  
> > > >  	if (check_device_permissions(dev, cmd[0], permissions))
> > > >  		return;
> > > 
> > > Wasn't identical patch already reviewed few weeks ago?
> > > 
> > 
> > It is still valid. No better approach was found.
> 
> I suggested possible solution which you implemented in V2. But you seem to
> ignored comment from Luiz so this didn't moved on.

I still have the patch, it shall be applied anyway on top of this patch
since they are fixing __different__ things. AFAIK Luiz did not propose
anything he was just against the patch.

Best regards 
Andrei Emeltchenko 

