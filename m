Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359390;
	b=qrB9UjJMEphB6ZkI6yoJKcLV4f1s7sxWmPNGalJaJpFajRYqC4NGPaFIQVhHxa7nyqi+
	 hXci2yrgUOqgmeefq0/VQeNeA/S09MHFY2uam5V/0nnh6UlAjz4ZhJDV1LL158uObwzdQ
	 Vm1v8oADPLO+3heo8Iuvo1rO7gfdqDbiJC4Ca4poDR+k6Z/OwO7TVPHclfOx7QbyrR9gP
	 qa3lLIaAj5vWpbN26Jj6lvhLA3FlfbJ/YbgDH0kO7HDshHBoDthl39PiqcWgwZ4hQMm/O
	 GB79MXSkOXgBMuZzccd7BSdSJXrtPq6OaYadop/ihQi5/XSXIHgd3Ctf6joGMgPsung==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dHjG97OtMYyiW0ho2NcoWZ5/kOUKKeDF7xy5IUzwaiA=;
	b=b82LpwwQuN7L9jAsDZ6+JqcpLiN5RdcHCfPOXCp1bWdGi6R2iFkppZY0ujj2/vtx8IEd
	 Bbu8jTLjW37Dk9QbiyGj124OKEFnP2S+ltEq2YiQoGJ+jqFNn2J+zCVW6oXgSR1zjlAbT
	 l80DbwXsykAdr890GtSnPB3z7cFhaPk8fzHym69FTjP2TB0vah3UTWvDqij6GRzur2Hod
	 xVPogSJl4emq3yWIE8lvEYbay2rBunrGIMPEII5wST3alxdAfJgpzGZrMbiX3qzsIb5s6
	 /Zh9NNyBYkTY/72cZ82ewGPIfyOXaLOL8Zzjj9K8CHQKY7fvPcQ2RuzmECikQfyUkcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8Mc0B3k;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C642C606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 01:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C642C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8Mc0B3k
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36dbde64409so5526110eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 17:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794359389; x=1794964189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dHjG97OtMYyiW0ho2NcoWZ5/kOUKKeDF7xy5IUzwaiA=;
        b=L8Mc0B3kUWL/a+kEPZINdKBQzpMN6IZ+kqk/mA//mPancew1NyYns5tBMKNcvw5OXH
         1WhpLtDXUNizT0m/Ov8uopIBEpHbCJv+2IXjD2dfTdg8mtauvNVVxbHG6vbsNj3zAEAA
         CQP6HMqkDmh6BI3NcsM1wIk7y2ZB1ljunodmWHJBtvW4n20YplMkz1ve0RwkyugWB0fu
         uqBngVPiHlwzXdlzUiS0Hwyod3V7kwY3s2nsfGVZbg8a+/3iHvKWOvEWbOC0z50qxZ0+
         cvYipBGY0EtD5+F/MRb5IBn/D/7KQtiYCPoH2IeX6z4muUGou0NTrGoiEgpDj70v9hmo
         TYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794359389; x=1794964189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dHjG97OtMYyiW0ho2NcoWZ5/kOUKKeDF7xy5IUzwaiA=;
        b=Al/pzDoakGCBS2Lw1KMlKgydqROxGFaPGNkTsZJ0pCW4a9Vct3/6Y8bTiv4b3vAh6k
         gHEUBPD2nVVAoaHCU9u6qwVlZkXEmLcr+NosH1UVV/d7nQrLltA/PoFgczcd03//wIom
         aJBgu6fdU26x0o8puU7dURL6gwV22P6EPPmgzmN1mlcvGGvm95MiO1Vz7F7oM7OF/tFb
         BuQ75iY3jlU1qpJAn9ySZX6J+rQlT7DN3GU3Ey0WX2yfjqpIAjeVqG9J+rsU3ytCp1hU
         4RZqEeF0d3eCF/GMWuaeiEfI45gostj26Lh7SrRHUCH1T/xqJ9RUvJi+1OYyP1Tixlc+
         ufZg==
X-Gm-Message-State: APuU4Z9Nj4wr2IfhrJjDlogkmy0StCxPOHVgqOFN0SGoorpiOq0UQC9h
	lUNJyqWY27lHdZKm28waL9Rjjdpo/CdWQEc4whVxRwnhy0VHCKFtP6T5++rzSPh0Pec=
X-Gm-Gg: AYBFou0LNzgIkG+SsaOCmQkUa1OPo4uMktitxITRQ2QppgN84b7PFfJ1zMqhDcIAUiE
	xDCfVl6hFieU2HYsDMwVo+5U0FzEBcwr5PbiOjYVzscAFZMPrHIwaNgZQUroRcFu7O1Ptch/y/m
	o6h8LzJyjsGCKtxBwsK+cGi40+drrAIrN9IEqkh2An48pktxrWT8/buka6S66bKGiMQckl4BM15
	h8KIOp/iAL7xpuQTxfiWo8YqMWjuya6zO68lK9ee+6n1waFPa6f/zWON7n/bKIenOHWqY30FnSa
	7FWpm3e4/FdGvwxKfW/9x9LJeCVkRucO4g1euwsJkgBrdPHZPiuYRc1yJNqLmQtwdD+RHO483nl
	S38gb8kN/GUW6icWqlbjB868OCvwzKL/DO4VD7IF3XsdVMtw1CxgGreU7j6fK+4ZvmSwO5p5GDC
	E8H679vKtu39x+0IgxzFsaMz37mCkNN/s2InVVi0x7Syy8cvDNRLi94VHBYPRKvSBLWw3ijOWaE
	7tfm6Y05CPmBV4sBF9N8GG8mJQgQko8213HbIzoMZ2gWdyZeMdLS6O8Sxv7daFmTpN9nOy2V9A2
	G5miOI209ualb5p0Q4our7CAiOvzyEFnUxk7pwwX4FLVD1BxM8F9vQZVfO1p+FbzGhI2dwQq39A
	=
X-Received: by 2002:a05:693c:630c:b0:36f:64e9:f1c4 with SMTP id 5a478bee46e88-376854b9a0emr1779840eec.6.1794359388665;
        Tue, 10 Nov 2026 17:09:48 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm10085492eec.28.2026.11.10.17.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:09:48 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH v2 0/3] Bluetooth: Advertising sets on a single-set controller
Date: Wed, 11 Nov 2026 01:09:37 +0000
Message-ID: <20261111010940.728149-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the controller supports a single advertising set,
hci_add_adv_instance() gives instance 1 handle 0x00, the handle Global
Advertising uses too. The parameters, data and enable commands already
use adv->handle; these patches cover what still takes the instance
number for the handle: setting the set's random address, removing the
set, and the Advertising Set Terminated event.

Changes in v2, addressing the review at
https://sashiko.dev/#/patchset/20261023132421.1889022-1-weihong.guan%40gmail.com
(I hadn't seen it, sorry):

 - The instance is looked up, and adv->handle read, with hdev->lock held.
 - Patch 1: hci_cc_le_set_adv_set_random_addr() records the address of
   the instance numbered as the handle and leaves handle 0x00 alone, so
   instance 1's address on handle 0x00 went unrecorded. It is now
   recorded in hci_set_adv_set_random_addr_sync() when the instance and
   its handle differ.
 - Patch 2: hci_cc_le_remove_adv_set() looked up instance 0 for handle
   0x00 and left instance 1 in hdev->adv_instances. The completion can't
   tell instance 1 from instance 0, which MGMT's Set Advertising also
   removes on handle 0x00, so instance 1 is removed in
   hci_remove_ext_adv_instance_sync() once the command succeeds.
 - Patch 2: while Global Advertising is on it owns handle 0x00, and the
   controller would refuse to remove an enabled set, so only the instance
   is removed then.
 - Patch 3 (new): the Advertising Set Terminated event finds the instance
   owning handle 0x00, the one enabled on it as hci_le_ext_adv_set_enabled()
   tracks, for the connection's responder address (which SMP checks), the
   instance re-enabled after the disconnection, and the removal on an
   error.

Tested on a Raspberry Pi 5 (rpi-7.4.y, 7.4-rc2, with net/bluetooth and
include/net/bluetooth from bluetooth-next and these patches) with a
controller reporting one advertising set (LE Read Number of Supported
Advertising Sets = 1), btmgmt and btmon:

  - A non-connectable instance (a random address) starts: its address
    goes to handle 0x00 and the set advertises from it.
  - Removing it sends LE Remove Advertising Set for handle 0x00; the
    instance leaves the list (Read Advertising Features: none) and
    Advertising Removed goes out.
  - With Global Advertising on, removing instance 1 sends no LE Remove
    Advertising Set, the instance still leaves the list, and the set
    keeps advertising for Global Advertising.
  - A connectable instance from a random static address
    (force_static_address) on handle 0x00: Advertising Set Terminated
    for handle 0x00, LE Secure Connections pairing completes (DHKey
    Check both ways, so the responder address is the one advertised),
    and after the disconnection instance 1 advertises again.

Built with W=1; checkpatch clean but for the Assisted-by tag.

v1: https://lore.kernel.org/linux-bluetooth/20261023132421.1889022-1-weihong.guan@gmail.com/

Weihong Guan (3):
  Bluetooth: hci_sync: Set an advertising set's random address on its
    handle
  Bluetooth: hci_sync: Remove an advertising set by its handle
  Bluetooth: hci_event: Find the instance owning a terminated
    advertising set

 net/bluetooth/hci_event.c | 42 ++++++++++++-----
 net/bluetooth/hci_sync.c  | 94 +++++++++++++++++++++++++++++++++++----
 2 files changed, 116 insertions(+), 20 deletions(-)

-- 
2.47.3

