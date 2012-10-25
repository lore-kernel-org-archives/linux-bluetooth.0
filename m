Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 13:42:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v0 05/15] network: Add network .connect and .disconnect
Message-ID: <20121025104219.GB30500@x220>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1350661172-18125-6-git-send-email-mikel.astiz.oss@gmail.com>
 <CAJdJm_NfFbRfLg9Jp_id3_z74P5A-Rg0VPnHvvD-6NopJWTB=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_NfFbRfLg9Jp_id3_z74P5A-Rg0VPnHvvD-6NopJWTB=Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Oct 24, 2012, Anderson Lizardo wrote:
> Hi Mikel,
> 
> On Fri, Oct 19, 2012 at 11:39 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> > +static void connect_profile_cb(struct btd_device *device, int err,
> > +                                               const char *pdev, void *data)
> > +{
> > +       struct connect_req *req = data;
> > +
> > +       req->cb(req->profile, req->device, err);
> > +
> > +       g_free(req);
> > +}
> > +
> > +static int connect_profile(struct btd_device *dev, struct btd_profile *profile,
> > +                                               uint16_t id, btd_profile_cb cb)
> > +{
> > +       struct connect_req *req;
> > +       int err;
> > +
> > +       DBG("path %s id %u", device_get_path(dev), id);
> > +
> > +       req  = g_new0(struct connect_req, 1);
> > +       req->device = dev;
> 
> Isn't btd_device_ref() required here?

Looks like you're right and I missed this in my initial review. I went
ahead and pushed an extra patch to fix this.

Johan
