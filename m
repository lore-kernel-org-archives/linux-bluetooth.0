Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72EA218ACC
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512547; cv=none; b=JpdvrYFN3my5n40Cmo4fEkGoNYzQvm3qVH2GMDFQkxPZidtaO1tubyjBZoM+VXQZPruOMq9C2ly8PE+pyqUfWU/qRJqlRJkGErgTT6Mxi3Yaaw/h6gjsMDQ6GLfIds5sakTerS4VP7F3CBCtovPWK65oN57ATQ/nqp5F9MSTdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512547; c=relaxed/simple;
	bh=ILwSeAVhSJMsSKfN3UnSji0mNmvYresnO0ex0MLDeCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIiZO+tv04/sJpgSbcT8cDXCS8MKP6A1nqYnXtG56gMrX1gHpJzhS1ye0i1YdbmY0Gp8Np1uQdL02bJaACgzDdhmNf097/4VpnUj45aQLWrDYVfDx3d063CyNZGfWXP+/gINxOe03Jv0mURdXlwPuQmFlh+w3yNJZgYNIGA6fN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EK4NOJPm; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK4NOJPm"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-336dc57f562so5778171fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757512544; x=1758117344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vm6fl/y2d+3m53NS+Q1I0JId0YrndSL9uOj0LNPC0Y=;
        b=EK4NOJPmbwtMqVKWuoRJ2D0hHqYh3J100Hfi4pVsXlXzRXOz9rZ/ePYTGQk9k6lJp1
         YII1NgtFPsveC3NYvnuGrXXfc2emL23xuTJA7kycPWV1w7kKgA70c96J1wwggmuiLWa8
         5tNrqwk9FfaMJYaQ9AhHh5BgcqZTHFfTUQmerp0cDDBTuF4PQNk+t2hq4LTOAe/vgFr4
         ONMCoXFjrGEPZ9ptcGUVHL2JxcgFK4Ytl9VUQiyz6vg3GEi6yqqmk2X/K6tkEQlauv55
         hzuoXzuUVdNrDknQpXPT6xXYoGDmaO4fO/WyqhY4Bp4MuLwJAVFooVeVc2vehB2WnP5t
         ABSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512544; x=1758117344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vm6fl/y2d+3m53NS+Q1I0JId0YrndSL9uOj0LNPC0Y=;
        b=PJ5gitx1OPZYSltIvK9am+HZMb20efwz5VepljR+x2wIFX4/pJxsd4G4+oYlOuI0ru
         eLlA5qEyY8h7Tue6uk8EbkzYc3pbMevbBsH5XhiEFhEcjvsyxNFL/1fs6nHCPcZdvFyp
         SjT/lS+d6vKnxMjkd4uMgpEb6vI50O7Bm2pC2vQguGnAevvl8F1p73KRbsn8Tk0sIHXI
         hfQm2q3l/V1XDBkJQ0GUquPWV8vxn15zAMhVOitIMRLTYjdJu1iQUbbO6PKdCXXLJIH9
         0iWaUXrot5IG+GsRrKb2HUINRA7vjIlLKNSEkGsO62zhneQKjboH77OgyrtNGh09yYZI
         vL0g==
X-Gm-Message-State: AOJu0YwLNle81Z7rRfml0eMnovzLrHxTzxeDN3EyyjCaJSf4zO89qkHH
	FXvLzRtLuqpiYjBA+cuw3PfAhyHv5pLwcIfFE2c9w6BY+iCjjTt9yjNQkuvC3y7c+VMOka1VaH/
	pJp0HzLCZuzvfXhqT8GJZfpSJlKey4D0=
X-Gm-Gg: ASbGncunsYoErk5Cib8TBf9/aRairRSIbRZ3e0HmYDGDE4NZwn7biWk+f+9iYEYqL0h
	cxdXgR5XSNNKJCNu3frxrcVv0qF1YqUOzcpRi3tK0vcCbXCeXMlYoV0C4b/Qhlo+GNkPL3UK0f+
	N0efYp75GXOFAYJVeNKETtrCkI64Ya/nraVpi/Yue99BC0RZnLLzO0BpoG43Reo6Za5r9z8D4Wg
	CZu9Lz/828mYhVherBSLHug+ETIHBMqOCatlD2VTtBD3Q9FpCcdWJvS
X-Google-Smtp-Source: AGHT+IFtJeb0u3069gxzrg/MvZ2c5q57gPD82eDFQh+LfYmag+bZs3o6ADHgPsH6SygyCoRcKnTnRzjGNRBhN8HETw0=
X-Received: by 2002:a05:651c:324c:b0:336:d686:74ac with SMTP id
 38308e7fff4ca-3381e707bcamr55782291fa.11.1757512543382; Wed, 10 Sep 2025
 06:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909215824.1739006-1-luiz.dentz@gmail.com>
 <20250909215824.1739006-2-luiz.dentz@gmail.com> <ca392074-252c-4e00-87a5-4b78cdeb4a63@molgen.mpg.de>
In-Reply-To: <ca392074-252c-4e00-87a5-4b78cdeb4a63@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Sep 2025 09:55:31 -0400
X-Gm-Features: Ac12FXx5P2cPWCvKafc3yhG5hywYYmZIYDE4QrNuhQKr7LxkCImVb2wjZgr634k
Message-ID: <CABBYNZLhF84nBjkwzn=oxpF+SnT+KPbfcHRc2ryH1mMZQbASYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
To: Paul Menzel <pmenzel@molgen.mpg.de>, zhuque@tencent.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Sep 9, 2025 at 6:06=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Luiz,
>
>
> Thank you for the patch.
>
> Am 09.09.25 um 23:58 schrieb Luiz Augusto von Dentz:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This fixes the following UAF caused by not properly locking hdev when
> > processing HCI_EV_NUM_COMP_PKTS:
> >
> > BUG: KASAN: slab-use-after-free in hci_conn_tx_dequeue+0x1be/0x220 net/=
bluetooth/hci_conn.c:3036
> > Read of size 4 at addr ffff8880740f0940 by task kworker/u11:0/54
> >
> > CPU: 1 UID: 0 PID: 54 Comm: kworker/u11:0 Not tainted 6.16.0-rc7 #3 PRE=
EMPT(full)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubu=
ntu1 04/01/2014
> > Workqueue: hci1 hci_rx_work
> > Call Trace:
> >   <TASK>
> >   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >   print_address_description mm/kasan/report.c:378 [inline]
> >   print_report+0xca/0x230 mm/kasan/report.c:480
> >   kasan_report+0x118/0x150 mm/kasan/report.c:593
> >   hci_conn_tx_dequeue+0x1be/0x220 net/bluetooth/hci_conn.c:3036
> >   hci_num_comp_pkts_evt+0x1c8/0xa50 net/bluetooth/hci_event.c:4404
> >   hci_event_func net/bluetooth/hci_event.c:7477 [inline]
> >   hci_event_packet+0x7e0/0x1200 net/bluetooth/hci_event.c:7531
> >   hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4070
> >   process_one_work kernel/workqueue.c:3238 [inline]
> >   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
> >   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
> >   kthread+0x70e/0x8a0 kernel/kthread.c:464
> >   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
> >   ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan=
/linux-6.16-rc7/arch/x86/entry/entry_64.S:245
> >   </TASK>
> >
> > Allocated by task 54:
> >   kasan_save_stack mm/kasan/common.c:47 [inline]
> >   kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> >   __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
> >   kasan_kmalloc include/linux/kasan.h:260 [inline]
> >   __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
> >   kmalloc_noprof include/linux/slab.h:905 [inline]
> >   kzalloc_noprof include/linux/slab.h:1039 [inline]
> >   __hci_conn_add+0x233/0x1b30 net/bluetooth/hci_conn.c:939
> >   le_conn_complete_evt+0x3d6/0x1220 net/bluetooth/hci_event.c:5628
> >   hci_le_enh_conn_complete_evt+0x189/0x470 net/bluetooth/hci_event.c:57=
94
> >   hci_event_func net/bluetooth/hci_event.c:7474 [inline]
> >   hci_event_packet+0x78c/0x1200 net/bluetooth/hci_event.c:7531
> >   hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4070
> >   process_one_work kernel/workqueue.c:3238 [inline]
> >   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
> >   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
> >   kthread+0x70e/0x8a0 kernel/kthread.c:464
> >   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
> >   ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan=
/linux-6.16-rc7/arch/x86/entry/entry_64.S:245
> >
> > Freed by task 9572:
> >   kasan_save_stack mm/kasan/common.c:47 [inline]
> >   kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >   kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
> >   poison_slab_object mm/kasan/common.c:247 [inline]
> >   __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
> >   kasan_slab_free include/linux/kasan.h:233 [inline]
> >   slab_free_hook mm/slub.c:2381 [inline]
> >   slab_free mm/slub.c:4643 [inline]
> >   kfree+0x18e/0x440 mm/slub.c:4842
> >   device_release+0x9c/0x1c0
> >   kobject_cleanup lib/kobject.c:689 [inline]
> >   kobject_release lib/kobject.c:720 [inline]
> >   kref_put include/linux/kref.h:65 [inline]
> >   kobject_put+0x22b/0x480 lib/kobject.c:737
> >   hci_conn_cleanup net/bluetooth/hci_conn.c:175 [inline]
> >   hci_conn_del+0x8ff/0xcb0 net/bluetooth/hci_conn.c:1173
> >   hci_abort_conn_sync+0x5d1/0xdf0 net/bluetooth/hci_sync.c:5689
> >   hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
> >   process_one_work kernel/workqueue.c:3238 [inline]
> >   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
> >   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
> >   kthread+0x70e/0x8a0 kernel/kthread.c:464
> >   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
> >   ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan=
/linux-6.16-rc7/arch/x86/entry/entry_64.S:245
> >
> > Fixes: 134f4b39df7b ("Bluetooth: add support for skb TX SND/COMPLETION =
timestamping")
> > Reported-by: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
>
> Just the name without the company/organization?

This was how it was requested to be.

> Junvy Yang <zhuque@tencent.com>

I'm not sure if the email is from a single individual or some sort of
contact email, @zhuque@tencent.com can you clarify if we should use
the above?

> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >   net/bluetooth/hci_event.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 571b7ca011c2..abb17dadf03c 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4391,6 +4391,8 @@ static void hci_num_comp_pkts_evt(struct hci_dev =
*hdev, void *data,
> >
> >       bt_dev_dbg(hdev, "num %d", ev->num);
> >
> > +     hci_dev_lock(hdev);
> > +
> >       for (i =3D 0; i < ev->num; i++) {
> >               struct hci_comp_pkts_info *info =3D &ev->handles[i];
> >               struct hci_conn *conn;
> > @@ -4462,6 +4464,8 @@ static void hci_num_comp_pkts_evt(struct hci_dev =
*hdev, void *data,
> >       }
> >
> >       queue_work(hdev->workqueue, &hdev->tx_work);
> > +
> > +     hci_dev_unlock(hdev);
> >   }
> >
> >   static void hci_mode_change_evt(struct hci_dev *hdev, void *data,
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
