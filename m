Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jan 2012 22:58:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/15] Bluetooth: Merge device class into the EIR data in
 mgmt_ev_device_found
Message-ID: <20120118205847.GA29068@fusion.localdomain>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
 <1326912717-6347-8-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_MfgdPvF00C2M=huzPk3TpZu5JivN2WdAK0-=BBJhyYsA@mail.gmail.com>
 <20120118202916.GA28661@fusion.localdomain>
 <CAJdJm_P5Q6sEk_f93YyxPv8UoHX1m3L5MWaP6upyKzFvsUR40w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAJdJm_P5Q6sEk_f93YyxPv8UoHX1m3L5MWaP6upyKzFvsUR40w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Jan 18, 2012, Anderson Lizardo wrote:
> >> On Wed, Jan 18, 2012 at 2:51 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> >> > +static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
> >> > +                                                               u16 data_len)
> >> > +{
> >> > +       eir[eir_len++] = sizeof(type) + data_len;
> >>
> >> Isn't it better to have data_len as u8? It is impossible for a EIR or
> >> AD entry to have more than 255 octets (given the length field is one
> >> octet).
> >
> > Since we've taken up the habit of appending items to the data (such as
> > the device class) before passing it on to user space we thought it'd be
> > more future proof to use two octets. The mgmt messages use two octets as
> > well. I was also initially of the opinion that one should be enough but
> > Marcel convinced me that two is better since we're living very close to
> > the limit and would have to break the API if at any point in the future
> > we suddenly need more space.
> 
> While for mgmt it is ok to use two octets (I was aware of this
> rationale), I was referring more specifically to the snippet above,
> where you copy a u16 value to a u8 eir[] entry.
> 
> While you can append many EIR fields (and thus have a local EIR blob
> with total size greater than you would normally send over the air),
> each EIR field you append is still limited to 255 bytes as per spec.
> This means it is okay on the function above to "eir_len" be u16, but I
> think "data_len" is not.

Yes, you're completely right (and I should have paid more attention to
what exactly you were referring to). I'll fix it.

Johan
