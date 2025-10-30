Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63EA36334B
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843720; cv=none; b=irCwSz0kOyEPS9PDU1iIkAvRN2TIieGOqT50nfckCNZDPtslMqZYY7XPzOTUqEWx5HHNmDz9yh2CkLkX3SghvOAfwJAf6Uy55B7y5NpoFNyXanNEqU5C1zF/iZ1wqa65bJFp8BNi0zFxHdBQV+/lCkVLMsidBGajIXdl3ch643k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843720; c=relaxed/simple;
	bh=LpJ2UN/YwkLzcjhS5OmWWMj7FhR2ZFaafCK0TgpPcIA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gcEQZyPIhBS/gCVHz5NfW3sHVP+XOV8YczOvGFu6x9NhgIfTzd3YmKM1X5vQI6EEy3Xad7LYrL2GziKm6NsGccITLnLfzmdahFKK9pmljVKnDw2dwJunFMn0PtONivbmkxs7AesUihxDQcF+U72+J2IoU9wiG7hc+wmAIotq+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1nHjTET; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1nHjTET"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5d758dba570so951161137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761843695; x=1762448495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp8wJEq0bGfyJZWtmhouJEynMd76HtulbeysoHrepF4=;
        b=V1nHjTET3AOfsrZ4/6KZtcFRqfa77FuL0lwJnscNgS0HM+UeYSkyhvS39YHK01V3Uk
         TKFzsv0GoQJTH+EyGgqexS7Atg8/hPUAFiYmd4fzFjD9kpoImKohnhSUhVgtGQmXf1FK
         ccZQHGy1UKx4coKrEjMF2J+FeSnR6XSdVgidPanB8AD6wLL5XrBbeeSmUeBZpB+ld51L
         chXI7NIwtAFuhCGI+CGvAOZGzRPHF/Sqofc5rI26To54/R6oxn0DzkPxtBhm4f0CXZcs
         nd69Anl6E0QB5lYVRlCHL0hMEeOKTcHynAlyauV74f9ptcVEJPFKRrgvqBtcUflou/Q6
         IadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843695; x=1762448495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp8wJEq0bGfyJZWtmhouJEynMd76HtulbeysoHrepF4=;
        b=Fov/EG9WMAjK3y99GjRAnTB2+pkyQ4PVcMsLEU3Jnzncu50VN8ZbhLsk7c8Xeb5mT2
         Om6G84JlmGhN38CynhcISRQaAsCGRkGIKktYqazTQcnI6SGyDls13ZQQLRbtGBA/sH7U
         sA9CNh6in34DTaoawIxeQxw7+VMrnox5S+fpF4HQz3XwWNKNtbJgChXka8h8ux7ZPVcV
         lDzQSh8vsc3kzugtwjgDCnAWYOmQzv/srtK4VZxB+WszRqC1kTeC08KDrJbqLM59dZ4W
         fwpucrdWBYEwhoQPkyzwepl2UcBv+PlSQPJvL+R5JnHesmgd+aluXSo1t5A9KSJcfbqg
         ZTtQ==
X-Gm-Message-State: AOJu0Yy2LTfzUMVypDCPrcP0K+cwQcD5tNKvZAyc2FhDpHWske6+tdgz
	k+RLvCDs+fbOfp7gZeGwcNdP6Dujj7pcsI2vjLAW5/3rGcKN+ACQogw9eDDrhT4X
X-Gm-Gg: ASbGncsP4uZvGIW4laIxISBrmkqP4MTzokDvkmI/IjPfoYYIGKNHzu06t8Wy/OQ8N2M
	3Olr94vEGoj3i1KOmxRw/K1l8wKU5PeRQ+jv0i+huxniBW3YwtKM1xTqxzPZAws6pILXfYyxzvR
	nlyhdeLj/wm27b+TZsq/Rw7ZXZ18OH6Ie2nxCiCf6l950QnpUS442qgTHdjQaI0Dr35R93hIewk
	Cq+JFMkfOduoYpuybJ8TCTJi2a5xTGp7UiNzqmmbsyjvA8D0y7mL0wcmqtPsL1S96z+oEQX/067
	v5maJ2JKs67nilSe478sTOCiHddZIkKDopGHnKHn7I+4AdFJWabRIvs97L4Lrr7rNmP1CizdEjh
	CA66UsHU2bYJVDQ/klWP49k36n4OA9lL2IcG+Xc2Kr8CjR6snT3OZo5qI8It6WELtpUOMtvMclJ
	603eMbs5f9lLJDH7+h/zGKlq31
X-Google-Smtp-Source: AGHT+IHFegvOeGHfNC4Mw0w+AU7+9kft938pI1aaCMfR+ox1pmhVvU1M+AkB5D8nkEMYoGATC5SRew==
X-Received: by 2002:a05:6102:290f:b0:5db:23ed:3840 with SMTP id ada2fe7eead31-5dbb13590bdmr52442137.37.1761843694133;
        Thu, 30 Oct 2025 10:01:34 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9350197756csm811781241.11.2025.10.30.10.01.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:01:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] bthost: Fix crash on bthost_past_set_info
Date: Thu, 30 Oct 2025 13:01:25 -0400
Message-ID: <20251030170126.251566-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following crash:

Invalid read of size 1
   at 0x401DEFE: send_command (bthost.c:1101)
   by 0x4021F01: bthost_past_set_info (bthost.c:3758)
   by 0x4006038: test_listen_past (iso-tester.c:3246)
   by 0x494984A: ??? (in /usr/lib64/libglib-2.0.so.0.8400.4)
   by 0x4943862: ??? (in /usr/lib64/libglib-2.0.so.0.8400.4)
   by 0x494C7A7: ??? (in /usr/lib64/libglib-2.0.so.0.8400.4)
   by 0x494CA4E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8400.4)
   by 0x402CC4D: mainloop_run (mainloop-glib.c:65)
   by 0x402D224: mainloop_run_with_signal (mainloop-notify.c:196)
   by 0x402C445: tester_run (tester.c:1084)
   by 0x4005609: main (iso-tester.c:4335)
 Address 0x40 is not stack'd, malloc'd or (recently) free'd
---
 emulator/bthost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 79d8305d78cf..faabbaa36a4a 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3751,6 +3751,9 @@ void bthost_past_set_info(struct bthost *bthost, uint16_t handle)
 {
 	struct bt_hci_cmd_le_past_set_info cp;
 
+	if (!bthost)
+		return;
+
 	memset(&cp, 0, sizeof(cp));
 	cp.handle = cpu_to_le16(handle);
 	cp.adv_handle = 0x01;
-- 
2.51.0

