Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948263148D0
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753161; cv=none; b=pUXES3gqBeBfvFuvS5yQWqz1TKY+02z9SGlr+Z0PEJZnG1Xbif+jkM1grkQl7fv1UfIqS1zEevpvbHvzXM2dvIdctxh8w/qvgf5RbqQ7Sq69B4ZMNzlZEi73JWMKlBoFIEWZSd+KPwVOLF61aiPm+B1ylWfV14pqnR4qkrIwcec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753161; c=relaxed/simple;
	bh=Diyy7esXI2xFjBiP+ztSceKwPn7crdBwPY+LnJ6aKx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWzHpjewdTD2TO14DKoJ3sxxUMOlnXzTm5P+1VPfT+6KpenPbVcuqeE5882OyZ1Hf0tBhkUgeJyF3Z1uZ9FCbhL/ZitXOH5li/8tcSTSIqPGDUVdyT4KVlEmccTMvM6gelnPo4uDIa9wGa4WZJGY1z/86Utua4FY3V/yS7e772k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lY0f5Gtl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lY0f5Gtl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778753157;
	bh=Diyy7esXI2xFjBiP+ztSceKwPn7crdBwPY+LnJ6aKx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lY0f5Gtl40y8GHPBRbji5ZtEdhmOgBlzTgJ3B0Rq+T7xO6FQaONcxGpEeRMi6lld/
	 5Suy78kOdV9HTVvkwmtMqHf4yz7Fpd8PrdN0OMRhXdNjjQgY72g61W8deD/GQi4UwN
	 FkIccLBI236KAcCjRWVx3WpH6ccG2XZGS+b0xYMQg4SXXlPiaKgenJZrC5tgXf1Kh/
	 1QKjO7HmwMWWdm/qIe6zKTP0DhC+rCjVuGJ3NxYq52TMVF/xK4BVzwvPLz4rF2Qhby
	 Pu0HQBNTAke38bIqSDLFiNGugi10IXyf2yNLtxhgSrCSxgJEBHUrQTyqTjikaJWkN/
	 oCRWfWstCOdVw==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9133817E04F2;
	Thu, 14 May 2026 12:05:56 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ v2 0/1] shared/bap: set QoS state when CIS is lost
Date: Thu, 14 May 2026 15:35:44 +0530
Message-ID: <20260514100545.54572-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZLcvmErUXHUXnAJOMv+saSP7aodVtfRV0QnL2-yXg=z2w@mail.gmail.com>
References: <CABBYNZLcvmErUXHUXnAJOMv+saSP7aodVtfRV0QnL2-yXg=z2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is used to pass PTS tests BAP/USR/SCC/BV-167-C
and BAP/USR/SCC/BV-168-C.

raghavendra (1):
  shared/bap: set QoS state when CIS is lost

 src/shared/bap.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.43.0

