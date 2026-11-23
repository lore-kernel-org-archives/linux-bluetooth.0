Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453970;
	b=lsc1iS7r5ueEAPOCWz4Szzm0puxqUYxIhR9ZGnuVs2gf4pj3jYE0tmyzNRmqKaRqYKMi
	 V7dn3tmjCkBFZqdLjfxiS9IlIM/yLAC11PXgpx6yyNRYJsv3J8Jpk3piz+YmOVsbJiKoo
	 F0aVszZgIEmY1haDLuiIXs7hMZXkvvnC5Bp7YX/cN3sI72VMQrVv/m+Y5DbvgHyg4zkPi
	 UK0eiiFbHUA9C7mcTJ6evALKkInYTkl7buAwicAI1rcIw72NY79GUEYeV+jPxwAsbblYu
	 L55Y0FOUVTxiugUSCO4UXbXp7oZ42B5lKHM8M2xToHlR+IWgYqX/4r4LMKT0GmLExkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mn9M3aWLgzfhrVG14JgwlvrpeRPh3f3SC3enbOvr/eQ=;
	b=zLOtebTWt+c5noNc5UG83kWBcCLNt5HNW53md76SaMfHU1GaTluvAFjmLHIjhBFCQJZQ
	 erKpWOKPtzs08MmUagEg8nH9jUPXX7DRcbwhqX8QdFWVuJnTERkxp3oP0H9CUOQ9pwSBS
	 IqVVjiSES48X3NLVY/fruHZEJ4kzG6tRws4aNUkXviCikwrdLZeMCy0+eXZqBS/NTECdm
	 syO1m4lpnmja7a3nzZfV49kF48iZ2E9akmgzZhsa3R9Oij+5fUjJulLt0Tj/tzNE5iO1R
	 tTI8PNYN0brE5P5Jr1y2TBU3Y0nQBufVAAN0pdHyfg8W4t5TUojqeffXthpn4rJXj9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=wLbsocAn;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFF606A31F
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40CFF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=wLbsocAn
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49a92144733so1719159f8f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795453969; x=1796058769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mn9M3aWLgzfhrVG14JgwlvrpeRPh3f3SC3enbOvr/eQ=;
        b=wLbsocAnOKERHwbTuBCdgmvRfB6I4/VlQkzwo4lS1oHBg/a5F/vqoL/AzflD+fVrVr
         /gHthLjYncvV0l+mxaGxZMtiKKy7yg8lpsICmT/Ovii62m8Y/bhig1ZJZuPDvVTMTXDx
         vABhEJ3+8b5MxM0QtnjuelY91RZPQU75txjnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453969; x=1796058769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mn9M3aWLgzfhrVG14JgwlvrpeRPh3f3SC3enbOvr/eQ=;
        b=qeH1pWiyuwelM7w6MFdbOYBop2qaJCjgh5if5GQ6C4w7K4qcob52KGRBXX2HEQ0sN/
         ZVw9B//keCr5rCK983f+PEWmw/2KpRPIWw02Y8+yNHarbt4Hcj5fkLYKWavbWYpo9lBl
         VINwSJLyGPYxYtg4vkPDktu0yvS6AMdbBWsLkGhbx/kqcQ9SVT5UXUKlYxq+2MkUs75r
         V6AWRQ7sZ4yxL7qpo+z/1bPdMqgaNw9ylWxGV3QouaK6dKKYVj3DVOnAEdbUGrkaWjA2
         rY9qAY8txSHmdgUzEzZCRM53XU5PbYuoXbyDAxl19zihO1gZ7IggSoKMTQ4xRFzEOWZM
         4J2A==
X-Gm-Message-State: APuU4Z8VNVQA6zqkqjLfrkxTf6KulIXxC3A6SFt4IbPWHXv/yJ7h3IrE
	+5ozxKEP9y9VzTFTiPp0GR2qUsjKda1Hc2qUfsS4LAnrBcrtk2aVVKSXlEkr+NCRHrarUufB7QR
	D/MxT
X-Gm-Gg: AZFdTZfOel7mSqtCYuW6qNZw/RMbZnQyx2+i1OlvcTDh65wRTPh7nGfsVDja9Lgdb4a
	kkeiAphYBA757SAYJjGzphFQJaPmDsi3ulhe/3nqEw8tW67DluZbZZzSSe0FO+4D0/APLO2q7Ko
	5P7d1t7OFqvvKm6A6XZkyneuuWgXWT/QDr09oYS62+7aDNrI0J55hwhTu0zL6WKYxwlYp0LIT8B
	YhdtcLPGHhJlnk2sQDrhVccah4y4OMuNnhJiU6hNu82oKywcV4N3rGi8cLX21uoqw5o50unFkqo
	nik0GVdyq8notik0VEeKR7/XfYIjGBmAH+WEkJ+v71H5XCpnk44bqIowvjeqK+ISBeTNTsQeUiO
	sJlXpoyeAnEFz4iBh0J71iDVnwIi7OjM3vnTDfZb8v3icrs8tx8xfiR/ApX2ZW3ej8AjYblBfjU
	IIwW79A8cnwAL4LVBSc88WYictgCiVL0PZ4RArOSdiD/ZU20v6UGibGTk65H+65fLMEUHyTD84I
	DODE5oJV3gGOjjo/0CfTN2Eg5rGp4QLxXjz93LJ8gpzt34Howr6h17V8f0xLWD2HeA8m5qiSHRA
	Gd7jV9kf68ZNKag4gcDK8AjTHel8FYFWcmXKNbfBSe/rZhUo
X-Received: by 2002:a05:6000:4809:b0:4aa:842f:5f78 with SMTP id ffacd0b85a97d-4abb759e947mr23470627f8f.46.1795453968605;
        Mon, 23 Nov 2026 09:12:48 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c43563esm24493082f8f.57.2026.11.23.09.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:12:48 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 2/2] unit/test-gatt: Add test for indication without a handler
Date: Mon, 23 Nov 2026 18:12:41 +0100
Message-ID: <20261123171241.511211-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123171241.511211-1-simon.mikuda@streamunlimited.com>
References: <20261123171241.511211-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A server with no GATT client on the bearer has nothing registered for
Handle Value Indication. Check that it answers one with a Handle Value
Confirmation instead of an Error Response.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-gatt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 3a35ccbc1..a4f03644e 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -5205,6 +5205,12 @@ int main(int argc, char *argv[])
 			raw_pdu(0xff, 0x00),
 			raw_pdu());
 
+	define_test_server("/robustness/indication-no-handler",
+			test_server, service_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x1d, 0x08, 0x00, 0x01, 0x00, 0xff, 0xff),
+			raw_pdu(0x1e));
+
 	define_test_client("/robustness/client-mtu-rsp-short", test_client,
 			NULL, &test_client_init_fail,
 			raw_pdu(0x02, 0x00, 0x02),
-- 
2.43.0

