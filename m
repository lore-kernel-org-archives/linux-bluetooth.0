Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00E2E3397
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137301; cv=pass; b=TVS1JsIQWxmCCXnosjZd2eOJdjMLkhz52LvnmvqeSeDYahveW49ZvjaYo8xni4kDYKCYa7ijWuJMU0UMulu1h0zFJpY0aTLQOMQCEwDp8XcPNw9RQ84X3LeP6urX01yBNAbhS6XXGNoCIJ2Y8pTx0j4lGEnxhRYvrxxDL242y4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137301; c=relaxed/simple;
	bh=+r3mBlkm7KmdDl3/wsAcVETzI2CR+ddA/nr0lf3syZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+5UCq1xQ5ROKcTpyzvVEPMUrTBI9aRP0xzNTfNRlOFODOOkASrLA3CUmqqFLU8jaiavVipel7SeP0vFiGt8RlO147aSzOVanob6p1YveyDyHBAhZn/gDjhSov/6JYJqqArE4dHdsuEiIqUk1awRE1ZrivCj87xMczwYlYHKs44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0NDzDxW; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0NDzDxW"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c21049dafso2459229d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 13:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779137298; cv=none;
        d=google.com; s=arc-20240605;
        b=BD+BhY0/C5aJ7wZ7m5HktVizhjpmiwwf+Ej6XQEb8O3kfMYGiorBudmlOV+uDTf38m
         lVGrFFCHJs82oDqO7xQvjAjxisHi6hRFTC/CIKDv1L2lqe31ztS6Q1/MqJVSt3hJS5D8
         WDmmwTEYX350vcV+cu7CvVBgXAPjq+argdwc8kzlkRn0++eW10nGnTnicJ2iqlZaOUt4
         3KTNREe083w+ra4hyF8o6NwLrNAP55Iai+uLcPeBXGqFgEnC4WUToIRriDZ7ibc6ZCQ0
         N6sBo9pWrNGOR7m+3Mu/wGnIr9IjR0QfKHHjEMMf4aPnuVsQ7tkWG35guocc5tnIRf02
         z7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MMgd4sohhog0ZGn5ZmCI1HIVzSl8Alx9SMp3XGD3tbU=;
        fh=3uQagIskG76CGRkQp5Nqnbl5CzbZ5stLQS1Xll5GfRQ=;
        b=PJY5Zf1U0VSeR1EqJxsMwUxCe9cxV8r7LVvX3AM+JOv/0eX2TNH/QgIBBBWtHtm3bd
         YCHUSqfsI1k2fH/EeECLxWY1gXgXN0Mb73fiy9C71/SLs5BVJ2seVJ78x5ZJMfjqiNsU
         WLWHkMFphv8Wo35A3UnEYO5EZnzSEERD+2IJPQXBYaHUKprjRISlokqAtIxLiljifKUp
         xI+YackxsvWR7cZ2fgz9sytY0WMXQGrhvfWaHw7nhlrYr6GbBhlQvRYX8ZJ+z/wlbtxc
         ROEuPNx+e7CRKIzbZhgJIxUakoBxTPT6UDW+nObgNOcxF826HUBSomNLIf+PYNXw98zA
         9yOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779137298; x=1779742098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMgd4sohhog0ZGn5ZmCI1HIVzSl8Alx9SMp3XGD3tbU=;
        b=A0NDzDxWwJ1fH/e2omudFmmdinnTBXokC7UNQafA6bfK45eFaPjou/9Q9HIj0xlphN
         V5b7pM65sYhO6fM1b7steSr6hdKXjZUGmuoKK0xSmreCksgPdCdQ11ekw6MblTf2Pcb6
         3N2sfUMKuebIwF0amlwxvqsFBfhGkk7U82N89t5Lm9/VzAUFc6TiVyYsy4pGlG4t0END
         4xyAW68ImDVWYwmNKEQ12uwno6SLlopLZDp3RLDR6ZYhhUfjqfcwqH4PmHSOVCz1/MEf
         y/UaKHChYdpAL8igzeYgvJ6T0aSDWjV+GYS3M9i6hprV7wGRlGgqP8IyxcsWw+WJBxVk
         rUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779137298; x=1779742098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MMgd4sohhog0ZGn5ZmCI1HIVzSl8Alx9SMp3XGD3tbU=;
        b=IEnb2mf5p66dYx5/nCCZUCtCtkr5olFHpPCKMARQESu9Go+1CZXFb9ReuMYOfa4Qeq
         LfbTqzfMnEZvQH9gcC5N9cD2FaNvaBDm4LOrTwUQxRJsSg72R7lcIrApwMCvb4Mf2ozv
         ZQPWEWyWaNcRhozt00wNp9/jUuPErrr7sKEqNvw3uUwYM7bvvNnWR/7YVtGZvA4moRgq
         taR32yvee/PWLS6C1ObPdIg9DlDnOkXm9wL0RWfLREUhYl/WzPlen136YEbxkSOs9+Ie
         x8geMzwytkFQVgJ5ThsOMzfVjQqjdUwWXHtGMPi0AQNPhjvI+xN74h22nZcHFl10lcpx
         KtBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mOXVCHP/pJ/ru7IpnNOlTfT48R5I2jzBUuwLIytxcwdRXmsQ7GWPgfCvvo1noyof6WrB9GCU8LuYXygQAGeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHp3oe+lwTRj7JGpqZp9YPvcyN6o3n0RMDmK0pAJtiX4Vb/QA9
	yO313atcGE+HqcEyifEiIsanV5ccIBiiWwO3+h7yGdZ6sASqwFlMYD9vY1CRFteEAbufFoDg2Nf
	ujKyCJS116LN4L7ru+ss2mSgz5qNM7gU=
X-Gm-Gg: Acq92OHgLfr0lsaCn/QiBvhcR5gxZJhVPRKmdjQ3IQ9EVMg20gCyRtJNTfGa+Br7pVK
	6jOrbfph5Muw9aJdeyuLND4VGmWLJoVMnc1U2aK0E7htb5ewA5ZbhAdhoW06lkaOJLFcUssNAB9
	+CEAVQVM2h6BJUT/YQdHorWqjCKcgPgoIGTvw8vTDLysYWJDfNBjrn9GbdaTdtOSmbOtJDgH7fX
	gdE/3PuGEEYz7eLiCd1slMi8Ci41bRIkoM81Nwh/qDqklZBwnQfCKQwugoV6ahqsumBIBsuhjSM
	xI+S51ksWf4wHRXF8A3ZxE3K5vWnka46bSHJW3RSqwN2TNKpcrNttpZ2RoPb7fm5StA=
X-Received: by 2002:a05:690e:1402:b0:65d:6f10:d42a with SMTP id
 956f58d0204a3-65e227cfff6mr16939749d50.39.1779137298499; Mon, 18 May 2026
 13:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-hci_send-v1-1-ae3eef758280@igalia.com>
 <20260514020446.639-1-hdanton@sina.com> <DIIHHUJM2CZJ.2OKA9PGHEHBRP@igalia.com>
 <CABBYNZKA3FsovfdWEeZYqFjjNCabjfa7uM48mq+r3G0PTb_JUg@mail.gmail.com> <DILWLB58NRY9.1AS5Z2W6EHAIG@igalia.com>
In-Reply-To: <DILWLB58NRY9.1AS5Z2W6EHAIG@igalia.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 May 2026 16:48:07 -0400
X-Gm-Features: AVHnY4JBqPVgcJdcjClA34G7Qa7ysrOjSS9sOqddoZvbb5CvwyV01id9DDcIGc4
Message-ID: <CABBYNZJdJ9GSeHjadoFJS4XRep2gx5R3+272evFgSkFKukg_bg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: Don't queue tx_work while draining workqueue
To: Heitor Alves de Siqueira <halves@igalia.com>
Cc: Hillf Danton <hdanton@sina.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Gustavo Padovan <padovan@profusion.mobi>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	syzkaller-bugs@googlegroups.com, 
	syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heitor,

On Mon, May 18, 2026 at 11:21=E2=80=AFAM Heitor Alves de Siqueira
<halves@igalia.com> wrote:
>
> Hi Luiz,
>
> On Fri May 15, 2026 at 10:33 AM -03, Luiz Augusto von Dentz wrote:
> > Hi Heitor,
> >
> > On Thu, May 14, 2026 at 10:54=E2=80=AFAM Heitor Alves de Siqueira
> > <halves@igalia.com> wrote:
> >>
> >> On Wed May 13, 2026 at 11:04 PM -03, Hillf Danton wrote:
> >> > On Wed, 13 May 2026 15:55:23 -0300 Heitor Alves de Siqueira wrote:
> >> >> Syzbot reported a warning when L2CAP calls queue_work() on the hdev
> >> >> workqueue while it's being drained. This can happen during device r=
eset or
> >> >> close paths for hci_send_acl(), hci_send_sco() and hci_send_iso().
> >> >>
> >> >> The workqueue is drained in hci_dev_do_reset() and in hci_dev_close=
_sync():
> >> >>   - hci_dev_close_sync() clears the HCI_UP bit before draining
> >> >>   - hci_dev_do_reset() sets HCI_CMD_DRAIN_WORKQUEUE before draining
> >> >>
> >> >> Add these checks before queuing tx_work, and free the SKB if it's n=
ot
> >> >> queued for transmission.
> >> >>
> >> >> Fixes: 3eff45eaf817 ("Bluetooth: convert tx_task to workqueue")
> >> >> Reported-by: syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com
> >> >> Closes: https://syzkaller.appspot.com/bug?extid=3D97721dd81f792e838=
ba0
> >> >> Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
> >> >> ---
> >> >>  net/bluetooth/hci_core.c | 18 ++++++++++++++++++
> >> >>  1 file changed, 18 insertions(+)
> >> >>
> >> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> >> index c46c1236ebfa..5d5f8ad7d1a8 100644
> >> >> --- a/net/bluetooth/hci_core.c
> >> >> +++ b/net/bluetooth/hci_core.c
> >> >> @@ -3278,6 +3278,12 @@ void hci_send_acl(struct hci_chan *chan, str=
uct sk_buff *skb, __u16 flags)
> >> >>
> >> >>      BT_DBG("%s chan %p flags 0x%4.4x", hdev->name, chan, flags);
> >> >>
> >> >> +    if (!test_bit(HCI_UP, &hdev->flags) ||
> >> >> +        hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
> >> >> +            kfree_skb(skb);
> >> >> +            return;
> >> >> +    }
> >> >> +
> >> >>      hci_queue_acl(chan, &chan->data_q, skb, flags);
> >> >>
> >> >>      queue_work(hdev->workqueue, &hdev->tx_work);
> >> >>
> >> > What you add is not enough, go and see how HCI_CMD_DRAIN_WORKQUEUE i=
s
> >> > checked in hci_cmd_work(), and in hci_dev_do_reset() for why.
> >>
> >> I see, I missed the RCU guards for the device flags. Sorry about that,
> >> I'll add them to v2.
> >> Thanks for the catch!
> >
> > Actually this whole thing might be because we try to clean the
> > workqueue without actually closing the hdev, so I suspect that if we
> > just remove all the code from hci_dev_do_reset with
> > hci_dev_do_close+hci_dev_do_open, it might work better and align with
> > how things work over the MGMT interface:
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index c46c1236ebfa..6782bbc9b6a7 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -539,47 +539,13 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
> >
> >         hci_req_sync_lock(hdev);
> >
> > -       /* Drop queues */
> > -       skb_queue_purge(&hdev->rx_q);
> > -       skb_queue_purge(&hdev->cmd_q);
> > -
> > -       /* Cancel these to avoid queueing non-chained pending work */
> > -       hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
> > -       /* Wait for
> > -        *
> > -        *    if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
> > -        *        queue_delayed_work(&hdev->{cmd,ncmd}_timer)
> > -        *
> > -        * inside RCU section to see the flag or complete scheduling.
> > -        */
> > -       synchronize_rcu();
> > -       /* Explicitly cancel works in case scheduled after setting the =
flag. */
> > -       cancel_delayed_work(&hdev->cmd_timer);
> > -       cancel_delayed_work(&hdev->ncmd_timer);
> > -
> > -       /* Avoid potential lockdep warnings from the *_flush() calls by
> > -        * ensuring the workqueue is empty up front.
> > -        */
> > -       drain_workqueue(hdev->workqueue);
> > -
> > -       hci_dev_lock(hdev);
> > -       hci_inquiry_cache_flush(hdev);
> > -       hci_conn_hash_flush(hdev);
> > -       hci_dev_unlock(hdev);
> > -
> > -       if (hdev->flush)
> > -               hdev->flush(hdev);
> > -
> > -       hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
> > -
> > -       atomic_set(&hdev->cmd_cnt, 1);
> > -       hdev->acl_cnt =3D 0;
> > -       hdev->sco_cnt =3D 0;
> > -       hdev->le_cnt =3D 0;
> > -       hdev->iso_cnt =3D 0;
> > +       ret =3D hci_dev_close_sync(hdev);
> > +       if (ret)
> > +               goto done;
> >
> > -       ret =3D hci_reset_sync(hdev);
> > +       ret =3D hci_dev_open_sync(hdev);
> >
> > +done:
> >         hci_req_sync_unlock(hdev);
> >         return ret;
> >  }
> >
> > Seem to work here and as a side effect we get notified over the MGMT
> > when a user uses hciconfig hci0 reset:
> >
> > # tools/hciconfig hci0 reset
> > bluetoothd[34]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x0006
> > bluetoothd[34]: src/adapter.c:new_settings_callback() Settings: 0x01fc0=
ac0
> > bluetoothd[34]: src/adapter.c:settings_changed() Changed settings: 0x00=
000001
> > bluetoothd[34]: src/adapter.c:settings_changed() Pending settings: 0x00=
000000
> > bluetoothd[34]: src/adapter.c:cancel_passive_scanning()
> > bluetoothd[34]: src/adapter.c:adapter_stop() adapter /org/bluez/hci0
> > has been disabled
> > bluetoothd[34]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x0008
> > bluetoothd[34]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x0006
> > bluetoothd[34]: src/adapter.c:new_settings_callback() Settings: 0x01fc0=
ac1
> > bluetoothd[34]: src/adapter.c:settings_changed() Changed settings: 0x00=
000001
> > bluetoothd[34]: src/adapter.c:settings_changed() Pending settings: 0x00=
000000
> > bluetoothd[34]: src/adapter.c:adapter_start() adapter /org/bluez/hci0
> > has been enabled
> > bluetoothd[34]: src/adapter.c:trigger_passive_scanning()
> > bluetoothd[34]: [signal] org.freedesktop.DBus.Properties.PropertiesChan=
ged
>
> Thank you for the review, and for the suggestion! There seems to be a
> number of similar syzbot reports for the hdev workqueue, so maybe the
> close+open approach is a simpler solution indeed. I've originally
> considered implementing a wrapper/helper for workqueue submission in
> hci_core.c, but if we can eliminate the race condition altogether that'd
> be even better.
>
> My only concern is that there seem to be slight differences between
> what hci_dev_do_reset() does now and what we'd get with
> hci_dev_close_sync()+hci_dev_open_sync() (e.g. we wouldn't use
> HCI_CMD_DRAIN_WORKQUEUE anymore). Would this alternative approach be
> suitable for the stable kernels? And if not, do you think the checks
> from v1 would be appropriate, in that case?

I think, the HCI_Reset is a heavy hammer because it's a global reset.
Getting all the pieces to cooperate has been causing all sort of
issues, and in any case I think what hci_dev_do_reset does is simply
wrong or outdated; for instance it doesn't seem to affect LE, such as
cancelling scanning or advertising. This is likely because interfaces
like MGMT don't use it and require a power cycle to reset.

--=20
Luiz Augusto von Dentz
