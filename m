Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120814103043.GB8175@x220>
References: <CAJdJm_PyZa_0K-5nZOo_D796x5cwiZ6GKMb7-Jey48CYPys88Q@mail.gmail.com>
	<1344010717-4529-1-git-send-email-jprvita@openbossa.org>
	<20120814093605.GA5352@x220>
	<20120814103043.GB8175@x220>
Date: Tue, 14 Aug 2012 14:59:29 -0300
Message-ID: <CAAngNMYzQpAVQ7+QAM_8wfm+Ys6TgXJB3gfw_t0FDszjAKR=5w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] mgmt: Add LE scanning callback
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 14, 2012 at 7:30 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Aug 14, 2012, Johan Hedberg wrote:
>> On Fri, Aug 03, 2012, João Paulo Rechi Vita wrote:
>> > From: Claudio Takahasi <claudio.takahasi@openbossa.org>
>> >
>> > This patch adds a new callback to allow the adapter to control LE
>> > scanning. The current approach uses the active scanning with default
>> > windows and intervals defined by the core spec without any filtering.
>> > ---
>> >  src/mgmt.c | 32 ++++++++++++++++++++++++++++++++
>> >  src/mgmt.h |  1 +
>> >  2 files changed, 33 insertions(+)
>> >
>> > diff --git a/src/mgmt.c b/src/mgmt.c
>> > index 8ae86d3..5ceeaa8 100644
>> > --- a/src/mgmt.c
>> > +++ b/src/mgmt.c
>> > @@ -1999,6 +1999,38 @@ int mgmt_start_discovery(int index)
>> >     return 0;
>> >  }
>> >
>> > +int mgmt_start_scanning(int index)
>> > +{
>> > +   char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_start_discovery)];
>> > +   struct mgmt_hdr *hdr = (void *) buf;
>> > +   struct mgmt_cp_start_discovery *cp = (void *) &buf[sizeof(*hdr)];
>> > +   struct controller_info *info = &controllers[index];
>> > +
>> > +   DBG("index %d", index);
>> > +
>> > +   info->discov_type = 0;
>> > +
>> > +   if (mgmt_low_energy(info->current_settings)) {
>> > +           hci_set_bit(BDADDR_LE_PUBLIC, &info->discov_type);
>> > +           hci_set_bit(BDADDR_LE_RANDOM, &info->discov_type);
>> > +   }
>>
>> Shouldn't you just return an error here (e.g. -ENOTSUP) if LE is not
>> supported/enabled?
>>
>> Have there been any patches sent that would use this API? At least I
>> didn't see any after a quick scan of the mailing list.
>
> I see that these users are part of the original thread sent on Jul 27th.
> I got confused since you renamed the subjects in a way that there was no
> other indication to the original thread except the References: header.
>
> The point about returning an error still remains though.
>

Ok, as soon as Claudio fixes this I'll send an updated revision of the
whole series tagged with 'v2'.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
