Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C427C162
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763416118; cv=none; b=iUHYLSHnCoJXyLhPV0rWZ0ECKjZOmRPChDLFB6wzwSCmw5IZZsCHLkmSFeRHnE0EwRCrHadnWx9N9mO7YI+ZNtTxrP1HuICU0Ilo0gcCwsxaetSdiHx/Lva3ZGdCBo3uO2zBwUOSyR4RHI/sGqufIB83F/kHvaWQkXKeop4vUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763416118; c=relaxed/simple;
	bh=QAMXCqqWYW7OBEuPgCelDMnhlBEBKyIcV13IfgdJfik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TERgic56pcDZjrCGXY8UCzHGNpBzGwohH4mPaQ9z+FIlkl5CjORtXVt1hUDLn08roRqeh9a6fjFExfx4hXursqySiVR1/7rOjGKPqRBc8anuOFB/Ltd8Af881+A9eyqRENrN7ImqlWvAflChj42urB0WQIWKeE6pv8Nc3NlFKjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1Vucg5Q; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1Vucg5Q"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37a3d86b773so44075241fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 13:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763416115; x=1764020915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDrYU5OA1dyom4Iu6cpaVri2jU+FdZJ726eoKPM3vis=;
        b=T1Vucg5QxDxHJfu2/NDyUKm8VrAA2aasi2iRH3JyTQul0LPMgam58AmZddmgfMj4lA
         o9FsZ/TWmiY1v65SDMhJ+eBUcbqd1XM25VxDoCTPu685CLkbriMecZ/aYZ39kY887N2S
         1MZP3Cpj2XGTF1NB4ygaQ/bKkS3L9Gn1dkq9ZG8EJ6HzrVXBVKd6VyUsr1hojjJGqpq4
         8HJOlK3OT45kTCo+ZoRSMVLiKe3M+hgZA3ySp/OHjikgsZ5vMjEb5hVHuB50iTQaLFLu
         LP/q9oziLCn/gRbZBlMCkzUhKdMc0T+FZ8yRpti4j5ypxhoZUVoPrvzPcoihQb1FwxUM
         UdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763416115; x=1764020915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDrYU5OA1dyom4Iu6cpaVri2jU+FdZJ726eoKPM3vis=;
        b=bth++pGEom71dtXWubHr788UiL6XGDoH4QxT3bTQe/KqCfPMscwsc42/661fMZLqBT
         9VyOr6nTLm+EON8sn5U7C7yWL7LTMLFy4qnVIpqb/0TM9vXfdOSYIzqejCL9iIcXpu8y
         AtLeLkdO9T74CDSHu3OW1ZsXNGOf6IZUDo+7n0LK/CbObfrY9uva6xTQuhg8Qt4Wzd4Y
         kZ4xfKhYB3uh1ezYGmVC4upRh5+xf5XQtK/B0IYBKJXpZV+bhm1bgjvrqKzgOaXZ/+cw
         JA01ywLG717ZvWN+FZoUK1Ase3TfRWY2kw0yGfihSSST+xvPF31jkL3+vF3Ub/zhkaio
         5NQw==
X-Forwarded-Encrypted: i=1; AJvYcCXuhA1+WBVm9KJancImiTQw55NAg5hBYCoIcu4ji7F5Px9CC3W40PSMfuukXCuQ2MZ0ROo2hWW2B7hW26cYn50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvM/VAUmFqvS9xjTEpjNWYhRfZUHxJD9EjmA1oQ72O+PxBFRaV
	7p1zO5EsVu950DzHWWiq9bXLJ2/gwLAODxhIFQA29FTaxV+T5A0GiRDaTVAGMSTV3TDArTSz6zf
	hoFWG/XtaAEwe+Mk3WdHQoljbye92ctI=
X-Gm-Gg: ASbGncuc/eXRYF+HUn3lD2qAb9Ki/twbUKhXnddqRTvu9f1HrBwDL8IBJlHmFZz2yV8
	PvMKN8+v9akM4BC8h5WmtoEzd+l3NEf7JPLJlbHnT5bESw0U4JATu88VFTr+2ILAY4WxtC2dIN0
	X/ysCfLZwMmrRL0e4O3Nt8PxjQ+Wn3+f2/835NWBYDXoF3hmIYO+w4bwyTBWG71lqbKYAsbtaOJ
	LjivKqp8sIwePpKcw8hBEv6viVYO+NSQUGrYzHkv2bY3hzgohCSz91Zmo/ZZ6YLjOo2ip8Q0wiO
	UnYq
X-Google-Smtp-Source: AGHT+IHA+DF7ZbUk9EYjscgkdn7nYHOkGKcX8xzixIWjlYwL8KN46yDtqiBToFWoZESyaT8wn1phQSDJyPxa9omH7rs=
X-Received: by 2002:a2e:9c85:0:b0:37b:9ff7:2a41 with SMTP id
 38308e7fff4ca-37babbc3066mr33974511fa.8.1763416114896; Mon, 17 Nov 2025
 13:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117201255.3969812-1-luiz.dentz@gmail.com> <1A6F9809-8B5B-4703-92A2-4DB1007143A6@iki.fi>
In-Reply-To: <1A6F9809-8B5B-4703-92A2-4DB1007143A6@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Nov 2025 16:48:21 -0500
X-Gm-Features: AWmQ_bk4Dx6gp52F06xGfScthBly7KzGMAR9_6aMRacayVxcOHotT3CWfg2VVLM
Message-ID: <CABBYNZKJv04Z7VVsAkQdE7JP9qSLoDXxTa5A_NKGmPyxG3esDA@mail.gmail.com>
Subject: Re: [PATCH v1] fixup! Bluetooth: hci_core: Fix triggering cmd_timer
 for HCI_OP_NOP
To: Pauli Virtanen <pav@iki.fi>
Cc: syzbot+25e9c406cbd26c66c417@syzkaller.appspotmail.com, 
	linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Nov 17, 2025 at 3:49=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> 17. marraskuuta 2025 20.12.55 UTC Luiz Augusto von Dentz <luiz.dentz@gmai=
l.com> kirjoitti:
> >From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> >Fixes: 486a25d25a4b3 ("Bluetooth: hci_core: Fix triggering cmd_timer for=
 HCI_OP_NOP")
> >Reported-by: syzbot+25e9c406cbd26c66c417@syzkaller.appspotmail.com
> >Closes: https://syzkaller.appspot.com/bug?extid=3D25e9c406cbd26c66c417
> >Signed-off-by: Pauli Virtanen <pav@iki.fi>
> >Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >---
> > net/bluetooth/hci_core.c | 19 ++++++++++---------
> > 1 file changed, 10 insertions(+), 9 deletions(-)
> >
> >diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >index 9f686e5903a1..dc318aa79c59 100644
> >--- a/net/bluetooth/hci_core.c
> >+++ b/net/bluetooth/hci_core.c
> >@@ -4121,7 +4121,7 @@ static void hci_rx_work(struct work_struct *work)
> >       }
> > }
> >
> >-static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb=
)
> >+static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
> > {
> >       int err;
> >
> >@@ -4133,16 +4133,18 @@ static void hci_send_cmd_sync(struct hci_dev *hd=
ev, struct sk_buff *skb)
> >       if (!hdev->sent_cmd) {
> >               skb_queue_head(&hdev->cmd_q, skb);
> >               queue_work(hdev->workqueue, &hdev->cmd_work);
> >-              return;
> >+              return -EINVAL;
> >       }
> >
> >       if (hci_skb_opcode(skb) !=3D HCI_OP_NOP) {
> >               err =3D hci_send_frame(hdev, skb);
> >               if (err < 0) {
> >                       hci_cmd_sync_cancel_sync(hdev, -err);
> >-                      return;
> >+                      return err;
> >               }
> >               atomic_dec(&hdev->cmd_cnt);
> >+      } else {
> >+              err =3D -ENODATA;
>
> Change itself is probably OK, but I don't understand based on a quick loo=
k what consumes the skb on error / nop (also in the previous code)

The sent_cmd is consumed on the next time hci_send_cmd_sync is run,
that said perhaps you are referring to the original skb which has been
cloned but in case of NOP it appears to be leaking since that never
reaches the we should perhaps just free it.

>
> >       }
> >
> >       if (hdev->req_status =3D=3D HCI_REQ_PEND &&
> >@@ -4150,12 +4152,15 @@ static void hci_send_cmd_sync(struct hci_dev *hd=
ev, struct sk_buff *skb)
> >               kfree_skb(hdev->req_skb);
> >               hdev->req_skb =3D skb_clone(hdev->sent_cmd, GFP_KERNEL);
> >       }
> >+
> >+      return err;
> > }
> >
> > static void hci_cmd_work(struct work_struct *work)
> > {
> >       struct hci_dev *hdev =3D container_of(work, struct hci_dev, cmd_w=
ork);
> >       struct sk_buff *skb;
> >+      int err;
> >
> >       BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
> >              atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
> >@@ -4166,12 +4171,8 @@ static void hci_cmd_work(struct work_struct *work=
)
> >               if (!skb)
> >                       return;
> >
> >-              hci_send_cmd_sync(hdev, skb);
> >-
> >-              /* Don't trigger cmd_timer in case of HCI_OP_NOP since th=
ere is
> >-               * no command pending.
> >-               */
> >-              if (hci_skb_opcode(skb) =3D=3D HCI_OP_NOP)
> >+              err =3D hci_send_cmd_sync(hdev, skb);
> >+              if (err)
> >                       return;
> >
> >               rcu_read_lock();



--=20
Luiz Augusto von Dentz
