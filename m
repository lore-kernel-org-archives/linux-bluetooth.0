Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9713FC5C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289074; cv=none; b=cXL+jAiueqmju1KS10eNaJlQTbL1mTrbQLqveacMV/QE9we9ap5eL4eQypHYiioj6cjF4am/1sN+46M8UjXzE/fPZ0oVQauUN/vH77z0YIOoHkTUOzbraT3w0Y4K36IErAmPR+mDcrEtZr5zqCeBEHMn3vgr8D8acnNiLv8HZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289074; c=relaxed/simple;
	bh=6F2wGlcLFdi5e9+GY58oy+JRIYpmOylnLyvKYoSAoXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVw26cNPlebEjZiWzP2xuHTV7+4bbjcskBBNhigdQD7I8MoA/If1R1edUfzQtzAb08cONDzrDIva0MAjTSr9vflSQwp//SzqDT5Mh+qOWp46jAvOW8rcgw2eefWclrJ/OgTggGgLl4tvJOOSaPYyQrIwTkArcITR+365645Pqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCpcxgu2; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCpcxgu2"
Received: by mail-vs2-f40.google.com with SMTP id 71dfb90a1353d-5c9a1536864so189510e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289071; x=1790893871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kdtul5kQ3tdjkQenjhTtE2ahfxZCGeAX7k9lx3BO/a8=;
        b=FCpcxgu2FD0KwoYYoGEzQfHVpAuPnSL/jCCSdwil+s+zs7Gb1wRDiEn6CAeWdi7jKw
         JpDXkS3ZzPItLzRicystx45GxiHMPRPzOSstWrcEWqFOLFsyD6aBh+ApoJwp1Lx6MAN5
         q3/CIzLDHGO1eNvu62Nw9anJMkXHmDmbW9nkiTIREpbQvRyoGaxLaRa2CY6bMGoaUWD+
         5Lz1v6B/EaV/a/V9HC3hlAGDJOpyldtBGadfDDSjNYj5AovIGEzMxkVEnlEw4ClLtpUb
         MeVxgp9VPGVbrbBySE7KrLCBlxEWpnqk+d1mmKUsKbIUup+8u5Wv+074tntnx7MjWJ3L
         Nwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289071; x=1790893871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Kdtul5kQ3tdjkQenjhTtE2ahfxZCGeAX7k9lx3BO/a8=;
        b=LE1HvNkKNjQJQjdFs5HSMyWLf1uZlKYohtkMQzeIgGI1RPQhCH43DgHle+R5oxMIFd
         /OEvo9ScIGYwyj+7ZSB4v63fHiG3weQv5ClYNvNJUAz4Jne3oy/XVJm3G6HkNcp7uPsd
         EeUVpZahdnKu4IrYuPqHHFD+Rd3xR1HY1897g3a8bvnMsHTacHm1lM0vFe13TM915wjJ
         tav+oI/Zdo3krvDtw3BHFLKneaic+TdPiFNtEKR8pZaADboxrCxFAxqPD6oHxdIVK5Gr
         92mT/1xj1wWIwF7lhd5V1E86GubpuuatlOtj4n4KxoyYkZo+RbPLPfLmdSkYbwEuyED5
         afGw==
X-Gm-Message-State: AFuF++nkI/GsUUOsZkmr8T0XUCASdV5Njp1mhpB5blBocaWOG6erjhKg
	jh75ccZwKwblXZvIGjendF2rQYXtVHWPIkzYmZRR055It02F3dr4jDp5Hj0sysG3iYIVWw==
X-Gm-Gg: AYBFou0NzJs6tkynbKQDJ1FhYPD5M7R7TOQO1YAECggNS9E8/Db2WFA4KPWht3CXjAs
	umMxK1cYLc+E67WAR0bRVJhAUt6hApJyLmq0hTPNr7pcGWFzgb/iX/guQAOy9VJEwSFHQkDEYc9
	XXqVNnA+0K4EE/bmj7NIDRCt9A73L94JS8dlXgXqs3D+/Ro7cGEeOA62aMdMtdTblv0AVVnuXDe
	wlXTGeMjwFjYLCcsImVex4mgozPunFCl5JQvF/E1p4pT3u4IBXqtzgphQQZU0Nfnwe1sTiBoe4c
	FBkNLEFuMUyZCehpCOhXYnlGg8PoVZUEy5xGIzNnwVqv7IH2YY+as3puWu2uz10ZVfn2iVMgefi
	J2BI3QJlv5dI0tgFoeyZLNL5xtIQ6FZeTkmnMWElD5ezd2W3nRMY4FYyP+K+e9C10BGtJmpBDJf
	MVwbtOvMrNk/KGd8ItVfwXsLraARB7x9mMuGneO1X5vawUOZDvZgU3tmF2BTyW8iL9+SB8RzAAr
	vGce7T8P1iFuHDrZJs20+pG2Fix7rBQRmiH+29kKYKFwG8GUKCVZJRL5zkLB4+S
X-Received: by 2002:a05:6122:548:b0:5c9:c26b:528e with SMTP id 71dfb90a1353d-5cb0bc5f6d0mr2152121e0c.20.1790289071653;
        Thu, 24 Sep 2026 15:31:11 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.31.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:31:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 17/20] doc: Add CONFIG_HIDRAW to the tester kernel config
Date: Thu, 24 Sep 2026 18:30:42 -0400
Message-ID: <20260924223046.605543-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Enable hidraw so unit/test-uhid, when run as root e.g. with test-runner,
can request reports through a hidraw device, as HIDIOCGFEATURE does, and
check the replies to the requests the kernel sends to the uHID device.

Assisted-by: OpenCode:claude-opus-5.5
---
 doc/test-runner.rst | 5 +++++
 doc/tester.config   | 1 +
 2 files changed, 6 insertions(+)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index dc1e51305c51..52178244fce8 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -205,6 +205,11 @@ Bluetooth
 	CONFIG_UNIX=y
 
 	CONFIG_UHID=y
+	CONFIG_HIDRAW=y
+
+CONFIG_HIDRAW is used by unit/test-uhid, when run as root e.g. with
+test-runner, to check the replies to the reports requested by the kernel
+through a hidraw device, as HIDIOCGFEATURE does.
 
 For 6lowpan-tester, the following are required:
 
diff --git a/doc/tester.config b/doc/tester.config
index e68740dc0f44..34f1530e174c 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -54,6 +54,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_UNIX=y
 
 CONFIG_UHID=y
+CONFIG_HIDRAW=y
 
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOCKDEP_SUPPORT=y
-- 
2.55.0

