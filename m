Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE526E6FA
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772419484; cv=pass; b=KKTXIZ6GDlKwnj4qUKm7lYgzF/afe5Bw7E8MKk4obE4Uv8eI3fw/BrToxgZ59J3v74iHDs7OEvtLw0V5BLm9kEwrPqdmsNmvlxVfYTXC8nFP/xwE+Yud81FeLUGNiOY0PEtVWmrknVlYFIZVVwghProEa59lQc0z2DRj1Ybd5aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772419484; c=relaxed/simple;
	bh=olcSii6WFgbbZpMUKDgGc42hfIUTMd/+DZEMmK9gR1E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cq7KuWhYARYA1McFM1RPhFGol/1wHz3oLXj5ofMB1wPDHiM+TvDPvFk8e5gfZRroDht1T8KX7ZoBRK0k3K4J4Rzy66It1QqS22XECqKVsbDNHiCOD50NdpMDaqoxOsxm+KFbn9Kpv2Q54/HGUbh/96zCCEn7GMTPoz51BqwjEhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmcYT9sh; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmcYT9sh"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so2983736eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Mar 2026 18:44:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772419481; cv=none;
        d=google.com; s=arc-20240605;
        b=kRutFcJjhN/VDpRj0KFFdP/QMoj7Yw6DPTbAzwS2V3n0tv19QqMU0XrBzAIGHb6CcB
         KpSBP75Taf+lKPnNp/RHpom511gheqacj25paF43QtaTdE7P6/yfohlwY9A3fc5jqRHl
         2i0jFE5J5mzkoycESyuelOaA61gdoOVJHqW4WzzTxOlZdC0c70tf5bd9IbdGhCrlLDZU
         MdmakHqPUKSwAbhaF5qpbK1JyhzzZRqO25DBRlnsTa4xKC3rRAzQthq0C1XJrXc2jp+K
         J1urIHfCRqJV4eNbDooYZVUwEMe8xYgcP8dJPZ5VQHr7VICFc1l+u3DsojraxYCQ4ne8
         vtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jtPabGiKzcsGKA0Vul2s0beN6n0+Q5INUlcnoWGXhzM=;
        fh=Ym7YLtscl/gkr8SJIPrMfBraFgWSnnIUx9nPuBfk5fA=;
        b=kJfftLjTsvNvpAZstb4F6uFKhyyP1u58uMW+MlRiVHqKM288UXtAQ7jeCjXqQYof9U
         BTu6Imi46hvilkrsHla/7rSBcqgCG/78GkTpNY07LykdDfW+EKSz0zhultnPu3lUgj2j
         0OfcNpQDWOddPOdNFaXzmozBoP5FsmS589YQeGHaK3hP53YnwiHxynKKig3aD4brsqqy
         WyiAJYRKwCzrKJAflenhHcyMo9X8nESfDuFPdfcNwzsb4MyPj3jOUnlYBCZrSoPz22/h
         cBbb3CmBikWMRRqz2R+eYhyyGrHZj1afHZ7t6JQuiMo8CLZ6Qje5i5k19r7uAAwVWvJb
         U54A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772419481; x=1773024281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jtPabGiKzcsGKA0Vul2s0beN6n0+Q5INUlcnoWGXhzM=;
        b=gmcYT9shqxGH/wWyLCtNBhJaFQHfgNTJlyBGSLAfYGMm9deMZQ8OyCtqm3zMZmmQlX
         cY+NuzgzMDk4HPv7pDk63mscs8uufg5uO75rU/VxI7qA+/4rUZ3IQM2h08/CUwd9/5vr
         3sYHUuXU2gJdoSmUWx3L27viP39DMedxTcNtRkblzFelLWueztkpYuzrABtQ5KeAtA/7
         NRUrgTnY6E9wOjyznAyJL9HrZDYKE7BK49HTlrE1+7Fn6EnMkwY/9PtVsoU56NHiqFoM
         yo2x98jVlex1gv1bHfpEIz66hAKVn2utTnmSAaOJk2Z+2VH14RJPv+kt/DWgm1bEu5sk
         zz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772419481; x=1773024281;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtPabGiKzcsGKA0Vul2s0beN6n0+Q5INUlcnoWGXhzM=;
        b=MIdT9j51+U5gRbwkYyjPKKFSZgKfQzedmSOvtbzae11RbWhtQ7ypVwb8x+Fk7Ky1W1
         rglnBgPVNJAqsMCuvPEXTewTMkE2kOMTzP2Ese1oGiTjdpJAtYdE2znOcshA7UxOKoRN
         TM5+eOdEWj2b196CbxzXbatAnfyxns8eyWpmp6m26LUFMOQk7uuMs23LAn3zIxj9K34A
         +BotPgXVrep083paioRqAmOpyNtZOCkxnHoH24Hk35tPGIdhRlq4e5hjxlzuv5PoqBHc
         KXufFdtgcSmpr+2yhAqwTtLIzY/nsXRyrBYTBeksf5EpZi1sC35FFyfid74XgCr3LRVx
         0ziQ==
X-Gm-Message-State: AOJu0YwcV5kng7pytWsNCsPgcQh/PCVJLKdae02+eOc2ivC0CcJWoVYS
	vyR0/POy2YT8oLqN3Kbqxmx+5hfFE2ph/TQhDbDMD1MHp0W/YFKjp6FnmqSSs2z1B/pQ14icPAM
	kNNv9M1OxPgkmcmFbJifV83pYyW0QuKeXIb28ghm520qKQhzLCE0j8Jswc2E=
X-Gm-Gg: ATEYQzyKX9RVrmHOBbwJvlR971BmxQV+e/Msaw3Eu2VzNJPJ8VRN3oVO8b3hJ8O0d2P
	6fHV4Gg8YiGUQLYF/s0SF5JkBQkl3DXocyKR0r4q4ALu9YMvChOrh5+lID4+AbAbu+JyWjM+tFz
	7wbzmjg5feqzBed5DqJIthuKChNvYjzzTwKhmcJhIGiF5KxPLEL83gnXZepXwEwTI4i8eANyfRm
	HHrMBegBO/PxDEIGlPPSTvV2oGrMHeKd3iOTiivuOl/5ytlFXHWdPSylrFHOzeEz+u3+xBG49XO
	f2UMkg==
X-Received: by 2002:a05:7301:1291:b0:2b8:209d:5983 with SMTP id
 5a478bee46e88-2bde1d3b487mr4277544eec.29.1772419480886; Sun, 01 Mar 2026
 18:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Date: Mon, 2 Mar 2026 10:44:30 +0800
X-Gm-Features: AaiRm52eIZyQrcGgw6NQ7mzVNFUFjTqizuzZTLtl5jzFbrfYdTekZW1hKBcuxJY
Message-ID: <CACrSQ4GigJ-41te+504D+dTRgC+46uwtjBQDuv4pY4LZ4Krpzg@mail.gmail.com>
Subject: [PATCH] Bluetooth: Add Vendor Chip Support
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From c3ecfc2bc762a438d0cc0a05aa412bf5893ad22f Mon Sep 17 00:00:00 2001
From: kaihsin <kaihsin.chung@synaptics.com>
Date: Wed, 25 Feb 2026 17:51:43 +0800
Subject: [PATCH] Bluetooth: add more BT chip support

Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>
---
 drivers/bluetooth/btbcm.c   | 2 ++
 drivers/bluetooth/hci_bcm.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d33cc70eec66..7ec871e1118f 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -515,6 +515,8 @@ static const struct bcm_subver_table
bcm_uart_subver_table[] = {
  { 0x4106, "BCM4335A0" }, /* 002.001.006 */
  { 0x410c, "BCM43430B0" }, /* 002.001.012 */
  { 0x2119, "BCM4373A0" }, /* 001.001.025 */
+ { 0x2128, "BCM4384A0_AP6684P" },/* 001.001.040 */
+ { 0x4119, "BCM4384B0_AP6684PL"},/* 002.001.025 */
  { }
 };

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1a4fc3882fd2..e8817e597a65 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1594,7 +1594,8 @@ static const struct of_device_id
bcm_bluetooth_of_match[] = {
  { .compatible = "brcm,bcm4335a0" },
  { .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
  { .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
- { },
+ { .compatible = "brcm,bcm4384-bt" },
+    { },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
 #endif
-- 
2.43.0
