Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC21CCEC2
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812213; cv=none; b=TL7pjl09hcE/C/SKDb+6tS013r0+NGyQQRSy4+5rBc9SAqDakgjh1V56PDOvmfBYKDvkqO6jJsLhiBCTdwglmG0ZjqJVW2sfkhVPLFvEawCRsMfiGDHDMNZN0IzNanacLtDfLGaEWXizRdo3e4w/HIj4a+Q2QXztojwqjOTjJ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812213; c=relaxed/simple;
	bh=CTuA5qqmTu9HSgV4o6O4sgZ+PbTVJ+7g9PK/Xh4wtzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYi7c1Sb7vx8Dxscv3faN/8zQCjfLLDVtsKpSP8udTm3cJKSgK+DtTDTuSzsXjP48cgFqRpvRzf4M1lNzICfIeSDdjE47MrHCQf3/kq4QPQH3ND5iB8QACxmsHLt6ZeJm9NGRXJRZxFkapIfj5lFLmRwikO1YSS7nzV3kMKukos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2xmhOVT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2xmhOVT"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2facf48157dso30266781fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727812209; x=1728417009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=me6iFcGp5uJ5XBy6XfqF9DBNW6mZUz46Fo46O7aH2c8=;
        b=H2xmhOVTJJ6Jw0DrtTbqGoaUGOF2gVA0+6zh6oDtiFPfhy4Dbs8hJZRJybfCNrItlT
         MNxH1IjKTOgKqf6PAzUzkWCR3m8fxMCgOMNHhIKkqwXxpEfdrC8kE0AAxDF1BZ5PJLKq
         6hPhoc/qRjJ/PMoY0hUmAbCPaPgHWKDdM18Nnfexr1Y8tn+jQX0kB6kB0wmHnUsML0zj
         bYHHMsE3P1IowLsCkAz7y/kjS8rx/T3f/dz23mryUuf8nMvLd1rpj/KnoojZ+3dC9xku
         TfMwiHxmofRGhTA/xEtGQwQBbPSvhoPIqmAI6Y+I5/ep2V5lqQbPB9785D/0MLjD7iyo
         3ZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727812209; x=1728417009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=me6iFcGp5uJ5XBy6XfqF9DBNW6mZUz46Fo46O7aH2c8=;
        b=qJ0KaRg1tll+mjZ9OyVa+4X3aNqck2dmV1bv9dRfXKNN6LtDLyzlgfdrEsHDH3ZGIZ
         v8obcr3Y5MWjJ+rNVBr7cqqmZYxIgpXf9Q5DFNY5mbNOz9UtcQCtRLKv7pESBMMuDTzP
         VA5kPffb3bspxkIlxD34RyAKamcWkCSdC5PVYCEj7E5mL4xbDFe/c+7XL5JqNVaUn3Uk
         MXnYGnPS1OIERRhVGpms8yHKl1BMEAOVPG8ULxmC1m53OWTqrs+uW8AWdVqf45jMpVHW
         P4KnshYzH3Vn5ZleSEWxrUIXl1ffBH9BXDM8ETy6ONyW9vh69b5KASLGiN6NjeFGowJu
         cd2A==
X-Gm-Message-State: AOJu0Ywm7XuMOemVngk1UyRs403rvQgX3iQfWC8WwYJ1BX9cO5hqZmTS
	rVCG5BInqtVhv/vcsLUpScRtLDHhWL0BGilwFw1o0ELAPyt8KY+0NWN5x2ZlfA4FSPTBxXg+7oF
	AtyB9MGv/x4g5jVK8KBJx2js9FTv46g==
X-Google-Smtp-Source: AGHT+IF72nAuwvIzJt33fw3WbtugFSHs+F611+81iMFgz/d3LQ8DOIq4foZoV+ljIE6Tmebk/0C93+e0sRnIf5RdVA0=
X-Received: by 2002:a05:651c:1992:b0:2fa:d4c1:3b5d with SMTP id
 38308e7fff4ca-2fae1013c02mr6063641fa.11.1727812209176; Tue, 01 Oct 2024
 12:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001194854.3186216-1-luiz.dentz@gmail.com>
In-Reply-To: <20241001194854.3186216-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Oct 2024 15:49:55 -0400
Message-ID: <CABBYNZKmxnB=QK7REZvoT-32uH3Oy8SwgP+Ars8ok6ZD-HjvLg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="000000000000f792fb06236fa039"

--000000000000f792fb06236fa039
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Tue, Oct 1, 2024 at 3:48=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes use of disable_delayed_work_sync instead
> cancel_delayed_work_sync as it not only cancel the ongoing work but also
> disables new submit which is disarable since the object holding the work
> is about to be freed.
>
> Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d465
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/sco.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index a5ac160c592e..f0604d7834df 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon, int e=
rr)
>         }
>
>         /* Ensure no more work items will run before freeing conn. */
> -       cancel_delayed_work_sync(&conn->timeout_work);
> +       disable_delayed_work_sync(&conn->timeout_work);
>
>         hcon->sco_data =3D NULL;
>         kfree(conn);
> --
> 2.46.1
>


--=20
Luiz Augusto von Dentz

--000000000000f792fb06236fa039
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v1-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v1-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1quropw0>
X-Attachment-Id: f_m1quropw0

RnJvbSBhNDE4NzU4ODVlYjdmZWUzZDY1NDc5YTcxZTg1Njc2Njk5YWZiODIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMSBPY3QgMjAyNCAxNTo0NjoxMCAtMDQwMApTdWJqZWN0
OiBbUEFUQ0ggdjFdIEJsdWV0b290aDogU0NPOiBVc2UgZGlzYWJsZV9kZWxheWVkX3dvcmtfc3lu
YwoKVGhpcyBtYWtlcyB1c2Ugb2YgZGlzYWJsZV9kZWxheWVkX3dvcmtfc3luYyBpbnN0ZWFkCmNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYyBhcyBpdCBub3Qgb25seSBjYW5jZWwgdGhlIG9uZ29pbmcg
d29yayBidXQgYWxzbwpkaXNhYmxlcyBuZXcgc3VibWl0IHdoaWNoIGlzIGRpc2FyYWJsZSBzaW5j
ZSB0aGUgb2JqZWN0IGhvbGRpbmcgdGhlIHdvcmsKaXMgYWJvdXQgdG8gYmUgZnJlZWQuCgpSZXBv
cnRlZC1ieTogc3l6Ym90KzRjMGQwYzRjZGU3ODcxMTZkNDY1QHN5emthbGxlci5hcHBzcG90bWFp
bC5jb20KQ2xvc2VzOiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9NGMw
ZDBjNGNkZTc4NzExNmQ0NjUKU2lnbmVkLW9mZi1ieTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8
bHVpei52b24uZGVudHpAaW50ZWwuY29tPgotLS0KIG5ldC9ibHVldG9vdGgvc2NvLmMgfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9uZXQvYmx1ZXRvb3RoL3Njby5jIGIvbmV0L2JsdWV0b290aC9zY28uYwppbmRleCBhNWFj
MTYwYzU5MmUuLmYwNjA0ZDc4MzRkZiAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9zY28uYwor
KysgYi9uZXQvYmx1ZXRvb3RoL3Njby5jCkBAIC0yMDgsNyArMjA4LDcgQEAgc3RhdGljIHZvaWQg
c2NvX2Nvbm5fZGVsKHN0cnVjdCBoY2lfY29ubiAqaGNvbiwgaW50IGVycikKIAl9CiAKIAkvKiBF
bnN1cmUgbm8gbW9yZSB3b3JrIGl0ZW1zIHdpbGwgcnVuIGJlZm9yZSBmcmVlaW5nIGNvbm4uICov
Ci0JY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZjb25uLT50aW1lb3V0X3dvcmspOworCWRpc2Fi
bGVfZGVsYXllZF93b3JrX3N5bmMoJmNvbm4tPnRpbWVvdXRfd29yayk7CiAKIAloY29uLT5zY29f
ZGF0YSA9IE5VTEw7CiAJa2ZyZWUoY29ubik7Ci0tIAoyLjQ2LjEKCg==
--000000000000f792fb06236fa039--
