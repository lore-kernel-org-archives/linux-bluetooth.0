Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793640234;
	b=QkLcsd765RF316AED/Bh+dzb5wK9fKspmr0mecWtir/1Ble43Nooylza4uoNqzE6HYje
	 fNPBwlgbX+nH+ZCyP3j8kdyqS0zSNzhUzqZWVZiBucBbGPh+cy0okd4bGClehOVrjUnWc
	 f6HzRA0xy14Qu10x/bLDXe2qGW7Flrpz+xbhXca6gRyHY2ML9ArhTQIJvkoVAz9UXOBQF
	 K6X5IQ76z2w/KpGZq63q7qXOQIsA8m+B5wlNTK8en+5uhiEiVHgF0GSFF6lE+4nyrlDgX
	 HUkPq5rIwqGYMxaPJw7whxZUrViJqPGUgEO5wqCrQyiasGka43j1g8ua6lPg45x+NOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NMhcwYj2Xh/UOAJWDcUbdWHHqi6JZzcb5fNLyhXGooE=;
	b=UD0exku86B0w3go+Jkts9hVCOEzDvorqN14jKcdQCiwKKrSsPBe63lTCFeNGGAN8Jc8n
	 uRlFEPVVo1XuO1bmmdMF4MW0BRcB1QnmD40KfZYScbP2lFS2cueK2QAPhfoG8NgaI6XUc
	 rmDZ5kdBsqci06P/HMT1OW5obxSwVDa1q0OiUfiEF2JYrcEinI9pD3lcp1ovD2rxKLW2x
	 FPLa1pqrTU7oYNd/WOhJil6yuZwhZisyZxdE22Bu91Y7UdFPgfhrNXh+EUtGog6UvhH8D
	 6zMwXKR+F1Mh+BOv5FJVDPC+hbIXulCXMlNrrFzVL6XopEe2hQmYc9yC+HvvhPbPkog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dX25uZ9p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE8606B1F2
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 17:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBBE8606B1F2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dX25uZ9p
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b125371596so31905987b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 09:23:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793640233; cv=none;
        d=google.com; s=arc-20260327;
        b=JdqfJK+bUTZlpnmVt1QNlBETJ90FoX3pTRO73PH/xZk1ypFhaAF03ej8LRAno5Bnqm
         J+3uHlar9xstJJ+LEmDV2mWhk0PlpO6vLJVcXiCpA6S3Ux9Bi6wUFjXKaCgthGWcXjiZ
         391F3gcuoI/dA/RzabG6QuLZ+dRWP2JAwZeia3fBOyPu4mYQdyFmHZxadEsz81VxjQGO
         IZrhCO4dfps7FeBJ8XE48RDy08/ZYFV8Zne+q9kg+V74L4Phj+WDPInqMOwjmM4JgvCe
         N/2o5cP51nHdGSHpdDOjfHeZ60tBYc7Ykn05aovrOISCboxkjODURDhfhV+1mddHi+Wk
         GsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NMhcwYj2Xh/UOAJWDcUbdWHHqi6JZzcb5fNLyhXGooE=;
        fh=WhsrwV6Uv/IfMsJNIu+ATg8ue0U4mHVMqaKXa2wcojs=;
        b=dNTBvGA63HCZCIDR0skNEtIwnX24dMJHwIiAio7Kti5ylRKawK5lQwmV2wX1HNB3xD
         dQ5hUOtI/qtq+8l4gvjLvG1r9X9XyzJMB0KtcRE2gxzou+cjKrFBiAQgIv+mnaz7XdPo
         pq1i4Qoo/XPFYrf5lX0wj2RSZgynOWfGVJsf3vt6wD8YVx+8a/wur4FnTzZ55D/9Q3Pc
         f/tVnnItUvllrH3N9q97yTThS0UctCVB7qV+09OYue/4wV5xLP1bW2a5XGlvRZz+nu+M
         xQlUF5rfK5JN8m48V6UU1+I012w+eai27ZHzAkMHgxJWngGyagaaSB3EUotM9gf1B8Ui
         4t4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793640233; x=1794245033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NMhcwYj2Xh/UOAJWDcUbdWHHqi6JZzcb5fNLyhXGooE=;
        b=dX25uZ9pIkkqcjmo435YVPxJeGtnfY4yJ2W54a/zE7wS9zMtPmWIjGD4u39ixssJpX
         SzcMCKGAMJTFzbw59DQtDhFN+oa4KgARxyyl0edL4jIFEmsvbQivmzxkgTwfyd2JVjym
         lQ0STAe4TqSjk9r7fLaqfXEW79F1ZtvOGIE25U7kC4Gizj/MVotauiaPyy0xG7P66PR7
         b/Mj8wQvLlxtMS1VcROMbCNSOJ4uHzDkdUebm9Qm6zDNlwRMFDQWUA8tTlGSkp3DaYIG
         /oeJksrMMJ2F7++F9++67FzOz3CrYLBFc4g/PKxSOyNQSU6lPe/fdsxXJ04KA0bl58jO
         Sfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640233; x=1794245033;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NMhcwYj2Xh/UOAJWDcUbdWHHqi6JZzcb5fNLyhXGooE=;
        b=B+A1BskyOxLoq4jmilNsNOuUupgo5kcWoArWOxgZJzb7HLWmJ1VthpZnoiffLg1xnQ
         6e+6YaXKdD6ybLe1hZN0Sh+qLbYQUh7qXASg9p/w5rGVIjkv3H+Qz2CY5LBXniFdLcY9
         U7dS+Jsb5wIqGNxZVxMBJ2I97tmrP132jH0G3Kv3j32udNiWWDX8VQ8KTvG/X2Nic+7H
         OEgOpusZi5D2NjQt85667Cdi3+eZMwXfRAlsxNvyKV/cssCAbVnIwN+PQ+Qu3T1lk3Mf
         VtKkGDgaWMOLo4OxuR8eae/cdwXuWR4rD83gyw3eMwqZ0A3aT3aAQu6X6m8X0Zf/DIIp
         ymgw==
X-Forwarded-Encrypted: i=1; AKwUvBz9gIhgysHq5Q02/Nhs3/eS154c8Mf5yNRLl/o1v0T1FwhliB8ES1imLc/PgxOSluKyKuktRRjoZXAHjrmFzQU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rtzCoC/bG6wah3GFb25NaE40Dip24ToqQarRgQT7RMuIqiXOy
	6qjb9xc4/looh/WJxnfLxXVyu9ExdqXWiw2ZgDeqhXJ/43lndXZtp2lVbdLCg///nW3NUMVUVXV
	BTRSX7nA3GNWRuLmmp8y4/YNpLxQ3IR4=
X-Gm-Gg: AYBFou0racvSshngJLfA9opc3HQDVqSdrZSe8xctESwmMYBiKnpyZVxDtmpIx5OGaD4
	D3u+A/Qiw1KrUNqfmBd5ThRGzwybMOhtaQNyMSsIyA3Qk/t5R9Iy2/Vymdff9Pd0LOzw3sFi2x6
	fTMKUZByb32X/fbT2Mk9lvsYBurxSXBDACzqrvHhX6arCO2DLzYuQpx5ZEbf8zknMKkLQyXe/e8
	xLy0XtRYDeqMy7HDoHB1SA/H9pfpf2+ff3u8eVUjfEl3ItaBsJfhrEZRz0t55pc1BA1tdArVtxW
	zSz5570OlGfGwHCHMqjFUuyO6wgsUt1q0CUiyga9FYTEoXBMwawkYcJ/UHRqO8UuvcxAHH6H5U1
	IVa07Jy5R2mVdwLlTAfiWLdE8vcGkHAKwd/X+fNA6h8Z82oG/VTAvJC+4HBIRxr7cRWqjqhkdkV
	B3Z5MefwNwzPNHSgoNG1aLcwdII2JiZXpjzeFd5PkEoJcp5yKvA6PpEnY0
X-Received: by 2002:a05:690c:18:b0:8b0:cd32:b8dd with SMTP id
 00721157ae682-8b1c6701c87mr107024787b3.17.1793640232900; Mon, 02 Nov 2026
 09:23:52 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0@gmail.com>
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Nov 2026 12:23:41 -0500
X-Gm-Features: AclHuK_r4gnQOsHGOoSkBL1i_04hLRUt4HfVTAlG6GDJlX3jWkppFW4bRVX-7AA
Message-ID: <CABBYNZ+-DMvdpQPTMfR806ZaBx053kg_00q7kz3WCTucziQDxg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Bluetooth: SMP: Serialize root channel updates
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Sat, Oct 31, 2026 at 3:32=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com> wro=
te:
>
> The SMP root channels in hdev->smp_data and hdev->smp_bredr_data are
> used by HCI event processing under hdev->lock and by SMP receive
> callbacks on hdev->workqueue. Power-off already removes them under
> hdev->lock in hci_dev_close_sync(). Two other writers do not serialize
> with these users:
>
>   1/3 The force_bredr_smp debugfs switch creates and removes the BR/EDR
>       root without hdev->lock. A connection confirmation can see a root
>       whose operations are not set yet, and a disable can race with
>       power-off and release the channel twice. Take hdev->lock in the
>       writer, and skip the deletion when power-off already emptied the
>       slot.
>
>   3/3 smp_register() replaces both roots when management powers on a
>       controller that is already up with HCI_AUTO_OFF set, while HCI
>       event processing and SMP receive callbacks can still be using the
>       old roots. Run the registration on hdev->workqueue, where it ran
>       before commit 2ff13894cfb8 ("Bluetooth: Perform HCI update for
>       power on synchronously"), and hold hdev->lock while it replaces
>       the roots. The caller waits for the work with the request lock
>       held but not hdev->lock, which HCI event processing on that
>       workqueue takes.
>
> Patch 2/3 makes that hold for every caller: hci_power_on() runs the same
> power-on update for a controller in the HCI_AUTO_OFF window, but has
> done so without the request lock since commit cf75ad8b41d2 ("Bluetooth:
> hci_sync: Convert MGMT_SET_POWERED").
>
> smp_register() still warns when it replaces the channels on that path.
> This series only makes the replacement safe.
>
> Cen Zhang (3):
>   Bluetooth: SMP: Serialize forced BR/EDR channel changes
>   Bluetooth: hci_core: Hold the request lock for the power-on update
>   Bluetooth: SMP: Serialize root channel replacement
>
>  net/bluetooth/hci_core.c    |  3 +++
>  net/bluetooth/hci_debugfs.c |  2 ++
>  net/bluetooth/smp.c         | 38 +++++++++++++++++++++++++++++++++++--
>  net/bluetooth/smp.h         |  3 ++-
>  4 files changed, 43 insertions(+), 3 deletions(-)
>
> ---
> Changes in v3:
> - Address the hci_power_on() path that reaches smp_register() without the
>   request lock, raised by Sashiko: https://sashiko.dev/#/patchset/99158
> - Add patch 2, which takes the request lock in hci_power_on() again, and
>   correct the locking description of patch 3; the code of patches 1 and 3=
 is
>   unchanged.
>
> Changes in v2:
> - Address the CheckPatch and GitLint long-line failures reported by the
>   Bluetooth CI: https://patchwork.kernel.org/series/1197223/
> - Trim the crash reports in both commit messages to the headline, call tr=
ace
>   and allocation/free stacks; no code changes.
>
> Link to v1: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184=
-v7-c26e53b52c260063ab6a-0@gmail.com
> Link to v2: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184=
-v8-60106ad0c49170f5bfb4-0@gmail.com

netdev sashiko instance found a couple of problems with this one:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-bluetooth-objects-ca=
ndidate-0184-v9-4094fa28af7bd56a283a-0%40gmail.com

--=20
Luiz Augusto von Dentz
