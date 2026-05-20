Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E813EAC74;
	Wed, 20 May 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287213; cv=none; b=C7NGcRpGjM5EYwJxKnWDUDYDrgfodgXHa3JyKRsp8vNFEiyZSZTWRHGFxbjXNzTiIkd5QBjGIs1vThh+mJugKk7yFcrVOyJLLiyn0fzTMIPBQn2JnLvGzHOxxLSZSsNvpYXz201QPYyAe8el6PAj0MHovjPB9nzfCEiQsEaKM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287213; c=relaxed/simple;
	bh=hAG0Mzd4kJoqrhuJ2dIFEzZBX14v1wi9p6wCLZZpY7c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qTY7zdWMIHZTMhe7tOL5g3Q8Nc+UUyiFXXetdwm2g0bnWZTqLwf2JbW0gzw4IQlzLWX/7Lo8fqaMuOhr0y+guUFZQrzPVOi5U7qdIdgG06RhGjqSFM8uMky+ETfFqUhQfyhPGS2ki2hnGup/24l0COFVYDOa7hUQyKy+0zAQyl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pQPsaYyi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pQPsaYyi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:References:Cc:To:From:Subject:Message-Id:Date:
	Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MGdUED0oXwzbLqsjyN9iLaoKzWmYn4RurXax3rscc9Y=; b=pQPsaYyiYdttsIORekPHK6YleJ
	TQqYq/Xq5fy1Wq6G96gYct3+Ij/2cRYpRppdf8d1XQrTOEELrXTXX1TDogB76W+MEJfXmJb/gNqCd
	RPkRQwXlT6eVZu1QzZAMU/0R8ma/aIzPEBkRSOZ5KCXG/CHTym7WTzqHkyUSfpPYYg7uXM0ezmS/L
	EaIqjOLanus/LvbRebDawnETutL8HJhWZa2EQQoL7PAcTigh/JApMDrRVdxDFbcXAzERJAuECSMPH
	EnJmHD7OOMArFNHSmrA/rgDJZlR/ZZEQPhgFVWWShd7Vmhg62o2tv/VULKQHyrl39DIWOxuaIDwU3
	ut6WLCdA==;
Received: from 177-136-90-227.vmaxnet.com.br ([177.136.90.227] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wPhsc-003ru0-Cx; Wed, 20 May 2026 16:26:38 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 11:26:32 -0300
Message-Id: <DINKO3RI4YEJ.21OFCL9QM6ZB8@igalia.com>
Subject: Re: [PATCH] Bluetooth: hci_core: Don't queue tx_work while draining
 workqueue
From: "Heitor Alves de Siqueira" <halves@igalia.com>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>, "Heitor Alves de
 Siqueira" <halves@igalia.com>
Cc: "Hillf Danton" <hdanton@sina.com>, "Marcel Holtmann"
 <marcel@holtmann.org>, "Gustavo Padovan" <padovan@profusion.mobi>,
 <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-dev@igalia.com>, <syzkaller-bugs@googlegroups.com>,
 <syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260513-hci_send-v1-1-ae3eef758280@igalia.com>
 <20260514020446.639-1-hdanton@sina.com>
 <DIIHHUJM2CZJ.2OKA9PGHEHBRP@igalia.com>
 <CABBYNZKA3FsovfdWEeZYqFjjNCabjfa7uM48mq+r3G0PTb_JUg@mail.gmail.com>
 <DILWLB58NRY9.1AS5Z2W6EHAIG@igalia.com>
 <CABBYNZJdJ9GSeHjadoFJS4XRep2gx5R3+272evFgSkFKukg_bg@mail.gmail.com>
In-Reply-To: <CABBYNZJdJ9GSeHjadoFJS4XRep2gx5R3+272evFgSkFKukg_bg@mail.gmail.com>

On Mon May 18, 2026 at 5:48 PM -03, Luiz Augusto von Dentz wrote:
> Hi Heitor,
>
> On Mon, May 18, 2026 at 11:21=E2=80=AFAM Heitor Alves de Siqueira
> <halves@igalia.com> wrote:
>>
>> Hi Luiz,
>>
>> On Fri May 15, 2026 at 10:33 AM -03, Luiz Augusto von Dentz wrote:
>> > Hi Heitor,
>> >
>> > On Thu, May 14, 2026 at 10:54=E2=80=AFAM Heitor Alves de Siqueira
>> > <halves@igalia.com> wrote:
>> >>
>> >> On Wed May 13, 2026 at 11:04 PM -03, Hillf Danton wrote:
>> >> > On Wed, 13 May 2026 15:55:23 -0300 Heitor Alves de Siqueira wrote:
>> >> >> Syzbot reported a warning when L2CAP calls queue_work() on the hde=
v
>> >> >> workqueue while it's being drained. This can happen during device =
reset or
>> >> >> close paths for hci_send_acl(), hci_send_sco() and hci_send_iso().
>> >> >>
>> >> >> The workqueue is drained in hci_dev_do_reset() and in hci_dev_clos=
e_sync():
>> >> >>   - hci_dev_close_sync() clears the HCI_UP bit before draining
>> >> >>   - hci_dev_do_reset() sets HCI_CMD_DRAIN_WORKQUEUE before drainin=
g
>> >> >>
>> >> >> Add these checks before queuing tx_work, and free the SKB if it's =
not
>> >> >> queued for transmission.
>> >> >>
>> >> >> Fixes: 3eff45eaf817 ("Bluetooth: convert tx_task to workqueue")
>> >> >> Reported-by: syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com
>> >> >> Closes: https://syzkaller.appspot.com/bug?extid=3D97721dd81f792e83=
8ba0
>> >> >> Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
>> >> >> ---
>> >> >>  net/bluetooth/hci_core.c | 18 ++++++++++++++++++
>> >> >>  1 file changed, 18 insertions(+)
>> >> >>
>> >> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> >> >> index c46c1236ebfa..5d5f8ad7d1a8 100644
>> >> >> --- a/net/bluetooth/hci_core.c
>> >> >> +++ b/net/bluetooth/hci_core.c
>> >> >> @@ -3278,6 +3278,12 @@ void hci_send_acl(struct hci_chan *chan, st=
ruct sk_buff *skb, __u16 flags)
>> >> >>
>> >> >>      BT_DBG("%s chan %p flags 0x%4.4x", hdev->name, chan, flags);
>> >> >>
>> >> >> +    if (!test_bit(HCI_UP, &hdev->flags) ||
>> >> >> +        hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
>> >> >> +            kfree_skb(skb);
>> >> >> +            return;
>> >> >> +    }
>> >> >> +
>> >> >>      hci_queue_acl(chan, &chan->data_q, skb, flags);
>> >> >>
>> >> >>      queue_work(hdev->workqueue, &hdev->tx_work);
>> >> >>
>> >> > What you add is not enough, go and see how HCI_CMD_DRAIN_WORKQUEUE =
is
>> >> > checked in hci_cmd_work(), and in hci_dev_do_reset() for why.
>> >>
>> >> I see, I missed the RCU guards for the device flags. Sorry about that=
,
>> >> I'll add them to v2.
>> >> Thanks for the catch!
>> >
>> > Actually this whole thing might be because we try to clean the
>> > workqueue without actually closing the hdev, so I suspect that if we
>> > just remove all the code from hci_dev_do_reset with
>> > hci_dev_do_close+hci_dev_do_open, it might work better and align with
>> > how things work over the MGMT interface:
>> >
>> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> > index c46c1236ebfa..6782bbc9b6a7 100644
>> > --- a/net/bluetooth/hci_core.c
>> > +++ b/net/bluetooth/hci_core.c
>> > @@ -539,47 +539,13 @@ static int hci_dev_do_reset(struct hci_dev *hdev=
)
>> >
>> >         hci_req_sync_lock(hdev);
>> >
>> > -       /* Drop queues */
>> > -       skb_queue_purge(&hdev->rx_q);
>> > -       skb_queue_purge(&hdev->cmd_q);
>> > -
>> > -       /* Cancel these to avoid queueing non-chained pending work */
>> > -       hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
>> > -       /* Wait for
>> > -        *
>> > -        *    if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
>> > -        *        queue_delayed_work(&hdev->{cmd,ncmd}_timer)
>> > -        *
>> > -        * inside RCU section to see the flag or complete scheduling.
>> > -        */
>> > -       synchronize_rcu();
>> > -       /* Explicitly cancel works in case scheduled after setting the=
 flag. */
>> > -       cancel_delayed_work(&hdev->cmd_timer);
>> > -       cancel_delayed_work(&hdev->ncmd_timer);
>> > -
>> > -       /* Avoid potential lockdep warnings from the *_flush() calls b=
y
>> > -        * ensuring the workqueue is empty up front.
>> > -        */
>> > -       drain_workqueue(hdev->workqueue);
>> > -
>> > -       hci_dev_lock(hdev);
>> > -       hci_inquiry_cache_flush(hdev);
>> > -       hci_conn_hash_flush(hdev);
>> > -       hci_dev_unlock(hdev);
>> > -
>> > -       if (hdev->flush)
>> > -               hdev->flush(hdev);
>> > -
>> > -       hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
>> > -
>> > -       atomic_set(&hdev->cmd_cnt, 1);
>> > -       hdev->acl_cnt =3D 0;
>> > -       hdev->sco_cnt =3D 0;
>> > -       hdev->le_cnt =3D 0;
>> > -       hdev->iso_cnt =3D 0;
>> > +       ret =3D hci_dev_close_sync(hdev);
>> > +       if (ret)
>> > +               goto done;
>> >
>> > -       ret =3D hci_reset_sync(hdev);
>> > +       ret =3D hci_dev_open_sync(hdev);
>> >
>> > +done:
>> >         hci_req_sync_unlock(hdev);
>> >         return ret;
>> >  }
>> >
>> > Seem to work here and as a side effect we get notified over the MGMT
>> > when a user uses hciconfig hci0 reset:
>> >
>> > # tools/hciconfig hci0 reset
>> > bluetoothd[34]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x000=
6
>> > bluetoothd[34]: src/adapter.c:new_settings_callback() Settings: 0x01fc=
0ac0
>> > bluetoothd[34]: src/adapter.c:settings_changed() Changed settings: 0x0=
0000001
>> > bluetoothd[34]: src/adapter.c:settings_changed() Pending settings: 0x0=
0000000
>> > bluetoothd[34]: src/adapter.c:cancel_passive_scanning()
>> > bluetoothd[34]: src/adapter.c:adapter_stop() adapter /org/bluez/hci0
>> > has been disabled
>> > bluetoothd[34]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x000=
8
>> > bluetoothd[34]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x000=
6
>> > bluetoothd[34]: src/adapter.c:new_settings_callback() Settings: 0x01fc=
0ac1
>> > bluetoothd[34]: src/adapter.c:settings_changed() Changed settings: 0x0=
0000001
>> > bluetoothd[34]: src/adapter.c:settings_changed() Pending settings: 0x0=
0000000
>> > bluetoothd[34]: src/adapter.c:adapter_start() adapter /org/bluez/hci0
>> > has been enabled
>> > bluetoothd[34]: src/adapter.c:trigger_passive_scanning()
>> > bluetoothd[34]: [signal] org.freedesktop.DBus.Properties.PropertiesCha=
nged
>>
>> Thank you for the review, and for the suggestion! There seems to be a
>> number of similar syzbot reports for the hdev workqueue, so maybe the
>> close+open approach is a simpler solution indeed. I've originally
>> considered implementing a wrapper/helper for workqueue submission in
>> hci_core.c, but if we can eliminate the race condition altogether that'd
>> be even better.
>>
>> My only concern is that there seem to be slight differences between
>> what hci_dev_do_reset() does now and what we'd get with
>> hci_dev_close_sync()+hci_dev_open_sync() (e.g. we wouldn't use
>> HCI_CMD_DRAIN_WORKQUEUE anymore). Would this alternative approach be
>> suitable for the stable kernels? And if not, do you think the checks
>> from v1 would be appropriate, in that case?
>
> I think, the HCI_Reset is a heavy hammer because it's a global reset.
> Getting all the pieces to cooperate has been causing all sort of
> issues, and in any case I think what hci_dev_do_reset does is simply
> wrong or outdated; for instance it doesn't seem to affect LE, such as
> cancelling scanning or advertising. This is likely because interfaces
> like MGMT don't use it and require a power cycle to reset.

ACK, that makes sense. Please disregard this patch, I'll send a
follow-up with the reset changes and any missing bits from the current
async reset path.

Thank you for the pointers, Luiz!
