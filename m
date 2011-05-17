Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1305163474.15916.166.camel@aeonflux>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
	<1304701521-26459-4-git-send-email-andre.guedes@openbossa.org>
	<1305163474.15916.166.camel@aeonflux>
Date: Tue, 17 May 2011 11:39:11 -0300
Message-ID: <BANLkTim++9Q_93+=8TnjfurEZgi+=KbskA@mail.gmail.com>
Subject: Re: [PATCH 03/12] Bluetooth: Protect 'adv_entries' with a RW lock
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, May 11, 2011 at 10:24 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Andre,
>
>> This patch adds a RW lock to protect concurrent operations on
>> adv_entries list.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> =A0include/net/bluetooth/hci_core.h | =A0 =A01 +
>> =A0net/bluetooth/hci_core.c =A0 =A0 =A0 =A0 | =A0 21 +++++++++++++++++--=
--
>> =A02 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index 65135f8..2ceeadf 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -188,6 +188,7 @@ struct hci_dev {
>> =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0remote_oob_data;
>>
>> =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0adv_entries;
>> + =A0 =A0 rwlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0adv_entries_lock;
>
> we might wanna consider just using spinlocks and not rwlocks. Also can
> you please look into using RCU.
>
> Regards
>
> Marcel
>
>
>

Ok. I will use hci_dev_lock and friends to protect adv_entries.
This is the approach already used to protect uuids, link_keys,
remote_oob_data lists.

About RCU, I see the point in using it, but since reading operations
in adv_entries are not _extremely_ requested, IMO, we'll not have
much performance gain here. Anyway, the changes to use RCU
are straightforward. So, let me know if you wanna try RCU to
protect the advertising cache.

BR,

Andre Guedes.
