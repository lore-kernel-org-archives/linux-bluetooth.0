Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jan 2012 22:29:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/15] Bluetooth: Merge device class into the EIR data in
 mgmt_ev_device_found
Message-ID: <20120118202916.GA28661@fusion.localdomain>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
 <1326912717-6347-8-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_MfgdPvF00C2M=huzPk3TpZu5JivN2WdAK0-=BBJhyYsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAJdJm_MfgdPvF00C2M=huzPk3TpZu5JivN2WdAK0-=BBJhyYsA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Jan 18, 2012, Anderson Lizardo wrote:
> Hi Johan,
> 
> On Wed, Jan 18, 2012 at 2:51 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > +static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
> > +                                                               u16 data_len)
> > +{
> > +       eir[eir_len++] = sizeof(type) + data_len;
> 
> Isn't it better to have data_len as u8? It is impossible for a EIR or
> AD entry to have more than 255 octets (given the length field is one
> octet).

Since we've taken up the habit of appending items to the data (such as
the device class) before passing it on to user space we thought it'd be
more future proof to use two octets. The mgmt messages use two octets as
well. I was also initially of the opinion that one should be enough but
Marcel convinced me that two is better since we're living very close to
the limit and would have to break the API if at any point in the future
we suddenly need more space.

Johan
