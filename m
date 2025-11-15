Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D14339FD9
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763211523; cv=pass; b=oqcRWC0WhGOEVQqq4V6VlU16DjzxJs/F28JfRMpZosLOklNQIJehWP6Bu/ntx22fbNihyFp7EgnIRNj/3snW2e99HVcgnJf45XKkO88HFJ8/iYvQ/Kw0jMzitKBuEoGu2ygPZQ4KBJK2xXYybCKKxip0ZTeZT70XQyNL8i3JPY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763211523; c=relaxed/simple;
	bh=j4JtGPkatC3Y03yed/G/43ceHkY/zvwYUAm57VKATzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBw+MBUV962uUeNWIIwmdXCxtF6aZVs7XDIQZb/eLygzofWVuHCkejju6rURsFLiAgBMkbgQe55EUbTPta+uIysIShkQ0RUSlwmaOqX+YN+SB95/opw8HIc+rV+keba0DbaGzgiZ8ZGQahGRs9Tt2J8PoOF/VtijpcpN//4kQcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=F2fTclCl; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="F2fTclCl"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d7vFp4z27z1022;
	Sat, 15 Nov 2025 14:58:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763211519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwlqCsJoespofxR+jw/PvORb/+OkToqFjZcdIh/aMbc=;
	b=F2fTclClsG2DsoS5YJuqYgJm6dcptqlS29HWMC/Nm63TofF7jaFLcFe4awPrm7TdiwH7o3
	B9IvXzjvI2vP7rl0aE2PpzyYBNbSm6SGTykBlJC7UeQj1NqdS3uE0yCMbEXu9Fm0HI4moF
	pjd2yURr4Fzlrf0/pC0aI3NZIKU4EuU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763211519;
	b=Wg/EcxIaoFs5zruoRfZ4/CCWG9xHZtvU2UMWaOHVNvV0WfAqp/RZEHXLBjc6bk3IOqMc5l
	8Pu2Ica3mpUMxU1uXzAJi9CRuGF59ttyom62RPRIPnIW8ZpJH2rtHWXl55tIy9rdURfMqZ
	N2oh0xEkFVJL4KFXwPTCtUE+q5gDufc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763211519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwlqCsJoespofxR+jw/PvORb/+OkToqFjZcdIh/aMbc=;
	b=RdDIr/6mQG5OuQdg165dYI8ruEsnL4P+uAHLhs+/801GX6QeIUI1b3BXRrIkZ4+rRitt/E
	/rmlxpE4eT3uESvnv9CiH1lB1NndxWDAEDUCaO/IHkQmlyWkWzTsDWJeaPVe0nth8UAwPE
	2xUHZtXLNYdn5u6GKiV9ibNj6PKlnjE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 4/6] shared/tester: better debug output on io memcmp failure
Date: Sat, 15 Nov 2025 14:58:31 +0200
Message-ID: <c4558b04f5a06eacb5cab40e0c3abc1c233df0e2.1763211509.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---

Notes:
    v4:
    - no change
    
    v3:
    - new patch

 src/shared/tester.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index d1e872b8f..1f59322bc 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -983,10 +983,11 @@ static bool test_io_recv(struct io *io, void *user_data)
 	if (test->iovcnt && !iov->iov_base)
 		iov = test_get_iov(test);
 
-	g_assert_cmpint(len, ==, iov->iov_len);
+	if (memcmp(buf, iov->iov_base, len) || (size_t)len != iov->iov_len)
+		tester_monitor('!', 0x0004, 0x0000, iov->iov_base,
+							iov->iov_len);
 
-	if (memcmp(buf, iov->iov_base, len))
-		tester_monitor('!', 0x0004, 0x0000, iov->iov_base, len);
+	g_assert_cmpint(len, ==, iov->iov_len);
 
 	g_assert(memcmp(buf, iov->iov_base, len) == 0);
 
-- 
2.51.1

