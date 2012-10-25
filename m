Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 20:38:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v0 05/15] network: Add network .connect and .disconnect
Message-ID: <20121025173801.GA9248@x220.P-661HNU-F1>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1350661172-18125-6-git-send-email-mikel.astiz.oss@gmail.com>
 <CAJdJm_NfFbRfLg9Jp_id3_z74P5A-Rg0VPnHvvD-6NopJWTB=Q@mail.gmail.com>
 <20121025104219.GB30500@x220>
 <CANT-zCUSkGJ1SWxUNU7J80WxRpotNbfEhmuQihoXj6WquaBePw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANT-zCUSkGJ1SWxUNU7J80WxRpotNbfEhmuQihoXj6WquaBePw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Oct 25, 2012, Mikel Astiz wrote:
> >> > +       req  = g_new0(struct connect_req, 1);
> >> > +       req->device = dev;
> >>
> >> Isn't btd_device_ref() required here?
> >
> > Looks like you're right and I missed this in my initial review. I went
> > ahead and pushed an extra patch to fix this.
> 
> I don't think this patch was needed. Actually, the device pointer in
> struct connect_req can be completely removed, since the callback
> already receives such pointer, and the network_peer takes care of the
> device refcounting. Mea culpa for adding this unnecessary field.

Good point. Feel free to send a patch to remove it.

Johan
