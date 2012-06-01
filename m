Return-Path: <cyrus@holtmann.org>
From: Joohi RASTOGI <joohi.rastogi@stericsson.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>
Date: Fri, 1 Jun 2012 08:01:43 +0200
Subject: RE: [PATCH] Sets the information attribute for the service
Message-ID: <3176460F0F455A44B2E93431E34FC86C2225BD8DFF@EXDCVYMBSTM005.EQ1STM.local>
References: <1338273973-28767-1-git-send-email-joohi.rastogi@stericsson.com>
 <20120530074813.GG6539@x220>
In-Reply-To: <20120530074813.GG6539@x220>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Sent: Wednesday, May 30, 2012 1:18 PM
> To: Joohi RASTOGI
> Cc: User Name
> Subject: Re: [PATCH] Sets the information attribute for the service
> 
> Hi Joohi,
> 
> On Tue, May 29, 2012, joohi.rastogi@stericsson.com wrote:
> > From: Joohi Rastogi <joohi.rastogi@stericsson.com>
> >
> > This patch adds the service name for
> > Device Identification Profile
> > ---
> >  src/sdpd-service.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/src/sdpd-service.c b/src/sdpd-service.c
> > index 39e05ab..1fa82a6 100644
> > --- a/src/sdpd-service.c
> > +++ b/src/sdpd-service.c
> > @@ -228,6 +228,8 @@ void register_device_id(void)
> >  	source_data = sdp_data_alloc(SDP_UINT16, &main_opts.did_source);
> >  	sdp_attr_add(record, 0x0205, source_data);
> >
> > +	sdp_set_info_attr(record, "Device Identification", 0, 0);
> > +
> >  	update_db_timestamp();
> 
> 0 is an integer, NULL is a pointer. The function call you're adding
> doesn't take any integer arguments so you should be passing NULL and not
> 0.
> 
I will do the required change and re-push the patch.

> That said, I can't find any mention of the service name attribute in the
> Device ID specification (version 1.3). In fact the table (8.1 on page
> 17) that lists all mandatory and optional attributes doesn't even have
> this attribute mentioned as an optional one. So why do you need to have
> it added? Is there some client that breaks if it's not present?
> 
I added the "Service Name" because while doing sdptool browse, every profile displays its Service Name along with other attributes like Service Class ID List, Protocol Descriptor List and Service RecHandle. But, Device ID Profile does not display its Service Name. So, I had added the Service Name attribute as well to the profile.
For example: For AVRCP TG the sdptool browse response is:
Service Name: AVRCP TG
Service RecHandle: 0x10005
Service Class ID List:
  "AV Remote Target" (0x110c)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x103
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0103

And for Device ID Profile sdptool browse response is:
Service RecHandle: 0x10000
Service Class ID List:
  "PnP Information" (0x1200)
Profile Descriptor List:
  "PnP Information" (0x1200)
    Version: 0x0103

Please let me know your view on this.


> Johan

Thanks,
Joohi Rastogi
