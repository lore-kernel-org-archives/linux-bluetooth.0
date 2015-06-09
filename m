Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKdVpaZtrv6GDMrFzWNRrhkOT4z9nBVmmi68FzPo015dg@mail.gmail.com>
References: <CAD0=r8wfL1TYghMk2wHYrZFZ9D=sz49_1fNPVsPvgqOUVdbuCQ@mail.gmail.com>
	<CABBYNZ+JoqhDtH_ZN9bVafMnDYgyjsmwKnTssA8_QFJ1js9kQA@mail.gmail.com>
	<CAD0=r8wDGKw4DRnEAsZqNvMc05CGnjz7HVFc6MTQZi74L9xC1Q@mail.gmail.com>
	<20150531025505.GA23991@t440s>
	<CAD0=r8xVzep5nu5=J4Hz5FkpSTo03csYt2=wtXRF6vmydR6q1g@mail.gmail.com>
	<CABBYNZKmaE2VMNxa4oNcByGmjS2FcH3UXLD1N0m3rsUce6GOeA@mail.gmail.com>
	<CAHrH25TsFBte0TazmN6AeeWFQ2eQimVCsSDrV3JXGLNaJ3BYJA@mail.gmail.com>
	<CABBYNZKdVpaZtrv6GDMrFzWNRrhkOT4z9nBVmmi68FzPo015dg@mail.gmail.com>
Date: Tue, 9 Jun 2015 13:48:07 +0300
Message-ID: <CABBYNZL4=CgPcz4ePsFv=xUU4kknqt8BzpLChyxxOTCUki5Z7A@mail.gmail.com>
Subject: Re: [RFC] Add new method to DBus API: DiscoverServiceByUUID
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman, Jakub,

On Tue, Jun 2, 2015 at 5:51 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Tue, Jun 2, 2015 at 12:42 AM, Arman Uguray <armansito@chromium.org> wrote:
>>> Service changed, the lower is your requirement to reconnect the more
>>> it will be required, but you got to pair to make it persistent across
>>> reconnections but the first time you connect is always going to be
>>> time consuming since you got to discover so it does not matter much if
>>> the first time takes 9.7s to discover all services since the next time
>>> it would not spend any time doing it again, that is the only reason
>>> HoG can reconnect very fast.
>>>
>>> --
>>> Luiz Augusto von Dentz
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> I'm late to the discussion, but wasn't this kind of functionality the
>> whole point behind adding the org.bluez.GattProfile1 interface defined
>> in doc/gatt-api.txt? Can't we do this through that?
>
> Yes, that was my suggestion to give a list of UUID of interested so
> bt_gatt_client instance can skip discovery of characteristics and
> descriptor not in the list, but it is not so simple when this is
> dynamic as it is applications may come and go so we would have to
> cache not only the database but also what was discovered which
> complicate things.
>
> Btw, the spec says the following about the service changed:
>
> C1: Mandatory if service definitions on the server can be added,
> changed or removed;
> otherwise optional
>
> So the following code should be optimized to return without clearing
> the database if service changed is not supported.
>
> if (device->le_state.bonded)
>   return;
>
> gatt_db_clear(device->db);
> device->gatt_cache_used = false;
>
> Futhermore Im not sure we need to clear the database like that, we
> could check if the service range match that probably means the service
> has not changed since the last connection as is very unlikely that
> service characteristics and descriptors would change even if the
> service was removed and added again in the exact same place.

Any chance that you guys give some feedback to the patch-set Ive sent
yesterday? Im assuming it does take care of connecting to a single
UUID since in most cases only Read by Group Type is necessary.


-- 
Luiz Augusto von Dentz
