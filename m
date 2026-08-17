Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851644237C
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976950; cv=pass; b=dAVQzGpy6MiZvMkB/78QoYopsG5J8NsXrsNgM98h00uscoQmIuUIigN0fSC4Fij9Eg2+yuWpDmKAba/QvNgpmatqk8gc/s0+9CZyfmDmq8fd4kCzn4w4b5z33hdVT43Oe1fhdN8zcUCRfoZAbXKK2Ji7cXITVbizy0s+/IanBpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976950; c=relaxed/simple;
	bh=uTPowtAM7GCKiHoH8OLA6wXDqpX6ayqhBGaRLKzR7IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXHZX/EVpfazXaiGOulK37Wzh4PLVvGkD3b6VG7fgGUmUJ6g/OProSD4h1Jryue61wx9Nm68fo3QzdTi9I0MLzwvdfTAMS3qKVoRNL07oZ885BfWRs5vs+DzfAcamO4rqgM5vGp6BQnpp1m6ovMpD8lEb3SMUEoH51aMi3wXTPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLTawrlV; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLTawrlV"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66cad42593dso859983d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 07:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786976948; cv=none;
        d=google.com; s=arc-20260327;
        b=f2OsvJgy3F/3jpC4BUpHmRL/p5czq8eDYtpSe9bU+W+7dPFxm6kQqmPLVU1Mmwh2R7
         kg0W14G8M1Io4Poe72IFJcc1apa8SY+I22FOClJPOEdNJ8kGyiEgNWpS7rMtEK74v4jT
         tCluqjjwo0dJi0aJae3EiGz8dw4sd5i4kcFE6+D8D6zqRm3FktrN6z+vuVqaU0re9s7M
         0c1YmJXjGF3zyxoJA/CnJfPXbjfEm4hqJJlZESb2EvHNLb37Ub8d3QF33QTBwT0U9rK7
         yD9gXyV+KkJ4RwXZShSTADVaVyoP3wuShekhesNImChkS7P7caxy7vl+g4jANYA7f53i
         ZTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q3EnwwPsDPP7x0Rshg4nAQC1XvkCJekZphmSiSBDaaw=;
        fh=kvO6HdwHiQWru/rF6FwqtiYHPquTrGaZAnx3zsD5urY=;
        b=lKfMRsu/kstuk5EHG3i2/v3uVjHNFVWljl6YirT6O0XCHGCluYxMI/0g+1g/u1eCuA
         A+F/xPvon9FY5+eFWoazX+Gf/zMLTbBaZi8gaQE21xrAawkZUMptTCDpZ61LClpdhVMs
         grNLojnpjOmOyD4v9wXb6cUUyAcjp9yG6+oS7WnlF4Iaux5DT+k53sKG3SJd0m6xHD4U
         VGjZk/y+juCyOd7rcshVkUMyYA0EdLW/tTuK/FNgCgvzt/sOsU0UDrMG+iOHK0ytgGXZ
         5IqTHWw2/igGixaqasZOEW68HaaLcFpZL9D3CNO3+yVCn3QQB62xXP7/498PfdXij234
         wDnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786976948; x=1787581748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q3EnwwPsDPP7x0Rshg4nAQC1XvkCJekZphmSiSBDaaw=;
        b=ZLTawrlVe+OMCEh/cBRM7D1hEsSeGm0RDKlLxDiyGuA2xsYUfYfs1SabkYsWPxfF67
         5mCQbajrJ3QJ5MUI+7i7DJpBnu3nxJpbH1w8uELJgAr19HpoLtcSCLscElv4Hlg565vA
         bA9dXPuyRElpxb8vbeCyiy9ME9l/xk0WBCT6aw2hdM/Za6tY9vNbxJ+obvNDrH7pj7Xu
         sTZmWj5f5zW6su8sa67SGcmSWLUtdNDdlfGjbSi06wVIixhtzen1SJBw/zdu5B4vAcoF
         Ef08qFqtcbJlyENqFT35x6QFdbzO7VhcPQFj2RLzV36lgDkBXD034YLD7zMTpxr2/tsX
         VuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976948; x=1787581748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q3EnwwPsDPP7x0Rshg4nAQC1XvkCJekZphmSiSBDaaw=;
        b=jvw4VIHkMZbrKclZyB86CsO9TJrMiVcqEb3i8bF3wD078dpxT4IX7uSabrzVVFZvg0
         439dRqPjddJkMsHkBkgWgsc3Kugprzo+F0K8OzRkzYJLnQHod5ImMDrhH1t76YusFUcO
         6lVqkgFNLUT78t+Lbw7/51Zf1DVWmj/F5EWU6R4lyuhjri0d/CvOs2WU26vJF1aIBt4J
         4LX274snGBtfAAWeuXSPAXKObyihEWVN18rHInNt5F1ibo53ZVHbS7MiP+vqagmjou+a
         kMisaRgUaMUVXrinZxCXbVR0zcCUc9D4H77P5kLyD6mHlI/4aCIQ2NMqh51hciisnkus
         Duug==
X-Gm-Message-State: AOJu0Yyb6ft/sLlfxraVTb6FLadWsHblutFYmmTH81v3reotcsnNtm9u
	Fq4ccRC7tAu8bOaotRmL36v4sxLV0hLexCEF7IwuxdRRQm0dchylf9n7SIODmRDIyBsmmogKJgu
	FEyXUr8xbs1R47kgOC6b+nIqPVlfS8g0=
X-Gm-Gg: AR+sD11+/hlNFU8xSw6V1hFDodLffhVnVIon87oCxMNpGxAV3+FIQE3yCCShmbLpHMi
	xkaXHhsqDyuJuA7QOmCVPorD543AV+hPm5thdPUz7m0NSgAFQZmJ4jk7Lf4zG67rou7TJkUuRF9
	2liqje6ARvR8yN4XwTd5XeTuiFREahIaM6HQthWtxpvhtDLujTJFqYu3UvWntR0ACHyP0WRJfr5
	WNWK4dZwYBqm7wKFkNbsJZ8febcTNpoqe1g+kXWyR0IcmzZYqZ1RJmIjokwX7oPPAiOWjL36VDd
	+4AjnujQNxsKG/Uuju4RUHg0lgv8Nm6rt2m3J26VOHZ0OA7vxpaFJ6dgBoe5GdczxFQBsYEt3RJ
	erBAEMi6GiHByRwVPep+7/dwN7lY3
X-Received: by 2002:a05:690e:138a:b0:667:debe:494f with SMTP id
 956f58d0204a3-66c8aa23518mr5106120d50.44.1786976948082; Mon, 17 Aug 2026
 07:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786092373.git.edragain@163.com>
In-Reply-To: <cover.1786092373.git.edragain@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Aug 2026 10:28:56 -0400
X-Gm-Features: AcwNN1V4CWlNCwHhZ3u2RNQWnsyzElnZKzajnGHrRcEOWov4FJp0cjDze7qmicg
Message-ID: <CABBYNZJJj0kCD29sW+GmfN-fAyb7a35gR8kxdJ=bXiOoj_tv+g@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/1] Bluetooth: msft: fix vendor event
 use-after-free during open
To: Ren Wei <enjou1224z@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, mcchou@chromium.org, 
	mmandlik@google.com, alainm@chromium.org, abhishekpandit@chromium.org, 
	apusaka@chromium.org, vega@nebusec.ai, edragain@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ren,

On Fri, Aug 7, 2026 at 1:14=E2=80=AFPM Ren Wei <enjou1224z@gmail.com> wrote=
:
>
> From: Yong Wang <edragain@163.com>
>
> Hi Linux kernel maintainers,
>
> We found and validated a use-after-free in net/bluetooth/msft.c.
> The bug is reachable by root on systems exposing /dev/vhci and the
> Bluetooth debugfs controls. We tested the fix with the original
> reproducer and verified that it no longer crashes the guest. We also
> verified that the existing MSFT monitor functionality still works in
> the same setup.
>
> We provide the technical details and the reproducer below.
>
> ---- details below ----
>
> Bug details:
>
> Commit 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a
> hci_dev's life cycle") changed msft_do_open() to reuse the live
> hdev->msft_data object across power cycles.
>
> That makes msft_do_open() free and replace msft->evt_prefix while the
> MSFT extension is already published through hdev->msft_data. On failure
> it can also clear hdev->msft_data and free the whole msft object.
>
> At the same time, msft_vendor_evt() reads hdev->msft_data and checks
> msft->evt_prefix_len / msft->evt_prefix before taking hci_dev_lock().
> Since HCI vendor events may still be processed while HCI_INIT is set,
> vendor event handling can race with msft_do_open() and hit a use-after-
> free on the old prefix buffer or the msft_data object itself.
>
> We reproduced the bug with a vhci-based setup that emulates a LE-only
> controller, enables the MSFT opcode through debugfs, seeds a large event
> prefix, and then sprays vendor events across the LE Set Event Mask ->
> msft_do_open() transition while repeatedly power-cycling the device.
> The crash we observed was a KASAN slab-use-after-free in memcmp() from
> msft_vendor_evt(), running on hci_rx_work.
>
> The reproducer requires python3, /dev/vhci and Bluetooth debugfs.

vhci requires root:

> btvirt -l1
Bluetooth emulator ver 5.87
Failed to open Virtual HCI device

> Reproducer:
>
>     cp poc.sh /root/poc.sh
>     chmod +x /root/poc.sh
>     ATTEMPTS=3D400 POC_TIMEOUT=3D180 /root/poc.sh
>
> We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

A general note: if root access is required, it is not a vulnerability
in the Bluetooth subsystem anymore. We should obviously harden it, but
generally, we shouldn't accept it as a weakness in the Bluetooth stack
if it requires emulating HCI traffic via vhci.
