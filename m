Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6D35202D
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340190; cv=none; b=VlXZByBRLgiHfO8tOFjQ5WH+ScyB5U2xYWSx4R8vMH6JaVl5aCARJSBYHlSPu/G20jPeYAh7t8ARQt3dGVM9MNXPXGD3NJZQl3uGe8kkj18u4mFEsC1bFgLXMlqTBajON0IdQV/Gyal4lHgVILYvQqyPVGrsDS8xMWRelLrGCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340190; c=relaxed/simple;
	bh=54WbrSwf5ROSKrfqZPEAYaKTiLS/zEDbWR02AOXwH9M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEYiM0jpf6zqUCya4dhylV4dOLriTL+jveIa+gzk9uxfbFMWZhxrLxUpqrzORf4V/yBh9rflih7k90VpXm6ddg0IxedHi5AHnT4VF4iP/c6hGblu8BpO2QQ5xlULmSzqXlzCiQkh3GqF5w1+9fW9mKbqfhtlIL8R3bUYzqpxuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0SQGT1t; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0SQGT1t"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-6cbb38f5094so1302115137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340188; x=1780944988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dj10ixTZTngMoVkBr2Um5hZovictIllzixK8CORP5fI=;
        b=P0SQGT1t3Nfs5WmEf7cfUAjXihk96fflahwRMGIdoSsKfNolUtI+0YjpQ40bBe6afe
         XVfFpIwySJE8gwhxIeAPP+UuA2gvuswyi9eow3wNXnyhbQDZQzMjLL22iF/R5lkomPPG
         NEwZMMDOkRv2i4Epxxc6FAModZpkGVW9xPM4BqRAf7b4niPD65VG02oRFSdhkf4BnbLY
         duxc468q7H0gmt3iwN0uZq+5p5vHAa4tpKbkrA1y1R6N3IjnJNVfsLKF5I8gWfKqU3zX
         LU+zPTAAQ0U+uR0TcxV9atdI2wP9DPpS7HRmCgABFM/mhtP59DgJV5HAP/Il/XH0Sppg
         aNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340188; x=1780944988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dj10ixTZTngMoVkBr2Um5hZovictIllzixK8CORP5fI=;
        b=dicueGNyjjI2DwZezQMbG9rgZIdnc1P0z7c4V+rrJOyjCXpgyQGeH9/w0fhwet432x
         v0+Yn/bczpHBdPIbsXELrRbpKLBALcRE697ko5OpZXq3uniZzqMLd9jEThNtoUZxc9/N
         BxxGkG6xCR5kqU8TXjM1a4hG1dhnB6YcSj0ceVIQC9iPK5d04zGxjUl/+oQ+hlq39ZzW
         KpZR9lz9uHO/V7EFQ/BMMYhSIdJCyfikjsX4++wSfSl11v/wLOjMDRGsvojn8biZqUOq
         40ro+DFrF1OGlmkfDrg8mnQqEbkLqlNG+b6wpipIgOruUbfP23AEelK07gaM/78/xR7c
         KgNg==
X-Gm-Message-State: AOJu0YxpFQQOWFsoQ5mHpP+3AxvEMD7qETVg4avzFvv8VHaa2ToTOsVW
	Fz7vNNyH25Q7c13P1ZdO9uoFzrpbQj33YXia9t1Iw5SQvtarzUMoZMziAGb7yoaFMkQ=
X-Gm-Gg: Acq92OGIHF34KapHXj5JPx+Dnr4K5EHgmlo1YAcJePEjVWcfBvbTUl8S1IOmhBQAti+
	ob3x1BW7Zagm2lie9hhwulAiNH/V+SkyM1PdsvHtj796TuYdKIW5Z4coVx1JomqEX/KQv0lwEhi
	yEC1JAXbeYc1vYYdsSMe9M12+Tic8kQr7cj3X/yzjxpZyjltLEQ3YBplbzfSyPbNe5e/BuEVwvj
	qV8TM2xaMdRD9wthV0gN+/hhE35WImcQICtbYWE5JDpOgVeyMaBODWkvB2Qry4I/KTcM3NCEWxm
	pjuKgNfcexe0vLGpEmQuo9CvuD1mGMUPwPnn3mKYGIudR4AMsEbXjCkYF+1W3yg36nmKXxv6/HC
	d28hmVvLF7lVE+XbDsxj6EiOqJcro3bBIOEcjLgjyfK9hAcnmXkQtkgiEXLhRn7KgwJgJ54JAC5
	DpJEohPHJpJz/9Xy74VDCvXsdgPblp3KZxxcJhgpfw/JdC4X5YRqSic+SLGpY7aZkrBAGeY0aaq
	V3AhsIyYBDB7PH4HZpZIhmRIh5Z
X-Received: by 2002:a05:6102:560b:b0:62f:5908:648a with SMTP id ada2fe7eead31-6c68b394deamr5558624137.28.1780340187945;
        Mon, 01 Jun 2026 11:56:27 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-963aba249f0sm6773382241.3.2026.06.01.11.56.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:56:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: ISO: Fix a use-after-free of the hci_conn pointer
Date: Mon,  1 Jun 2026 14:56:20 -0400
Message-ID: <20260601185620.727132-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601185620.727132-1-luiz.dentz@gmail.com>
References: <20260601185620.727132-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In iso_sock_rebind_bc(), the bis pointer is cached, then the socket lock is
dropped:
	bis = iso_pi(sk)->conn->hcon;
	/* Release the socket before lookups since that requires hci_dev_lock
	 * which shall not be acquired while holding sock_lock for proper
	 * ordering.
	 */
	release_sock(sk);
	hci_dev_lock(bis->hdev);

During the unlocked window, could a concurrent close() destroy the connection
and free the bis structure, causing hci_dev_lock(bis->hdev) to access memory
after it is freed, fix this by using the hdev reference which was safely
acquired via iso_conn_get_hdev().

Fixes: d3413703d5f8 ("Bluetooth: ISO: Add support to bind to trigger PAST")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3978a78d5252..c648c3b3e75e 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1098,7 +1098,7 @@ static int iso_sock_rebind_bc(struct sock *sk, struct sockaddr_iso *sa,
 	 * ordering.
 	 */
 	release_sock(sk);
-	hci_dev_lock(bis->hdev);
+	hci_dev_lock(hdev);
 	lock_sock(sk);
 
 	if (!iso_pi(sk)->conn || iso_pi(sk)->conn->hcon != bis) {
-- 
2.53.0

