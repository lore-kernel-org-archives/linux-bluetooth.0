Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390325;
	b=h+jLgO4MLvg4pXBjyoeyol4pw0OB9WpIYlR2xx8sNfCq6/Y1rZkKvdQPwBxefZ8p78jV
	 jR/s2LQc7d1kjArtHjuS8rNN1R2bKZcXGbA3AhHzxAxerybs0kOLrE4fZIVIzX9+fGZJY
	 6steyeKI0HN366mLq9pJLg+EytzMcAm4U7yPg4Yej+TRQEXgmzsEKaJSF42/JEIZ8rJZE
	 AIT7mUFaVQL3IYHe0xyHkitNid/JXmvNKBIA4PHTKaHb+oMl2W5+R1oDTKOHrdbyY6mfH
	 ZDYqNrAXJ75aNgXmIJelJfBxp6Hb0JjTjMxIJreP9sBguRmN6wmDYFywH3CQu56FYEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OvcsK1MZNIxG645vDUNLdhdgHTZUV/jW504dcb+ejsA=;
	b=15GxXB681spocfR8se5nT3mpbDH2Swo1ByrgqB40SYZip2Q5+mjT2tmY3q7q+fwPGwsH
	 h3N9JcQh4KeFFZjXB33MJsaH6/AKHsOd9Yl76RlZyCyil2kwLgNnNkRTC5Muzyw0WQeLH
	 pXAQhGrPW/1TzDepOT1WKvHiSyw3ohP54iV3hag7SyG07IwBd8kK3tY92rpeORclBnjsK
	 mNm/4RyJw5tg/u7E7SwOkwWcSKW1RfXlhehWTk0rfMnbpHwFr9Jkglehj5ZX1kA/v20H7
	 3qWxIGcUUicAo29QdPgm98Z4UdQjn7qfgvwuUqLj5uEp4y/hIHLK/Hs7+KxRXVrPiuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2NX+aEW;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F1606A327
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E96F1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2NX+aEW
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a3c08d6928so5071977c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794390324; x=1794995124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OvcsK1MZNIxG645vDUNLdhdgHTZUV/jW504dcb+ejsA=;
        b=M2NX+aEWZZ7U3BN5GA9MQBawF+tZs/Pja1AIXiVnIOFXwiREIS9lppIplaw/gB+apY
         0C0/Ec4FyRvgeWO83DWLqnjn7iljhsJLiyKSOj4RpOt582xas9oDO8OBt64gaZ+3RMQK
         it9oblePgSjrmF8FTZ8TFTmjMJsuTR9owDDz1HKUn3sfCCOiTgt5fEs/ysm047y6RaR9
         6oEdndPcL62TLAj1lyxLW4y5Nrt5usAQuflUn9iD2k/2BTXwhH7DYLDSEyF+2iUbCG6t
         2ryOytTstib012D15IdkuFB5w/a2sN02SnPOQS6y8R75i0tbfBe//NOH2u5i+tbGn7TK
         uhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794390324; x=1794995124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OvcsK1MZNIxG645vDUNLdhdgHTZUV/jW504dcb+ejsA=;
        b=aLB2+i2SDT7GXebJSISHVDQh4sQV88bXZPdR+jVNxB26VPeKOmdiLq7xGxXf1Qz+kr
         Mp3GhWeLk5zgfESn3Ti/7m01Y3SR5kryq34Y7kunYCujaknIigUwTfCbJ3FRtapV3tsE
         VwlZfRBjVawdA38HKPiRrtDno9kGNasd9bUAmUqZ/gq63gmktxg93Z0PaS+sgrKwkc1W
         CI+yuerA/Nts0Vy1wk89U0QspT6ah0VyDkgrzduUaZpa+nM7Nd8Qc8EKSuDqZMh9UtZb
         pZxgvsyECi8slEN4rw2euFONH8CfvryTqEPg5XsrH2W0H6HQwqnpAzMsyT4OwJIWyB+j
         P+NA==
X-Forwarded-Encrypted: i=1; AL+hErFSXThMAlGxRbCsHjPVXBT5AFkOPJgeU4TV4BJTyc+VTXPcQCFyvJmr+knXRQCaVKH1xHKB2FyZiQABJKKyIP0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ajQuJChXlUr7+Dondb2XhtpESfjPnfsyFJnhfzLP5Imn0lzax
	CCpfkqcIjHIRi5RaNkNFKyDWW7fM3kTk8JQasz7BS3qGWG+ihcgLRTtJ
X-Gm-Gg: AYBFou3C1Ou0as73+lul88FsOMDU/n4JvsAY8Fex9PdWvf7aIVyIjuAASflCsyMchfl
	ulZGqpQVhuuZacJE2NuLuzLMgX1vl2JxeFGjwaOnAIQuzh2TQkYbNmukgweNRLhUcCEHIMkmu2+
	pf7s2fe3YawE1X7CxWaoFnL3rt2X83q0kGPH/chzwWv6GF0+ZtiGuuYKuCGda8qZyLOboBWWtYN
	NsEtNqC5+bHFJqXSAv6LH935JbnLMS5MpOv6x7IbwiagElDK01dWIAn+76+p6BVl174CM92tzMj
	WlVpr3EdHWacZAsSSR4cfd/j0T/yuTlK/Kms2Kg9oW6loJvA6+P6akM5p2Hcvq/AK9mgNry+7vE
	33hdUQoz+Ffk6zVhtf6nHaYQhAo18g6qK+pzrblwg+nRIinxCIvKRc9hXKs/bS1zYyyGPokPlru
	/UK8Lv8pS1d3hZDkqsN8lN0cxGHZY1YzB2MHbIl2zgaTOScRY46RoxuaTySeRpszC3UinIkJ6Cn
	HlJ6eRPX/geFPMngyGvCF619LBqm84uRdWj6kmpipADNvXxwNAt+IH0hm4pw00HrE4hlv8J6aF1
	yHORNybfTHNgx+EQ7TdWkQFg5jU=
X-Received: by 2002:a05:701b:2702:b0:14a:d8fe:3390 with SMTP id a92af1059eb24-1b3c034b33amr1797678c88.32.1794390323867;
        Wed, 11 Nov 2026 01:45:23 -0800 (PST)
Received: from linux-691t.suse.cz ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc14sm13890844c88.12.2026.11.11.01.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:45:23 -0800 (PST)
From: Chun-Yi Lee <joeyli.kernel@gmail.com>
X-Google-Original-From: Chun-Yi Lee <jlee@suse.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH] Bluetooth: SMP: Fail if local and remote public key X coords match
Date: Wed, 11 Nov 2026 17:45:18 +0800
Message-ID: <20261111094518.1359684-1-jlee@suse.com>
X-Mailer: git-send-email 2.51.0
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

From: Chun-Yi Lee <jlee@suse.com>

The commit 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys are identical")
 patch be introduced since v5.13. Looks this patch can handle the
CVE-2021-37577 issue. However, it only checks if the full 64-byte
public key (X and Y coordinates) is identical, which is insufficient.

In CVE-2021-37577:
Bluetooth LE and BR/EDR Secure Connections pairing and Secure Simple
Pairing using the Passkey entry protocol in Bluetooth Core
Specifications 2.1 through 5.3 may permit an unauthenticated
man-in-the-middle attacker to identify the Passkey used during pairing
by reflection of a crafted public key with the same X coordinate as the
offered public key and by reflection of the authentication evidence of
the initiating device, potentially permitting this attacker to complete
authenticated pairing with the responding device using the correct
Passkey for the pairing session. This is a related issue to
CVE-2020-26558.

Furthermore, according to the Bluetooth Core Specification, the remote
and local public keys should not have the same X coordinate:

Bluetooth Core Specification Version: v5.4
(7.1 PHASE 1: PUBLIC KEY EXCHANGE)
"If the two public keys have the same X coordinate and neither is the
debug key (see [Vol 4] Part E, Section 7.6.4), each device should fail
the pairing process."

Bluetooth Core Specification Version: v6.0
(7.1 Phase 1: Public key exchange)
"If the two public keys have the same X coordinate and neither is the
debug key (see [Vol 4] Part E, Section 7.6.4), each device shall fail
the pairing process."

To ensure both initiator and responder roles strictly enforce this rule:
- In smp_cmd_public_key(), restrict the check for the initiator to
  compare only the 32-byte X coordinate of the public keys rather than
  the full 64 bytes.
- In sc_send_public_key(), add the corresponding check for the responder
  to verify that the 32-byte X coordinate of remote_pk does not match
  local_pk before transmitting its own public key.

This makes the validation compliant with the specification and mitigates
CVE-2021-37577 across both pairing roles.

Fixes: 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys are identical")
Link: https://nvd.nist.gov/vuln/detail/cve-2021-37577
Signed-off-by: Chun-Yi Lee <jlee@suse.com>
---
 net/bluetooth/smp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2df303f6a38f..d1786e398128 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1889,6 +1889,16 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 	}
 
 done:
+	/* Check if remote and local public keys are the same and debug key is
+	 * not in use.
+	 */
+	if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
+	    !test_bit(SMP_FLAG_INITIATOR, &smp->flags) &&
+	    !crypto_memneq(smp->remote_pk, smp->local_pk, 32)) {
+		bt_dev_err(hdev, "Remote and local public keys are identical");
+		return SMP_DHKEY_CHECK_FAILED;
+	}
+
 	SMP_DBG("Local Public Key X: %32phN", smp->local_pk);
 	SMP_DBG("Local Public Key Y: %32phN", smp->local_pk + 32);
 
@@ -2734,7 +2744,8 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	 * not in use.
 	 */
 	if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
-	    !crypto_memneq(key, smp->local_pk, 64)) {
+	    test_bit(SMP_FLAG_INITIATOR, &smp->flags) &&
+	    !crypto_memneq(key, smp->local_pk, 32)) {
 		bt_dev_err(hdev, "Remote and local public keys are identical");
 		return SMP_DHKEY_CHECK_FAILED;
 	}
-- 
2.51.0

