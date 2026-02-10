Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD322B5AC
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770703730; cv=pass; b=c0HuJfRLh51WMjBqfrGqMFs9fJIiM57cGbeKcruPNdtS1YuJA2OuzxS3SsNOaL/AMeM+mSCzuVPFJpyIA9+RVDtHInUPvW9G1QeoVVYsPRLJBs7FYJLb8WvqLgEdab4DNG/6Ra8emAoDiN3WrncIAXJBb1nG0gooL7cuhtgUbwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770703730; c=relaxed/simple;
	bh=dqE1EhK+JXE8ehEVX4gEh0+buta/lBl23EK3YHcx7xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEmtunmVkE6IJzpNvT0Ib0gHYXuLqTBO/iZrtW6h/TEDNdDU5QZsMYTYJHHxERrTo8q5QonDkh5mFmM9SXYZ6D7N1rSbi+lUUKCdDIBxFueF1xosvi7EoRS2JL0ll5nEqfWaROjG2RIkQAFMlN4Q2Rjyld8hA5S7oEPIGCw1TZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isiwpcig; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isiwpcig"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89473dca8aaso52585266d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 22:08:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770703728; cv=none;
        d=google.com; s=arc-20240605;
        b=ajXDzcNlWYR9AT2bnA0bzyYG2ZwBFBNKGO2Ehsf6COtLvTftP1uklmXUwAScI5m8so
         U42xMDohwuPt/yepEwnl85AfPGGqn2h0ZvKxb/c+y2lnLaJjp04GBu/PPfshk+MnxVg0
         bQz3Dgl8H9L9Gng0yv8hd/P9TNEoPjXmuVm1olqsgaelt6J/rns6KTkROMUQmJ1psKZG
         sBeLRr94socHbofNW5kh9g202lOsV+PgpjXxLoUP3UBVE84RFVjQxoh7bQfSWmgkc2qf
         QHnUqvItL50yLQa8CEzw81NW0uX33+CO6vNjeu0PT+QT532wXP8Nn8L84VpANpQ49J/q
         lNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q0mCI/yjFUhthC1HfRpNppGuI6gqM+bzKO/g7Mkc0dU=;
        fh=yVcsFQ3kaaWZkm8DzYzKxKHrEm/DIS8TJDAKTEleFDM=;
        b=iOnmLhk8y84wfp5yXnBDBSViIhJvnopy41F/S+GKWu7d/S/b85uxEjS51H12mXreE2
         PrBnJvmYMHKnYtc1KZECrxGyJmP8jGD6yudgmFdECvvAP5gaE+qcXXnszACLUASf5vY+
         ByUlWsagQcvt1SiuZj97HIT98DqtDznHJbL1/ATr2gj+RoqG9mijQyXEjGTJ8TZ1KI9b
         P/aqgol95gO5wJhD/hWVO7ah3JJ8NzcRJrtkLvqZ6rI3mX63Dnhqi21YEa7lX7Ol3flI
         91QYEMoV1VNr6TM7/2noJh182RIx6pSzBSaLcp6ctbuBnSqqw99Ejd2UvYn5ynWJRKaK
         d55Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770703728; x=1771308528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0mCI/yjFUhthC1HfRpNppGuI6gqM+bzKO/g7Mkc0dU=;
        b=isiwpcigJJdB3ghyX0uvCbN7klE1YJvvMLA4xC2QRkpYifAa7AGI1QhATod/fg4LKO
         BQsrXaxxDCYTZ4RxGs0NhIZKoFdzW550PO1h3QF4keLCw/Iwm98KZ1ktyYbaaRIa/oxC
         LMl+N+0gYVpd/Bqa2y1iZjZ+4bwxJQ3KP1yClc93siz5l666r+hr+b/9T6NzSXVgfXqR
         br3aP7pbEf0K/mYZU6ogrCoha+8MieJrxVtbqJJztXw+fcGklXhqZ70t+eOHrqHjivNc
         O0u8BBUjNKyE89hNyM6zHGHpPjeu1HrncinT4YF+n/W1qjmPFgUIY8NDBNo/9/dlL4NO
         F3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770703728; x=1771308528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q0mCI/yjFUhthC1HfRpNppGuI6gqM+bzKO/g7Mkc0dU=;
        b=HuV8RI/vMUWQQSLgkuW/Rhq94Cwy2U6TCv8ZU96LMiCrlS0jmbM6xtrvngMzkVYp9K
         y2fQY2criH1V+7ORQkE5io5GI2SBd6NGN5sk7EPOFx8tTdpRPIc5w5r/iGvct2bJHSOo
         mAnfD4oN6DR33wEMts0Klif2/tvGJOrH/08ftzAYc7E29ZdY1QiNJuP++T3HX+gCT4F0
         H1rcR24ZQxxTXIir0pBJWbfJpQSoOggvDDEslZ7pYJE0wAdZxPNFsc2Tv9BqTEJnn8vP
         jDj5PQAK82wia/ZmQeZ7yVrL1ktRxj3prs72S670xOHqbKeUliTD0EpOCsU1aRlG0tQM
         3JOw==
X-Gm-Message-State: AOJu0YxAsqtzfzWhrTVScqNaDvaCe3n6Qsbb8zQT9lZDvVUn/ldVIjYd
	V5LPsdRw5FD57h0l5vaa6+w15IP0HZ2ScaP9K8wZE+jjYodgFZ9ZFLoCbPCZprQslr1eBscHDIJ
	PDWC6L0cfaAHYAjncZafpjSUiYuLulho=
X-Gm-Gg: AZuq6aIQA5Chbqg0AXHAv9WXjhmaiRax+H9+Rw53jDlyyf7A1oHjYcR0RMvwdKaN0cq
	gpei4O8C0eukhmQ6I+RMx1OHp4F2dlPDJMQ8ImiQvrgGEjP6iaIccSU9eEagvM62Kuf8iHrPdfT
	Kt8VwLw2M4ihFYAGJuLdiGsJnqbITP0VPMG0nJp5WEEphE4OGDxKt99+wIUk4X2ip/l7XScrPxi
	XM70LZRzgi0nVFKOLDRYh2opNj9WtqlcDqunhVGUYwEkWBn+YGIZYQjIOOzR5X9fWVZ9AHMf8ZR
	zRYIX+YgwOuMmGmhzHnYkomJGfLRizV7j/m8vw==
X-Received: by 2002:ad4:5ae7:0:b0:88a:2ebd:1e39 with SMTP id
 6a1803df08f44-8953ca7b3c0mr225642256d6.38.1770703728358; Mon, 09 Feb 2026
 22:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209100211.36533-1-youjingxiaogao2@gmail.com> <20260209132535.2716-1-hdanton@sina.com>
In-Reply-To: <20260209132535.2716-1-hdanton@sina.com>
From: kawada <youjingxiaogao2@gmail.com>
Date: Tue, 10 Feb 2026 15:08:12 +0900
X-Gm-Features: AZwV_QiDMqPCr2uyz3rDvg7ktNXMQ1Lii9KomAJxItlG0uX6tD25PzEJxdbewRc
Message-ID: <CAKZCeSVJQAsYVSDBHOmUyBMbQqBA1D7ZP4KK-azWUjb+p-vpJg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix use-after-free in hci_conn_drop
To: Hillf Danton <hdanton@sina.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	johan.hedberg@gmail.com, linux-kernel@vger.kernel.org, 
	syzbot+3609b9b48e68e1fe47fd@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> but the race still exists after this patch.

I agree that the TOCTOU issue remains. I looked into all the functions
that can be called as entry->destroy in hci_cmd_sync_work where the
second argument (data) is used as hci_conn*. I found five such
functions across two files:

In hci_sync.c:
  - create_le_conn_complete
  - create_pa_complete
  - create_big_complete
  - le_read_features_complete

In hci_conn.c:
  - create_big_complete (separate static function)

Of these, create_le_conn_complete and create_pa_complete already use
hci_dev_lock, which effectively prevents this TOCTOU issue.

The remaining three are vulnerable:
  - create_big_complete in hci_sync.c calls hci_conn_valid without
    holding hci_dev_lock (TOCTOU)
  - le_read_features_complete calls hci_conn_drop with no validity
    check at all
  - create_big_complete in hci_conn.c calls hci_connect_cfm and
    hci_conn_del with no validity check at all

Given this, I believe the following set of patches would be
appropriate:

1. Reorder hci_cmd_sync_dequeue before hci_conn_cleanup in
   hci_conn_del
2. Wrap all three vulnerable callbacks with hci_dev_lock and
   hci_conn_valid, following the same pattern used by
   create_le_conn_complete and create_pa_complete

If this approach sounds reasonable, I will prepare updated patches.


2026=E5=B9=B42=E6=9C=889=E6=97=A5(=E6=9C=88) 22:25 Hillf Danton <hdanton@si=
na.com>:
>
> On Mon,  9 Feb 2026 19:02:11 +0900 Masahiro Kawada wrote:
> > Fix a use-after-free in hci_conn_drop triggered via hci_cmd_sync_work.
> >
> > In hci_conn_del(), hci_cmd_sync_dequeue() is called after
> > hci_conn_cleanup() which may have already freed the conn pointer.
> > Fix by moving the dequeue before cleanup.
> >
> > Additionally, le_read_features_complete() calls hci_conn_drop(conn)
> > without checking whether conn is still valid. When
> > hci_le_read_remote_features_sync() blocks waiting for an HCI event,
> > another thread can free conn through hci_conn_del(). Fix by adding
> > a hci_conn_valid() check before calling hci_conn_drop().
> >
> > Fixes: 881559af5f5c ("Bluetooth: hci_sync: Attempt to dequeue connectio=
n attempt")
> > Fixes: a106e50be74b ("Bluetooth: HCI: Add support for LL Extended Featu=
re Set")
> > Reported-by: syzbot+3609b9b48e68e1fe47fd@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D3609b9b48e68e1fe47fd
> > Tested-by: syzbot+3609b9b48e68e1fe47fd@syzkaller.appspotmail.com
> > Signed-off-by: Masahiro Kawada <youjingxiaogao2@gmail.com>
> > ---
> >  net/bluetooth/hci_conn.c | 6 +++---
> >  net/bluetooth/hci_sync.c | 3 +++
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 0795818963a..aa3607327ad 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1232,15 +1232,15 @@ void hci_conn_del(struct hci_conn *conn)
> >       skb_queue_purge(&conn->data_q);
> >       skb_queue_purge(&conn->tx_q.queue);
> >
> > +     /* Dequeue callbacks using connection pointer as data */
> > +     hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
> > +
> >       /* Remove the connection from the list and cleanup its remaining
> >        * state. This is a separate function since for some cases like
> >        * BT_CONNECT_SCAN we *only* want the cleanup part without the
> >        * rest of hci_conn_del.
> >        */
> >       hci_conn_cleanup(conn);
> > -
> > -     /* Dequeue callbacks using connection pointer as data */
> > -     hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
> >  }
> >
> >  struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t sr=
c_type)
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index f04a90bce4a..f31086c187f 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -7371,6 +7371,9 @@ static void le_read_features_complete(struct hci_=
dev *hdev, void *data, int err)
> >       if (err =3D=3D -ECANCELED)
> >               return;
> >
> > +     if (!hci_conn_valid(hdev, conn))
> > +             return;
> > +
> >       hci_conn_drop(conn);
> >  }
> >
> > --
> > 2.43.0
> >
> The uaf [1] is due to the following race,
>
>         cpu1                            cpu2
>         hci_cmd_sync_work()             hci_rx_work()
>         mutex_lock(&hdev->cmd_sync_work_lock);
>         entry =3D list_first_entry_or_null(&hdev->cmd_sync_work_list,
>                                          struct hci_cmd_sync_work_entry,
>                                          list);
>         if (entry)
>                 list_del(&entry->list);
>         mutex_unlock(&hdev->cmd_sync_work_lock);
>
>                                         hci_conn_del()
>                                         hci_conn_hash_del(hdev, conn);
>                                         hci_conn_cleanup(conn)  // free c=
onn
>                                         hci_cmd_sync_dequeue()
>                                         mutex_lock(&hdev->cmd_sync_work_l=
ock);
>                                         while ((entry =3D _hci_cmd_sync_l=
ookup_entry(hdev, func, data,
>                                                    destroy))) {
>                                                 _hci_cmd_sync_cancel_entr=
y(hdev, entry, -ECANCELED);
>                                                 ret =3D true;
>                                         }
>                                         mutex_unlock(&hdev->cmd_sync_work=
_lock);
>
>         hci_req_sync_lock(hdev);
>         err =3D entry->func(hdev, entry->data);
>         if (entry->destroy)
>                 entry->destroy(hdev, entry->data, err);
>                 hci_conn_drop(conn)     // uaf
>         hci_req_sync_unlock(hdev);
>
> but the race still exists after this patch.
>
>         cpu1                            cpu2
>         hci_conn_valid(hdev, conn)
>                                         hci_conn_hash_del(hdev, conn);
>                                         hci_cmd_sync_dequeue()
>                                         hci_conn_cleanup(conn)  // free c=
onn
>         hci_conn_drop(conn); // uaf
>
> [1] Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in hc=
i_conn_drop (3)
> https://lore.kernel.org/lkml/69301edd.a70a0220.2ea503.00cf.GAE@google.com=
/
