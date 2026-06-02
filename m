Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8333F4137
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420002; cv=none; b=TwVJuQz4ZTOtwL7NqfM8tO0hyfPUpjBvQawRS+qYipTHB6TpTHkFwKRboJoDmSE1H0oQHFBfX9C5dab3cdm8Fj0kAoiQz52t7ul5dYiNwj4cN0cT2jWaL9aVS4G+xseSIiclkus9We0ATkovb7N9t9F58HoWOMJ+Ph/1vLwl5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420002; c=relaxed/simple;
	bh=Bl3uE87V4+Vf8cpIROkGPVGhCj5LvqUs/uEkG8IUj6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHMR1YrVdIVHG+Az9w8gpoSs+IWakb5E//18P4JaTYYveumWKcLAeXQeBXVsLq7fs7gz7XZOul8oiObb5UztYBtd210dPoFT7ccSHe3ctFE6oU/Omg02XsYTXOdHZd7lO07uPOxTvgvquQHsbG/fyUEw+R4zRW47fqhBmKdJbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAFoBobu; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAFoBobu"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1363e78746eso14762703c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780419999; x=1781024799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfY3gW1bToFTm6OdfmLQuzmiuL3/uQdYF//iDFnkcOo=;
        b=NAFoBobuQtgopFK5GaDSl+gw/r8ku1tG8x89qbjqRwmHAY1JqKUAT6tUnIIO3HRb0+
         WjF7T8gKE9/DCBZZs3oEsLO6IMMvXZUIKkyMQNKkVqZ9R7iHB8/ROee/1OvAD96PGl8o
         bktBanho0/L2RyHnc7OReEL09LooX3WOGe2RIK4SEMtpmWiFL1CAtb9PwdhgiG89IdnF
         scH0BwPq24Nsy88SKK5ySkMEcuTQtn0M1i4hmv8CUYwNN6tDHSaVsOOcFrtxlcVqC2/l
         o/7p+7jx9P5zrTbtuTwIhcdTOZeKdg7jXrT8SJiXIlGM/gagfMAvCKUPdmclo1LnFFSd
         XWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419999; x=1781024799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfY3gW1bToFTm6OdfmLQuzmiuL3/uQdYF//iDFnkcOo=;
        b=Ez2+o3JnbOtp9BA3fuBu6et4pjTzINnrzvkooq51psmfWyiGF3z/3VgJoVyTMtP5QQ
         rNiWr+qrohk26U0aw0tkD/XDRkIrHeY3y+DuWcQ5A6zRNGiJc40WwJu8aFMim3Ae4Pto
         bYtkzoQekiWgZcsz2IDkBBD8SDrr/ybGyf2r0lGNjTCNEP7uDP7u3RMS8NDAee4xJghd
         3gV0aDAh3aGXAfqVXqV7nPSTvp9qsdugDTTKsF1K2tSIn+yz8mGNLqvW7u/Nt5KrMx9N
         JNJYD0ygSBvVzFZxfH0EecT4LE+nzXCPw+Dowva+zEIpdRwusykj9/0HCOq2THQVC76q
         AmMg==
X-Forwarded-Encrypted: i=1; AFNElJ8fZWKDS08oJeti5yYXx8fIxKirK1n9w2ky/9IFqz/JXynT0ijMdXwlnSYMKOQMEVVdT68F4hzr3+oADfz68FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJ+ariIVoTnchWs0GBpR93wO3gH6sw/BcJPOW2WmdeNhMQ0YF
	XM/Cb/NO8s/ScJZwQ0GNQTzhgTr6/lI3LMPRP/5izAFCAX5+0VqWmMKE
X-Gm-Gg: Acq92OG07Lh9eerWZYhAOkihb8SbGKA0KIAbrBHqFxTRczA4gsyFOKo0CPEhTQwDuMB
	eeSK7jc+SmAhF37K5MDO2lVAxYttp4rlE2Nm4P3rQD1LQQ4ns4QKe0S1tCTj/2DUvs42gFQC9F3
	/5WoRzSHPq9f+gG6T1jezzOjrgKkwOLMYZ+PQmHAWRK3i8lxtYLQ+Y1d2o4H4efo5JOgN+4bC3e
	ns4m3Wa+FEuOtifkcyMQN2xIp6NtIAxPTM55c4mxcAi432lEc5tof4ektCeWr5m0h09+cmVtzIK
	wsXDKInxPzaBAD23Tl0ZH1Mr39Jo2Ny2hBspWhjG4F9pq03gu2Qkh8PFPcQBTsrD0SYiBFgjCn9
	ThHen/tOnvA6NWE920k22IqUUlGNo0lL0BBQp9rPEb3gpC271kDydCUfBwrF1R3rqet9Wtl/ASz
	h3Y2OfiJQZgOSPSyU6vpM44uZ5WszR45KbLniW/uBVnazR501HwQhjUwhOzni0PM1zHpAtFvbob
	mqB3rEiZkz66uGSEMyiXII=
X-Received: by 2002:a05:7022:ec88:b0:12d:de3f:d84e with SMTP id a92af1059eb24-137d42c2977mr7409925c88.39.1780419999005;
        Tue, 02 Jun 2026 10:06:39 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f53f06c4sm264969c88.0.2026.06.02.10.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:06:38 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Arman Uguray <armansito@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v2] Bluetooth: eir: Fix stack OOB write when prepending the Flags AD
Date: Wed,  3 Jun 2026 01:06:21 +0800
Message-ID: <20260602170621.1454711-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eir_create_adv_data() builds the advertising data into a fixed-size
buffer ("size", 31 for the legacy path). It may prepend a 3-byte "Flags"
AD structure (LE_AD_NO_BREDR on an LE-only controller) and then copies
the per-instance data without checking that it still fits:

	memcpy(ptr, adv->adv_data, adv->adv_data_len);

tlv_data_max_len() only reserves those 3 bytes when the user-supplied
flags carry a managed-flags bit, so an instance added with flags == 0 is
accepted with adv_data_len up to the full buffer. At advertise time the
flags are still prepended, and the memcpy() writes 3 + adv_data_len
bytes into the size-byte buffer:

  BUG: KASAN: stack-out-of-bounds in eir_create_adv_data (net/bluetooth/eir.c:301)
  Write of size 31 at addr ffff88800a547bdc by task kworker/u9:0/65
  Workqueue: hci0 hci_cmd_sync_work
   __asan_memcpy (mm/kasan/shadow.c:106)
   eir_create_adv_data (net/bluetooth/eir.c:301)
   hci_update_adv_data_sync (net/bluetooth/hci_sync.c:1310)
   hci_schedule_adv_instance_sync (net/bluetooth/hci_sync.c:1817)
   hci_cmd_sync_work (net/bluetooth/hci_sync.c:332)
  This frame has 1 object:
   [32, 64) 'cp'

The "Flags" structure is added by the kernel, not requested by
userspace, so only prepend it when it fits together with the instance
advertising data; when there is no room for both, drop the flags rather
than the user-provided data.

Reachable by a local user with CAP_NET_ADMIN owning an LE-only
controller on the legacy advertising path.

Fixes: b44133ff03be ("Bluetooth: Support the "discoverable" adv flag")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2: drop the kernel-added "Flags" AD when it does not fit with the instance data,
    instead of dropping the user data .

 net/bluetooth/eir.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 3f72111ba651..1de5f9df6eec 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -283,10 +283,12 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size)
 		if (!flags)
 			flags |= mgmt_get_adv_discov_flags(hdev);
 
-		/* If flags would still be empty, then there is no need to
-		 * include the "Flags" AD field".
+		/* Only add the "Flags" if it fits together with the instance
+		 * advertising data; drop it rather than overflow the buffer.
 		 */
-		if (flags && (ad_len + eir_precalc_len(1) <= size)) {
+		if (flags &&
+		    (ad_len + eir_precalc_len(1) +
+		     (adv ? adv->adv_data_len : 0) <= size)) {
 			ptr[0] = 0x02;
 			ptr[1] = EIR_FLAGS;
 			ptr[2] = flags;
-- 
2.43.0

