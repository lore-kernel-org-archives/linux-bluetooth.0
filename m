Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BFA3D0AF
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBSzuVED"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783182d4a0aso255843485a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 11:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704827347; x=1705432147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gxMh/XZqeJNIbjEzr56tNxTCqRqB1iF8p0Up7EnBXtQ=;
        b=jBSzuVEDxfC29KbGyakCLpUmEc15eBcC9rnn5vXqGHHzuvKiQQKNPan1iGsj4rjfCH
         l6uPT0+AtF6m9b46tHn+i5tq0DFCON0Hmn2zuHARxlzCdykPBFbJxLUG2DN5eLk+uzPH
         dOyhvvA3daufaQmxtYsCByRUN4wwCwM6DcKb8miN8JDKgg512tLuaYkSbkgvEbTXS9On
         rrixTgX2FDzPNLrlSI5jfy0OIMQRz3+0Ax1J215TotAJ66Q1Sk3J23PFQtXhd9txhPe2
         gCcrgAJhLMEO13Dfb0ZAs4IL4ib9NcG4G5pzntmrWwI4pi2B4tEo6sLIlCJnPhALg0Hl
         KNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704827347; x=1705432147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxMh/XZqeJNIbjEzr56tNxTCqRqB1iF8p0Up7EnBXtQ=;
        b=ptv+olVO5Yu+GDKuavpPFUd8BdehyLVYMiVzing+iV8LKHOgt91oAKqKNe2w7hr69A
         LhABAOeqbsrJ8c4SUnltqtPp0BKWFmmt8HF/urTTMgEwaUxopOtLeVdHYzVBIyITgg9t
         KUvRDnrkXxHeQJTOeZ0tmFpZeL+dqDDis/WwlLaA+35ew+vdP0zI701HQurZmt0D3v4B
         EReM+thNtB3ODMQTqFBOTnYfnFrrayKDSLqHkhoDo1yrzUjT+yVpsmGin3y6R78qJoIM
         HYnzVdvjRtwFvRL3HDxVDH6bHZHTs7MBRHs5v1FUaQc1p5truiVWB6RKUKrLOrKAvhAs
         lY0w==
X-Gm-Message-State: AOJu0YyYnyvmYIuHSzdmHxrMKh0clWkMulKJAkPP7OaOXZAvcLPzXAuC
	e4qiU+bDq1lfMhApqUXXgBp+fFD3Zig=
X-Google-Smtp-Source: AGHT+IHuTzBJxICKzow1+g0fLSw+Mt7mR2f+dhdxmwnkgHEUujaWTYlMz0NtmlCZzYpdgIeFZZZYnw==
X-Received: by 2002:a05:6214:f24:b0:67f:d5ac:4b3b with SMTP id iw4-20020a0562140f2400b0067fd5ac4b3bmr9248637qvb.115.1704827347474;
        Tue, 09 Jan 2024 11:09:07 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id z17-20020a0cfc11000000b00680ca85b06fsm1110332qvo.31.2024.01.09.11.09.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:09:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Complete request if command timeout
Date: Tue,  9 Jan 2024 14:09:05 -0500
Message-ID: <20240109190905.546266-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If command has timeout notify the hci_req since it will inevitably cause
a timeout.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e5cb618fa6d3..acf4d99cd8fc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1523,10 +1523,21 @@ static void hci_cmd_timeout(struct work_struct *work)
 					    cmd_timer.work);
 
 	if (hdev->sent_cmd) {
-		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
-		u16 opcode = __le16_to_cpu(sent->opcode);
+		u16 opcode = hci_skb_opcode(hdev->sent_cmd);
+		u8 status = HCI_ERROR_CONNECTION_TIMEOUT;
+		hci_req_complete_t req_complete = NULL;
+		hci_req_complete_skb_t req_complete_skb = NULL;
 
 		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
+
+		hci_req_cmd_complete(hdev, opcode, status, &req_complete,
+				     &req_complete_skb);
+
+		/* Notify hci_req the command has timed out */
+		if (req_complete)
+			req_complete(hdev, status, opcode);
+		else if (req_complete_skb)
+			req_complete_skb(hdev, status, opcode, NULL);
 	} else {
 		bt_dev_err(hdev, "command tx timeout");
 	}
-- 
2.43.0

