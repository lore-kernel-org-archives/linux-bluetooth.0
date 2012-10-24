Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1350661172-18125-6-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1350661172-18125-6-git-send-email-mikel.astiz.oss@gmail.com>
Date: Wed, 24 Oct 2012 08:28:23 -0400
Message-ID: <CAJdJm_NfFbRfLg9Jp_id3_z74P5A-Rg0VPnHvvD-6NopJWTB=Q@mail.gmail.com>
Subject: Re: [RFC v0 05/15] network: Add network .connect and .disconnect
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Oct 19, 2012 at 11:39 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> +static void connect_profile_cb(struct btd_device *device, int err,
> +                                               const char *pdev, void *data)
> +{
> +       struct connect_req *req = data;
> +
> +       req->cb(req->profile, req->device, err);
> +
> +       g_free(req);
> +}
> +
> +static int connect_profile(struct btd_device *dev, struct btd_profile *profile,
> +                                               uint16_t id, btd_profile_cb cb)
> +{
> +       struct connect_req *req;
> +       int err;
> +
> +       DBG("path %s id %u", device_get_path(dev), id);
> +
> +       req  = g_new0(struct connect_req, 1);
> +       req->device = dev;

Isn't btd_device_ref() required here?

> +       req->profile = profile;
> +       req->cb = cb;
> +
> +       err = connection_connect(dev, BNEP_SVC_PANU, NULL, connect_profile_cb,
> +                                                                       req);
> +       if (err < 0) {
> +               g_free(req);
> +               return err;
> +       }
> +
> +       return 0;
> +}

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
