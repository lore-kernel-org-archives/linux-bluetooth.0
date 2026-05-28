Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E43B27DA
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961513; cv=none; b=aEz8qW1tqjT85AE0wra6psz/C2N69DqlXW6YRz/Q4ehwFTfO11Sf/zwLf4/cY0FRX8JLpIadASsjwAmE3LkKNiLrfGVQbMrha2dpKr3PEEBo6SmAfKcOzSGxYEfoamvLbpkwVMrFtVNG0CPqzVJ8FxEUJQlt7JcyPtcoLQjkt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961513; c=relaxed/simple;
	bh=IfbBa6mGkbkRWI0hlfFucfNIljPfTM3OpI3kTgA/dpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNAkg8KZf3OCafmIVELblQ4sbmMR+bWu9rANtAewctEtNzzSKd1xxZO0kPbrgKKD1gO7h9cN+ppmK3xP1rGx+DedfW5yUT3s5ex6YdB7AfZeUmMnqajrBjzx5wVuB2kZudOrintPIpQfIhelWM649HxM5S7V5hw7G0PtQCkhQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT+lcFTY; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT+lcFTY"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c801d732058so5628897a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779961512; x=1780566312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yBDHnHhRFcY/lY+WGqOKtRwJwLgBPCUwv4P0vLy9mdg=;
        b=TT+lcFTYq4UqjMYVJIRjfcAbi0BCPWdW9hza91ugup17b3CEySmTB0d93yM5ITpSxs
         Fw2I4DjvB3lUmx/GHj/yUN3+SqISD2jOyxesCiBCG0ijdZhTSSYNeRmNvK5/YX15n/54
         3YkPMKjUwif6NVzCV19q/aRbkFrkaXDCIvZq5rAE637WkCJnVQQgHGH3s83nM9g68lyn
         wb4grpKpU4x1W+75I4p3ikrA6UwchYsmFMFx+E1XUV10GECk41vNdpK8LQ4nUs908tzk
         5ZM7oScFMHKYvR4gfZTUrh86j06HIq9ewDCn6F1y2EivNqnkN8qv+T7UYbOdrDko4fOZ
         6bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779961512; x=1780566312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBDHnHhRFcY/lY+WGqOKtRwJwLgBPCUwv4P0vLy9mdg=;
        b=Q4oGG99TvG8O0xAw6B81AFSHfZ3U53KLA0xknd2uCDeR5siJOKJIItNzruLlSsouto
         mWI6/uB75glx1yn/aeamZhgqaTIkY/iDDjNb2gzw+eJUZ0Lx2Qa2z+XD+2JKrLo06AqR
         l4OSbUbLYr87//4ELmzyWhfbup9B77bdGrS8ArT6pnLXUbQ22rKlZGemDASSGradAiPp
         0a1vCR5Cz7ICdW+nUZpZ8NRzUsf8nELF6AxP7uoO7wWeokIXZXd/TlAE17J+qJyv6LZy
         jO34JNr0pv/QDWlXSYKfL/eGB07ZGONgNGncDzlbeaLjJYlvumOXE3pY1cfVxo+uaJdv
         f10g==
X-Gm-Message-State: AOJu0Yz/8kluPEHgPMDQfQbRs/+ijkAi5vqW8EzCBw7JprpmEzKHq/1k
	opLZzz8hOt5IBMAnKWDBGekWtwpRHH7CaFEi0Wb1XwTzTJ49S18xbGaJ
X-Gm-Gg: Acq92OHsN9LTpwdLhkvfUFJ8vz9YHPSjnm4XWRE2DzqI4Ttlx1dyNN0w5Wu+8J4vYu8
	tC7PqaVzuy2jwNDyepqYwPmMP4MDd8wuN0YPGv4xpUk/8bnoICmQ6qwWv4garohuZV9ZKJfcZYK
	N5SIS+Al48+sY6mbRrKGe67tBzu5zGp/qlJLzH82oZQecRUdWGH7d5oAcWt+3RFqRnLE7weUvTw
	Bb88f1odIMyNanRY4TespeD4TzUW0U/rLfjzpfwjQLbZ8itELKUZdatj2I8GuOrR4ty9xbBHnmQ
	QA0cBPROfFvjhsT3wPdkSsa7hZZYOo9r/s5LtMy5D6UMo+VuJCqgx6c1p6Xzte5GYV6ngU2aCmp
	pMwWLickbQ2asHw+RpvUZsa4dumbKttZXVWc6QlmSRUmCS3ZzX1b+V9bc9gVTK8xyy3rfMkBTaw
	x3x+wJBudvDpRvs8hk/voP5LCLp+aNPC6WrwWipWCx/w==
X-Received: by 2002:a05:6a21:48a:b0:3b3:23b4:6950 with SMTP id adf61e73a8af0-3b4024e00e6mr398772637.18.1779961511853;
        Thu, 28 May 2026 02:45:11 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70ba03fsm5314756b3a.33.2026.05.28.02.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:45:11 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH v3] Bluetooth: MGMT: validate advertising TLV before type checks
Date: Thu, 28 May 2026 17:45:06 +0800
Message-Id: <20260528094506.3699804-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tlv_data_is_valid() reads each advertising data field length from
data[i], then inspects data[i + 1] for managed EIR types before
checking that the current field still fits inside the supplied buffer.

A malformed field whose length byte is the last byte of the buffer can
therefore make the parser read one byte past the advertising data.

KASAN reported the following when a malformed MGMT_OP_ADD_ADVERTISING
request reached that path:

  BUG: KASAN: vmalloc-out-of-bounds in tlv_data_is_valid()
  Read of size 1
  Call trace:
    tlv_data_is_valid()
    add_advertising()
    hci_mgmt_cmd()
    hci_sock_sendmsg()

Move the existing element-length check before any type-octet inspection
so each non-empty element is proven to contain its type byte before the
parser looks at data[i + 1].

Fixes: 2bb36870e8cb ("Bluetooth: Unify advertising instance flags check")
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
v3:
- Move the KASAN excerpt earlier in the commit message.
- Add Reviewed-by from Paul Menzel.

 net/bluetooth/mgmt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index de5bd6b637b20..027b266ccc747 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8638,6 +8638,12 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 		if (!cur_len)
 			continue;
 
+		/* If the current field length would exceed the total data
+		 * length, then it's invalid.
+		 */
+		if (i + cur_len >= len)
+			return false;
+
 		if (data[i + 1] == EIR_FLAGS &&
 		    (!is_adv_data || flags_managed(adv_flags)))
 			return false;
@@ -8654,12 +8660,6 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 		if (data[i + 1] == EIR_APPEARANCE &&
 		    appearance_managed(adv_flags))
 			return false;
-
-		/* If the current field length would exceed the total data
-		 * length, then it's invalid.
-		 */
-		if (i + cur_len >= len)
-			return false;
 	}
 
 	return true;
-- 
2.43.0

