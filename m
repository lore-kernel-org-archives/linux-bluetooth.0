Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4A74F3EB0
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569106; cv=none; b=RvGGWyRfdxkzwS5sFhwvjiVsr8+Te+tt6DqbTyNyiR7S81Sq5Jx6IeSjVltnsvBsB7nHPqhdpUryScQTJo11gVVHLdHm4zal8QwtdbLVYF9b0dmOvdPRlT/ozZmqkXxSSjwuv7BQnRcN84DB6NCo90heQg9RbuIAwanuWDvOKAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569106; c=relaxed/simple;
	bh=eQdT5RfQTz6BxPtDB1qDa77mG5fm28MVcbl+cZsKJYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nub8AxROEt4BrKL+4pq9YpbujwhRfGpO+I3PBviS75hQ8w2DOc0LnKDgRr43QEZg4dXxq6SmRuqitGo0AwJC/cg1qZ3tcFwU2TX1uGWJCyf+UIeOmqTmaRm3RlIoV3Ok6JIVvzV92BlXUaA1PNQeFMx93iBEo4oNGsPzGVjO/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=g/W/BBPA; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="g/W/BBPA"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15ea896ddc8so14112c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791569103; x=1792173903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVP2rSyn2HXNY9pugbmXcSgq4LaQK43XQNcSZFxnakA=;
        b=g/W/BBPA7QOy9HtTEh0uNfjPto+Jp5T3oK5MqyFG6Xj89dqftfdeuFXyk6938YiS8v
         P17oB82iuSni6l66yV1tjH3m06CJ4j0jO0Wqub1ITQphZQnN129SvziePc2kK/9X2xNq
         naTViCGVucERsPF/ughHMv36imfplKrxHVDcDdPGkbSVJ/2BvGzknXbEZc3gWpNlOd+O
         kacwnjXJkydX3TWzCP2bs9YyNkjyNtsSsRvKMuPFj/bF9NDaii2NEBYP0BymDYQYMYfM
         x//eYO4x3bTXWLE+hz4Yzfxi9VsuA96lX/2ON2y8HhLcHo7YwTqd32jZSaDZVf/EAtsA
         VM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569103; x=1792173903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XVP2rSyn2HXNY9pugbmXcSgq4LaQK43XQNcSZFxnakA=;
        b=XtEx6G0e6gFHV3cHFt7q3TkF/D4cDtRIKmhj0/nhF7XoRskqbb5xigv0Ir/WjhBIBQ
         0ovp0hDUiPE4EGEFt1O6F34TC3EBnyyBMh/NHdsmXeGCQlPauUFMPubYhnCTuOQLBeV+
         LwebISqN5U2uiKSMTvo8oL2LXKoZdsx0WcYtQ/ZBtb1Z9kEP1EjRdNJMLqyFq0omgGS0
         ACXxybLNds74kQ5fRsnNPgim0uRdDrXg4oBbyFOmpuUgkGU6Wep2EgumYigIv0bRE7EF
         /NOZRTNmbXh3V5aLBqg1L6qBkc1ycCBioeimeXW/+0XAoorzEA8GyyIXXyF0rMJbRw5M
         RVHg==
X-Gm-Message-State: AFuF++maR4X4BfYTmFMOuLnA6FUQ2+FELsIQgIoQlzHabvBjjhwjeT4G
	FyNTPn2IbYF31zBD4qeAQRjwphBuf0ho5M1KuMraJXOM6gIxlJAxSj61AbYz35raAr4y2onKTHh
	9ywYs
X-Gm-Gg: AYBFou361sX2m8v8R7pBtjMz/vqwP7wHvhWX0nyIgQonTRJoHtBlQ+VCwWHRt1sAZ5u
	5UsiKwwxJ1EHsIPypykxcwId57F0EEsSv3pphVXagl0uDj1ok5ZgqMb1rHVUFiGajkcvCw7X8+c
	bgrSYbSLKwrfbIa0KmdydoAvlzDla3KZQ0A1LBU89n8eY585YMJQBEZ8dvx4qSyk4EoXxBgAX3F
	pySOeQHwfWljWvgMYmB/jBx2FvqYJNVpEpGYxqYMSkEhgCNP730lUUzo0B2dquwtmC5W5a1G0gn
	ZhasU1MWxJCTuxxxwqZJHVjw9oZ1zSCGtYQ7bs8DmJw6gun+Zyjvfe2Re16BYS9mLKIbsNcH8/o
	rOML27ZQR21I0GH1ayuqXtqWGe+NQMS34D4tx3EX2zXF+UO1M9tk5IH7o7c2EbCArxDp+hg40HW
	W9IyGM5zrOZAb9neHPa261RluW3Tyzdh2zM+I63Z94MVRpivyVHsESH3hJrM8ecWNxWe5/d0ix3
	ylBR/IRvC2OOTPybfugSTjyCbtghoL0xjq3/z7eroZmLLkSUaonkw7K53JrrcnrSPMElCgtTgLA
	qgqNM3mZbhs425/9476cy2TR69z6PJMUNLapK1mK
X-Received: by 2002:a05:7022:171c:b0:14f:8e70:fad0 with SMTP id a92af1059eb24-16a6090d024mr3139777c88.33.1791569102981;
        Fri, 09 Oct 2026 11:05:02 -0700 (PDT)
Received: from localhost.localdomain ([12.158.218.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6be0sm16111163c88.13.2026.10.09.11.05.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 11:05:02 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v3 3/5] client: Print LE.Role in info
Date: Fri,  9 Oct 2026 11:04:46 -0700
Message-ID: <20261009180448.29117-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009180448.29117-1-kevin@simpleble.org>
References: <20261009180448.29117-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prints the Role property of the LE bearer with the likes of info
command:

bluetoothctl> info <addr>
...
        LE.Connected: yes
        LE.Connectable: yes
        LE.Role: central

Assisted-by: Claude:claude-opus-5.5
---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index fff75056e..01ed00073 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2097,6 +2097,7 @@ static void cmd_info(int argc, char *argv[])
 		print_property_with_label(bearer, "Connected", "LE.Connected");
 		print_property_with_label(bearer, "Connectable",
 							"LE.Connectable");
+		print_property_with_label(bearer, "Role", "LE.Role");
 	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-- 
2.54.0 (Apple Git-157)

