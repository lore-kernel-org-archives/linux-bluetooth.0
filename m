Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD892222AC
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779165117; cv=pass; b=Q5MvafWgh07nehNrGXCJ8FnjqyrPkmK/meFJu592efb8YvXndY3aKWRrbn4iPRCld7FAbFxnIYgJm4uErvZdDhBHuvW9/ZqwOGBkB8rGnL7U5CW5ENzYuGyEVwtdOJRk4CLOp8ces/n5jvtJ+Gow7tmxPj+1Eb7V+YHyxJDFnzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779165117; c=relaxed/simple;
	bh=LB2eeG1SpolST48Ht8N5ZVmPK5SGJL8UVYCuIxMFohc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t/+uRx+1jpBEM3z7Y7MlaJvvh7a4UGfn87zWO/ou4Cz3+uht1rK+ytiEltjsz6r8L56/L/BMNB//DX3hv1Hgt/nD6iIKpFXYhIY5BybujBxG5pXfl/02YVc2wyMDvKsWZ4ymrFjhc+yXtAJ/hoZP/dst9KKwT+XdW+kfJ7k7Qvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY4YuZ0w; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY4YuZ0w"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso25135975e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 21:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779165114; cv=none;
        d=google.com; s=arc-20240605;
        b=L1Ok6QHFT1jgHGjkdhdM4StHxXhQ9ptanpLdX9Riqmuuj3ItRrwcvIDGm0JUgyvhD6
         lkyMIwwGFtA7Qn48sHBnQiz99yGj3swQPlhHZS4ueFdOBNFtNdm7mBMCFsBqbdDIfQyt
         /MEkHhOMFk1aeI46hMY8cJ/h8yGoTSAfmPQAG/BwqdCmqC9BOaTUjyINIt7QjOwEzlMs
         /luaMaR2TY69WRuzkyrQXZNcnOBNabFWhMCkQAt1lcQLltaTMNppsoGYh7bkd72sMX3o
         RBAMl80YNy22pqd3SeQHielUEfK1aR9CgLBHFVy0bbxhFboN/rbvABPIQ8PsriIiXfqu
         z08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LB2eeG1SpolST48Ht8N5ZVmPK5SGJL8UVYCuIxMFohc=;
        fh=SdGkAVvgcihIGuzESgts4NGJYMq7g+prLiYW2T6X6rE=;
        b=gr7PJRgrpUMcbHQlJzwKJ14EMpEkCFIRIZITShRzcyCCWagUaoIIUyOVBSKB53Elzs
         crBgWY8eYKuQA0Uk5qMxe6/YfUyCJoPIk+KmiBZjpOGVNKO3BEQQoBD1h5U5wzl046SN
         7GPPvdtEgu02R8IeQiJ4k3iGW8wYK0/EXb0clSsswxdN59oVWBt9QECN4IHjj66TdZ4M
         hTQ78hNSw8SJCwl2WtRKxMqU3fQKPaINQPTVpZzIJJ505kxjbT7RIjjZPk97nASLIwfT
         WRyHRakB5Ea35XqZ0NuZnS6dSo3kwzmg7Q8ui6oOR5gZdc19lVFVqURCT/hJaXjI+DNb
         pYOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779165114; x=1779769914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LB2eeG1SpolST48Ht8N5ZVmPK5SGJL8UVYCuIxMFohc=;
        b=TY4YuZ0w9Ef7EPQM7XJxtmopK1cr5oF036YqWHApUcnslpf1aJaV3+BSZodLfPvigX
         Q/CQHt6Us/Yj+Cke7mM+3tD6nNJ+srv52mgS1DRhXz8e7qgmZeAJ6CQ9fuYpH/DQxh8b
         T4ZnoXGCbtX81SJcS4BsDCe8q9T5+1mh5RIb+Vaf0q2iz/f7l8BSpMwVyEjeylvxn1CZ
         8u/b32nsTimLNzqophHb5E0UEjCak53l7hK8GXGaV9/yH02xLNr5E7CB6PEyzKShLnGp
         ku5dKq+K9MKK/7KjN4uHthIBpGSiAZ8xfJxRM4N+NssYEyImPLseYP4lFXZw4gf2LNd7
         gqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779165114; x=1779769914;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LB2eeG1SpolST48Ht8N5ZVmPK5SGJL8UVYCuIxMFohc=;
        b=negPtDAwDFRKPkDzgwPIAannkg8drg9spywjXRTvCGQpwr+wKy9KKaLzfQm7zRH+Jj
         pK89lTVnUZvhNOG4EmwgRqG+9AMKHbhM3aSgLI2DQrLrcra7fGBA5R/lXTwjVFXU7uU9
         P+e7kTOziF2VP667kLlF53YkwYH+1jezLyMYeyjvxbQvRcv7qOgYBaXTn/SCRHl5Nhtd
         gaIe/3ImLOEg49YtGTigd17UFONuRpjHIDo/9MJaeX1U7RWEYP5ixejt9wjTxTeU94Ei
         UQnpTkD8k9XPKGjtVg/BhncYylQo+0RNZqmzm+OiEgsIAw6P3et+lfXz3rsQGC2PEKXd
         bwZg==
X-Gm-Message-State: AOJu0Yzsc6mg7gzVuPqUNntTlxSNpEq0qH/j9wgbOzjl/c8eDXiWIpH9
	Ch1LKXbvMhMy0KGctW441fPAdykuimNrs/Vh4igv+UxJxuGjh4iMoWzU5sRtcHT/SItPZbhY9wz
	gfR7YxN7KCmDUaHC326SQ/dYIEa6cLO+DdbVS8fPnqw==
X-Gm-Gg: Acq92OEEpc0juFd0nYz8TWqGwCzJn2R1BULe9dhGB4Qm+kBtV7kQmzvv46/+Sr//4Iq
	IJnUlQpFJqP+jxIN2VGfLaEUwyMAAb6Wtvm77vbiPnMbMhuWAsUIs5C8X7OSNuO5BBz39u7i5HJ
	fCOEHUTGqCAjYOCAKavOm+lEwtcPUdvh8Vp5yIaeQKG/th9MW6S/8bsNnztXHTXlH4LF4dn4Onq
	qNtt3fzEM2YOMKCNLymhNrLopiPQYSuHcnmwjUHyD5QqfaNOBmH/T94qJx/7P1zNw70ctx6Bdh+
	i4nkWYiWegpuHEvyl8M1
X-Received: by 2002:a05:600d:10:b0:48f:cfae:b654 with SMTP id
 5b1f17b1804b1-48fe60e5537mr217793815e9.1.1779165113908; Mon, 18 May 2026
 21:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Baley Eccles <baleycod@gmail.com>
Date: Tue, 19 May 2026 14:31:42 +1000
X-Gm-Features: AVHnY4Li5nUZrvw8vcm2bYlGMK9IhnqMjGOljLZnXZ-_QnQCztFbvk2LXkdu2tc
Message-ID: <CADCSNFD0Ut-jJohTQFczjBgaVf=mBrc2rq4hJQncVZpF4bCoxw@mail.gmail.com>
Subject: [REGRESSION] Bluetooth: MT7922 fails to initialize after "Bluetooth:
 btmtk: validate WMT event SKB length before struct access"
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Subject: [REGRESSION] Bluetooth: MT7922 fails to initialize after
"Bluetooth: btmtk: validate WMT event SKB length before struct access"

Hi all,

I have experienced and looked into a regression on a MediaTek MT7922
adapter. Bluetooth works on v6.18.29, fails on v6.18.30, and reverting
the bisected commit fixes it.

Hardware:
MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter [14c3:7922]
Subsystem: AzureWave ASUS PCE-AXE59BT [1a3b:5300]

Good kernel:
6.18.29-p2-gentoo-dist
Upstream base: v6.18.29

Bad kernel:
6.18.30-p1-gentoo-dist
Upstream base: v6.18.30

Failure:
bluetoothctl list prints nothing / no default controller is available.

Bad dmesg:
Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
Bluetooth: hci0: Failed to send wmt func ctrl (-22)
Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
advertised, but not supported.

Good dmesg:
Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
Bluetooth: hci0: Device setup in 129909 usecs
Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
advertised, but not supported.
Bluetooth: hci0: AOSP extensions version v1.00
Bluetooth: hci0: AOSP quality report is supported
Bluetooth: MGMT ver 1.23

Firmware:
/lib/firmware/mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin
/lib/firmware/mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin
/lib/firmware/mediatek/WIFI_RAM_CODE_MT7922_1.bin

Bisect result:
624fb79dadc1b65757986a9d0fdde5c0cf3fe179 is the first bad commit

Bluetooth: btmtk: validate WMT event SKB length before struct access

This is a stable backport of upstream commit:
634a4408c0615c523cf7531790f4f14a422b9206

Reverting 624fb79dadc1b65757986a9d0fdde5c0cf3fe179 on top of v6.18.30
fixes the issue and Bluetooth works again.

Please let me know if there is any additional logging or testing I can provide.

#regzbot introduced: 624fb79dadc1b65757986a9d0fdde5c0cf3fe179

Cheers,
Baley
