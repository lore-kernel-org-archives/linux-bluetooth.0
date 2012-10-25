Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121025104219.GB30500@x220>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1350661172-18125-6-git-send-email-mikel.astiz.oss@gmail.com>
	<CAJdJm_NfFbRfLg9Jp_id3_z74P5A-Rg0VPnHvvD-6NopJWTB=Q@mail.gmail.com>
	<20121025104219.GB30500@x220>
Date: Thu, 25 Oct 2012 17:53:13 +0200
Message-ID: <CANT-zCUSkGJ1SWxUNU7J80WxRpotNbfEhmuQihoXj6WquaBePw@mail.gmail.com>
Subject: Re: [RFC v0 05/15] network: Add network .connect and .disconnect
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Oct 25, 2012 at 12:42 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Wed, Oct 24, 2012, Anderson Lizardo wrote:
>> Hi Mikel,
>>
>> On Fri, Oct 19, 2012 at 11:39 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> > +static void connect_profile_cb(struct btd_device *device, int err,
>> > +                                               const char *pdev, void *data)
>> > +{
>> > +       struct connect_req *req = data;
>> > +
>> > +       req->cb(req->profile, req->device, err);
>> > +
>> > +       g_free(req);
>> > +}
>> > +
>> > +static int connect_profile(struct btd_device *dev, struct btd_profile *profile,
>> > +                                               uint16_t id, btd_profile_cb cb)
>> > +{
>> > +       struct connect_req *req;
>> > +       int err;
>> > +
>> > +       DBG("path %s id %u", device_get_path(dev), id);
>> > +
>> > +       req  = g_new0(struct connect_req, 1);
>> > +       req->device = dev;
>>
>> Isn't btd_device_ref() required here?
>
> Looks like you're right and I missed this in my initial review. I went
> ahead and pushed an extra patch to fix this.

I don't think this patch was needed. Actually, the device pointer in
struct connect_req can be completely removed, since the callback
already receives such pointer, and the network_peer takes care of the
device refcounting. Mea culpa for adding this unnecessary field.

Cheers,
Mikel
