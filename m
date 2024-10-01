Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3681C9ECC
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801799; cv=none; b=XsNKUac2A1RGIoEtx0S6vJmWX0P/eJezjwDTy6EnLKF89FzSIYYWkgwqtPvppgfO/z9akMRiKqamRcZodPMWQtUQ8BgSQt9zOVJlxOCFeSxa04a2YTfwMuPe4rFoSUwofDicd/4oBpOhwC3vMrkzSkmBrc3rtx1obo7gFpMFw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801799; c=relaxed/simple;
	bh=/LEfJeccmeYjOyxLPM3sBwQJn1WP+vPGHl4TnhR7Jpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejAO87P/NNmRkyzukk1i9ASGow6Y8oMj4+WoIKFZn2ozSYPG1E1sx/nz1VDo8P7u7U+4S0nNdUKYTof2YucClB/iXHx+YeGg+v+JFYd2kfxhfhlpD3DPdaepGXG/SFzTVB5K8XRoTK+1/xkKlVhoOD7BqqzGn6zfAFDlSo3aK/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h47hEW9D; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h47hEW9D"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac60ab585so30388691fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727801795; x=1728406595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VjRfQahvJCC4a4UbW+y7OVFcgIsjOS/2+7uVC7JYi5s=;
        b=h47hEW9Dif5Eycu/YvNBS5IO2gWvXMeVhe3sLQ0n0IGFJothM8aF9vW0UKwc/4GmKG
         N7U3si8EbH/mpqzypn/fb9MsFapoH105evTSmBgCnXhkFOKQYpQ7Y6jUon3GTuoIh/x7
         Q6e+NmF5QX0gET0r14/3Y5iitmH4HMrFTR9qqr42sJuz1GnZsSgQ97Rw7r5ZDxR+ZNWa
         ukcUlP80TYbWg0BZg3rnhj6ZvIUuO0Da9MfeZyIrfQiSoyiryzglSzjGG5kBYQfUheO7
         Rv8QlQT2sTprBjXWM/4B5KgR36k4+QX25Ii2ygeP+Duq7caCBNjhm2oVCBbZMDtgSyMn
         MiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727801795; x=1728406595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjRfQahvJCC4a4UbW+y7OVFcgIsjOS/2+7uVC7JYi5s=;
        b=XQo9BLb3CLXFBJYyrIgMASxoC7T8qiR7TgX6ssYPzouuUrg3i6naVTVuM7dkZS6Y5c
         gUTMPNZGY4z+hcN6psb02TzA6+9rZu3Vz+XdekIR79BJxrY6zCn4HxjSSLZZWsE7g2pS
         7YwVXRNdnKhVzJE8+m4VAsyS4xqcgPpIAdLFxmyt2H9gmvgjz160n5PQmedxSNmCcLEp
         ahkl39ZgvlCqdPCu9EGpT3DehO7L+9f/zOIdUgCvkCdU7tp6+nCjEh+yaVgMO/j8Xy+J
         PQ01FTM1hoATWwxUa1X1tAQ75uZ7b++1/5gvI3znUJE04Mg09mKkSJrb3JH0tRt31pLx
         UKag==
X-Gm-Message-State: AOJu0YxQu4RtTTeOeiAk/JxtOVfYS+i9DD/GrfsUS0K9Vq+UoA7pvoR9
	tEMguN2iTI/RA/qn+xGlm0teTSCiwH2VXCXgXA9/W70xpQ8uTBHklX2RB3VylFi+d1/a5Ij5NKA
	RSwxW2ksRmOtzAKJmiatiF7B0wnXA5Q==
X-Google-Smtp-Source: AGHT+IGtnrWPFhR1cEKGuM4tBne5YfF2Q8US89w54bg7+xKDRitTmtgVEF5+lkRsg8HbnSVw7dcCsrwyc501hdbxQXA=
X-Received: by 2002:a05:651c:210f:b0:2f5:806:5cee with SMTP id
 38308e7fff4ca-2fae1015664mr3576361fa.11.1727801794647; Tue, 01 Oct 2024
 09:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001165055.3111289-1-luiz.dentz@gmail.com>
In-Reply-To: <20241001165055.3111289-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Oct 2024 12:56:22 -0400
Message-ID: <CABBYNZKKq3=RqD5Y2z=qy3Mv3Y8J53E+UEUi8bqWVAfx6CXGRQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_conn: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000003676de06236d34af"

--0000000000003676de06236d34af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:50=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes use of disable_delayed_work_sync instead
> cancel_delayed_work_sync as it not only cancel the ongoing work but also
> disables new submit which is disarable since the object holding the work
> is about to be freed.
>
> Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
> Closes: Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.co=
m
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_conn.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 0c01ece500a9..fb0946eac8a4 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1124,9 +1124,9 @@ void hci_conn_del(struct hci_conn *conn)
>
>         hci_conn_unlink(conn);
>
> -       cancel_delayed_work_sync(&conn->disc_work);
> -       cancel_delayed_work_sync(&conn->auto_accept_work);
> -       cancel_delayed_work_sync(&conn->idle_work);
> +       disable_delayed_work_sync(&conn->disc_work);
> +       disable_delayed_work_sync(&conn->auto_accept_work);
> +       disable_delayed_work_sync(&conn->idle_work);
>
>         if (conn->type =3D=3D ACL_LINK) {
>                 /* Unacked frames */
> --
> 2.46.1
>

#syz test

--=20
Luiz Augusto von Dentz

--0000000000003676de06236d34af
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v1-0001-Bluetooth-hci_conn-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v1-0001-Bluetooth-hci_conn-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1qokec40>
X-Attachment-Id: f_m1qokec40

RnJvbSBkYjBiZWZkOTRiOTVlMjYwN2I5NTBiMDk3MDdhNDIyNjIyZTI3ZjU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMSBPY3QgMjAyNCAxMjozNDowNiAtMDQwMApTdWJqZWN0
OiBbUEFUQ0ggdjFdIEJsdWV0b290aDogaGNpX2Nvbm46IFVzZSBkaXNhYmxlX2RlbGF5ZWRfd29y
a19zeW5jCgpUaGlzIG1ha2VzIHVzZSBvZiBkaXNhYmxlX2RlbGF5ZWRfd29ya19zeW5jIGluc3Rl
YWQKY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jIGFzIGl0IG5vdCBvbmx5IGNhbmNlbCB0aGUgb25n
b2luZyB3b3JrIGJ1dCBhbHNvCmRpc2FibGVzIG5ldyBzdWJtaXQgd2hpY2ggaXMgZGlzYXJhYmxl
IHNpbmNlIHRoZSBvYmplY3QgaG9sZGluZyB0aGUgd29yawppcyBhYm91dCB0byBiZSBmcmVlZC4K
ClJlcG9ydGVkLWJ5OiBzeXpib3QrMjQ0NmRkM2NiMDcyNzczODhkYjZAc3l6a2FsbGVyLmFwcHNw
b3RtYWlsLmNvbQpDbG9zZXM6IFJlcG9ydGVkLWJ5OiBzeXpib3QrMjQ0NmRkM2NiMDcyNzczODhk
YjZAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBMdWl6IEF1Z3VzdG8g
dm9uIERlbnR6IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5jb20+Ci0tLQogbmV0L2JsdWV0b290aC9o
Y2lfY29ubi5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9oY2lfY29ubi5jIGIvbmV0
L2JsdWV0b290aC9oY2lfY29ubi5jCmluZGV4IDBjMDFlY2U1MDBhOS4uZmIwOTQ2ZWFjOGE0IDEw
MDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmMKKysrIGIvbmV0L2JsdWV0b290aC9o
Y2lfY29ubi5jCkBAIC0xMTI0LDkgKzExMjQsOSBAQCB2b2lkIGhjaV9jb25uX2RlbChzdHJ1Y3Qg
aGNpX2Nvbm4gKmNvbm4pCiAKIAloY2lfY29ubl91bmxpbmsoY29ubik7CiAKLQljYW5jZWxfZGVs
YXllZF93b3JrX3N5bmMoJmNvbm4tPmRpc2Nfd29yayk7Ci0JY2FuY2VsX2RlbGF5ZWRfd29ya19z
eW5jKCZjb25uLT5hdXRvX2FjY2VwdF93b3JrKTsKLQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMo
JmNvbm4tPmlkbGVfd29yayk7CisJZGlzYWJsZV9kZWxheWVkX3dvcmtfc3luYygmY29ubi0+ZGlz
Y193b3JrKTsKKwlkaXNhYmxlX2RlbGF5ZWRfd29ya19zeW5jKCZjb25uLT5hdXRvX2FjY2VwdF93
b3JrKTsKKwlkaXNhYmxlX2RlbGF5ZWRfd29ya19zeW5jKCZjb25uLT5pZGxlX3dvcmspOwogCiAJ
aWYgKGNvbm4tPnR5cGUgPT0gQUNMX0xJTkspIHsKIAkJLyogVW5hY2tlZCBmcmFtZXMgKi8KLS0g
CjIuNDYuMQoK
--0000000000003676de06236d34af--
