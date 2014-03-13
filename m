Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140313083055.GA8329@localhost.P-661HNU-F1>
References: <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
	<1394641631-1534-2-git-send-email-claudio.takahasi@openbossa.org>
	<20140313083055.GA8329@localhost.P-661HNU-F1>
Date: Thu, 13 Mar 2014 10:10:39 -0300
Message-ID: <CAKT1EBeFRxvsQqmj-xi9_VasG9aE=1QXy65Tvmu-7AanAXWPeg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 01/15] gatt: Add function to create constant attributes
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	Claudio Takahasi <CLAUDIO.TAKAHASI@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Mar 13, 2014 at 5:30 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Wed, Mar 12, 2014, Claudio Takahasi wrote:
>> +static inline void put_uuid(const bt_uuid_t *src, void *dst)
>> +{
>> +     if (src->type == BT_UUID16)
>> +             put_unaligned(cpu_to_le16(src->value.u16), (uint16_t *) dst);
>
> I thought you were going to add helpers like put_le16() to shared/util.h
> first?

My understanding of our discussion in the IRC was that put_uuid()
could be implemented inside src/gatt.c for now.
Anyway, I will send a new patchset moving put_uuid() and put_le16() to
src/shared/util.h

Regarding the remaining put_leX(), get_leX() (and related helpers) we
can start moving to src/shared/util.h after this patchset.

>
>> +static struct btd_attribute *new_const_attribute(const bt_uuid_t *type,
>> +                                                     const uint8_t *value,
>> +                                                     uint16_t len)
>> +{
>> +     struct btd_attribute *attr = malloc0(sizeof(struct btd_attribute) +
>> +                                                                     len);
>
> First of all I think it'd be better (coding style consistency-wise) to
> do the allocation separately from the declaration of the variable.
> Secondly, malloc0 can return NULL (unlike g_malloc0) so you'd need to
> check for that.

OK. I will fix it.

Claudio.
