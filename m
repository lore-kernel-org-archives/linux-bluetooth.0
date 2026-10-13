Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016C501F55
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903829; cv=none; b=OeNc3rp+2Tfg5Q3ZOaRT52P59WNt/ZMlWbuI5AK/Fa5rTyBEB5ooVITeav/xHhDFs/qboowqMH0tlsVn1jxjdZmY6Zh96WsfkSd3hYggUzaYPPwNcgdcAZ/BNLWcmFV/F5C/72ch07qzhDnQ1F8XNdYBuwRWvlsQYbFups58LBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903829; c=relaxed/simple;
	bh=j8a2JRzCMgZtJXIIcnnLCTAKvYpdryQBpMZO0pLyjYc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ksDQgndXHq0sUcGpyKr77uMZWwKleS8BM2S2feBwJwwU3K/vXyoxkCjd3hw4j8BAvOfRmvcFocaxj7HmuBWBG+HNWhGdxWOgFg8geceMweQ1wElv9cwfKoch3DGAc2maFKQ+0NmlHP990QgKYodRFxeTR4d5t8c89nbfZ9wVQCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlZsCS85; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlZsCS85"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-784980b88acso207639137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791903826; x=1792508626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJoABb3GxN4U1Xhe6qXyzuMwtAhFV261/FilCvV9uV4=;
        b=UlZsCS85laj/Pqpl6iOUTaSk3puO50nv/44AgoCathza8gexq07W+PY6wwij9Lybh7
         cTI/r7m/nTmRKyrHVqiZADxT1Ox1I9tiDGJAJK+VLgmELcy/J42j/GAq8bMRMhTLgmWa
         gqviFCCEg3cucPw+LYWR5W18g+JycZvaopEXvVGVh0LzICqwMshNWy4MEN3YMHvvfkFd
         iPQS3Th8SIS7PTpDtjSJxuslbDi3k5/b9atfZNZ0NWDPyJXKZXu0E2YCA7HcqheGvR58
         nbnkZHpG2+nfbfC9zL7MSI6OEOyHUWdnnuxXpWA3uPq/24/jYPM5BoV8FL9HPndOyas+
         rsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791903826; x=1792508626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lJoABb3GxN4U1Xhe6qXyzuMwtAhFV261/FilCvV9uV4=;
        b=rvjlz2hxwD2e0tLSX3Ie7K/WZ0tlRYftpTmorLc/MDJbtyYEbzW8Kon+jgPIgdC4SU
         tOw2w5vv38D/w7nVW0HV/7wqiCKXwPxJbGzMy1GI5lr0MHtwGhEadg/COeQe+7cOK/V0
         W5EjsNY0LMawhG+DGi5LusIppY6kZHT1Eqi6pio4dToMTKcenA4aCZl3pORF6PuDRtDm
         6zcbiZewjPaU+qNmQ3hGrE8plBfTuLvVNA0XLB7kV+83Bqy4akiomysPxiZj8eHTNAgB
         MdrnARJtgAUXLpDET72mEMM9sGsLKXbjZfjEAZbaXDp6kvfFAqB3PGXtjwzh8Z1/x84S
         ydmQ==
X-Gm-Message-State: AFq9FYJEteZLViW5bwy9Na+m6DU+XvfVjOO4M/PBhcxLcBkDKJt6YWYQ
	iVYMmF7fJ0Rqw1H9jDb8dtaSdQWg/ZI1WpKWzAYqqCiM/SUctBZkp0YanJhHFw==
X-Gm-Gg: AYBFou2PisH9tSq/TlGobOVuTIQcXiEJObq8a/x2pEhiqOVfaKtWdWGYjVF9P+VDO9h
	cQRg4PSqAeVgA8NjQ5XF6yTXgYENxWyxdm8soaAVvaQnaOxUx00MsIElqNB72PP/oefNfKJlrwv
	XrfPIK1VxqUirTVVbj1SNVZmU2pTbxnGtaFFKuX1BkFn6w0qt8hykFncliaOaTzlxJA1Lcncjxy
	YK9XZVhXPE/lfGJP1y1eMvdCrK8y6mxjNDqf8+Nj7o/sRkV12LIZQQCMTGhn6pF5v4xVA2HmPk3
	bwpj9A6NgHi3nNEtMSGJRIivC4ynxViDVmqgzwMuT8bOCMb+RRRiyFEA8fLOk+wCVVt6KFYHBJU
	NyO9rf+Rip8cEFCcWcYQo7nl7XsWy7KxOm46QB9w2ZxcYzEvztlkeEKAdXFSs0TB+TmApJIMqah
	CovUR+kRP4igY2FVG35ts8SBOgQqOXuzzWZP9VhUtK979kpgac31++noiqNmwNPZhR6fG2OjfHT
	z0m8QdlFIA8CuCqLF9ZU4kf/l+Oa7Y58e4Eh3Z/t2ajhDX92pTLUoPyNSaJRDIx
X-Received: by 2002:a05:6102:38c6:b0:7b5:4700:3a6a with SMTP id ada2fe7eead31-7cb37381bdfmr3358164137.26.1791903826138;
        Tue, 13 Oct 2026 08:03:46 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb3539092esm8993812137.3.2026.10.13.08.03.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:03:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] test: functional: connect instead of pairing a bonded BAP device
Date: Tue, 13 Oct 2026 11:03:36 -0400
Message-ID: <20261013150336.579039-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The hosts are shared between tests, so a device bonded by an earlier one
is still bonded when a later one pairs it, and pairing it again fails
with AlreadyExists. cmd_pair is meant to connect it instead, but it
checks Paired, which is not set until the services are resolved, so it
can still issue the pairing:

  FAILED test/functional/test_bap.py::test_bass_past_transport_acquire
  AssertionError: Failed to pair: org.bluez.Error.AlreadyExists

Check Bonded, which is what the pairing is rejected for, and connect the
device instead when it is set.

Assisted-by: OpenCode:claude-opus-5.5
---
 test/functional/test_bap.py | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index c4bd5fc6aa61..7cd9466bd5f7 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -112,12 +112,20 @@ def pair_le(host0, ctl0, host1, ctl1, advertise=True, services=False):
         ctl1.send("advertise on\n")
         ctl1.expect("Advertising object registered")
 
-    ctl0.expect(f"Device {host1.bdaddr.upper()}")
-    ctl0.send(f"pair {host1.bdaddr.upper()}\n")
+    addr = host1.bdaddr.upper()
+
+    ctl0.expect(f"Device {addr}")
+
+    # A device bonded by an earlier test on the same hosts is rejected
+    # with AlreadyExists if paired again, so connect it instead
+    if is_bonded(ctl0, addr):
+        ctl0.send(f"connect {addr}\n")
+    else:
+        ctl0.send(f"pair {addr}\n")
 
     pending = [PAIRED]
     if services:
-        pending.append(f"Device {host1.bdaddr.upper()} ServicesResolved: yes")
+        pending.append(f"Device {addr} ServicesResolved: yes")
 
     pair_wait(ctl0, ctl1, pending)
 
@@ -155,6 +163,25 @@ def list_transports(ctl0, hosts):
         transports[idx - 1] = m[0].decode("utf-8")
 
 
+def is_bonded(ctl0, addr):
+    """
+    Tell whether the given device is bonded already.
+
+    This is what pairing it is rejected for, which Paired does not
+    reflect until the services are resolved, so cmd_pair, which checks
+    Paired, can still end up pairing a bonded device.
+    """
+    ctl0.send(f"info {addr}\n")
+
+    # Tab indented: the [CHG] lines and the LE. and BREDR. ones are not
+    idx, m = ctl0.expect(
+        [r"\tBonded: (yes|no)", rf"Device {addr} not available"],
+        timeout=REPLY_TIMEOUT,
+    )
+
+    return idx == 0 and m[0] == b"yes"
+
+
 def remove_device(ctl0, host):
     """
     Remove the given host, so the test starts from a state where it is
-- 
2.56.0

