Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DFE28680
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866858; cv=none; b=F0nznGkNbqZODVRgf59nAhBzmEnV1EhkGLaMVAiQGa8M28ttcq11r6wyBdB1ykfWofefBHnLwGV5VwWDGWcFEagpe4F0z8t5/Ac7wbkTsjS9lQH95iqldgnvUNIyBJ+PRWF2LN4ykevFI8VnrLcpiwRAT0Pire8L3lDgBYZxrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866858; c=relaxed/simple;
	bh=rdh7g/ZcB2Ex0TyD5R4Wpsa+9G5LzF2ApinH5cm8B7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrnLDSyh69wMBMlVvt5e0CtjEDEVh63NbNueR5ZD1BTjBtxGHOkOFd/f9jvPmm7Dgd8oHEqijyLJtQYlchWr71VyS68/aHqj9XKxqSgG9T7gXtplSkbPS6d1+YINvAXfFv6jQ/OSm6qYp5MMDKG/GdIUeEyjCq1P5ZMnH8O263s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B63CC20005;
	Thu, 16 May 2024 13:40:53 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ] obexd: Fix memory leak
Date: Thu, 16 May 2024 15:40:48 +0200
Message-ID: <20240516134053.102475-1-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

To not leak "buf", we need object->buffer to take ownership of it using
g_string_new_take() (but it's only available in 2.78 and newer), or we
need to actually free "buf".

Error: RESOURCE_LEAK (CWE-772): [#def66] [important]
bluez-5.75/obexd/plugins/filesystem.c:411:3: alloc_arg: "g_file_get_contents" allocates memory that is stored into "buf".
bluez-5.75/obexd/plugins/filesystem.c:418:3: noescape: Resource "buf" is not freed or pointed-to in "g_string_new".
bluez-5.75/obexd/plugins/filesystem.c:440:2: leaked_storage: Variable "buf" going out of scope leaks the storage it points to.
438|			*err = 0;
439|
440|->	return object;
441|
442|   fail:
---
 obexd/plugins/filesystem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
index f52927541bab..4887a0b8ac81 100644
--- a/obexd/plugins/filesystem.c
+++ b/obexd/plugins/filesystem.c
@@ -416,6 +416,7 @@ static void *capability_open(const char *name, int oflag, mode_t mode,
 		}
 
 		object->buffer = g_string_new(buf);
+		g_free(buf);
 
 		if (size)
 			*size = object->buffer->len;
-- 
2.44.0

