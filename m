Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120118202916.GA28661@fusion.localdomain>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	<1326912717-6347-8-git-send-email-johan.hedberg@gmail.com>
	<CAJdJm_MfgdPvF00C2M=huzPk3TpZu5JivN2WdAK0-=BBJhyYsA@mail.gmail.com>
	<20120118202916.GA28661@fusion.localdomain>
Date: Wed, 18 Jan 2012 16:40:57 -0400
Message-ID: <CAJdJm_P5Q6sEk_f93YyxPv8UoHX1m3L5MWaP6upyKzFvsUR40w@mail.gmail.com>
Subject: Re: [PATCH 07/15] Bluetooth: Merge device class into the EIR data in mgmt_ev_device_found
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Jan 18, 2012 at 4:29 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Wed, Jan 18, 2012, Anderson Lizardo wrote:
>> Hi Johan,
>>
>> On Wed, Jan 18, 2012 at 2:51 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> > +static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
>> > +                                                               u16 data_len)
>> > +{
>> > +       eir[eir_len++] = sizeof(type) + data_len;
>>
>> Isn't it better to have data_len as u8? It is impossible for a EIR or
>> AD entry to have more than 255 octets (given the length field is one
>> octet).
>
> Since we've taken up the habit of appending items to the data (such as
> the device class) before passing it on to user space we thought it'd be
> more future proof to use two octets. The mgmt messages use two octets as
> well. I was also initially of the opinion that one should be enough but
> Marcel convinced me that two is better since we're living very close to
> the limit and would have to break the API if at any point in the future
> we suddenly need more space.

While for mgmt it is ok to use two octets (I was aware of this
rationale), I was referring more specifically to the snippet above,
where you copy a u16 value to a u8 eir[] entry.

While you can append many EIR fields (and thus have a local EIR blob
with total size greater than you would normally send over the air),
each EIR field you append is still limited to 255 bytes as per spec.
This means it is okay on the function above to "eir_len" be u16, but I
think "data_len" is not.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
