Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C55C30ACFD
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298539; cv=none; b=tT1e9N3mYPmd68PTmc7QwQQ/39dpXxtn8uk32yctlkAodTFqUD6wxzE7i2dxuI7FqRdXvAPFIJ6UM27JTuQvWq9wpUWABJHP4Fjqvd3v/wqnnaNwoCGxNT7+LrWK/kNRpPMeRww/GZEK6Kw4znNWfDb+SbuuqCSHqDlNw8hngz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298539; c=relaxed/simple;
	bh=CKKOz/kJjVMYvd4pkS/mzcXxbyE3VVj4IwNZiwo+5HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8vBVt8UXTCfFll47pHcZH4SnqV1PQb7mxGtxa1kyNGQNHn35vZYZzK9cJvE1o21YX271kWZZE75k3cbeE6njNJ0DztlQYvqcviukxihLXxM9LPo7DW+Wrh2/4PeyFEUZJNRZSJod6lM1Oc7DI/vSWs09yjBckN5C+gEn172Xzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=VhhekJWd; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="VhhekJWd"
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9AEB83FCD2
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 09:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761298534;
	bh=26R2VT5jzI1SQyB0zhhuSRv+RHj2m1tX2R9GgjHg43Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=VhhekJWdI/0DQoCK4OXbEgIDCIWcmNtxRLQl944TB5Wn92s5rzDCScoLZcZOSd000
	 7dZ55BmWMC6+G8p26ERgyKLsHOweKYtN7JU1iyvG0reB6nQL82fjQFN21RW2mLmlXU
	 E+IqM5bEswxcjsvuYKHJiAhFZ35m/jsxLXDUoAAk2raStX1BoGMUgZJlVsJsp3L3H5
	 8AeFxDhIkPZAGTbS0kjm0YKaEeMJ33VrHEr4cpyWF4mgZJQkgCKaZ+Nf35aY18uI2/
	 lKznACd64TZbqPdFuaHMpemmufXK7yoqcwqRvv1pDOCeHnaKucw/ws+qyBalfrZrac
	 GEhUI1l6Mf6BTosthERoMyriwxcUbI6UlGP5FuiSOuPQ31jNV12LCqGYWXfdBP6HE7
	 1KabtHmOk4lht2BT5TuDY/CqnbnpXJ2kqSwzcArbJaCHgUP5ux24FV8WNrQPmQjfic
	 7kXw452jKt/9jzdChsUuGLLcNtv/Sdx7gZo1R2xDWhF1gowQylkwekdiX4VWvYAAMy
	 pKlPA3HMD2dfFzgpQppEi5Fne7ROHDA8GlRphelC2AQHqq5epf/dYYmExHDbgPFSmT
	 ArE7+Mx0uIFXMMromW1rdtWp8LhcmPsp+E523BHc/AGjzVowpWP58Vs0saybWqY5vL
	 omm7FjvjUTKZJfs6tVxyHmSc=
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-63c4999fa3dso2333608a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 02:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298533; x=1761903333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26R2VT5jzI1SQyB0zhhuSRv+RHj2m1tX2R9GgjHg43Y=;
        b=odxz4ri/+IEQlmClwWLyoMzfqusrGhWLtJ/uq1A2x4IKJYWRU8IJwMsgs52suzwM06
         AWZh1QaXPt4z1nw/GVj+mhVYXrDpuG20+Ol77ZO6JU/UeYlL3cIPMXy3Qy2iN7CNwQ74
         uZwaSOm2D0YXsz66I6tWt6AFx04i7TmF/SzR1yUMioOtytS/d8R4PR201X57AeRin8ns
         wQpceABNJk7AXuF6B/VX4wEvd8TuUgokUbfSTefJCcbk4F0hds+4n335NIGlkSSZT4I+
         /m8cjzAvZ2AOdq/75/hH4r//4gm0iGCLr5BhzxrWJwf5Ygq23JPipm7kQwWkFM/uoU/S
         GWVQ==
X-Gm-Message-State: AOJu0YwMDdf2kJDMeNpq+lW8on2PSG0u6pyEEJGSCAmURJCo9EMhm2Lr
	i007hoxywKTjO/L3PJO7zBInPOnVbvkd2E0y432bKMihGQ9cvgNa11wurc5fHMrdldRE7i2Gv1W
	H4jCQWuIuuG8ci80hubpVpz+MSCwaiB6tMJLu5i6yObqVwjM7yxI6gI8y129XLBk4PR4dq2p1lM
	ChGm2ZqKJIoXAB012kGA==
X-Gm-Gg: ASbGncvyOf1o/irEXHN5dOZjZG2NOGZqw9T904uX69d38przjhtgc/gd5iPy6V0t4Fj
	Vasg2TMgHHL4lXUSih9dCp7TzaFduyxXRouIu8WgP7tnJJx0R16EaC+EKogWPpdhfd68QnNi1qz
	585D09vEc5UO+Ycgj844m4ZMlM6k4W56w7PyMPO0wt5rbF71igk33V09T6eFBbEOopLCquXI5Hn
	N8Zltu0y/Q3sdYrHahjEsANAqy0kPCIkPG0hzljo7PU6JXMzYbtWoY6p2TzzJql/1B8hCNI6c0s
	qQUlMHvRol16GzPzk2PYVqWWoN3MCoQPYbJq61huE3EWxTPRZTg6rLFQMiBDxT+ZJrHLxhq86tX
	keYJum9IKiC4aRGucNOYgdAEuKBvBZzlB470kVvkD1/tv3dXGfk1jF5T9JVK/4JLtZT20AcvVfo
	rW
X-Received: by 2002:a17:906:4fc4:b0:b2e:6b3b:fbe7 with SMTP id a640c23a62f3a-b646ff85d64mr2985656266b.0.1761298532702;
        Fri, 24 Oct 2025 02:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHktn0K7hIKONtdl/GTMWbtxk2Nz+4UZGCYT4qx5DLDDB4cnUeQYHIRQ6xWpwNFFClkuOt+6w==
X-Received: by 2002:a17:906:4fc4:b0:b2e:6b3b:fbe7 with SMTP id a640c23a62f3a-b646ff85d64mr2985654266b.0.1761298532290;
        Fri, 24 Oct 2025 02:35:32 -0700 (PDT)
Received: from framework.. (2a02-8428-32a8-2801-a6e0-ca89-98fb-e4fb.rev.sfr.net. [2a02:8428:32a8:2801:a6e0:ca89:98fb:e4fb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144efd3sm494497166b.69.2025.10.24.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:35:31 -0700 (PDT)
From: Antoine Lassagne <antoine.lassagne@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antoine Lassagne <antoine.lassagne@canonical.com>
Subject: [PATCH BlueZ 1/1] obex: forward nicer failure messages to dbus
Date: Fri, 24 Oct 2025 11:34:35 +0200
Message-ID: <20251024093435.169217-2-antoine.lassagne@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251024093435.169217-1-antoine.lassagne@canonical.com>
References: <20251024093435.169217-1-antoine.lassagne@canonical.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without the fix, the following error would appear:
"OBEX Connect failed with 0x53"
After the fix, the error message becomes:
"OBEX Connect failed: Service Unavailable"
---
 obexd/client/session.c |   3 +-
 tools/parser/obex.c    | 103 +------------------------------------
 tools/parser/opcodes.h | 114 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 103 deletions(-)
 create mode 100644 tools/parser/opcodes.h

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 89c877f08..e1a5ad361 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -32,6 +32,7 @@
 #include "session.h"
 #include "driver.h"
 #include "transport.h"
+#include "tools/parser/opcodes.h"
 
 #define SESSION_INTERFACE "org.bluez.obex.Session1"
 #define ERROR_INTERFACE "org.bluez.obex.Error"
@@ -328,7 +329,7 @@ static void connect_cb(GObex *obex, GError *err, GObexPacket *rsp,
 	rsp_code = g_obex_packet_get_operation(rsp, NULL);
 	if (rsp_code != G_OBEX_RSP_SUCCESS)
 		gerr = g_error_new(OBEX_IO_ERROR, -EIO,
-				"OBEX Connect failed with 0x%02x", rsp_code);
+				"OBEX Connect failed: %s", opcode2str(rsp_code));
 
 done:
 	callback_destroy(callback, gerr);
diff --git a/tools/parser/obex.c b/tools/parser/obex.c
index 157ea2cce..820c8b99c 100644
--- a/tools/parser/obex.c
+++ b/tools/parser/obex.c
@@ -20,108 +20,7 @@
 #include <string.h>
 
 #include "parser.h"
-
-static char *opcode2str(uint8_t opcode)
-{
-	switch (opcode & 0x7f) {
-	case 0x00:
-		return "Connect";
-	case 0x01:
-		return "Disconnect";
-	case 0x02:
-		return "Put";
-	case 0x03:
-		return "Get";
-	case 0x04:
-		return "Reserved";
-	case 0x05:
-		return "SetPath";
-	case 0x06:
-		return "Action";
-	case 0x07:
-		return "Session";
-	case 0x7f:
-		return "Abort";
-	case 0x10:
-		return "Continue";
-	case 0x20:
-		return "Success";
-	case 0x21:
-		return "Created";
-	case 0x22:
-		return "Accepted";
-	case 0x23:
-		return "Non-authoritative information";
-	case 0x24:
-		return "No content";
-	case 0x25:
-		return "Reset content";
-	case 0x26:
-		return "Partial content";
-	case 0x30:
-		return "Multiple choices";
-	case 0x31:
-		return "Moved permanently";
-	case 0x32:
-		return "Moved temporarily";
-	case 0x33:
-		return "See other";
-	case 0x34:
-		return "Not modified";
-	case 0x35:
-		return "Use Proxy";
-	case 0x40:
-		return "Bad request";
-	case 0x41:
-		return "Unauthorized";
-	case 0x42:
-		return "Payment required";
-	case 0x43:
-		return "Forbidden";
-	case 0x44:
-		return "Not found";
-	case 0x45:
-		return "Method not allowed";
-	case 0x46:
-		return "Not acceptable";
-	case 0x47:
-		return "Proxy authentication required";
-	case 0x48:
-		return "Request timeout";
-	case 0x49:
-		return "Conflict";
-	case 0x4a:
-		return "Gone";
-	case 0x4b:
-		return "Length required";
-	case 0x4c:
-		return "Precondition failed";
-	case 0x4d:
-		return "Requested entity too large";
-	case 0x4e:
-		return "Requested URL too large";
-	case 0x4f:
-		return "Unsupported media type";
-	case 0x50:
-		return "Internal server error";
-	case 0x51:
-		return "Not implemented";
-	case 0x52:
-		return "Bad gateway";
-	case 0x53:
-		return "Service unavailable";
-	case 0x54:
-		return "Gateway timeout";
-	case 0x55:
-		return "HTTP version not supported";
-	case 0x60:
-		return "Database full";
-	case 0x61:
-		return "Database locked";
-	default:
-		return "Unknown";
-	}
-}
+#include "opcodes.h"
 
 static char *hi2str(uint8_t hi)
 {
diff --git a/tools/parser/opcodes.h b/tools/parser/opcodes.h
new file mode 100644
index 000000000..654ddfc6f
--- /dev/null
+++ b/tools/parser/opcodes.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *
+ */
+
+#ifndef TOOLS_PARSER_OPCODES_H
+#define TOOLS_PARSER_OPCODES_H
+
+char *opcode2str(uint8_t opcode)
+{
+	switch (opcode & 0x7f) {
+	case 0x00:
+		return "Connect";
+	case 0x01:
+		return "Disconnect";
+	case 0x02:
+		return "Put";
+	case 0x03:
+		return "Get";
+	case 0x04:
+		return "Reserved";
+	case 0x05:
+		return "SetPath";
+	case 0x06:
+		return "Action";
+	case 0x07:
+		return "Session";
+	case 0x7f:
+		return "Abort";
+	case 0x10:
+		return "Continue";
+	case 0x20:
+		return "Success";
+	case 0x21:
+		return "Created";
+	case 0x22:
+		return "Accepted";
+	case 0x23:
+		return "Non-authoritative information";
+	case 0x24:
+		return "No content";
+	case 0x25:
+		return "Reset content";
+	case 0x26:
+		return "Partial content";
+	case 0x30:
+		return "Multiple choices";
+	case 0x31:
+		return "Moved permanently";
+	case 0x32:
+		return "Moved temporarily";
+	case 0x33:
+		return "See other";
+	case 0x34:
+		return "Not modified";
+	case 0x35:
+		return "Use Proxy";
+	case 0x40:
+		return "Bad request";
+	case 0x41:
+		return "Unauthorized";
+	case 0x42:
+		return "Payment required";
+	case 0x43:
+		return "Forbidden";
+	case 0x44:
+		return "Not found";
+	case 0x45:
+		return "Method not allowed";
+	case 0x46:
+		return "Not acceptable";
+	case 0x47:
+		return "Proxy authentication required";
+	case 0x48:
+		return "Request timeout";
+	case 0x49:
+		return "Conflict";
+	case 0x4a:
+		return "Gone";
+	case 0x4b:
+		return "Length required";
+	case 0x4c:
+		return "Precondition failed";
+	case 0x4d:
+		return "Requested entity too large";
+	case 0x4e:
+		return "Requested URL too large";
+	case 0x4f:
+		return "Unsupported media type";
+	case 0x50:
+		return "Internal server error";
+	case 0x51:
+		return "Not implemented";
+	case 0x52:
+		return "Bad gateway";
+	case 0x53:
+		return "Service unavailable";
+	case 0x54:
+		return "Gateway timeout";
+	case 0x55:
+		return "HTTP version not supported";
+	case 0x60:
+		return "Database full";
+	case 0x61:
+		return "Database locked";
+	default:
+		return "Unknown";
+	}
+}
+
+#endif /* TOOLS_PARSER_OPCODES_H */
\ No newline at end of file
-- 
2.43.0

