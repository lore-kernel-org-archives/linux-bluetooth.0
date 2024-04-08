Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728DE1487E9
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612583; cv=none; b=n0RmYOghUNkLB32Y/O9huy739SJp3odfIZ2ppzYL5A+dAZ0p0q4Mf9JmpWBTYW5tcVPfqOOQBEF2bkcoeIKaTCov8XUVu95IpWLFdGjOUqgbFSK2yPb6A4bgxjZQomzGPbsbVPaZ5O/QLZV0dG0/5gPxYUMZK471TeoslcFmsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612583; c=relaxed/simple;
	bh=9aJoy5YWJ+2dlXqHyIFDhuX6VFc2cSpxJgETMwfMlRQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiriGXJgW1Q9t74af+U1uojn9OZdiZBzhL88Lc1Vf8QfLj09fmzr8igiscnMjD/HrrXk+9Okti4cRTz2vJxPJB0ApyNdl+7WOxtPHn/InrYyiaHmjLqsIuYlnAesdzZtZlhM2x/9yUXVXSBgSTJaylptiGdCxS0/p0svnLSPXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHlvgN9g; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHlvgN9g"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4daa91c0344so1625368e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 14:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712612579; x=1713217379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl+SppwAKGBp8KZCd6/T4Y1i/PcNDdL3WeE9JQ5bmM0=;
        b=QHlvgN9grb26iyY00oFckwDblYBrxBaF4ZQltPf+XGUNaWTz8La7k5MRfKu+KxZTzK
         N71+XsWiSymUX9kbgnNdkglZc2JF57Rc1YstfTSixvFW28UllAWPbTLv+4krn8aCLhM9
         tgLC5jiAVqu/3PdTnRB/MAfv07dxepKTLZurIznh43lrQ0yFh5k1oSJ6j3doN30wg1FB
         Vc7ccKXTZcsU4/lW5z6Sp+svnvceUj86NgAn+wExkF6Gl8lzPfUSWi8bBbfSSa7w3FuS
         97A8DPLVlmEADXJMnBzURVXhdG9acalC3b6iMnMhUt0oCfIi8zi0UT0kT5isv6FM3Li1
         +/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612579; x=1713217379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl+SppwAKGBp8KZCd6/T4Y1i/PcNDdL3WeE9JQ5bmM0=;
        b=FZ+wBXR4YYbofdyvF45lACaXgcI6t+LrhnIQay4XxQPsxZdDZuwn0XBw6Yn9Kzulel
         JnkOBYlCQY9A1qzWEUP3XcKZ2FzLxbVbp3amC7sOIC6Y60h0117US8c0Cdih5uyksUJM
         AT1rpBHWoWxEqcjbp115a+JgyyQhniQYsShi+4Xjp2xhEQJ3x4yTGTxQQcyHZ/q5iQZU
         lJhsdDg0ciZHEm0LyFdnwDwftDIVDx6tZgrGQC94dWUNUeeBX9i/AOCZS9Ii3UBvZacj
         xlSk1fpo0TfL2Y8WdYAd2kvKM+c5xBFltOfUjNGWQsgM11PV8R4mrlCNCa4PQFJ4N5wo
         42tg==
X-Gm-Message-State: AOJu0Ywuk3iR+LrsoGxJn7Pj8kEFnOecY6PmX1FzhzEoamFvgxCwICIo
	942vqJF7O9G0auf+kqqU5V7kjwl3V2yLpxwfhvLWc2I5V2z1ClFtUQjG4aRW
X-Google-Smtp-Source: AGHT+IGnj44Y4FQRuIa4nwhMBKtP0iWIWuAUbW1iTGxfnyaHyrkPJdI7op4KBn/B/j1lzDmMpBiRAg==
X-Received: by 2002:a05:6122:1aa6:b0:4d3:3b1b:aa92 with SMTP id dz6-20020a0561221aa600b004d33b1baa92mr5949955vkb.11.1712612577533;
        Mon, 08 Apr 2024 14:42:57 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id h20-20020ac5c294000000b004ca7514ee1esm1063625vkk.32.2024.04.08.14.42.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:42:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] hog-lib: Make use of bt_uhid_replay
Date: Mon,  8 Apr 2024 17:42:52 -0400
Message-ID: <20240408214253.3758319-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408214253.3758319-1-luiz.dentz@gmail.com>
References: <20240408214253.3758319-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_uhid_replay to replay the GET/SET_REPORT messages
recorded during the first time the device is created.
---
 profiles/input/hog-lib.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 8071e1364b10..0291adb6eb23 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -856,12 +856,14 @@ static void set_report(struct uhid_event *ev, void *user_data)
 		--size;
 	}
 
+	if (hog->attrib == NULL) {
+		err = -ENOTCONN;
+		goto fail;
+	}
+
 	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
 				report->id, report->value_handle);
 
-	if (hog->attrib == NULL)
-		return;
-
 	hog->setrep_att = gatt_write_char(hog->attrib,
 						report->value_handle,
 						data, size, set_report_cb,
@@ -1726,6 +1728,11 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 				"handle 0x%04x", r->value_handle);
 	}
 
+	/* Attempt to replay get/set report messages since the driver might not
+	 * be aware the device has been disconnected in the meantime.
+	 */
+	bt_uhid_replay(hog->uhid);
+
 	return true;
 }
 
-- 
2.44.0

