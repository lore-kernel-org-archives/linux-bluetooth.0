Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140814100124.GA2865@t440s.ger.corp.intel.com>
References: <1407937477-25402-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1407937477-25402-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<20140814100124.GA2865@t440s.ger.corp.intel.com>
Date: Thu, 14 Aug 2014 12:13:16 +0200
Message-ID: <CAMv5Gbdy5F1q9VpchGRi9JmzFujv1nrsauv-UYicy1WJqAr=wA@mail.gmail.com>
Subject: Re: [PATCH 2/3] android/bluetooth: Add support for get remote service
 record property cmd
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,


On 14 August 2014 12:01, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Grzegorz,
>
> On Wed, Aug 13, 2014, Grzegorz Kolodziejczyk wrote:
> > +static void send_remote_sdp_rec_notify(bt_uuid_t *uuid, int channel,
> > +                                     char *name, uint8_t name_len,
> > +                                     uint8_t status, bdaddr_t *bdaddr)
> > +{
> > +     struct hal_prop_device_service_rec *prop;
> > +     uint8_t buf[BASELEN_REMOTE_DEV_PROP + name_len + sizeof(*prop)];
> > +     struct hal_ev_remote_device_props *ev = (void *) buf;
> > +     int prop_len = sizeof(*prop) + name_len;
> > +
> > +     memset(buf, 0, sizeof(buf));
> > +
> > +     if (status == HAL_STATUS_SUCCESS) {
> > +             prop = malloc(sizeof(*prop) + name_len);
> > +             prop->name_len = name_len;
> > +             prop->channel = (uint16_t)channel;
> > +             memcpy(prop->name, name, name_len);
> > +             memcpy(prop->uuid, &uuid->value.u128, sizeof(prop->uuid));
> > +
> > +             memcpy(ev->props[0].val, prop, prop_len);
> > +
> > +             free(prop);
> > +     }
>
> This whole extra malloc (which btw is missing a NULL check) seems
> unnecessary to me. Why don't you simply do:
>
>         if (status == HAL_STATUS_SUCCESS) {
>                 prop = (void *) &ev->props[0].val;
>
>                 prop->name_len = name_len;
>                 prop->channel = channel;
>                 memcpy(prop->name, name, name_len);
>                 memcpy(prop->uuid, &uuid->value.u128, sizeof(prop->uuid));
>         }
Good catch, I agree - this is simpler solution. Thanks! I'll change it in v2
>
> Johan

BR,
Grzegorz
