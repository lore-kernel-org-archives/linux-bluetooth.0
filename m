Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96FF1D0F58
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893628; cv=none; b=SCeU5BN919dOagESJGhqyPy9FU5vs3zOZtFmwlyldF4zbUcuNDYYlGr3rb6q/BaWSQAKhzzvZamHwAqVQWfm1+a12z9bJc13d8A3sHerD+SDW4Luj6C9/78IS5BMxbucr3zOB2m8oHgkF74bDOytGMWQsOc1bHVxiIYD/i36usg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893628; c=relaxed/simple;
	bh=oqsUzWncR0dzlB5DuzzzFIlAOwld4xyzkjPQChHVWC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnwXrzpEM2K6RNpkgKJOsXWD22vgd/DE2a0YhS/Tya8sGMYIrbM8xFaRW0JRadoSRQE8DBlXWRgeqcQcGCy1pr+rXC2qKQk7dL7zEuiyF890hCiQLK+V7KCD10PdcsSTsWsHet5yABvsKcx71k15Mue2ccdc+Lls2SldkmRQkK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3Fu4XYA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3Fu4XYA"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2faccada15bso1146231fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2024 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727893624; x=1728498424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=By+RNCYVHuKygTX5g/xUnly5jy7CMFsRzGGDBAYM6Wg=;
        b=L3Fu4XYAvU5M9e/drjCRIBoSP5MHWlblnlgXmkvCJcu2YpJWyHSzXi937Rq0bj4U1X
         mfZOLIbbjHBgqW3Xe4VIrpZlxttg+Qzn4J0GBwBvdV7ovyzM/YuXK6OjNQ3zJx21l5Ng
         lPMZ+nUhDyEz3+S1KQmfQBAGSsZagd9Tci+u8bW4+ZZSG8XAWf3KyHu7+r5u8adJXpJZ
         ODkyyw3hYn7i4jKOaFQCWQfgQDozK+MnWwoYrTU1yUEPuQsQ0HrGTJxlaJCHD6W9TSnA
         FjnE2hnM8RxAHCTSe3gBkCRFWTFEmEd65IhdbYgoSYEwn7U+gnt5QvLvTz9h51aruEpj
         1p6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727893624; x=1728498424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=By+RNCYVHuKygTX5g/xUnly5jy7CMFsRzGGDBAYM6Wg=;
        b=hPHvxfzHj2aD6SjlXCI9Hnh2RXOxbpoyO9KXeSp9IX2DOpuWWrVPMRtjFUyT8rhPDu
         cW+YfcZMzfYfEtgeJdeLndvNg5zgYnoCGTQ+/CxUFJmopKu7CfxL8q3bBlrraIbXXB4y
         f/VQ5qKU//WOIBJEEZk2ROQVnznM8F2a9RbBZ7pb92Y5gRPJxh2ONFXRFxM7IrKkvlIt
         f0+1PIjh/HUQZJY5/h6cVrqXYDZtjU7eSlaK1l6s8OSwx5uI+Kft9hZQzeOJzF9+IUUK
         IE1r8j11yaSOK5vTDFQYgK2giIgJSiJpL6yMdvalI6IODxx6J/6dVcRhuPKcD+giM7rX
         XJQA==
X-Gm-Message-State: AOJu0YxsuhZWeA1OeGWi9V03MtylKJtx7prw9Innnus7eb2AslEWSNfN
	kpF07D+QJWLoJlBazCEo0UDySUCcf+gDqhTyU1pG7CpYHZQGwe/frwwlGGT8tgGUfpH1acaxTqP
	iUd0VuiHrLVtTWCjigpMSC7pk8n3M/Q==
X-Google-Smtp-Source: AGHT+IF3TpYY4u+U9MOEFfPsTIz2E7FEhP4dQxxsaOQHX3/ouwkxVGguaWE7WD8n5UdEb6usQw61NKHRx7nJxIAnkV8=
X-Received: by 2002:a2e:701:0:b0:2f9:c337:aca9 with SMTP id
 38308e7fff4ca-2fae10e864emr21212311fa.44.1727893623678; Wed, 02 Oct 2024
 11:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002154034.3359675-1-luiz.dentz@gmail.com> <20241002154034.3359675-2-luiz.dentz@gmail.com>
In-Reply-To: <20241002154034.3359675-2-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Oct 2024 14:26:50 -0400
Message-ID: <CABBYNZKvkU59_bpzxd0fKMsDkhhSWiE41bF83ycP1FMXiMqeEg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="000000000000a6705406238295e2"

--000000000000a6705406238295e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Wed, Oct 2, 2024 at 11:40=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes use of disable_delayed_work_sync instead
> cancel_delayed_work_sync as it not only cancel the ongoing work but also
> disables new submit which is disarable since the object holding the work
> is about to be freed.
>
> In addition to it remove call to sco_sock_set_timer on __sco_sock_close
> since at that point it is useless to set a timer as the sk will be freed
> there is nothing to be done in sco_sock_timeout.
>
> Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d465
> Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work"=
)
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/sco.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index a5ac160c592e..8dfb53dabbd7 100644
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
> @@ -444,7 +444,6 @@ static void __sco_sock_close(struct sock *sk)
>         case BT_CONFIG:
>                 if (sco_pi(sk)->conn->hcon) {
>                         sk->sk_state =3D BT_DISCONN;
> -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
>                         sco_conn_lock(sco_pi(sk)->conn);
>                         hci_conn_drop(sco_pi(sk)->conn->hcon);
>                         sco_pi(sk)->conn->hcon =3D NULL;
> --
> 2.46.1
>


--=20
Luiz Augusto von Dentz

--000000000000a6705406238295e2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v2-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Disposition: attachment; 
	filename="v2-0001-Bluetooth-SCO-Use-disable_delayed_work_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1s78meu0>
X-Attachment-Id: f_m1s78meu0

RnJvbSBhMmRiZTE4ZDY2MzA3MzIzODUxZDE5YWNkYWUwZWQxMGM2ZWRiNzJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMSBPY3QgMjAyNCAxNTo0NjoxMCAtMDQwMApTdWJqZWN0
OiBbUEFUQ0ggdjJdIEJsdWV0b290aDogU0NPOiBVc2UgZGlzYWJsZV9kZWxheWVkX3dvcmtfc3lu
YwoKVGhpcyBtYWtlcyB1c2Ugb2YgZGlzYWJsZV9kZWxheWVkX3dvcmtfc3luYyBpbnN0ZWFkCmNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYyBhcyBpdCBub3Qgb25seSBjYW5jZWwgdGhlIG9uZ29pbmcg
d29yayBidXQgYWxzbwpkaXNhYmxlcyBuZXcgc3VibWl0IHdoaWNoIGlzIGRpc2FyYWJsZSBzaW5j
ZSB0aGUgb2JqZWN0IGhvbGRpbmcgdGhlIHdvcmsKaXMgYWJvdXQgdG8gYmUgZnJlZWQuCgpJbiBh
ZGRpdGlvbiB0byBpdCByZW1vdmUgY2FsbCB0byBzY29fc29ja19zZXRfdGltZXIgb24gX19zY29f
c29ja19jbG9zZQpzaW5jZSBhdCB0aGF0IHBvaW50IGl0IGlzIHVzZWxlc3MgdG8gc2V0IGEgdGlt
ZXIgYXMgdGhlIHNrIHdpbGwgYmUgZnJlZWQKdGhlcmUgaXMgbm90aGluZyB0byBiZSBkb25lIGlu
IHNjb19zb2NrX3RpbWVvdXQuCgpSZXBvcnRlZC1ieTogc3l6Ym90KzRjMGQwYzRjZGU3ODcxMTZk
NDY1QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KQ2xvc2VzOiBodHRwczovL3N5emthbGxlci5h
cHBzcG90LmNvbS9idWc/ZXh0aWQ9NGMwZDBjNGNkZTc4NzExNmQ0NjUKRml4ZXM6IGJhMzE2YmUx
YjZhMCAoIkJsdWV0b290aDogc2NoZWR1bGUgU0NPIHRpbWVvdXRzIHdpdGggZGVsYXllZF93b3Jr
IikKU2lnbmVkLW9mZi1ieTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei52b24uZGVudHpA
aW50ZWwuY29tPgotLS0KIG5ldC9ibHVldG9vdGgvc2NvLmMgfCAzICstLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9ibHVl
dG9vdGgvc2NvLmMgYi9uZXQvYmx1ZXRvb3RoL3Njby5jCmluZGV4IGE1YWMxNjBjNTkyZS4uOGRm
YjUzZGFiYmQ3IDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL3Njby5jCisrKyBiL25ldC9ibHVl
dG9vdGgvc2NvLmMKQEAgLTIwOCw3ICsyMDgsNyBAQCBzdGF0aWMgdm9pZCBzY29fY29ubl9kZWwo
c3RydWN0IGhjaV9jb25uICpoY29uLCBpbnQgZXJyKQogCX0KIAogCS8qIEVuc3VyZSBubyBtb3Jl
IHdvcmsgaXRlbXMgd2lsbCBydW4gYmVmb3JlIGZyZWVpbmcgY29ubi4gKi8KLQljYW5jZWxfZGVs
YXllZF93b3JrX3N5bmMoJmNvbm4tPnRpbWVvdXRfd29yayk7CisJZGlzYWJsZV9kZWxheWVkX3dv
cmtfc3luYygmY29ubi0+dGltZW91dF93b3JrKTsKIAogCWhjb24tPnNjb19kYXRhID0gTlVMTDsK
IAlrZnJlZShjb25uKTsKQEAgLTQ0NCw3ICs0NDQsNiBAQCBzdGF0aWMgdm9pZCBfX3Njb19zb2Nr
X2Nsb3NlKHN0cnVjdCBzb2NrICpzaykKIAljYXNlIEJUX0NPTkZJRzoKIAkJaWYgKHNjb19waShz
ayktPmNvbm4tPmhjb24pIHsKIAkJCXNrLT5za19zdGF0ZSA9IEJUX0RJU0NPTk47Ci0JCQlzY29f
c29ja19zZXRfdGltZXIoc2ssIFNDT19ESVNDT05OX1RJTUVPVVQpOwogCQkJc2NvX2Nvbm5fbG9j
ayhzY29fcGkoc2spLT5jb25uKTsKIAkJCWhjaV9jb25uX2Ryb3Aoc2NvX3BpKHNrKS0+Y29ubi0+
aGNvbik7CiAJCQlzY29fcGkoc2spLT5jb25uLT5oY29uID0gTlVMTDsKLS0gCjIuNDYuMQoK
--000000000000a6705406238295e2--
