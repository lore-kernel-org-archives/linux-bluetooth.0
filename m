Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305718;
	b=ELtiOIOFuH28P0qYIZTj14f3sH2CxyUPTE94nL1phcz/Z1sZA+eOD0ZlXzYNonb61YBt
	 DWTqOzGxL/SEwwF33ApOHhH3j15vK3EzeRqaFoSWFsSfGyXSRl26vONL+43RoYyyYVwq3
	 IQdviKOfzJfv/bD3WeaamI0mBzu7wPHeuI5sYTdcbeBKlXW6VzwlKMsUEkKeTolQk0+a7
	 7Oee9xL8joPIr1IBekyB4odhfT1YUC+UHoGuVy3Z33XHgtulcT8ntMoJIXIx6FLOpgvTh
	 Qo32fLWMW2801tFLkjBK1uribWh7cEQPIAVwUNQKuTa8l4H1BRmMk+KmD8O6xxYqxSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lbbKXnXlDWrZBBtTs8TaCdwHJMgkhA2ffCtAIVgiVQM=;
	b=MyFIkmKWUMpgSD+FS2xZ+MePzPZdYnobFoWTDBM4yIizm145PRD6VcV0bQQI9G4wF6wm
	 HmugrrcM0HGiau+tq5pb3JitgJLJePP31fLML+bwqnMM+K1m4nWKwO2jv5Bvqp1bfdXCP
	 6AVnxQSDH0rCoa9E6csHWlntl65y1DJ1iWKOHht7ykU9aTetP0lDafGJgiJr70zRDZbPv
	 lUbmaf60onrPbWZejJ29ityotI1I35Utc+xwzztOFOaReD0Hoaq9fGvMTcdy4oSF9jsIM
	 gnjAfOy9weGjXCyJUk1XV5J1YWsfrwguqnwq2R1HpCp06WLBIOLdiYmCtS3hYyaU88w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=Iiw0cjWx;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FA9606A338
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 20:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2FA9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=Iiw0cjWx
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3550c917fd3so115387eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793305717; x=1793910517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lbbKXnXlDWrZBBtTs8TaCdwHJMgkhA2ffCtAIVgiVQM=;
        b=Iiw0cjWxnyG+XhZh6De6QuIAo9FW87ufwsGgMWJWaOb9lX3TCuijcJUqKt+eS7mNd8
         4F8sscA1hNcmNSGdcegPxznGqIkJFE432QdgkCs+C3rpx6ORZmSIWj/k0Xz+qJFh/vYk
         al2pJg4/rAc9kfM+3pk/Fvp+AduQumE74Y6EtmrdhORaOEk/xsE6pq8GRTIV5Olucr4p
         CI9cRt7JlHGKfrek/kORxzgILHLROnuBZne1hIL6ENaamolONDTD03P+bYAQ82sK3SlK
         CmEvl3AjcOixwbFM50f8492DDcOXuE06Te0d7Xt+aWK71ne0VfvLmkUSImhaXCqqCT/A
         ooBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793305717; x=1793910517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbbKXnXlDWrZBBtTs8TaCdwHJMgkhA2ffCtAIVgiVQM=;
        b=zXgcRu7R1eWMNOMsZtWRn3AJgHvIZPBGhhI2QoxknCIfSnwhy3ceZyJLHcObsPArDW
         WBeKf73Iafx5d1Ppf7z6l1V97CLfctwsyS62M9CRNAYO5pmTvMTmbCw0b/JAzTZ6gefA
         eczu42LFYACDhLSfNVqZRBEz7E8YZS7qTQVI0usexlLdowrfTCzZcORAkOkhG6tX52Dt
         fn8pNTpZ37EmzxsOuSMxZvA/4DAe6e2Is08/ihPZLr98b5dYBQv1rmb7j3kPCDa7oTPB
         vh185yFswA7+KAQHTVUI1Vbc73fIP1os0X1tu9xSylUcCdnKqf5HxyFexsAULOGVnC59
         bTqg==
X-Gm-Message-State: AFq9FYJxIH14hFH63psCz3z1hGkY82EmJvq/IZOVRw/cUkB/LHnXsFVs
	K90cyCbbXZOZ8DUY6hi7ComjTN5vlsgxvJIV1MLU6EH/ehbuXFN8lFNyu2Jtdv2fCIY0ezAuj5G
	zcRPPFJi96g==
X-Gm-Gg: AYBFou1zUzeIEzNZrfpyug3e8nFjLkPsC5XiUqvOvtwqmaMIQAD0TbIxDr0elMhFrdI
	1URBOCc20Mie5xaAsqch9uj1AqIFjvAsDR6N+u+z5/UAQaag9kZTZcjpUE144S9OMvWXka9WmHe
	MsjyvfLZQMEUfYopUU0dCtHXUwr2cfzZ/wSbshOU74vtXBwvh/yYZ0UEMd3GOzQukGU5G7h+7pB
	6ruyuN6iFndidPPUF4kM1GFDVotw0KtpZX7juN2YWrpnPeBR/bcCjZZ3FXJAvJLrDNyX8XCeGVo
	3izN7ohnD6rsA/lywNvmSSEFZrcISJrqN7qB2xCQWTyxtQCkX5uvWgpPZtrzPYxqbYDFkfBB1Bk
	+qlqqt9+3sm0U6Vh+TbVymnTXvvVAqXyLD2mZTACFBXhGvIyHe5VxalwWJKbyHg9QAw4TMiWWn6
	0SHK7a8P77zch+wPW+ldFmj9hcXkEChi0PWwDDNAj54PQJxnSG/l7y6/31S7BmJMxxKau0QX2U/
	zkGd0l3MfC99J21oc2Jf2NdonqXfxzwOziYeB6Ryd+e5mR71bqRg6ptiJVSz71tEP1eFodZODqn
	cxzBqxI27m16qLrrRmrn8o9HMaUzjvtXDruCK16KIU3nFptVlPxMJ6rDvKOOfy0hRkgvqS7Fcae
	VdzYB/YR0RhhTIEvj4+s9HyW7FiBCUmnyf6uCB4s95vEpCVEa5PynJ3qZ1nscXMSs5R9tt/Q=
X-Received: by 2002:a05:693c:601c:b0:36a:270:ce76 with SMTP id 5a478bee46e88-36a424de9abmr612001eec.33.1793305716768;
        Thu, 29 Oct 2026 13:28:36 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1dfsm934519eec.7.2026.10.29.13.28.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 13:28:36 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH] Bluetooth: MGMT: Clear disabled connection parameters when loading none
Date: Thu, 29 Oct 2026 13:28:32 -0700
Message-ID: <20261029202832.35354-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

Load Connection Parameters only clears the disabled connection
parameters when it loads more than one entry, so that loading a single
entry can update the parameters of one device without dropping the
others. Loading no entries does not clear them either, though, which is
what bluetoothd does when it starts without stored connection
parameters.

Pair Device adds disabled connection parameters for the device it pairs
with, so these now survive bluetoothd restarts, and new connections to
the device keep using the parameters they were created with instead of
the defaults set since, e.g. the connection interval from main.conf.

Clear the disabled connection parameters unless a single entry is
loaded, as was done for any number of entries before.

Fixes: 0ece498c27d8 ("Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kevin Dewald <kevin@simpleble.org>
---
Found with the BlueZ functional tests, which run one after another on
the same VMs: after test_bearer_le_pair, the next LE connection between
the two hosts kept the parameters the pairing had added.

Reproduced in test-runner: host0 pairs with host1, then bluetoothd is
restarted on host0 with MinConnectionInterval and MaxConnectionInterval
of 80 (100 ms) in main.conf and connects to host1 again. Without this
patch LE Extended Create Connection asks for 30 to 50 ms (3 of 3 runs),
with it for 100 ms (3 of 3). Without the earlier pairing it asks for
100 ms either way. The kernel testers pass as before. Only tested with
the emulator.

 net/bluetooth/mgmt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3cb4f9ece8..cf5256f4a8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8175,7 +8175,11 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	if (param_count > 1)
+	/* A single entry may be an update for one device, so keep the other
+	 * disabled parameters then, but clear them otherwise, including when
+	 * no entries are loaded.
+	 */
+	if (param_count != 1)
 		hci_conn_params_clear_disabled(hdev);
 
 	for (i = 0; i < param_count; i++) {

base-commit: 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9
-- 
2.53.0

