Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F954C9570
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690095; cv=none; b=F1Hn2vbBkZO62/EvSMdlbqlnNxI/r5ukNVWDryRqsh4ul8Hk9evDQB4EOO7s9NoypGXaPK7UecnoUy85HE/qReJhOFTSINa2fJvhZE3WMbwc7e1tU3G87XI7XibuUPfeg4egs7LOn4VgzfT80u/unQzaZyTcOfSbCnpRDOxdkBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690095; c=relaxed/simple;
	bh=mwvzHcVH9PM/cYuhh5hpen6f9wmZLh6Jr5ley6/wYhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLrF7CC7bounB5gsS0PGSlHwDM4FvAKepevgl5lKKdf1n/vniYONNgBb2QGdkir13QB6MrrYEex5a8N2PRbgz//4aHk9SO9AH4G1M+1FV9cpwQqGbCFrWO9n2vOKWu4ytQZixXP5bN1Ze4aAziQNrBh9SgXj4FSfjQB2aSBW9F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IDXKqorY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IDXKqorY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778690092;
	bh=mwvzHcVH9PM/cYuhh5hpen6f9wmZLh6Jr5ley6/wYhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDXKqorYMI7tMsLlq8riGKqmK1cIpU3UoBUX0nr5+hp/MDRAm1/BCOVAdAN9lpfjU
	 e39ARokWcDeXuks8tXkpzv1OddPq9xh1BjaHQ8h0xfQ42ZnAcdHXdQ0AGR5a1hx0W6
	 Nzb/7MP3msQk6OXgWh6yDfXJhSF0y+jQWL7bbD0KwP7HJfafmK99izqvQIicjo+YzJ
	 ToTLDmNNtfo8UsV0eBePQAxrEHRqV31XYQOOFBN4ZZo/KEwzZPk/6puwunFBMgXlQd
	 KupqxGDVgwfn9DLWy04vGksHx0BqnpH6+7jYihzuq6nXCX6Bv+Lml8NQneTog822je
	 BsRylX8DcL+GQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 97F4717E12AA;
	Wed, 13 May 2026 18:34:51 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ v2 0/1] shared/bap: set QoS state when CIS is lost
Date: Wed, 13 May 2026 22:04:34 +0530
Message-ID: <20260513163435.11344-1-raghavendra.rao@collabora.com>
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

This is used to pass PTS tests BAP/USR/SCC/BV-167-C and BAP/USR/SCC/BV-168-C.

raghavendra (1):
  shared/bap: set QoS state when CIS is lost

 src/shared/bap.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.43.0

