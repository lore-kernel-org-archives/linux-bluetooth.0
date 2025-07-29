Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0415CD74
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816945; cv=none; b=r970ETAt0wTof1oCW36+IkAm+ucVZx+//ptl/xKKnD85jjMT+946EkQkfHHouB+Uw98Iig5Dpxrx8WzFFp7J8o6GWtMxxabpX5YnlLqLNSo2C//scwKPvAHYnj9gUr/M5CQQVSbObvLregZs1xp+RZX/uDLx6fbEZNUB8uyxfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816945; c=relaxed/simple;
	bh=aXjpIxN/nKuOjpM4TcqyrW+Opn8HAnvDUWwZM7jhTYg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5gQApcLh1hx0y8d0fxo3V/TRYtE4Z5ZdiN4+KNKcIepd36R56Q/bvbAWIr4iNDKlBeqGWtwUAdRlap5wFW5jpW5lpyCDZg0KYkFnMfdwiqq/iF9atjAs0oXfW6NNnw71B+RVq4pTMwnSlJYlzgh7Sd+Yud4lCAexG7vHamFM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq8smFjT; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq8smFjT"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e7eefcbf08so2003691137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753816941; x=1754421741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waNKPqUAyuBfV0k+OpPQAnkOLwoEbFlp421jVIhy30s=;
        b=Zq8smFjTpPhcCMZgE1ZI2n8lJyxpqj0jIO48JHEsjT9JDv+rdOhvNnNNtX7l/arfoe
         A7i0wZzsjdstulUKPu0F4R2QYBvRPd+69dTz3dvfTgBcXFwJMqteNYW6SNKkPqpVXz1U
         3zAQIuv6vaFFi4BbsIoARuI+O+c/Q8NUw1V119v9m7TtgAWEYZS6fyAyPdHAdHSy3/Az
         bh0zIwdlL++ghSjiY5J3522TaPrs/iNFHYybpzYBlNCmNP28BWxbxyKz6XX/WYu8tfVD
         WDC2ELAclzdG54+Jm1RpeUQYYHATh20YBVP8MUgJlXPOBHcFE0SfiXxZiQ6xOfvB7xd8
         7I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753816941; x=1754421741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waNKPqUAyuBfV0k+OpPQAnkOLwoEbFlp421jVIhy30s=;
        b=WXF0GT3kv167CIPjaSpFyC8KNlwMFT/bOkZmn82rCNPhX5TkheqMvdCw8EKOio+kDv
         MhgB4wvebmd10b/OS+X6umA9LJ1VToUYpGblctjn+0UYhS4saf7ZpGO7h90HLYPI8FIx
         Ia+HgANLn2WgB4O+BKmVpuSLTyg+bgIXYBTfry2mjA5QAVVDXdh3l7wlTq/+1hmiVwAo
         gu0iVj9DbN68gMgAo6oZoIufYFY/+tLZunHarFisvadrXABcPKKAfLQgHoT6Iv+6pCR+
         E1soB5KUE7Mkt8dzv5QTC7xwaVdDkj0w6spfSB0vy6PaLQqZT7wVzGCnfCGMUkuhgqMK
         cVpw==
X-Gm-Message-State: AOJu0YzWrKlGHqTiBcYUP4Rux+XPM3o3rMfh1cSjrUl5oXMfmkcCJtoe
	oH2wPz+ZeIKkCwUX7+1ycdEl6QnQ3gZMPSlUYToUbizIqcU+O1A6dVNd0L6Khgp6
X-Gm-Gg: ASbGncsC00QKwS+1l7qPoTp5RLXcXdGedLKPIVMi8Hz4pm90hswtc3T9ozSlIlGPpMn
	MqZ8V4j0nVw/mQs9iLVDLm25Z+wpYhq/s/SEtmhMTsNcnRpew8D19Q2HcxyYeuHEXywVPtGxoud
	UAZlBb99Tpl0/30bhnaRm0mRiUExkko/JmKArXDUyVCDq+LEOYxtDHpZ6gOlXGbkbcnbAfgL03t
	WBCLm86cXWlyQb3cGWDmuXIV9XotpPWpFEum/cD0NJrZhVWQ9l10FwRoy7CedXivx9QqX/fmF3l
	HoK6MaZRK2wG6naPRwHt2EmIzGE2o1Mu1+zt/SQc2ivh7B3J2C/nQLfqX5RmTckAvC53lfqI2uf
	ypxoty+/T074257UwGD7f4/bdk5F12rDeMZZqvm8aFRN+5mUZWN+l2XKOV+mEWLgB
X-Google-Smtp-Source: AGHT+IE9HJhjN7epoXccaOfzjF9v3Bhcl/WgP9C0XdRto8OMWp8qaT8+7uMiVAzZTXOv7UXtguOsuQ==
X-Received: by 2002:a05:6102:5114:b0:4e6:d94f:c197 with SMTP id ada2fe7eead31-4fbe87956d6mr752722137.23.1753816941598;
        Tue, 29 Jul 2025 12:22:21 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fa46d0745fsm1684577137.5.2025.07.29.12.22.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 12:22:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] bap: Fix possible crash with Broadcast Sink
Date: Tue, 29 Jul 2025 15:22:05 -0400
Message-ID: <20250729192206.272462-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729192206.272462-1-luiz.dentz@gmail.com>
References: <20250729192206.272462-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the remote terminates the BIG Sync the following crash is observed:

Process terminating with default action of signal 11 (SIGSEGV)
 Access not within mapped region at address 0x8
   at 0x40781C6: setup_free (bap.c:1024)
   by 0x4078EB8: bap_state_bcast_sink (bap.c:3118)
   by 0x41319DF: bap_bcast_set_state (bap.c:2392)
   by 0x412CFFC: stream_set_state (bap.c:1537)
   by 0x4131CBA: stream_io_disconnected (bap.c:6597)
   by 0x414A079: watch_callback (io-glib.c:173)
   by 0x4149EE9: io_err_watch_dispatch (io-glib.c:380)
   by 0x4C9587F: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
   by 0x4C9E7C7: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
   by 0x4C9EA6E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8400.3)
   by 0x414ABED: mainloop_run (mainloop-glib.c:65)
   by 0x414B1C4: mainloop_run_with_signal (mainloop-notify.c:196)
---
 profiles/audio/bap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index d90d39bdc134..3dc4cd92e9ac 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1021,7 +1021,8 @@ static void setup_free(void *data)
 
 	release_stream(setup->stream);
 
-	bap_update_cigs(setup->ep->data);
+	if (setup->ep)
+		bap_update_cigs(setup->ep->data);
 
 	free(setup);
 }
-- 
2.50.1

