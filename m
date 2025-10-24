Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E18726ED34
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323776; cv=none; b=cYHYzwDTvS4tEOAN3HJyOuvxYij+v83k7NpWSgpQYgCkqUAZWCiRBhPLCs0MR+MtZWlMQIfhTdfhqQzntBIFPnAc7BzZnOd1pRinzfq8OELphhg8Mu+gga1fvXUNSevr7VDztjG/LkIf9s5xYtd9E3KR7zMc5XL/Pg49Jf0hbYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323776; c=relaxed/simple;
	bh=Qzgh4TwmdqAlsGKEFX9L3ufviEEfHBTNxvxl57muGoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4zHxK/UffWd5ugS3MNkyRSYURbOJf8yZ2FBm2lmWNiykby5htuK543ECTmSih+25Om5t8sT2frSTpabuSqdS6ftHC/5yAlrI9n+ZYnMnlNRVkwERGZl4w9GrSuZ5ydMYkZhpkK4kfwrKDP/IBHfvO1cEfHxKHBVktAoZi845sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDXnk4v6; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDXnk4v6"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-81fdd5d7b59so22071986d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761323773; x=1761928573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBtuboWe2Q4Plv4p7qqEyz/yAU9YybNXJhSJ5Y5XAWw=;
        b=MDXnk4v6AJ+waf0J0A8j7nuXNvOw48j+irRaQNHc/IMFaEYRJoU+N0mN+wyQnYjw4D
         UfE+KCzaekNifpmu6ejJdMWWXnBcORVhQJCfIxckXMbbfVZZvYeKFUmw/SmVoTP3T5gk
         H4l7pBoQwJsPTfQOUhXFQEWl3t4RCnK8kejg0njU/gCDzpJ/Li4tR38ZoL9TkvGp1rSl
         GZEV6GlsC5qQ8gZQ+PsSEIMqA5EacjyuY0AzGjSykBNGlnWlTJPEdgFm1hYcT4lvDPeW
         ZD9+93kz+b5v+7e/nN10QyalYO84RTAgANi/BWFQgRdzs5xzdTDf0iQN6H5d1iNqfni3
         sQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761323773; x=1761928573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBtuboWe2Q4Plv4p7qqEyz/yAU9YybNXJhSJ5Y5XAWw=;
        b=TX7yNqdTgKiI60DRIp9+lPqOk6eKFGyKey6dPAHUo++YFKmjhwCy4gvhmupjm5I3kk
         rG94gDZcveN4E2sIk858GU/jv393gWyd+tWtGkUPnj/lvGgdCRJUMLPklKo1QCLoiF8p
         Cr6tbGHoPS0S0WdH915rAOb//wLvzxt5LGtvnA4qIYtInDJagF/YP89VN04rWahGOz4I
         vSNzuumRJ0MXbFtLA1qrnUlQJDmL1+tA3iYwFMv+mw9LWWDbic/RQVe58tEGwqRRbmA6
         LyzBQz0rpoWJLWsj4wR9laxv5coRg1zspJckmrisIOfwKFfEIu3eUds7cDjfYdu5Xdpe
         DEEA==
X-Forwarded-Encrypted: i=1; AJvYcCU0JbIH0V2ivB+tBrzzT2bClHn81E1AkR+559lXQLrb0WPTJM9sewR44bSSBsr/acMSq11LKQomF03yUDDJpbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDc75p0vhypb1JQ8cczai377F+tRtHW+JUQJlY9mkA4ePa57Y
	DzZqIimQk7AbuGhJZuZdkZ4+RXOWGE/JBBkkcGmoMGxpUZTNzWFOBPs9
X-Gm-Gg: ASbGncs4MA2ceKjNFWtTm7xmQsnIyxAU/MCTtijOSAsMYLpagbgQbeK9c6hOIHtntyK
	1N3W7WB1aDrusm80iwIos2+CgzDHAcdda8zi+84UJ2Az0Hfy0gC5ahYXfQ8hGRd5818eoQov5Vu
	Q0Y0/kRHrS8076T4zfd2iT43Ad9Cha4HhKLV4XaEYyBFFGJZiu8wFRonWZmBa0G9T2OvlrMRMd4
	ZbnkffwN0mqhu/wKrxrFVa3tUYjxaFAvbzCGWPqtJTrmP6oa1LsMoOKk7MqsavSztWetgbCIVWM
	7gvFuXkBfdmIkYUsVeOtCUP3xdFzTKnTf82jgDZSfAaLlM/a1U3e5PVlh4w+WVEx7siUb/X5CgC
	4iUjeSYWyOXQ46E2Aghyn9TARHx4MRIXafKU68vdy+V8CuXXHXlAVCB5Z7zaTjsHI7ozcVqCc4z
	p0Rmt58KjzL5sV/DH+Um892mwK92poakI=
X-Google-Smtp-Source: AGHT+IGKHP8NoxcYy/C47NubjPRMEfZKuZ2ykE1dPkqqxoalIE1zRnG5oQpATNvC6wV2Okf3syX3pA==
X-Received: by 2002:ad4:5cea:0:b0:798:513e:3bd with SMTP id 6a1803df08f44-87c20545decmr340344866d6.3.1761323773013;
        Fri, 24 Oct 2025 09:36:13 -0700 (PDT)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f8fb6d2e4sm40908776d6.13.2025.10.24.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:36:12 -0700 (PDT)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH v2] Bluetooth: hci_event: validate skb length for unknown CC opcode
Date: Fri, 24 Oct 2025 12:29:10 -0400
Message-ID: <20251024162912.221224-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZJtp0wqL_SJEk0wVo4DuadrBirmJ5VOe_TyE_RN8jOJNA@mail.gmail.com>
References: <CABBYNZJtp0wqL_SJEk0wVo4DuadrBirmJ5VOe_TyE_RN8jOJNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hci_cmd_complete_evt(), if the command complete event has an unknown
opcode, we assume the first byte of the remaining skb->data contains the
return status. However, parameter data has previously been pulled in
hci_event_func(), which may leave the skb empty. If so, using skb->data[0]
for the return status uses un-init memory.

The fix is to check skb->len before using skb->data.

Reported-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a9a4bedfca6aa9d7fa24
Tested-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
Fixes: afcb3369f46ed ("Bluetooth: hci_event: Fix vendor (unknown) opcode status handling")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
changes in v2:
- check skb->len before accessing skb->data in hci_cmd_complete_evt(). 
- remove v1’s changes
- update commit message and Fixes tag 

Thank you for the response Luiz. I didn’t want to spam you or the ML
with another reply since you were very clear.

 net/bluetooth/hci_event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d790b0d4eb9a..d2ac95a824db 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4211,6 +4211,13 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (i == ARRAY_SIZE(hci_cc_table)) {
+		if (!skb->len) {
+			bt_dev_err(hdev, "Unexpected cc 0x%4.4x with no status",
+				   *opcode);
+			*status = HCI_ERROR_UNSPECIFIED;
+			return;
+		}
+
 		/* Unknown opcode, assume byte 0 contains the status, so
 		 * that e.g. __hci_cmd_sync() properly returns errors
 		 * for vendor specific commands send by HCI drivers.
-- 
2.43.0

