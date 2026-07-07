Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DEE3AB29C
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461939; cv=none; b=glBmGRBOHxEhNgvjIZ1WPCIMcud17Z0ITH5MuO4RTJcwyd7vw6ZUVEK240TxyoIUGV0GoJ2N5sWdnFikwK2RFtWuh1+R9+/OTSjLlHCuGharWCZwdH0S7tFnRdopzH5oztGYChDcWzK8xO8CJyeKh8rV2bednVRSdm3FrZRBrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461939; c=relaxed/simple;
	bh=e2P5r8XA3RGJrJLw1cxuTkaS4mej/2Imv19r1823bMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrKtg/fpqlkfaRonAOj0e8PsfCkIjXm38xIkDHpL8UzitLI8SiUO3eBFNe56ep4RUFrF4FxSnRUrv8JKzvEd/B1BZsIpsOteul0AxRdT0RKVL1y8jKsqTmanHDgCsrbbEzZl1hMFKHLtqke7JZEyKWeov0MIxYpjzSDuRZhpVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFxgZLm7; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFxgZLm7"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9217d13c276so7012185a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783461934; x=1784066734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=utjog+6AQ/2tRyz48wuvZRgUxH52Ru+dsh50BRKnIuc=;
        b=CFxgZLm7VTQcMEEuT7mS3UEWw2zOPdgx/LbmRKW/vHX2/gNaHbrcN/kBpZK7833HMm
         CiNeVJqitjmB/RS+eKNrvY4Ny3McPUQk5Umw+KxW2u8kC09KRu72fRzRUnwoBS2NPwL6
         T6cqiP+rZlJ808ytxdhGr0LYUz9jdOWWQn7DV9ypothaDSj3hi9njaS6iqN+yuAxM/E2
         S/iaF4zavHSyw1gdSLyJo1knJEtLlZKSpo+ip9A8LP4OVyrCelGBlvFsswfUqb9IqaFK
         Rn5Om0c5yY/Gv7imgBsKwtGAwwonO4RaxgUwMEM3ItS/ZWbcdmpSyrCe5GY2W9OMu5OS
         vPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461934; x=1784066734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=utjog+6AQ/2tRyz48wuvZRgUxH52Ru+dsh50BRKnIuc=;
        b=U8BG81LSysLD4rtcYolh1aZBq0QXq//NByZoEJ/2HHDTlx/qZd3B0urx2tUOcxI9mP
         dWMdXdP2xvEW3mIJrsWjPlhJXAHMhc93Pg999Nj0giYl1O1qGehvNz6x7KaeNReAzmzt
         Gee02liMhod+DkFsYG/lXTHSevNP3OTbBh9BiKfHwqA8am08KKDclfn4JOp8/84plX5g
         0a5Vvp/qdBNJuWHHkGusFF1WRIlQAmlHdRGI+quI/To4rCySMCWgtwbhnlupHvC/e5IR
         ocbh2I42XxYIGrmxzV8i6eGBBqpZiMOsSWQ0THJvQj8JJd3anfCxk4Fq1E9c1RPWBH+F
         1TXw==
X-Forwarded-Encrypted: i=1; AHgh+Rpb+F6kW8fHbpfNr8RsqttaWQdmVWDp63yDpBrTm4qABAQ6v9hqRVu7mx00PDp/PnmYunPOTSerp3EWgUWtBlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCarAUdJFG2GFAJRnMGMkL6pGOuf2xHdKOqXTAdcTEcD+oXGo3
	1eeppaHHIFrT3egI/sSTAMaEOPu/aNYThBtJ70Gb9j9edYzK7n3TYXZqikR9+hLv
X-Gm-Gg: AfdE7cmOFmNnFLywSWqCFDhaQxNuws3wdebYEJHOEJ9Xt1ln0I8EQ+6ZVhuaSwMGl1R
	pNQBDTDHnVpgMYV5ASi/CCfV6mL5WGXiYAu7+XBNeW9t77fXdAoNFPB6qkWxAXypOp54jVYshIR
	anOleMie/Q7DhVPfSWAZDaMXLLHOUlEK+S+nD+T8JV+uA6cXxAuNJc8DvyEOsR85y6VYWq+3t6d
	2ARt5co4lInUPce1BC/GDMQnVeF81WAawBIqW6NXjKHqyKY6pA72J3fzH4dy6mbne1++EoKs2Xt
	HHrgHP98YGLR3yTydcTMszzSyZRf3m+gj20lvrjq1uCC6b4WaAUAHqYkk+VWxZ8HpCs8t1ShDQC
	etY2vU17R3o3pmhfmyrBplBnh6PB0PL28Ak6+fs6I5oe1qzGrG5i6nHO49R/vvGMtLTeYCythLd
	9vOL0hzYSG0Fovin9XkCS46Q4xAd4y6CtYMB5V1kemNd2DmL1P+eOwhixqqmQSE1Ytrzlbyuf9h
	r/3SRCZVrWXRi7OkcZXbTyFOufue+JoUHoH
X-Received: by 2002:a05:620a:1712:b0:921:dae6:a701 with SMTP id af79cd13be357-92ebb5976ddmr834874885a.54.1783461933994;
        Tue, 07 Jul 2026 15:05:33 -0700 (PDT)
Received: from jeremy.kali (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cc18f1sm1250745685a.40.2026.07.07.15.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:05:33 -0700 (PDT)
From: "Jeremy Erazo (Devel Group)" <mendozayt13@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Claudia Draghicescu <claudia.rosu@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: ISO: backport missed OOB write fix to 6.6.y and 6.1.y
Date: Tue,  7 Jul 2026 22:05:24 +0000
Message-ID: <20260707220526.271712-1-mendozayt13@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702144207.320421-1-mendozayt13@gmail.com>
References: <20260702144207.320421-1-mendozayt13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeremy Erazo <mendozayt13@gmail.com>

Hi Greg, Sasha, Luiz,

v2 respin.  Two things fixed vs v1:

  * The 40-char upstream SHA I put in the "commit <sha> upstream." line
    of both patches was garbage.  The 12-char prefix f4da3ee15de9 was
    correct but I hand-expanded the tail wrong, so `git cat-file` on it
    fails.  Corrected to f4da3ee15de9944482382181329bb6d7335ca003.
    Thanks Sasha for catching that.

  * The v1 patches were asymmetric: 6.6.y accidentally carried the
    put_user() hunk in iso_sock_getsockopt() that 6.1.y omitted.  There
    was no reason for that split; my mistake in v1.  v2 drops the
    put_user hunk from 6.6.y so both branches now carry identical
    mechanics against their own net/bluetooth/iso.c (add #include
    "eir.h", add EIR_BAA_SERVICE_UUID define, replace the memcpy() with
    the eir_get_service_data() + bounds-check pattern).  The put_user()
    correction is a separate getsockopt correctness fix; if that hunk
    is wanted in stable it should travel as its own patch.

Everything else in v1 still stands: root cause, affected branch matrix,
reachability, build verification.  Re-stated below for the archive.

Root cause: upstream commit f4da3ee15de9944482382181329bb6d7335ca003
("Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID",
2023-09-28, mainline v6.7) addressed the OOB write in iso_connect_ind()
but landed without a Fixes: tag, so the stable autoselect bot never
picked it up.  linux-6.6.y (v6.6.143) and linux-6.1.y (v6.1.176) both
still ship the pre-fix code where ev3->length, a __u8 in [0, 255],
drives memcpy() directly into iso_pi(sk)->base[248].  Values in
[249, 255] overflow 1 to 7 bytes into adjacent fields of struct
iso_pinfo, including the low bytes of iso_pi(sk)->conn.  FORTIFY_SOURCE
flags the write but does not block it.

Affected branch matrix (as of today, 2026-07-07):

  * linux-6.6.y  (v6.6.143)  vulnerable  - patch 1/2
  * linux-6.1.y  (v6.1.176)  vulnerable  - patch 2/2
  * linux-5.15.y            NOT affected  - iso_connect_ind PA-report
                                            handling was introduced by
                                            commit 9c0826310bfb in v6.5,
                                            after 5.15.y branched.

Both patches carry the same three hunks against their own iso.c:

  * add #include "eir.h"
  * add #define EIR_BAA_SERVICE_UUID 0x1851
  * replace the unbounded memcpy() with the upstream pattern
    (eir_get_service_data() + base_len <= sizeof(iso_pi(sk)->base) guard)

Reachability of the underlying bug: any host with an ISO listening
socket bound as a broadcast sink (LE Audio / Auracast use case).  No
pairing required, single HCI_EV_LE_PER_ADV_REPORT event within BLE
radio range.

Build verification: net/bluetooth/iso.o builds cleanly in both trees
with BT + BT_LE + BT_HCIVHCI enabled on x86_64 defconfig.  No new
checkpatch errors; two warnings reported are "unknown commit id"
(shallow clone) and one long line in the backport-note paragraph.

I did not include a reproducer or PoC in this series because the fix
is the one Luiz/Claudia already landed upstream and there is no dispute
about the OOB write.  A userspace reproducer against /dev/vhci exists
locally and is available on request if the maintainers want to confirm
on their side.

Changes in v2:
  * Fix incorrect 40-char upstream SHA in the "upstream." line of both
    patches (thanks Sasha).
  * Drop the getsockopt put_user() hunk from 6.6.y so both patches are
    symmetric.

Jeremy Erazo (2):
  Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
  Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID

 net/bluetooth/iso.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--
2.53.0

