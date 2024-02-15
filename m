Received: from mailrelay6-3.pub.mailoutpod3-cph3.one.com (mailrelay6-3.pub.mailoutpod3-cph3.one.com [46.30.212.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB330145322
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037649; cv=none; b=joctxt9u2KqoQo/WWzZZ5kll0R+OSF7cH2FB9XDdytP4o3n4nP7nIf38o1JBv/6n3cgRIhRabmf1f48XdU7G0aC1iLxOhX4aN3fc547JOBlB/G6tUfgKu9B+Q81/3e7iE5Qpspfl6DNB2DJURA9Ez67YDGuQs+gZ6WtFG1kNdr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037649; c=relaxed/simple;
	bh=n5AALWDWVFfDt7AhhFaZUtP31sr02/JWfuVbqN717zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNQZZO88D65NKgJLT+gpKPJUYeb53HOKJm0CqxEyYh186dBrXhuJxUfklmDY+Hhr1CVypooaouR4etKtC72Zh/vzKXax8bSAT8Lztvo1QF7qODbjyHeGjZFbz8q95o4l9xvbrLDsZAjKaF5EiRy+pVpMGRFO8MbqfN7WeD0Cot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tjernlund.se; spf=none smtp.mailfrom=tjernlund.se; dkim=pass (2048-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b=c2aiIwA0; dkim=permerror (0-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b=MTg38H9w; arc=none smtp.client-ip=46.30.212.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tjernlund.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tjernlund.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b="c2aiIwA0";
	dkim=permerror (0-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b="MTg38H9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tjernlund.se; s=rsa2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=HxKzli1QDcoWQ9eNu+ZCZamYtUMLkLZfYiCsOWpRTqU=;
	b=c2aiIwA0YfDeh/KzG5n08k2vknxybGk707VQw5wusmciOua/wKg0mkgzcDgQv3yUP0MeyGSBl+gOO
	 o1OzqlBGZvS9fsCNSGFtIflI6r00qeehWqKO0YQPbR8zwaqO6EnG4Gq6OZhkBiKbin5/iYEZ53wYRy
	 DnxURRxLsRT4CTIJvHjl8ObTO56vMlAMlW291ciLXNHn0XDO3Twil4xkUn6kpog7AEDe/tlCXO5A0u
	 cryL7azq6GXfwaNBrXzSKnLlhkYgydNqSuGdh02mcYakGV8g4bwI1xCpQm729wcWDtFYRO/EzoaZNx
	 XH63LKDrfJASwxbBPamVgch5gXEzMcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=tjernlund.se; s=ed2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=HxKzli1QDcoWQ9eNu+ZCZamYtUMLkLZfYiCsOWpRTqU=;
	b=MTg38H9wvo72Y92aigU96oVFbI2K8TPGXjSNRk4QYHS55VomiRWrlaZd2OkA1OIIAv1Od9weUGZi7
	 cvtiQz+Cg==
X-HalOne-ID: f4bfcb3d-cc54-11ee-8b79-bd80189f112a
Received: from jocke (c188-149-162-176.bredband.tele2.se [188.149.162.176])
	by mailrelay6.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id f4bfcb3d-cc54-11ee-8b79-bd80189f112a;
	Thu, 15 Feb 2024 22:52:55 +0000 (UTC)
Received: by jocke (sSMTP sendmail emulation); Thu, 15 Feb 2024 23:52:55 +0100
From: tjernlund@tjernlund.se
To: linux-bluetooth@vger.kernel.org
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: [PATCH 2/4] bluez.pc.in: Add definition of libexecdir
Date: Thu, 15 Feb 2024 23:52:13 +0100
Message-ID: <20240215225249.16242-2-Joakim.Tjernlund@infinera.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215225249.16242-1-Joakim.Tjernlund@infinera.com>
References: <20240215225249.16242-1-Joakim.Tjernlund@infinera.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
---
 lib/bluez.pc.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluez.pc.in b/lib/bluez.pc.in
index 3d6e59616..1c2f30b33 100644
--- a/lib/bluez.pc.in
+++ b/lib/bluez.pc.in
@@ -1,6 +1,7 @@
 prefix=@prefix@
 exec_prefix=@exec_prefix@
 libdir=@libdir@
+libexecdir=@libexecdir@
 includedir=@includedir@
  
 Name: BlueZ
-- 
2.43.0

