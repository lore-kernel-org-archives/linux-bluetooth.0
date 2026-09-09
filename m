Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFA39D6C8
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978535; cv=none; b=X3831tRwT0T1z9zADq2jypUVrsai8v/6SdjJrZIwNGgMsOBQHaeynUGweN1HPYXr9rtqOyW/I9leRLYxTD75WpsyZ43ZaPoSBcEqwa+xLvGqEnQ+KOKoRcKKWKWOTmTU7eUoPtWvDNRZmjGr8+bCFGxR+WTfisTZlxwDKNhdGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978535; c=relaxed/simple;
	bh=voamRdGe5zBb6ihef6zBif/MHrrTmUJ1oVQQYxkmuNU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btEd2Po5cuWEhl5b9y+xnCsAaj2wVC7fjoOpStHwuqXjKKDViF6UPRQ4Yke15/gLTYpmSDzodNqfoDMj5trqk1Om/EmbERDHvJ6MFSiLZTSzQLz5y1bJ9nT2DkuLDSpfpuBkcusX+4dqgUzfZvtvD1tvcTLXa415UIAYqeNDEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao3XUmJc; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao3XUmJc"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5292fdso507444e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978533; x=1789583333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7GYxkPCu0FUFHaN9n/82WODo2QVFNeGzJe8Zb/Sxr8U=;
        b=ao3XUmJc0trjxPkQOt9KiZrdHMwqqk65oHYeUCDVmc9m6E/G+Iae3WN3s5835HDUWm
         Q0Aqwb0mpPNJg75lpOHjhpLSUPK6rIrotMHgi+X3z7lsQDOp/qsxGoFUSet/XO6vskqW
         cyANlyfhVgsMTVxjYZEynP31DQIQJzDpSCJvguv3BTj/+i0ILh4QZw1tCzHODMnqSsgY
         Tsrw7bcMD3i0MROgbhPtfkBQAXPW4KJfutTNJEKsKR7oB6xy/4E9aWNXGHYAALqYAMhx
         jYoKKqn+sMnCACWvSTTeN5Be+JfaCqYRa+GC2W3kzTOEyqAr4B2U0D9dN5gEvzmnNmoZ
         KiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978533; x=1789583333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7GYxkPCu0FUFHaN9n/82WODo2QVFNeGzJe8Zb/Sxr8U=;
        b=KTcyxgOVvEH1RKEKAQE1ZEzuznywGGBudhktQlzVgfYoAxlB4mOjeEnQSgvqzmS5Y+
         Vve6lh8JFenmX17SLDWXnAI32cDOjjCCe/gdxocxVaGKHj5OMO97z22buW2yrXHEEvgc
         FvqGud/FoYAFd2xvdDZXYndG8jq29mLR6/vclVGWDUjpXT53q3HeUslKh1HBmukfFV4S
         rSHg0g0SQRFLcZwckQBXnXFMWv4DVoHvLfE5OqZ5E+i3Unoci/PBmkfSIQTFKOt7pVBe
         bWnQcEDz/M3/FQkOYnaylUHI3mO0R8So4zg7xLN0nVulbV24kNXWs7ZGrWfErqum1d2V
         cUMA==
X-Gm-Message-State: AFuF++kBx6vguDWZpDDWMiGndDPlhtEEn1EKr7C8dvKpi5ctTMCjCK4R
	A8/K1kggL+Y+74CgHBAiJDVYztg2/Ytj26N6Iq+VwfDB271JxWE2R1ToEYYMi5IX
X-Gm-Gg: AYBFou0aqoe1/APF5ruTBoKQ6ff3jG/pKKqHIFCCVCJUUm/R0IVcOrzd+yQqdPUoA6B
	W7RAqZMg+17TAkBINEWhn0hvjqpOYrsACXO+Hu3/vO+aWV5VRLXGWQS6FfrNYn+3NmqUrpFG9A5
	7kBDjiJIw+3vlplgCK1B4os5IPfwcbJknrkHFZB7LVxv2zmFFEsaOYTWvF6Lcufpd2tKyalfoTR
	sRG1mRk34VFzRjDFNAOe6G7lWRbvpYv1hXhNHnccuEiMrxfv8Hr6V1z1WDx6zPbpaViKex0WDk5
	42rzJvH/FHKcxpxs76vmplDa/u5qsx6vYqSEWL5InaW/bV0vpNr+cEf0KaTcrPmxVwOfcAybyOO
	sZbipjq1ShKJRn5kOzM6zvDvaxsdB90qsUceAimBuxNV1JrVCYV4lFAKyqxO78UD+31Hos3QIaV
	I88T/6hPr8jYraKl1zRPNuyrf/woni7uxApUpwRZuhPUYBXRuCbWJw5hirQbvifbBy4DFu7njd4
	Fyn2OVGS4XCCmBN1nByhvmDhxgrbVCpl4lvDNkb1bEhSMqQopG3QI9dScvHV2ccehE=
X-Received: by 2002:a05:6122:178a:b0:5c7:ab80:2922 with SMTP id 71dfb90a1353d-5c8287e72c7mr3908467e0c.6.1788978532706;
        Wed, 09 Sep 2026 11:28:52 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm5399388e0c.11.2026.09.09.11.28.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:28:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 02/10] doc/btmon: Document the request reference on command responses
Date: Wed,  9 Sep 2026 14:28:32 -0400
Message-ID: <20260909182840.1289776-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909182840.1289776-1-luiz.dentz@gmail.com>
References: <20260909182840.1289776-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Extend the Command Complete example to show the request frame number and
the response time, and describe how the reference is resolved and when it
is omitted.

The model drafted the text, which the author reviewed against the actual
output.

Assisted-by: opencode:claude-opus-5
---
 doc/btmon.rst | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index adb2c9881f97..99d6c8ae2760 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -232,14 +232,26 @@ input going into the controller, ``>`` is output coming from it.
 
 **HCI event responses** reference the command they complete::
 
+    < HCI Command: Reset (0x03|0x0003) plen 0             #5 [hci0] 12:35:01.843185
     > HCI Event: Command Complete (0x0e) plen 4           #6 [hci0] 12:35:01.864922
-          Reset (0x03|0x0003) ncmd 2
+          Reset (0x03|0x0003) ncmd 2 #5 (21.737 msec)
             Status: Success (0x00)
 
 Here ``ncmd 2`` indicates the controller can accept 2 more commands
 (HCI flow control). The indented body shows the command this event
 completes and the result status.
 
+The trailing ``#5 (21.737 msec)`` is the frame number of the command that
+this event responds to, and how long the controller took to respond. It
+saves scrolling back through the trace to find the request, and makes a
+slow command obvious at the point where it completes.
+
+Several commands may be outstanding at once and they need not complete in
+order, so the reference is resolved by opcode, oldest first. It is omitted
+when the request was not captured, which is normal for the first commands
+seen when attaching to a system that is already running. ``Command Status``
+events carry the same reference.
+
 **LE Meta Events** contain a subevent type::
 
     > HCI Event: LE Meta Event (0x3e) plen 31           #487 [hci0] 12:36:18.974201
-- 
2.55.0

