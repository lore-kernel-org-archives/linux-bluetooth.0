Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66C3E0238
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502408; cv=none; b=TIM+uzsxpgFNWdE6ig3XXc3EKEzPNAqoWqP2RPNCPDDfI0iZ2Wuu8UtzLBsFq4n1f1nIfhidW44BS5s4oE/JDB+svC2IJiG6TLnvXXnRV0FxRohyAvZp0GcPg5ZwaWCmMR1VUAU1fF+qPoLzHIrc6CgnupE683MDV2Gknp/T4O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502408; c=relaxed/simple;
	bh=G0x9V/BI3+TkxKKe772RWr7WrNrThQ0LLlvnqrrrQKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOkYwbj9o3a/Hd7rc01rcVONcXtqzEPoPRVTzmUvqPCnn+VZL5nnGEZtQzu/i89ClaG3fvouixxfEdrgAktVpzXPtzMnDLRi6Ajh6wLqe/lcNBae7RZDiQ5B4aUCI2LjFw2jK+/cB2x4P0Q3E6yNdTxuyqD7MoOIBw6GSRNkMBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm78s1Ub; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm78s1Ub"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50fb1ad3734so55283581cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778502405; x=1779107205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eApZdy9HouG7Tom5otuoq8d1bHH7NMiFlZKRNtB+9kk=;
        b=Rm78s1UbNcuOLAQ/jIxoezgrAKfhgUdoR8vH1kkpBSLhq1tm0SSmxurQ1vxmWvCQTF
         EFnblfkJTqUYCYg4AVND7aVdZzxRyrYTOECN77vnYtA49VxxccAkx+Gt/0LLgsLfuPgA
         pCAw0CxFASJcmzNRVfzxIyNlOeDKfrNDlR8EEpoc1JU3J1gjGhnsxodtTpFIJSCbbZei
         xN5+YguzFxOAcCJ/sv+jcrB3wJdo+ZDfRUjCcZbR3Z7s0eneAXw/ewLQE1SO9iCQklAe
         w03z6qSkG6Jj+m9ib5V12+m6LUtwsIe0YUhx3UGaiOVGRZse51aD5dsdYB0iHNOu4w1K
         EgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778502405; x=1779107205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eApZdy9HouG7Tom5otuoq8d1bHH7NMiFlZKRNtB+9kk=;
        b=Ix1y/FbrFTKjeN7EYjkEMF8124svSqX4Z+tVxgk2b4u1pJX+5yjxOdOns8Kwlc58B3
         RLuHdsgtS4zB87iJ5kGk4VuvDgjEUQi8jikP5MrQIGdJJ4iczaYCOubHG50U2Ch6W85B
         6neb8wZ6HuG0Isu2YUaSotB7Eu/vTPv9y8qGPU6ESLDiJgt0A1BniKUJXcL4ldY077JU
         Cz3I/zjabHp/P5qQJT+6Rqx6KbdDYCxOEfXbeP8SbT7aqStWHZFL7JATaPqfHdg9Ohto
         k1CxtUkCZzXBdI1+CwTJvApMlPonfYExIF7Ge8kdUv0LpR/uEvrB/d7iMXl1QWuA59o5
         xsfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QHV5o3nXGk1aEZ7nUgjZoWu08Og3c0FVC9VZrT88WUfi9V9sAkKAM4MNGBvPDDhXUFcb1JxbyoWOmZb/n8u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7D3G/t+6CxN4yVwbHqV/g5juE/TN2swnbT4gJf5/I1zovprxn
	eBfGKOJfKgKu8pg418ySfdBFIdoNXatLx+125lkMX9q62kT8nKqyBVv7
X-Gm-Gg: Acq92OGSblNLubFOfnhojn9onBN7dAFzjnvfRTQGx8FUKwD7rPKA1u5so3BxnbQBmkd
	/OiQmq4QGsP5w8wTbmebZjMWC6Ypgl2qEPXdFV8gGJQezw+dnfbPMvrI8PP5A8WOijDz/4zqCrW
	6QF8FQZByEXKRfDrEVD6U3hSST9UZAkNYh+zXEjVeKV9MZE/P7lImDpcD8VA52D0na0IXR8P7dC
	bWZdD9KCnmysDqa/xcwCaqPvsDnlnDIv/pzgMciwlW5QZrDKfyczCYVa7eZckiEb0Nf8HkqbYmD
	t4ZmSv/Nv7+XhdqDd8sKx/dS1I/DfB0NQ7dhvhWXCp6j4MXoqj9NHFYrmVVGNP/v3v3gmKQPgai
	QC+2qv0zbTHY2zsmJtT4YlLktB0NSI+CmwxuS0DYC59bZcDFqG/3x/v3y6xc0o/IG/xCifTo1eA
	xantIjOOGD5KCjNnwQblW6arDZv1rMATO1ReEk2dLH4xEfpRiHCPNSxSs8F+LQofNM/Md6L/ulO
	czkY57GGEwYqLxGJ4xPZQDYFSFLnCCp92zwWHFndQk=
X-Received: by 2002:a05:622a:138b:b0:50f:340f:ff35 with SMTP id d75a77b69052e-51475c8ba3bmr220256631cf.26.1778502404796;
        Mon, 11 May 2026 05:26:44 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7bf7e4sm88392871cf.17.2026.05.11.05.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:26:43 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
Date: Mon, 11 May 2026 08:26:41 -0400
Message-ID: <20260511122641.437434-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1c08108f3014 ("Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end
warnings") converted the on-stack request PDU in l2cap_ecred_reconfigure()
from an explicit packed struct to DEFINE_RAW_FLEX(), but did not adjust the
size and source-pointer arguments to l2cap_send_cmd():

  -    struct {
  -            struct l2cap_ecred_reconf_req req;
  -            __le16 scid;
  -    } pdu;
  +    DEFINE_RAW_FLEX(struct l2cap_ecred_reconf_req, pdu, scid, 1);
       ...
       l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
                      sizeof(pdu), &pdu);

After the conversion, DEFINE_RAW_FLEX() expands to declare an anonymous
union pdu_u plus a local pointer "pdu" pointing at it. Therefore:

  - sizeof(pdu) is now sizeof(struct l2cap_ecred_reconf_req *) = 8 on
    64-bit (4 on 32-bit), not the 6 bytes of (mtu, mps, scid[1]).
  - &pdu is the address of the local pointer's stack storage, not the
    address of the request payload.

l2cap_send_cmd() forwards (data, count) to l2cap_build_cmd(), which calls
skb_put_data(skb, data, count). The L2CAP_ECRED_RECONFIGURE_REQ packet
body therefore contains 8 bytes copied from the kernel stack starting at
&pdu -- the 8 bytes overlap the pdu pointer's value, leaking a kernel
stack address to the paired Bluetooth peer. The intended (mtu, mps, scid)
fields are not transmitted at all, so the peer rejects the request as
malformed and the L2CAP_ECRED_RECONFIGURE feature itself has been broken
for the local-side initiator since the introducing commit landed.

The sibling site l2cap_ecred_conn_req() in the same commit was converted
correctly (sizeof(*pdu) + len, pdu); only this site was missed.

Restore the original semantics: pass the full flex-struct size via
struct_size(pdu, scid, 1) and the pdu pointer (the struct address) as
the source.

Validated on a stock 7.0-based host kernel via the real call path:
setsockopt(SOL_BLUETOOTH, BT_RCVMTU, ...) on a BT_CONNECTED
L2CAP_MODE_EXT_FLOWCTL socket emits an L2CAP_ECRED_RECONFIGURE_REQ
whose body is 8 bytes (the on-stack pdu local's value) rather than
the expected 6. Three captures from fresh socket / fresh hciemu peer
on the same host -- low bytes vary per call, high 0xffff confirms a
kernel virtual address (KASLR-randomised stack slot, not a fixed
string):

  RECONF_REQ body (ident=0x02 len=8): 42 fb 54 af 0e ca ff ff
  RECONF_REQ body (ident=0x02 len=8): 52 3d 2e af 0e ca ff ff
  RECONF_REQ body (ident=0x02 len=8): b2 fc 5b af 0e ca ff ff

After this patch the body is 6 bytes carrying the expected
little-endian (mtu, mps, scid).

Cc: stable@vger.kernel.org
Fixes: 1c08108f3014 ("Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end warnings")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 77dec104a9c3..4773a453b145 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7282,7 +7282,7 @@ static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
 	chan->ident = l2cap_get_ident(conn);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
-		       sizeof(pdu), &pdu);
+		       struct_size(pdu, scid, 1), pdu);
 }
 
 int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu)
-- 
2.53.0

