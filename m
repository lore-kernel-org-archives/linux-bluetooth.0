Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056C4C6815
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951577; cv=pass; b=OPc8F2pNhqWLyql1c0uO4FLUTpa66+COPNRvGyl4o2UxUcAfbszgCr0r1gFFbk+YN0p2JZoa0mnbwY8S3T5n3CYN2Zmr9wUNTuRWjbf5HcBRgjrhuauKJYToUmut8x9wpOzGdQdu45+RR+Ka5zEw56ow8nJ3qPRAgmhSJvDflac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951577; c=relaxed/simple;
	bh=kKkUQcbhi26M/mkN5TN2jphDNVphewt85IahrXmYcQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LD82wr5Cz72idOpdWWMhNdAR/69FQnAaNcwEOPU/utMtOjuVyLNbLQbCkdCDfmsA/+V6zcYmV85waVLsRblicrtRdbOcGABh+5S6PzcRhYeuXWecP2XW21pYVtVdhUVqZCrwTH3kPw5GlAFVranF08RxfWwwdZwJcP8xXXsg2+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdM2TU0G; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdM2TU0G"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a8496fd8c3so84177387b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 07:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790951575; cv=none;
        d=google.com; s=arc-20260327;
        b=AplUwtvTRN5H67uc6dnzoYVBLXZi/1/zEm0BepZUuQJO7ygX6sYKrFX7UyUkwv2IQP
         YDiI8sn6EL5NLLj12zOAEfF3JqvhHKjPzVEoTsGcpf9XWZKGK1XcSOFmxdguGDPQWbAp
         kIV246yJ9mKxWoLqQ7yzrBAlWdeRgTvY9NCHIOFYkabNhZL3O0jnrmURQgyvCOS0/53J
         otWbA2G8PMrN6WcQC6vLEAwhpg+1J6NeMeki06C8vfwWfMmvvMMan5C1w/Ra98CweHFR
         ugRGESREu4j6hB8z3aNZSZnkUCC5ZtttYwvZcTfajJbHJviJ6QVqz6Fy1rBu/Kq6XSL4
         dBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NEJuNp97mXfRaSULFI9ZLN/PvtyixMSG2YXXNPsqTwk=;
        fh=H9oc8/dlX+oBRPuqS+0fsVitNntZ3EykkQyhky/PWWU=;
        b=c8QVS+m/hImkpq6NkycFwvxfTkkJN1mVnIMjmNeX9/3XQL5nEzFUIJpZYl0JElZ4yx
         6GugSKwMhrwlfgoqfIEhlGFPYz4HgzAbS789s3meCQbgjF8v8dbN27M/76vA9Qbo+Qi9
         c3wB0504eo7nQrXjnS6ZXwGE2ItAI//MugAgTOFZGHZ6WGo1UabIVJNUxGwds3MU/cVs
         2fUTogDCy/aM8V0Re/QhJQDRDcuQy/+S99sxnCbfSWGn7p0hd2p7J4fu0ePw1ltRGcxf
         89shh6tnOz5CS+CK5fWi4t2tGPVGclarxlQ5P3/B+8d6CjTGMI9NTSyY0r2iPb/r6zie
         nE4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790951575; x=1791556375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NEJuNp97mXfRaSULFI9ZLN/PvtyixMSG2YXXNPsqTwk=;
        b=RdM2TU0Gg9f4si8PMao+jiYYqRVbNvePRkd+6Pas6f6YmO1CpyL3vLtx6hsjwzi6X3
         E2pcn1yGT5XpZ4Mx16oU0QZvrwEDbIB9x5x03fR9Njr49ZNoGgjIXyH+Hu2L6lSE+HwR
         NO5Xogp/7CCCiVafGl3D4l03mCrkIs+gxv5DXi5VZw0iiDSf5gILX84IvmlSy99//Mb/
         +kEGlO/1kAlvGLrz50r8oHrqQW6Hz10h2yVbQJ3OQwozRdDUxOn81e/Jl+thHZycXouL
         gvOTN8T4oVTFKqVDqB+jkBucalscu9MGQftn7d9Qc2aPlbXKUxHJg49QTpM5/6sqG4EC
         5WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951575; x=1791556375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NEJuNp97mXfRaSULFI9ZLN/PvtyixMSG2YXXNPsqTwk=;
        b=P/nnP9f4COqnFv0VT1jVGV8VzdLzRWiuTAg165ChLnpYogWeXtX+426vKRo8Kfsumz
         K+hIAbuHuX73MwgyDlg6UDDx2eiRT+4PI+jcpOX0kVo/PNZ/6yP5CoM8v6WllxdDvBvP
         6eLgdNCaybFaXu2fjw6CKHOKb+redwgBiBKIl+T0D30UX9FJJrHZIHEkdm+oWa8A5+LZ
         nB4kPZ9ZpoJDbcRp0LQExCjRvZ0pk0w6iHigfNV2BbKbAT4p5sURiwCl+tl6vtMYawWf
         6XT9pGBO5Q2bRZu8vrH95tXlCPiYY3Q8vPUvv+pH0gFa7gaWEqHoytyYV7nm94axEbHV
         QHpg==
X-Forwarded-Encrypted: i=1; AKwUvByCTT2Jg79v5UJ8bsKhp2I7ELKfbpi3D6Z4k0/qM3hDrDg34/HoKy3s175wAVt070u+MYUgBUu601wDUz1ut54=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbCw9MnBY1szaGljccKUfkuZU0x4BGkwcwu4Z9YFlQ8KSNhy9d
	MiKlucHvwYV6PCnDGc/AZnZgdJNDRGELgA24XJsn2HnvZM/W0a5pwcUFgcsm2+fAZ4QC+pDqTzZ
	aX7pj9foL6OTvwCp75R0xw9cdtTR/VBM=
X-Gm-Gg: AYBFou0IsJevkOsUBP1xJ/C29/F03DIheimK95kbX7LNMd8q/qbN3QaJdYFkbapMhGS
	TBpDESBxziPi7Nr4t9KQnVKsFgHBIndHEScMjWfPVMW8/G709vYOIDbc/LeborQ4ZTtO2VqQ8cO
	29pGlb2Z4mFG4QpmLvNWk7CU++sMRsiVnDZ7d/z8vPHqWHPwESh+vdT2ci+n4zdj2cDyZ2NmdFJ
	BM+8fOhEUK3pAzTHjXRMAqvh6WC1JizwTnMIurWMlpfra6kTScsbg4d6dZ8AhGBp2v/upxcwC8W
	5a+QSJHkFBuvgqj0TOlABm9h9LEAPAh7owZ11Z1pSBXdPW/Hmz943K+2PokcAqm13rWbYpOH7C1
	nrAzM2wiLt4b+Wku37Px/UhunKg/ah69/8nOEQ6KgBuRo9URus8cQ
X-Received: by 2002:a05:690c:c1d:b0:8a9:e7a0:6f6e with SMTP id
 00721157ae682-8ae39c120e6mr11852257b3.47.1790951575131; Fri, 02 Oct 2026
 07:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002044810.80340-1-rabindrameher116@gmail.com> <CABBYNZLeHVQjsnjbPn76LVKT1RxSadYPZDqoNY7Lj-zEysU8-A@mail.gmail.com>
In-Reply-To: <CABBYNZLeHVQjsnjbPn76LVKT1RxSadYPZDqoNY7Lj-zEysU8-A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 2 Oct 2026 10:32:43 -0400
X-Gm-Features: AclHuK_s09FvcmvKeeOnHlkCh7VSMR-2ZvJ1LFGY5DWWJ9pPxGuKkQ8snax1QHM
Message-ID: <CABBYNZ+870EdpRWDpx22ZZX4=_+bVwjf3Fv4HazoV5u9+_ab6g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Cancel cmd_timer before draining workqueue
To: rabindra789 <rabindrameher116@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Pauli Virtanen <pav@iki.fi>, 
	Chengfeng Ye <nicoyip.dev@gmail.com>, linux-bluetooth@vger.kernel.org, 
	syzbot+48fc5b35b350240fd465@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 2, 2026 at 10:29=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Rabindra,
>
> On Fri, Oct 2, 2026 at 12:48=E2=80=AFAM rabindra789 <rabindrameher116@gma=
il.com> wrote:
> >
> > cmd_timer can expire while hdev->workqueue is being drained,
> > causing hci_cmd_timeout to be queued on a draining workqueue.
> >
> > Cancel cmd_timer before draining the workqueue.
> >
> > Reported-by: syzbot+48fc5b35b350240fd465@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D48fc5b35b350240fd465
> > Fixes: 40b87657200c ("Bluetooth: hci_core: Rework hci_dev_do_reset() to=
 use hci_sync functions")
> >
> > Signed-off-by: rabindra789 <rabindrameher116@gmail.com>
> > ---
> >  net/bluetooth/hci_sync.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index c01c8b58d9e8..e1c28bffdc15 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -5545,6 +5545,8 @@ int hci_dev_close_sync(struct hci_dev *hdev)
> >          */
> >         hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
> >         synchronize_rcu();
> > +       /* Explicitly cancel works in case scheduled after setting the =
flag. */
> > +       cancel_delayed_work_sync(&hdev->cmd_timer);
>
> I'm not following here. If a command is outstanding and times out
> while we are draining the queue that should be flagged. Or perhaps the
> problem is that hci_cmd_sync_cancel_sync don't actually behave like
> hci_cmd_sync_cancel which clears the cmd_timer whenever it cancels the
> cmd_sync work:
>
> static void hci_cmd_sync_cancel_work(struct work_struct *work)
> {
>         struct hci_dev *hdev =3D container_of(work, struct hci_dev,
> cmd_sync_cancel_work);
>
>         cancel_delayed_work_sync(&hdev->cmd_timer);
>         cancel_delayed_work_sync(&hdev->ncmd_timer);
>         atomic_set(&hdev->cmd_cnt, 1);
>
>         wake_up_interruptible(&hdev->req_wait_q);
> }

Maybe something like the following:

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1fe11d3ef1aa..87b9f96af057 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -702,6 +702,12 @@ void hci_cmd_sync_cancel_sync(struct hci_dev
*hdev, int err)
                hdev->req_result =3D err < 0 ? -err : err;
                WRITE_ONCE(hdev->req_status, HCI_REQ_CANCELED);

+               if (!hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+                       cancel_delayed_work_sync(&hdev->cmd_timer);
+                       cancel_delayed_work_sync(&hdev->ncmd_timer);
+                       atomic_set(&hdev->cmd_cnt, 1);
+               }
+
                wake_up_interruptible(&hdev->req_wait_q);
        }
 }

> >         if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
> >                 disable_delayed_work(&hdev->power_off);
> > --
> > 2.43.0
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
