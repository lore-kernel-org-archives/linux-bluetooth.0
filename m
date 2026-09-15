Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D04BA9FD
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506952; cv=none; b=PhGO9CJubW9pOouDRLgO6Sxlh5GUCIL8elGoZ4GMEHIdRtO76+KUNdgWg0Zj28RfWUlRBDTIOhT0M1HiyUzIuIZ7weuhAKHDHXE1CiWu65DdsC5AB4S2nr2GyfsaRpBFz6TRBEEQ5FNGX94Y+3KB5b73KSmWdOmXdghqtYR3rj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506952; c=relaxed/simple;
	bh=HZrHgsRMLRCIdvIQRZv3Sb1HqLA1pL5bePzGe6q/JVw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdIMEenhMP83SbAQvetS0H+Gmfh2ea1e42k2hm0In+EgjPbSbgnImRJpTIDhASPwQUc2FEHy75tXYfeUVLZZfflnU3F0hB6mtTnAhh0LJp3JLEOFRBuLSTA99gIkFeld/M72v7MRBdrFoQzCkYeY5dINZBASeTja9/MfviQfjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7Mbdoxp; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7Mbdoxp"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-78a7003f9f5so100269137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506950; x=1790111750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jaVcSYaVbNTHp9wnSNd8VF5S6AtlBTJmeg9IbkdKku4=;
        b=D7MbdoxpLLN2IFZhfWO7rIGZH/kuDVbNF9SefX/tzH/6ElkBoKJtTbZNJpDNqNux4L
         xj99jcJmF3XH3cTK3KeTCyZSeXjfIHPV4S7pBq6gyD3GU8ShIejp4YqKoAIyZqhSsPFX
         +dlciuDpfTPjVV70BCF4EA4N8fUcdf7pgvKtdWqEIgGlorf13vTfRQqV5aM0AMDPKx6H
         RY+FpDY+1rJFoUf7PbXykYpq3Vu4kQUcJ6G4cttVexj0nDiNUBaIX/TLgW95bl2uolGB
         nOMf4YnNf0+RDJ/mBt17HdAMR8AddmTsKfrLhMEaIt5YvV/SjarXPKfmrWGdsVglGnpe
         fgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506950; x=1790111750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jaVcSYaVbNTHp9wnSNd8VF5S6AtlBTJmeg9IbkdKku4=;
        b=KpMi7VpbKjSZZg5kDQva9yjQ2EiUm15F9uDYeN0v2C7y+Ew4cNgikpgAzHEajzX1sO
         pR1FIGOhg6C4Toc10SAHho3Tp/Ctuw4OxhBMNKSFDwggo0+AZXWCHiE3qIBjZ3zn/SFh
         /CrvqdqX8AXGhkNVZkSMKksK0UxBoj7V1wjGgWm2avMi5VyM2c8NPcs1ZZx3bZblbsjc
         8komhEkjJMu1laqi4HiUvcFeQ8+yHYlhewQ2AOmOUGRw18zrar5lGjUTkgHTP8ruHv7C
         mN7Y2ZAF82FaFR+Sf3Nuo9ricyev9wQ6NEnrjtJJvYds4QOBphPpnpg/XF/MXgSzmDG4
         Zkiw==
X-Gm-Message-State: AFuF++n5X3jS6zKFXdcgHbTIitPbTqhotMXWPByMjwYVrrufGcGAfhef
	kaMEGap6RcUxjZZcPeVT1IPmsfjwGOwkrz21sl/+5/YJAYGdRdZjCsj7F1kHkKkP
X-Gm-Gg: AYBFou10uIyb1OccLgUf+KYv0XXrmoz9FDK0rkFMPrBpd9hMt2R5BC3SvE4U+FvhZAg
	bRJ/dLEsmoZN7Rskd4FK/CaZ4COrHanHnv7iH1rk39wgTP5xNevRJEKQaUFCnJUueKpnIg0Whj9
	H5MzVBSlj0BLGVtVxFbPZggY+i4fmtX0zqoL9dMksbQvvw2fsPk4jPJIfrCFa1vyALUpdiLt5HC
	dvr2xwkGct680SX7lvspvy6bj3/FByUaqjz80BHwcVlzGpW6acwMpctujc6/VswsEDuHG2CdtQX
	5ajZuQSdwrIDcjidYfT4D/6VyplqyhiKEMU4C6mFJxx0LzavlpFmlnCC7GIMHA4DzUVP8cn5pPR
	t2MRHNua7kIIN43M/Cy/tNhfbbB5I7uGC02iGprfGnCg3C4URm5JVIeJu3fJBpz3+hkapDInq0+
	TX9Y49cZ1Xn/iyGvhUFrDiUM0iAQzf7j2rGWOqVfrhQZXKE5smlkT4AqOMmYx3TAGAddJnYPa8N
	ag8TxNZDORL95nCy0auMhq+evDuOC6vy9wPiA+J1lygr6g1/LgvIddq8gf4OP9KLA==
X-Received: by 2002:a05:6102:390a:b0:79d:62a1:1c73 with SMTP id ada2fe7eead31-7a02b2a0ba7mr172702137.12.1789506949910;
        Tue, 15 Sep 2026 14:15:49 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 10/11] test: functional: fail as soon as an operation fails
Date: Tue, 15 Sep 2026 17:15:27 -0400
Message-ID: <20260915211528.1223784-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A test waiting for what an operation reports on success only learns
that it failed when the wait times out, 20 seconds later, and what it
reports then is the pattern it was waiting for, not the error.

Watch for the failures alongside it, so a test fails right away and
tells what went wrong, e.g. "Failed to pair:
org.bluez.Error.AlreadyExists".

Assisted-by: opencode:claude-opus-5
---
 test/functional/test_bap.py | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index bc9bcfb83ad8..6ffbf0371e0e 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -32,16 +32,32 @@ def dev_addr(host):
     return host.bdaddr.upper().replace(":", "_")
 
 
-def expect_all(ctl, patterns):
+# Reported when an operation cannot complete, so a test does not have to
+# wait for its timeout to know it is not going to
+FAILURES = [
+    r"(Failed to \w+[^\r\n]*)",
+    r"(Device \S+ not available)",
+]
+
+
+def expect_all(ctl, patterns, failures=FAILURES):
     """
     Expect all the given patterns, in any order, returning the groups
     each of them matched.
+
+    Fail as soon as one of the failures shows up, e.g. a request that
+    was rejected, instead of waiting for the timeout.
     """
     pending = list(enumerate(patterns))
     groups = [None] * len(patterns)
 
     while pending:
-        idx, m = ctl.expect([pattern for _, pattern in pending])
+        idx, m = ctl.expect(list(failures) + [pattern for _, pattern in pending])
+
+        if idx < len(failures):
+            raise AssertionError(m[0].decode("utf-8") if m else "failed")
+
+        idx -= len(failures)
         groups[pending[idx][0]] = m
         pending.pop(idx)
 
@@ -88,7 +104,12 @@ def pair_le(host0, ctl0, host1, ctl1, advertise=True, services=False):
     legacy = r"\[agent\].*Passkey:.*m(\d+)"
 
     while pending:
-        idx, m = ctl0.expect([legacy] + pending)
+        idx, m = ctl0.expect(FAILURES + [legacy] + pending)
+
+        if idx < len(FAILURES):
+            raise AssertionError(m[0].decode("utf-8") if m else "failed")
+
+        idx -= len(FAILURES)
 
         if idx == 0:
             warnings.warn(
-- 
2.55.0

