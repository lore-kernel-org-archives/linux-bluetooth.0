Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 02C626FA8
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2024 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987587; cv=none; b=F4FUceR0K+/3OaCASkAi2q2gNywroRQDi6WSZBXoX+9UALGWO5kgx8gvjqmsoOr1jPfOIOQf19V+9IZkEccqEbfDX8o/XK9rCPU7LcfMO45EXCe2d0OydjZSLgRl//EfuBkuKxIvbQtjjALLbEpmdUmrM0VaHl63oYWJ7pr0Xm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987587; c=relaxed/simple;
	bh=u2TnfsDIFmOl2f3uQUwOR0RURXJS9Cl6rQY7B8diH1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Udg/is1VDe1w2JofezExNKqfXlQU2LSyP/W1rw0639BkDLPZxUmCoXqKFnSTwGdYtFnCistB1dc12jsjJhOVwSY5GZ/KYSeVQc+sUmhtFg29Ti9WaJXmT60cl7xEZX+aVV2ekIsG29+eLtmEH9d6haTomCYx5lolb2guoWnuOkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 2AB876059852D;
	Thu, 21 Mar 2024 10:19:39 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.2
From: Youwan Wang <youwan@nfschina.com>
To: linux-bluetooth@vger.kernel.org
Cc: Youwan Wang <youwan@nfschina.com>
Subject: [BlueZ] obexd: Remove redundant judgments and fix code style
Date: Thu, 21 Mar 2024 10:19:25 +0800
Message-Id: <20240321021925.513182-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Youwan Wang <youwan@nfschina.com>
---
 obexd/src/manager.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 73fd6b9af..c393911a7 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -525,7 +525,7 @@ void manager_cleanup(void)
 void manager_emit_transfer_property(struct obex_transfer *transfer,
 								char *name)
 {
-	if (!transfer->path)
+	if (transfer->path == NULL)
 		return;
 
 	g_dbus_emit_property_changed(connection, transfer->path,
@@ -542,9 +542,6 @@ void manager_emit_transfer_started(struct obex_transfer *transfer)
 static void emit_transfer_completed(struct obex_transfer *transfer,
 							gboolean success)
 {
-	if (transfer->path == NULL)
-		return;
-
 	transfer->status = success ? TRANSFER_STATUS_COMPLETE :
 						TRANSFER_STATUS_ERROR;
 
-- 
2.25.1

