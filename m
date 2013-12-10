Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Dec 2013 11:08:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] input: Fix crash when SDP record isn't available
Message-ID: <20131210090814.GA9360@x220.p-661hnu-f1>
References: <1386428021.32408.13.camel@nuvo>
 <20131207175226.GB29280@x220.p-661hnu-f1>
 <1386452701.32408.25.camel@nuvo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386452701.32408.25.camel@nuvo>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sat, Dec 07, 2013, Bastien Nocera wrote:
> On Sat, 2013-12-07 at 21:52 +0400, Johan Hedberg wrote:
> > Hi Bastien,
> > 
> > On Sat, Dec 07, 2013, Bastien Nocera wrote:
> > > On startup, if the SDP cache has been removed but the pairing
> > > information is still present, we'd crash trying to access inside a
> > > NULL record struct.
> > > ---
> > >  profiles/input/device.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/profiles/input/device.c b/profiles/input/device.c
> > > index 521aca8..62f6dbb 100644
> > > --- a/profiles/input/device.c
> > > +++ b/profiles/input/device.c
> > > @@ -811,6 +811,9 @@ static struct input_device *input_device_new(struct btd_service *service)
> > >  	struct input_device *idev;
> > >  	char name[HCI_MAX_NAME_LENGTH + 1];
> > >  
> > > +	if (!rec)
> > > +		return NULL;
> > > +
> > >  	idev = g_new0(struct input_device, 1);
> > >  	bacpy(&idev->src, btd_adapter_get_address(adapter));
> > >  	bacpy(&idev->dst, device_get_address(device));
> > 
> > I've applied your first patch, but I'd like to understand a bit better
> > how you'd end up in this situation. Is this accomplishable through BlueZ
> > APIs or only if one goes and messes with the storage directly? Either
> > way, is this the best approach or should we consider still creating the
> > input device but just ignore the bits that depend on the SDP record?
> 
> I rm'ed the file in the cache/ directory. I'm not too fussed about what
> the end result actually is, it just shouldn't crash. The same patch with
> a warning that you shouldn't fiddle with the cache directory would be
> fine as well ;)

Fair enough. I've applied the patch now. Thanks.

Johan
