Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F223E25B
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775193540; cv=none; b=J3LFqA2+Vz2WnEOs5HA0d+f4/ePbQii1oV8ROjorgAOdCSirjlYSVMQG/BQJt9vLlQ13QwLdJ+tIsMS+tBwq5riREckz4Ru07LXfaWMMLTRl1Y2CEgMrhI4GPxMKOQFFpjldH9i7g1/NnwDUBHeEhkXLZMrFDAawKJT4VZnntGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775193540; c=relaxed/simple;
	bh=lE9pWPqLFzimEy+L1b601emZGZP6CNyGLKMqWu0D1xM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=UpXx7CeTm6DXZQtNhJJp79hAbyzSuU8G4RHdlJ2btVh7RISHFt7EXZKyjBU+E0o+6FJD5vspACymHe03xXvx97DtWsYNJ7OrcJ4vd4sui94qkyuM/ICH3RshUB3EDkIysGa+5o9v4nEZKFod/cRIucpzS3O2Yf96472iyutNw5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=osVylPtX; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="osVylPtX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775193527; bh=AWfBsyrf3pkX/c9YscH26IOuTwywYvJGXnEdswsI9Fg=;
	h=From:To:Cc:Subject:Date;
	b=osVylPtXK80O06Kai4530z1a4yaIRselbIeziqnRLXTT5lE8BYH798ZfS+Izpzut/
	 rjEgduztp1g9eM/QIoTR8lKOM+8qX4kUOhfotj8Cxxvr0VdedTWn4ty823e0KWhzi/
	 yeSZz3IIOiVzuHxbNQfEZW5AtC4An6AccV5cGjjA=
Received: from caitao123456-pc.. ([116.128.244.169])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 4ADB9E1E; Fri, 03 Apr 2026 13:18:45 +0800
X-QQ-mid: xmsmtpt1775193526t0eevyb1p
Message-ID: <tencent_B48D92FA1FDAD2A12B772500611B6FE3AD05@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uKP5QKdMWf7HFjd7AhExfGhzWtQnfbjoFw68eKqC7WAJSJwHhko
	 q36hJDFYVnGSrxZcBQrNfD6Scqf4maiYhgLui7jnCi0B8etTaix3o9C2C2sjzDly+KhlHypdRz/C
	 0FwZuBpnRAAYgu693omALwh3HtShalt2GSszt7ei81dMtYIi0NccimzS6mx8dG+B/Mc7aNDv6Ho3
	 oid5t+ld/w59NRrPm6xApce930VNA/G5OaocgUroJOT7n7wGf8kRsCnK5yg+cPLJAf1Bc8EeFlK+
	 BLmYnz6WjEm2hj9GZo7SbWy5Cg2TBfEJanT4ryxACM8qhvmq/GoPDKLIQhaXpTU9TvZ0Frc4o7sd
	 Jaq952kZk4JtykGjSUYqB/IG5uuS9wvQScgZRyl9iqOS3BeW9Fxls22Inz1swfPxvbF+8IQ91/Z2
	 7KQPPRcUNB3HY6IvibZf401+BA+FYwtjypQJZF/OAsRKk444Kgwsa+QRHO9FqzSyQkyBiCGNtdbm
	 pOKqPtZL4xyLvyPO49eqAVM07u0s+Z4ZauSBbeBLlntJJ9ctrwEVWx9VBSQHmG0hHW+4vyhoBI33
	 xdDdGaWa2BMcbjU57Pagel//bRL8N71rp4TUjevJAOoeRZoXnBweem2Ahy2gDfZuClpVhqZCyfvF
	 GcxI+kJWJSSN+1V4VOD1xbRSr1/pf4ATP5jo9O2ISYM7wEzyIACbIlZIfRHWKAy4O7yQzGMCxazL
	 zYH+FSIVMr3CFsf3FJHK9Hv2hlFjKBfgC+gC/ZFt1TRLtwDLmGi8QXPQTyV9RfNfWw6pHPxxcKYZ
	 LtvO6DIAe6FTNktz7DXtHPtU0u6v0TVds110pv55YP+cmGkku/BQpydKeCJq0qRiQvb/gnRb+UEi
	 wXP0qo0onoAno4BPmMg0fhqYFnZNZhCWdBOme8VdGU8haj2SVRWtsEuJ02QjXiyoHwGzRW3sziLB
	 OfKAOXpSETORJ8Y7QmLMMVPt3+6mFe
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: 294305068@qq.com
To: linux-bluetooth@vger.kernel.org
Cc: caitao <caitao@kylinos.cn>
Subject: [PATCH BlueZ] src/log.h: Add line number information to log output.
Date: Fri,  3 Apr 2026 13:18:40 +0800
X-OQ-MSGID: <20260403051840.146045-1-294305068@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: caitao <caitao@kylinos.cn>

---
 src/log.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/log.h b/src/log.h
index 1ed742a0d..14b54194e 100644
--- a/src/log.h
+++ b/src/log.h
@@ -57,8 +57,8 @@ void __btd_enable_debug(struct btd_debug_desc *start,
 } while (0)
 
 #define DBG(fmt, arg...) \
-	DBG_IDX(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+	DBG_IDX(0xffff, "%s:%s():%u " fmt, __FILE__, __func__, __LINE__, ## arg)
 #define error(fmt, arg...) \
-	btd_error(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+	btd_error(0xffff, "%s:%s():%u " fmt, __FILE__, __func__, __LINE__, ## arg)
 #define warn(fmt, arg...) \
-	btd_warn(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+	btd_warn(0xffff, "%s:%s():%u " fmt, __FILE__, __func__, __LINE__, ## arg)
-- 
2.43.0


