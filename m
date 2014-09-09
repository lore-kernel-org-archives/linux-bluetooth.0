Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Johan Hedberg' <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1408619604-26201-1-git-send-email-bharat.panda@samsung.com>
 <20140905084453.GA9598@t440s>
In-reply-to: <20140905084453.GA9598@t440s>
Subject: RE: [PATCH ] GATT: Add support for Gatt multiple char write request
Date: Tue, 09 Sep 2014 14:24:44 +0530
Message-id: <021801cfcc0b$bdf350a0$39d9f1e0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> On Thu, Aug 21, 2014, Bharat Panda wrote:
> > Changes made to handle gatt char multiple write request 1. Changes
> > made to handle gatt long char write request 2. Cache/prepare and
> > execute long char write request.
> > 3. Updates gatt attribute db using offset value.
> > 4. Proper offset and char length handling to fix below PTS test cases,
> >
> > TP/GAW/SR/BV-06-C
> > TP/GAW/SR/BV-10-C
> > TP/GAW/SR/BV-09-C
> > TP/GAW/SR/BI-09-C
> > TP/GAW/SR/BI-14-C
> > TP/GAW/SR/BI-15-C
> > TP/GAW/SR/BV-05-C
> > TP/GAW/SR/BI-07-C
> > TP/GAW/SR/BV-07-C
> > TP/GAW/SR/BI-08-C
> > TP/GAW/SR/BI-25-C
> > TP/GAW/SR/BI-26-C
> > TP/GAW/SR/BI-27-C
> > ---
> >  src/attrib-server.c | 323
> +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  src/attrib-server.h |   3 +
> >  2 files changed, 324 insertions(+), 2 deletions(-)
> 
> First of all sorry for the delay in replying to this - you sent it just
when I had
> started a two week vacation.
> 
> > diff --git a/src/attrib-server.c b/src/attrib-server.c index
> > e65fff2..10a7923 100644
> > --- a/src/attrib-server.c
> > +++ b/src/attrib-server.c
> > @@ -85,6 +85,25 @@ struct group_elem {
> >  	uint16_t len;
> >  };
> >
> > +struct local_db {
> > +	uint16_t handle;
> > +	uint8_t offset;
> > +	size_t len;
> > +	uint8_t *data;
> > +	struct local_db *next;
> > +};
> > +
> > +struct char_handle_len {
> > +	uint16_t handle;
> > +	size_t org_len;
> > +	struct char_handle_len *next;
> > +};
> > +
> > +struct char_handle_len *local_char_handle_len = NULL; struct
> > +char_handle_len *local_char_handle_len_head = NULL; struct local_db
> > +*local_prep_db = NULL; struct local_db *local_prep_db_head = NULL;
> 
> Shouldn't these variables be part of gatt_channel instead of them being
> global like this? Otherwise we may have conflicts between multiple
> connections to different devices.

Yes, True, it should be part of gatt_channel, as this is tested with single
connection, I couldn't identify this issue.
Thanks
> 
> Btw, what are your plans regarding our new ATT/GATT APIs in src/shared?
> Are you planning to provide patches to update these features to use the
> new API once we have the rest of the ATT server infrastructure in place?
> I'd like to avoid introducing too much new code for the old API since it
will
> eventually need to be converted to the new one.
Yes we are in plan to use the New ATT/GATT APIs and provide patches for the
same, but as the complete infrastructure 
Is not in place now, we can put TODO comments to add these specific changes
after rest of the ATT server part is completed. If you suggest so. 
> 
> In general, could you please read through the kernel CodingStyle document
> which is what we mostly follow. There are quite many violations in this
patch.
> You'll also want to read the coding-style.txt and HACKING documents from
> Luiz that were just recently pushed to upstream bluez.git.

Ok, I will go through recent patches from Luiz. I will submit a new patch
with the fixes for coding style violations, If you agree on submitting this
patch with the above TODO comments.

Thanks
Best Regards,
Bharat

