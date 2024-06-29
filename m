Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01862BA34
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2024 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719692206; cv=none; b=fhs3NP8Eb/Fdb0waagCJlJ94/+BK0H7+tNBHgIl+wK2nZRSqj+CohniceHupwCK1s7cdfLHpGkXa2Rz8lwDGKZKU5sQpCvp5uGYNYji8X5ENRvGOFyCd/lAnekO6KpUmG7FtP1CE9GFX+TtphPc2b+NC8hvCbZm+nC8ectPyVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719692206; c=relaxed/simple;
	bh=7RV5JUzTYXgZaEJCGf7sGVcCqiDZCdo4o5BE42LUfzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQ3GIlPlrRhpQ6UE/HBLW23Gka0ITKG5r4I0gWjR/nnPR8FbJzVYBJefzYQFspsIEvoiGbX+q5pYbfdAudtNI9nogLchnf+7NGQvVHeVub19Cxt69w3DwVvtPYp400O2sRFgUm7b+tQMqFQpuMtqwNtSvr3S0LCwYlCYGdVW6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arnavion.dev; spf=pass smtp.mailfrom=arnavion.dev; dkim=pass (2048-bit key) header.d=arnavion.dev header.i=@arnavion.dev header.b=bCtGHoRI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IEm36UcF; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arnavion.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnavion.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arnavion.dev header.i=@arnavion.dev header.b="bCtGHoRI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEm36UcF"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 186A61800093;
	Sat, 29 Jun 2024 16:16:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 29 Jun 2024 16:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arnavion.dev; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1719692203; x=1719778603; bh=m5MvGOya7irprl8mmO4X+
	CNRsMA0LMH1rbnnrRR47tg=; b=bCtGHoRIjwgpVsl9sjEvDKMeue0yQ3Y+Rpid3
	w/t6+VpWmuH5OKYWFyBbpCq85oTK0aYAEbgvl7LcSqq7WqxMCUtiKZG5jc0HZFOK
	zjr+etotypAWLl6peCTb7CEsWyuS2zluOcUHexWLi3cvVm90S9mSp0vibrrX5Ac/
	tTYe+l+hdW3fGUFZmddasnG4tzq0Ydoimhp9KDOwjvnGZAuEJThX6tVCvShOK/lW
	bc/5AelVaWnQ+tSghySaXGUUTwY0YNR8gaiwJMUlTOqQf4/7lfPDhyTeluxsj3fF
	BLeDIdSPiHGDb65DQMY9vJYRlWblm/W04Jx4EHipbIjPoZeXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719692203; x=1719778603; bh=m5MvGOya7irprl8mmO4X+CNRsMA0
	LMH1rbnnrRR47tg=; b=IEm36UcFOt/wjos/aKaun/ORcppp2W4tO7i3rBhVcJ2U
	2Odr6ziBKLqDZR5uvo4qBubXR01iwE1KtI/9cT2br/ttc2GTcL6ZmI+dG3Bu831I
	PKzLOdO4sbRVvxeR2nOHV1tMLWDeGs/nnsBcRfSjkYQobiAqMloU6GJV0GTqy7gE
	9J1lsPdeuRtx4veJZQauP77/PvLLTN586xMgNtkv+QbiwHnmLO/Y+cIpvvGd3uEA
	Y4fum4j5cf4dMQEzc1T7WCbHxtBFApBC02+knJPwOkzRBFvxeyoMGFBofP5nSOTw
	BP0clsuTNgwQ6LbjOsop+zplDWz6Pbao3ezFAoa67w==
X-ME-Sender: <xms:q2uAZryWMU3zutXwVBhJ8bU0aQOKgN5l8ZfVv-idP6zEmqmVVpiF1g>
    <xme:q2uAZjQy0LAArcp19QT0H60KJ2cN6pqXCi1ZFgd2gk335V36pyvhoQmLYDttBqvrN
    Xevvv2Lavj8XmdWcrY>
X-ME-Received: <xmr:q2uAZlVwEK0O33Pn9WzAySkSUZg5TVOKUzgYZ-ZQX24s70jKjDzEo8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdelgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeetrhhnrghvucfuihhnghhhuceomhgvsegrrhhnrghvihhonhdr
    uggvvheqnecuggftrfgrthhtvghrnhepjeevkeeugfetieekvdejfeelgfegkeegjeetvd
    eiheejgefgfedttdevhfffhfelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesrghrnh
    grvhhiohhnrdguvghv
X-ME-Proxy: <xmx:q2uAZlieK_5UDhhIa9uZdaP_HqTpwCv5ZbUXpe6A8_qX-fKKPi3DuA>
    <xmx:q2uAZtA_Oe4G1_Y06Oyf2LQcK81Ip279137u7iTZ2ZkrUCJucW-K3g>
    <xmx:q2uAZuKnW5Lp6PQZfieqxb7wII9bXtVtHa_SxjHrUHcvSnppuWYwyA>
    <xmx:q2uAZsAY0dwbmU8pxVbRjTD_nJRPIvHwt4l-cwZbMLnPjlpT7vhKkw>
    <xmx:q2uAZgN33mnIf3AkgaqOjpOV757l-xHjKo9lknW4JFQikGPkDfwFmZJq>
Feedback-ID: i31c1461b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jun 2024 16:16:43 -0400 (EDT)
From: Arnav Singh <me@arnavion.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Arnav Singh <me@arnavion.dev>
Subject: [PATCH BlueZ] policy: Fix AutoEnable default when main.conf doesn't exist
Date: Sat, 29 Jun 2024 13:16:32 -0700
Message-ID: <20240629201632.1356542-1-me@arnavion.dev>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

180cf09933b2d8eb03972c8638063429fe5fece5 changed the default to true
if the config file did not set it, but it still remained false if
the config file did not exist at all. This change fixes that.

Fixes: https://github.com/bluez/bluez/issues/886
---
 plugins/policy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 0bbdbfc88..9a449da61 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -74,6 +74,7 @@ static GSList *reconnects = NULL;
 static unsigned int service_id = 0;
 static GSList *devices = NULL;
 
+static const bool default_auto_enable = true;
 static bool auto_enable = false;
 
 struct policy_data {
@@ -858,6 +859,7 @@ static int policy_init(void)
 						sizeof(*reconnect_intervals);
 		reconnect_intervals = util_memdup(default_intervals,
 						sizeof(default_intervals));
+		auto_enable = default_auto_enable;
 		goto done;
 	}
 
@@ -895,7 +897,7 @@ static int policy_init(void)
 								&gerr);
 	if (gerr) {
 		g_clear_error(&gerr);
-		auto_enable = true;
+		auto_enable = default_auto_enable;
 	}
 
 	resume_delay = g_key_file_get_integer(
-- 
2.45.2

