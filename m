Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7797136B05F;
	Tue, 10 Mar 2026 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180041; cv=none; b=MzEE5MDBvKr6DdxKgepkPiPw8cVE3Czu0qikRLNR+DgC4sRMJUqcuc5oxb8v6Eb3QSoI7RhEuOZsaGR5wEKWxvn9VZzxYwWidMhiwUbBXCk45NR8nn3t125kVIvbtw6xwY/Xd9A45Rv863BsFwarCbLRjJOlRMg7C6uZ/JbJbvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180041; c=relaxed/simple;
	bh=koGOcD/39JRJlUIo/80r7zi0PGrQKcjt1Zjdekk9KaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhQjFTQIv1mr3NyJiehdNxcCIuq1tyYT3qRxn7nEzmNrDP2BIKuhxt9swq9uyynZ14y7PRiThL0qroNrVZ/pDAgUcNCgXfY2sYKbffipfN20DL1B8Cr9CPTm2f8VHB5v9+AMDIuGDSaPqG1gDu4RmoHZO8iFPrRHvJ5K0ad7lx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev; spf=pass smtp.mailfrom=johannes-moeller.dev; dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b=GbJg+KUH; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johannes-moeller.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b="GbJg+KUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=johannes-moeller.dev; s=protonmail; t=1773180038; x=1773439238;
	bh=hZEJp9rUkZ10x1+tyxfdIyN6b5ZE3brXj1HdhI3Pomo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GbJg+KUHYaanVfVg6/Cg9LBsQ79CmVoIN2K1mjboFF8EeOMvXuD3i/3UeTnZ5c7yF
	 U4BvhTa4M2XwriTvah+Zq85PNH/aiReXaQvtXpEDX26RqG7mgRB4//3jGV0F4psgLD
	 ikKbww1Omun7isuwLAPJj88bORJsWu2udCuT//OpcVxfBx98Zo9jLBadLWLjCBBZ2g
	 RLyPSbLRQOpz8Y1FST+x7rpUjAP2aDIZYaWQARZ4Fhdr1OIeWg5h4Em+oWdlXBkiIe
	 NuDnlhupU+SelV39KmaKUIHNxFPNbN2CBLSi0hRzPh6SPxTvhofMogx7b1XxbHzV4O
	 svqeuweG7VKkQ==
X-Pm-Submission-Id: 4fVnr52wJnz1DDL7
From: =?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access
Date: Tue, 10 Mar 2026 21:59:47 +0000
Message-ID: <20260310215947.35756-2-research@johannes-moeller.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310215947.35756-1-research@johannes-moeller.dev>
References: <20260310215947.35756-1-research@johannes-moeller.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

l2cap_information_rsp() checks that cmd_len covers the fixed
l2cap_info_rsp header (type + result, 4 bytes) but then reads
rsp->data without verifying that the payload is present:

 - L2CAP_IT_FEAT_MASK calls get_unaligned_le32(rsp->data), which reads
   4 bytes past the header (needs cmd_len >= 8).

 - L2CAP_IT_FIXED_CHAN reads rsp->data[0], 1 byte past the header
   (needs cmd_len >= 5).

A truncated L2CAP_INFO_RSP with result == L2CAP_IR_SUCCESS triggers an
out-of-bounds read of adjacent skb data.

Guard each data access with the required payload length check.  If the
payload is too short, skip the read and let the state machine complete
with safe defaults (feat_mask and remote_fixed_chan remain zero from
kzalloc), so the info timer cleanup and l2cap_conn_start() still run
and the connection is not stalled.

Fixes: 4e8402a3f884 ("[Bluetooth] Retrieve L2CAP features mask on connection setup")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Johannes Möller <research@johannes-moeller.dev>
---
 net/bluetooth/l2cap_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f8ed03095592..93e41d9ac124 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4616,7 +4616,8 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
 
 	switch (type) {
 	case L2CAP_IT_FEAT_MASK:
-		conn->feat_mask = get_unaligned_le32(rsp->data);
+		if (cmd_len >= sizeof(*rsp) + sizeof(u32))
+			conn->feat_mask = get_unaligned_le32(rsp->data);
 
 		if (conn->feat_mask & L2CAP_FEAT_FIXED_CHAN) {
 			struct l2cap_info_req req;
@@ -4635,7 +4636,8 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_IT_FIXED_CHAN:
-		conn->remote_fixed_chan = rsp->data[0];
+		if (cmd_len >= sizeof(*rsp) + sizeof(rsp->data[0]))
+			conn->remote_fixed_chan = rsp->data[0];
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
 
-- 
2.43.0

