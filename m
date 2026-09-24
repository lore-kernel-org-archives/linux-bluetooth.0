Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6642981E
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289067; cv=none; b=L1kxFh3X1o0hzRodn+qMqcss49pXTgkBiReknkcIXqngv53j4Pj7GLMCUAwDMt3ozMOioDlwfKzu83fYU6SejiTPE3G8s4yQEkMZzSUhelcViQTFBUSGPTudr8noQftcR+GIXJuOwPc7E1SyryI604f4AMy/Y5bHATB+2wiLZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289067; c=relaxed/simple;
	bh=/FEZTPT2L2/rGDOLXfjsNIFDX0IxbzgjtFtLjsrX9oY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0pvYGi3ebFjsJnfOQ317mpJ8VfvQM3iPNoccZqL+cS7bk/OF6Eq6hdLnkiaHkwh+rLuXwphnToxMKIr+HEq/jqUdlD32vo9TaGqCVofq19DSNEX0kXPB2AWZDg57j+i0h9OACVckyvBTM8R0Er8sR34a1R/W9sgS2L/s5dACYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPGgPY5i; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPGgPY5i"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5cca96ec1feso10055e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289065; x=1790893865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rp41POhCiiUSxOFWV5cikekbyRUKV77FzUtqMDpkOfw=;
        b=nPGgPY5iTapNOkFE8kO8V1ourgIpZopcSW6wLOyWyISRw9Rw3qwCGg/i8nHEO/Eshl
         GinzVU/FaftReYE1axL+uFvi/HIlEycs0d6vsmS0p8tw1L5wwpyH5QuSEHmYo8Q5EoiK
         OeOC+/LQOBGwo/ggrTXK/T+HWjOIpibeZoAcrvmbYhfuuTuSydFA4o7Cf69ppQUujBWz
         9oFh1JZz9810LVnRIkIjYq2CdLdUGsjb3MCbhfWmQ+F/8/VqNjlMnD+jPb/1rDV4n27T
         1yic+HyJ1cg5fA65FL+8vfYOP1XOojd6wRk29FBDpGX9uGmltYHXiQlRcQs3LvmEfYyO
         jfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289065; x=1790893865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rp41POhCiiUSxOFWV5cikekbyRUKV77FzUtqMDpkOfw=;
        b=w1w71YAt8wnvBTdry6iOwpB52K5YNZqZE2u75fR6wnITqZEi2vcGeP35q5thipibjc
         sTGTnYYZ4WmpNHlJfDlp9MhH08KO1bKE5HPSUVWi4/a38t1tkPw4F2TQzxeUJlc9DI18
         HjnMEaJGEQBOXeyNKmMnKsCOfDefQUMUAKbwxH0T7Qi8EaZ/2yc0iEoPyFx6wEo8kiSA
         jgWr9wR/gY/7QtAOiWhIDX9BDzh9uS2WPLvB4284jD4+7mydDbuUayUsuMOEojYNKxQm
         mQq2pq8BJlGJGIVBqoQSDTw0KO/5C1i3/DhuwZcdyUtAVxLNOev7+OMEYyfhYFnU3sDb
         APDQ==
X-Gm-Message-State: AFuF++k0Kn4MOZ5+QIMgbZSldc9f5ypiIM6nH60Yht1Y304iWsRL4fyS
	lVqeTi84biYEtbtxhASBgj2n7NH2OkSes5awynp9UBDex6T4OlnThR9cWdH9sN97SQvSVQ==
X-Gm-Gg: AYBFou1SuSxRTajAxO8aw8J8642adpCYYX4XMPOhkG88DBoAO3HXBpYfxNNIi9X48KH
	cVHSv01lpbjBhju95HsGtrYonmV00CL7qrAxTG8tvU17jgunp8vLh9FNLLI4VOAOxoa4/AzdSin
	Hn+VZIo7/K0cKbsWrLQyHGu6AbaFaXEvpDDNNlww5C7tUDQWgRy/yDqUKm1L3HYjUwBk/08yGYN
	mu/M4efTlTRDdgEThDpjeEvMO/7PEd3O0r0dqVltvePoNzG9lJ9NI2Cd4PppR1ZEQmCDGFFvDBN
	GqTVOtU57BN9aYvUVp7SkYkUoYNhq0SczqnLgYeD2yVENJNf2KRj4wK5XPMfMZf2qTZAfH6m/62
	FlrMB3Dz2Xib+IVoYVdbVfCzVtRYepDJN3+6nQtdRFsK2lJQb7cKhEqHjxjQ2jlh5LUKZ/F9vpT
	TiV4GhQLvw8d9S3Tuj3bT1A3Iu03c3BgZnzhGsfXb8Y4i8MjD9keOiJQjFcSmazM6yZeZ3L8fbF
	DS+YqosxN0bMPjGxPv+YkiPwpdeQ4P3lZb3MvGeqhrDzln5Rk0TkoHday1VlLS5ViDEdfMYfD4=
X-Received: by 2002:a05:6102:1489:b0:7a7:bbf2:182e with SMTP id ada2fe7eead31-7af1bb76367mr1717965137.9.1790289065235;
        Thu, 24 Sep 2026 15:31:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.31.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:31:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 10/20] shared/uhid: Fix size of Get Report reply with a Report ID
Date: Thu, 24 Sep 2026 18:30:35 -0400
Message-ID: <20260924223046.605543-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The size of the reply did not account for the Report ID prepended to
the data of numbered reports, dropping the last byte of the report,
unlike Input Reports which already account for it.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/uhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 919618a71b00..36a16c331e83 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -530,7 +530,7 @@ int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint32_t id, uint8_t number,
 
 	if (number) {
 		rsp->data[len++] = number;
-		rsp->size += MIN(size, sizeof(rsp->data) - 1);
+		rsp->size = 1 + MIN(size, sizeof(rsp->data) - 1);
 	} else
 		rsp->size = MIN(size, sizeof(ev.u.input.data));
 
-- 
2.55.0

