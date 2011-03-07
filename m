Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv2 2/5] Initial Client Characteristic Configuration
 implementation
From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20110223032608.GE16014@jh-x301>
References: <1298323843-31106-1-git-send-email-anderson.lizardo@openbossa.org>
	 <1298408491-11154-2-git-send-email-anderson.lizardo@openbossa.org>
	 <20110223032608.GE16014@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Mar 2011 21:52:24 +0100
Message-ID: <1299531144.2688.9.camel@donpedro>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, 2011-02-23 at 00:26 -0300, Johan Hedberg wrote:
> On Tue, Feb 22, 2011, Anderson Lizardo wrote:
> > +static uint8_t client_set_notifications(struct attribute *attr,
> > +                                                     gpointer
> user_data)
> > +{
> > +     struct gatt_channel *channel = user_data;
> > +     struct attribute *a, *last_chr_val = NULL;
> > +     uint16_t handle, cfg_val;
> > +     uuid_t uuid;
> > +     GSList *l;
> > +
> > +     cfg_val = att_get_u16(attr->data);
> > +
> > +     sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
> > +     for (l = database, handle = 0; l != NULL; l = l->next) {
> > +             a = l->data;
> 
> The variable "a" is only used inside the for-loop so it should be
> declared inside it as well. I think you can move handle inside the
> loop
> as well as long as you declare it static (so it only gets initialized
> to
> 0 on the first iteration). 

Would that not be a waste? Declaring it static would place it in
global-space. IMHO local variables must never be static, unless there
really is a need for it. For embedded devices with less memory, to many
of such constructs would be considered a problem. 

Putting it inside or outside the loops makes no difference with most
compilers as the optimizer will figure it out anyway (to the code, not
the style), but putting static in front will change the output and will
lower the global memory available. And since the number of used
instructions most likely will be the same, putting static in front will
at best be a waste.

Thanks,

/pedro
