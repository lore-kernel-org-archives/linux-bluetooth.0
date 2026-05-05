Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6839DBC4
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971479; cv=none; b=El3SqaRf2+MTgldbxwsNXW5VuvtULVoyQGRJr/g+07FLkjLyHCVLAlqQogDnqKvIfBNodm/zUUWY4l+ATf4Cp2FVwxj1xC/3l1+Js2bGmAtRdVcmEkZfnQuG8WaL5KlqoujRTqadNzEHQqb2jwOhxeiONWW0McvPoOBMJxieEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971479; c=relaxed/simple;
	bh=3cYys359eTdT9nX2oDG9Xhw9Xc+I8wRiC305pHZGx/A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzQoh0J2V09zFW6O/0uFzqBqRwMe44IgLQTDUdlsorlFXQYv3hDVHwRUFm17FAmk/J+QaHX+RbLkldUOunciTe3DtyHux6Zlvobtl5k5aaq+7MqrD+DrjCSSIo2YGqHNK1+UPHjFwQvafBRv2znjgqm0AasXvUulrAViD2P3NiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F01C13EBCD
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:50 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 05/16] tools: Install gatttool if deprecated tools are enabled
Date: Tue,  5 May 2026 10:45:11 +0200
Message-ID: <20260505085741.2497401-6-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505085741.2497401-1-hadess@hadess.net>
References: <20260505085741.2497401-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTGXmq4sYO8BlJrXIVgIB7muk3QXODh1MUKdBH55Ci7J8U9YX61JX1VQW8u9G5stDX74kCWWnUAfyRKrnnNOtSD3rtlDuerXVBgIxMk5b3MfGfM/b3dGKEeik62rh1ydwVt1LeS1zRVJaWA60DbeCD2Jy7CSeWU9iG3wZ2G9wI1HEEbJtgcqJSAm7L42hgUweSs68v0ULwk1ufjPgGCzjPSaoqHVDUueiQtxHGEREaPLFctB/LAtEqkfGedmJhO3+Y1tnNi1Ve5FBMuld9eaX2Yg8L84hYoAdKKG0Zl9phHx63OcGndijZqF6Zmle32kTfUcEFGhFepwHbN87dag93+hH/O/dc5g8YlYEhJsBNiR49c1MhIJTmauSpnZu8uV4cuvjvAc/yzRSgnzwU+dDSMsP9cXZDmi5PEdOS5/xhlju9s1YpTBRcQwTNVDHQ6JOnQgNq3QDsUl/cAAyDoOkv2EmVrOLKKl1/KKARD2BvnEBfZ/BiPU6kbWc/Jm8e+PZqqMvUPSj9MH0s0LZKeOwW/rgxGoFB/dc929cm4gaJBv39cKEQcjLJR1KAG8ls+SyxeQ3N+xhTCjJyY5/gzJdJwQgxMeeFoepJoBETbJgFgKDmh+2bebWy9Vui2kVmtBOVOvdKqN9RxjcafTU7HtJQUTA3I7x4Zdi1QdtnR9C0LuOQ

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1141909
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=720486
---
 tools/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/meson.build b/tools/meson.build
index 8fc0dc1d2fb5..5f092e7e1b5c 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -204,6 +204,7 @@ if get_option('tools').allowed()
     executable('gatttool',
       sources: gatttool_sources,
       dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, readline_dep ],
+      install: true
     )
     executable('hciattach',
       sources: [
-- 
2.54.0

