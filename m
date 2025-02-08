Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3A1AF0B5
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Feb 2025 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739007283; cv=pass; b=ZefmbGdcdyxpLM/CUycgcs+bJF97WfeSQQHFRtfNqPfoTdeN++TggHQq2A6jtwNrZ236BHetfS8u49fTJNVILuluhathJw8ufyOJKpkv+D2BOFzsvB7IAC6I3GowOn5UMM6cKzIQXkoy89scEylN78uC4CL87P1CMOl5VKVEyHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739007283; c=relaxed/simple;
	bh=YSaToZoP0vyC6K8lDL94dlTR+iw8Z5PD+u6zmXj6RgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHJ92IjX9b4joXggdaf2NKwZ2KczLhk7rmWTFxwbGvB2ILCZkarXYWiF14uNQpc7TzbV6VgcD4XJSSbXRMdF7YuOgxVlkm+/5r1x9TRjPhj0wfckQXBDoo6uWdH6+1hpM/X+a9GlhvS59q22anhE/9O/wBz1229MbKV2oG2L+QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=E4TFSCd5; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="E4TFSCd5"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4YqlzW2sNNzyQx;
	Sat,  8 Feb 2025 11:34:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1739007272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PIEhqa/Nx8GaEDR8myCJtM/9E8mo9z0QKIpnDUh5Kys=;
	b=E4TFSCd5Lw/RFtElXJAvg7kJVnos3T9fd1nx3ls6O3CnFS2QsatLJpvfgE3+S9+hwxKWoj
	eTRvz2YGF5qE/BiH+5ec3aK+OR8O5v78+ZqrgVBewGJdxgwenZasM5gRRW+Bm9+kV5A9jd
	Ex94S/eMdq+r965AqwNp8xliZyyKBNk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1739007272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PIEhqa/Nx8GaEDR8myCJtM/9E8mo9z0QKIpnDUh5Kys=;
	b=yY5rhbNIq6m4GYC6SYZRAzVozcb3+eKyaC/YtDzku+JcoJ1LFdNhMBe0KAuApkNwANOwjX
	2HfSRVivO+KBQowstYUCS9lB985k99vTopJ2gl8NGftYwOqL1nnoAvRiFW+yeKbyOVzN4j
	obK1WQVDsTqIx92Fl2J7OOJ4HdXnRJk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1739007272; a=rsa-sha256; cv=none;
	b=jYBaqhvr1z40dOvq+bEHx60L2LzFWAGlTU4+BthJmfVLR5A6wNt0lsMbx6ZJ0jfVWYcMtN
	SIKOcubx1eucbrKqBwXAr/KH+lfMgONPj3u37EC6r2JiWJ6HzqSfId7xfuJkYiPzwN0MKF
	PeoNdIeNLvi757mtyRWz7BVxhZrx8aA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] build: check first before enabling -D_FORTIFY_SOURCE=3
Date: Sat,  8 Feb 2025 11:33:55 +0200
Message-ID: <da7a417d9b27d26393d6c9f52f675e7ae0541e8b.1739007137.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With --disable-optimization, _FORTIFY_SOURCE=3 produces compiler
warnings/errors:

/usr/include/features.h:422:4: error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]
  422 | #  warning _FORTIFY_SOURCE requires compiling with optimization (-O)

Before enabling it for --enable-maintainer-mode, check the compiler
doesn't fail when using the flag.
---
 acinclude.m4 | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 9f2dc302e..168117840 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -65,7 +65,6 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
 		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
 		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
-		with_cflags="$with_cflags -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3"
 	fi
 	AC_SUBST([WARNING_CFLAGS], $with_cflags)
 ])
@@ -136,6 +135,21 @@ AC_DEFUN([MISC_FLAGS], [
 		misc_cflags="$misc_cflags --coverage"
 		misc_ldflags="$misc_ldflags --coverage"
 	fi
+	if (test "$USE_MAINTAINER_MODE" = "yes"); then
+		AC_CACHE_CHECK([whether ${CC-cc} accepts -D_FORTIFY_SOURCE=3],
+						ac_cv_prog_cc_fortify_source_3, [
+			echo '#include <errno.h>' > fortify.c
+			if test -z "`${CC-cc} ${CFLAGS} ${misc_cflags} -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3 -c fortify.c  2>&1`"; then
+				ac_cv_prog_cc_fortify_source_3=yes
+			else
+				ac_cv_prog_cc_fortify_source_3=no
+			fi
+			rm -f fortify.c fortify.o
+		])
+		if test "${ac_cv_prog_cc_fortify_source_3}" = "yes"; then
+			misc_cflags="$misc_cflags -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3"
+		fi
+	fi
 	misc_cflags="$misc_cflags -ffunction-sections -fdata-sections"
 	misc_ldflags="$misc_ldflags -Wl,--gc-sections"
 	AC_SUBST([MISC_CFLAGS], $misc_cflags)
-- 
2.48.1

