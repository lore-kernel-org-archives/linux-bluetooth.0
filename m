Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040F31B838
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527126; cv=pass; b=qZvYNTMXRiCO7xMl9h6Xj1kDFXMNCVzWG/iyxtQGF2VVs7SNCKW6KIDMeFAPLwEpJk5yBcFfRtnX4P1lwdQ2+9pX+ulx6OHeuG05PqrrnVpgVOOZlZr7YMt5U3A1XKQx3nrsgD/uZ8DLJbcxo8PoEgGEy4X/5jA4pHA0ZYx2VzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527126; c=relaxed/simple;
	bh=cCUEjVyvXPjvenluJvof0R5NUdQ/rRfIEr0ztvApjrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smBVhqSbh58udnC8PIlDzubEht1+4h+TCbaCR5+5pVhOlAU087mIkuw5Z5cjYs8dbi8jedRBhtCFOLv8XmBG8gdZ8tP4knxR8dcA2HCecE3EjSuy1BUSFFZAPfG++33U5NYSkGnCXxWQmRZC7etLoIEQCoOveOtzjP1aKkMGXIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFIOj6sV; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFIOj6sV"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66899c7b57bso1890708d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 12:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785527124; cv=none;
        d=google.com; s=arc-20260327;
        b=czC0Rn0fN6VD49CTM3KSx7nRp8dX6NiGR+suMWMsWHDNaIqo2XTVkegWDMp9ECQ4/U
         /BvIBT8l200lvj+/tiNLGswudAwOtTPba0x0PigKy/z3PeATmDc3+5WD0R26B9ADSolX
         xQBmpLDno5ByM8OxkgX+5KIkAv5ngBMs5u0/ANhfgMgF2UkLEjg5mX7MYBEmi31znnr4
         HJQwBahcWrMRB+JQfRaf24VUF+QSqRfmZkyTTUUId2U1OjWZgkEYKbsmiDhIdbWrYuI0
         tMG9g/ESJDddf+jUuOyDcqC7Tuy8WBmbjr8zLBKc1SemPNgHtTRK008y9YitnbBQ4ee8
         nA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ve9Rf+D9HJudBq0CAbi6hRU06X7OxOvTtvFT36AgLrY=;
        fh=rxTrxiUM39Jum6iLJHCVZw2mYhD1eEJpeoDFUyMxsXo=;
        b=N6YjLJnb6NLCWKt5k+od/QT19Go0j4tCPe61k5EFfyPmdAVzTUWoXph9aeEdtbWLl6
         QvGu/ucO7HTqnBAq/rOd2zD3qQyiW4v6E559TYKiN/bJ120Hf7VF4XFzeFwzUFxebPqG
         MjYCBPUPUMX1pwdB8TSXsWxMKVfYj05kBdVeQUEDQU6SgHIf8NsAY4ue6o7D2kpANeuU
         ruUkwLZH4WswyTju3DCcju48YmJwNBS3XJSRO0+RRJUXL3/oz87AHYBhE5mrGgzKXdQW
         FpJz+fRZ1M+L8s4ox1VNfnWDWLbDi/vhQBNNmVnXwTDWQy9WGerSyRXbduIfBcwn4w+c
         OkGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785527124; x=1786131924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ve9Rf+D9HJudBq0CAbi6hRU06X7OxOvTtvFT36AgLrY=;
        b=sFIOj6sVeNl53K1Nq+W5kTM1570NXZa7ADIHWTAk7dfx7PIQ5ixYwiMMKrbpx8slgp
         DOSQKGZz4AigQ6rWLSe8k5tnWBhk5GXmHmE5+DdEeqAJ9+u5pnFKYO/b3oXTN5opkXtA
         gpbs8k4Ab7rgToMZqs3lYFjOGfi/Cuki/Rzrs0Jf5shfoByKTUm8wmZEBazDd82Z5DwA
         a4UTWWajdfI5IfHR+Uv57YxZOIvc1yJXdQ07Tfc4IUwRFDickdWE2UhXafxt/B9z50so
         dRw5VtDoXWUDx5Ef/G2iHyswvOdlsViwMLExCsFWq+GOqBM8CPE3FKtOHtmtWiMtymDl
         ucPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527124; x=1786131924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ve9Rf+D9HJudBq0CAbi6hRU06X7OxOvTtvFT36AgLrY=;
        b=hEt1RwSlPghURnxxyp9aR20hX9aoAKFrN+oZ1JcjsZ2rqvjcoByc5jpQ8Qm57LAhNI
         n08PRoYE69uusTCu2LHxiEseXvHqPq+bBjdr27Xv1kAy0MZv/WplSrtmqriOCYMfp1M6
         CbSr9wMxSiASR5hj2y5F0KMMNv5SpUknbT3/eRsao1Qnfn2UjsyCrOjV6FR6zX47i2mK
         stwv81gffRrxO3TSuPTcdTyyYI3RzdrE2lNDYJm7+QxD3EJrAow14pZ9AN0DfLQ8Az00
         lvF2YbVEVNI38u5oaj4q5WqN74eUfGnZ1Und/H/rDQecs6gvwWcmJr8xEeXoh9Y/X/W2
         liEw==
X-Forwarded-Encrypted: i=1; AHgh+RpqeiPq6DNcOaOvRuxUQSO3c2VFz2uJSEsPMJom4yIUDpqoJYQbENHqmkXLiOdkbMCUb63tkAZYMDIHb1aXEF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAKO6pcT5qon1dueM5L7hGUOuYPcOnR6b25Ty7hIIwpDclyKSy
	KPYM27zY/3qFX/a4QIxZ73UZTxQqltksbngx+uuQhv2idFesJbTeM5lxqVt38ct+mdShsDqc6GG
	hTsoIf+bBHhMDSEiyY3hhyIYjrqcbH40=
X-Gm-Gg: AR+sD13UsgP1VK8uuFY3cq6CyfwMG5s7HBgzI/hQ62S0lpCtuaYGXa6JykpD4AD3OR8
	Wth91GojF1jYAyKNEbbzWgtbME6AjSEldbRbppB5R6QVM5JYz2rXXRtdFj8udNgQyiyN2kco5ps
	UaYeUquzuvzyFxiZrkyuVpnbrdGNV07KOVF6LHaaQuWROaCu7d+Hkrbp53bwxLr9DmQjmuK0zl6
	d5dNs2VSs8fQ43Qyf3agafw+47OcMDWq7uVjC7C7s/j+OI/aupus+dQjdxnDGS+6xP+00eq/q7E
	MYGnnPBCHLXRg4MfhRVP747zu7AEoPf18zwalT67k5HbCTF+vnPzzLSD5pFd0WCX4TrHuo30dS+
	q2+5lTkixsG6EjzDPflgija9CDkskJvgfySo=
X-Received: by 2002:a05:690e:4403:b0:667:f3d7:eb35 with SMTP id
 956f58d0204a3-6694efe0e97mr1089162d50.6.1785527124099; Fri, 31 Jul 2026
 12:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730092331.2069741-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260730092331.2069741-1-nicoyip.dev@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Jul 2026 15:45:12 -0400
X-Gm-Features: AUfX_mz6mvXtIkPFddN4aW93kRtgDysqoRVhdaYPe9M0YLfqc630_fEbIBqs7bA
Message-ID: <CABBYNZKgxz4JbKv8fgTeWGEGV0P_pPmcy_YG=rLDroc_1wu==g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix accept list UAF during suspend
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengfeng,

On Thu, Jul 30, 2026 at 5:23=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> hci_update_event_filter_sync() walks hdev->accept_list while sending a
> synchronous HCI command for each remote-wakeup device.  The suspend path
> holds hdev->req_lock, but accept-list updates are serialized by hdev->loc=
k.
> Consequently, remove_device() can free the current list entry during the
> controller wait.
>
> The following interleaving causes the use-after-free:
>
>   hci_update_event_filter_sync()    remove_device()
>   fetch accept-list entry
>   hci_set_event_filter_sync()
>     wait for controller response    hci_dev_lock()
>                                     list_del()
>                                     kfree()
>                                     hci_dev_unlock()
>   read the freed list.next
>
> KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in hci_suspend_sync+0x835/0x910
>   Read of size 8 at addr ffff88810bec8440 by task kworker/0:1/10
>   Workqueue: events vhci_suspend_work
>   Call Trace:
>    hci_suspend_sync+0x835/0x910
>    hci_suspend_dev+0x182/0x450
>    process_one_work+0x661/0x1090
>    worker_thread+0x45b/0xd10
>
>   Allocated by task 86:
>    hci_bdaddr_list_add_with_flags+0x1a8/0x400
>    add_device+0x381/0x820
>    hci_sock_sendmsg+0x1033/0x1ea0
>
>   Freed by task 91:
>    kfree+0x131/0x3c0
>    remove_device+0x429/0xb70
>    hci_sock_sendmsg+0x1033/0x1ea0
>
> Snapshot the remote-wakeup addresses under hdev->lock.  Release the lock
> before sending HCI commands.  This preserves list order and avoids
> retaining an accept-list node across a controller wait.
>
> Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/bluetooth/hci_sync.c | 38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c0b1fc293b49..540da19d1d64 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6250,6 +6250,8 @@ static int hci_pause_discovery_sync(struct hci_dev =
*hdev)
>  static int hci_update_event_filter_sync(struct hci_dev *hdev)
>  {
>         struct bdaddr_list_with_flags *b;
> +       bdaddr_t *accept_list =3D NULL;
> +       size_t i, num_entries =3D 0;
>         u8 scan =3D SCAN_DISABLED;
>         bool scanning =3D test_bit(HCI_PSCAN, &hdev->flags);
>         int err;
> @@ -6263,26 +6265,48 @@ static int hci_update_event_filter_sync(struct hc=
i_dev *hdev)
>         if (hci_test_quirk(hdev, HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL))
>                 return 0;
>
> +       hci_dev_lock(hdev);
> +
> +       list_for_each_entry(b, &hdev->accept_list, list)
> +               if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
> +                       num_entries++;


If !num_entries we can probably bail out here, or we do need to call
hci_clear_event_filter_sync? If so, perhaps that should be called
first.

> +       if (num_entries) {
> +               accept_list =3D kmalloc_array(num_entries, sizeof(*accept=
_list),
> +                                           GFP_KERNEL);
> +               if (!accept_list) {
> +                       hci_dev_unlock(hdev);
> +                       return -ENOMEM;
> +               }
> +       }
> +
> +       i =3D 0;
> +       list_for_each_entry(b, &hdev->accept_list, list)
> +               if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
> +                       bacpy(&accept_list[i++], &b->bdaddr);
> +
> +       hci_dev_unlock(hdev);

While this works, iterating twice if there are no entries is wasteful;
we should bail out or rework this.

>         /* Always clear event filter when starting */
>         hci_clear_event_filter_sync(hdev);
>
> -       list_for_each_entry(b, &hdev->accept_list, list) {
> -               if (!(b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
> -                       continue;
> -
> -               bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bda=
ddr);
> +       for (i =3D 0; i < num_entries; i++) {
> +               bt_dev_dbg(hdev, "Adding event filters for %pMR",
> +                          &accept_list[i]);
>
>                 err =3D  hci_set_event_filter_sync(hdev, HCI_FLT_CONN_SET=
UP,
>                                                  HCI_CONN_SETUP_ALLOW_BDA=
DDR,
> -                                                &b->bdaddr,
> +                                                &accept_list[i],
>                                                  HCI_CONN_SETUP_AUTO_ON);
>                 if (err)
>                         bt_dev_err(hdev, "Failed to set event filter for =
%pMR",
> -                                  &b->bdaddr);
> +                                  &accept_list[i]);
>                 else
>                         scan =3D SCAN_PAGE;
>         }
>
> +       kfree(accept_list);
> +
>         if (scan && !scanning)
>                 hci_write_scan_enable_sync(hdev, scan);
>         else if (!scan && scanning)
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
