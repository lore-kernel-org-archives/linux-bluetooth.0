Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Nov 2014 10:22:43 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix dead code warnings
Message-ID: <20141111082205.GA9152@aemeltch-MOBL1>
References: <1415625918-10189-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1584207.SFKaHYrozt@leonov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1584207.SFKaHYrozt@leonov>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 10, 2014 at 09:05:41PM +0100, Szymon Janc wrote:
> Hi Andrei,
> 
> On Monday 10 of November 2014 15:25:18 Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > gatt_db_attribute_get_permissions() used everywhere without check since
> > those conditions are checked already.
> 
> It would make sense to put such warning into commit message if you are 
> referring to it in subject.
> 
> > ---
> >  android/gatt.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/android/gatt.c b/android/gatt.c
> > index 086bb94..04101f6 100644
> > --- a/android/gatt.c
> > +++ b/android/gatt.c
> > @@ -5992,8 +5992,7 @@ static void write_cmd_request(const uint8_t *cmd,
> > uint16_t cmd_len, if (!attrib)
> >  		return;
> > 
> > -	if (!gatt_db_attribute_get_permissions(attrib, &permissions))
> > -		return;
> > +	gatt_db_attribute_get_permissions(attrib, &permissions);
> > 
> >  	if (check_device_permissions(dev, cmd[0], permissions))
> >  		return;
> 
> So if we always pass valid pointers to this function, then maybe we should 
> change it definition to something like:
> 
> uint32_t gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib);
> 

Do we really need a helper which just does reference?

Best regards 
Andrei Emeltchenko 
