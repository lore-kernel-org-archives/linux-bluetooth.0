Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D5BFAB8.7030608@codeaurora.org>
References: <1297891081-27976-1-git-send-email-bgix@codeaurora.org>
	<1297891081-27976-3-git-send-email-bgix@codeaurora.org>
	<AANLkTikCnorqDid1cRYmCm=-Jq04K67wJOHpOdWE8Pn+@mail.gmail.com>
	<4D5BFAB8.7030608@codeaurora.org>
Date: Wed, 16 Feb 2011 14:00:15 -0300
Message-ID: <AANLkTimGOVmYopwC+dS95MHH+o_wknxdk62r2_zb1nqE@mail.gmail.com>
Subject: Re: [PATCH 2/3] Add SDP registration of Primary GATT services
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com,
	padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Wed, Feb 16, 2011 at 1:26 PM, Brian Gix <bgix@codeaurora.org> wrote:
> 1. We currently register everything into the attribute database a single
> attribute at a time.  The current attrib_db_add therefore has no inherent
> knowledge of entire "Service" objects, and lacks the start-end range that is
> required not only by the SDP record, but also the ATT driven GATT Service
> Discovery. Ideally I would like to see a "Register Service" API which
> internally would register all INCLUDES, CHARACTERISTICS, and SDP Records,
> but this would be a significant departure from the current code.

You are right. In fact, we have a proposal (currently not implemented)
to create a server side API for registering GATT services. Please see
my e-mail from 2010-12-30 entitled "[RFC] BlueZ server side API for
registering GATT services". I was actually expecting comments from you
:)

Suggestions/comments on the proposal are welcome. Please try to keep
discussion on this topic here on the list because there are other
people interested on contributing to the implementation as well.

ALso note the proposal is to create an API on top of the current one,
with minimal changes to allow both to be used in parallel (it may be
necessary in cases we want more control over the attributes).

> 2. A less significant change would be to create an sdp_record_from_attrib()
> API, but it would need to be called after all attributes for the service
> have been registered, because it needs to calculate the "end" handle of the
> service, much like the current GATT procedures to Discover and Find
> Services. This would probably constitute the "least change necessary" to the
> current paradigm.

This is my suggestion on this thread. After the attributes of a
specific service have been inserted into the database, you can know
the start-end attributes.

> 3. I'm not sure that the "struct attrib *a" would add anything here, except
> as a way to prevent having to explicitly specify the attribute handle value
> in the first place.  We should eventually get away from specifying explicit
> attribute handle values, because that makes it hard to have mix-and-match
> services.  A service app writer should not be expected to know the remaining
> 0-65535 "number space" that is available on every device that they want to
> target there service app to.  In that respect, having attrib_db_add assign
> an available handle, and return a "struct attrib *" pointer could then be
> used instead of a handle when registering the SDP of a completely registered
> primary service.

What I had in mind (still not discussed on the list), was to make the
"automatic handle allocation" feature together with the high-level
GATT Service oriented API. This would work by keeping track of
used/unused start-end ranges, and allocating ranges for services as
they are registered/unregistered. Example:

* "free range list" starts with: [0x1000, 0xFFFF]
* Register service A with 10 attributes: [0x1000, 0x1009] (free range:
[0x100A, 0xFFFF])
* Register service B with 5 attributes: [0x100A, 0x100E] (free range:
[0x100F, 0xFFFF])
* Register service C with 11 attributes: [0x100F, 0x1019] (free range:
[0x101A, 0xFFFF])
* Unregister service B (free ranges: [0x100A, 0x100E], [0x101A, 0xFFFF])
* Register service D with 4 attributes: [0x100A, 0x100D] (free ranges:
[0x100E, 0x100E], [0x101A, 0xFFFF])

> I propose that I change this patch set to follow plan "2" above.  If you
> want to subsequently change the return of attrib_db_add() as you have
> described, it should then be trivial to change the arguments to the new
> sdp_record_from_attrib() API to accept the attrib struct pointer rather than
> the explicit start handle.

Agreed. sdp_record_from_attrib() may receive just start/end handles if
other fields of struct attrubute are not necessary.

>>> @@ -609,7 +603,7 @@ static uint16_t write_value(struct gatt_channel
>>> *channel, uint16_t handle,
>>>  static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
>>>                uint8_t *pdu, int len)
>>>  {
>>> -       channel->mtu = MIN(mtu, ATT_MAX_MTU);
>>> +       channel->mtu = MIN(mtu, channel->mtu);
>>>
>>>        return enc_mtu_resp(channel->mtu, pdu, len);
>>>  }
>>
>> This change looks unrelated to the patch.

Any comments on this?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
