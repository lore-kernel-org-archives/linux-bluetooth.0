Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185F3368AA
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015025; cv=none; b=pytYN9zcYsD7K1XsXhVnLyG915znqmQmSAdKIlmHhMr3/oE/JBO5CG+XEB6JfUZV1kxeyW4/M7dt5Ii0vY8z9o5sDHLEHJspAHRgeCkq7latGxJOy43s88q8u7Krm74+br0cVjiYf7EplIm2XObEsqCJxOwwSvlSenY4stP+wrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015025; c=relaxed/simple;
	bh=hyYGXZCE8QDHfDGGlf/PgMRL5wriElVhAAc8x5CWDf4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2lDozjtfvqSJXMWyHQedgMdH2RehGKZDLZdUxDdXImcZKzwW4ValVWLItQ8LIP09xsQe7ieffRWq0qD3gI6L83Hw4pyoooSV/KpJ5505K5i8wcW84DwfOVZSorPyKAhV6rEj34KaYzk9TrWNG0MjT6f10E8VBos8rv8n66zby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 478BE58291A
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:53 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15B913EDD6
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 3/6] doc: Recommend using _cleanup_ and friends
Date: Tue,  9 Jun 2026 15:50:55 +0200
Message-ID: <20260609135837.476561-4-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609135837.476561-1-hadess@hadess.net>
References: <20260609135837.476561-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTEVlSdXhFUvSV8QQx6yOrxge8LgLVsxPuUsLns/yksmkNx+qdDvLvza5bKGN8WNxSHwt+f8VbZ4lJPoURNdRMWp8SMuewEQUfgBMkY/jbgr+LyXuM7iW1giNJiHgNHw6TWCI3u/pWopj0uku4KXuEzF2U7Jkv7EHtBXrrJV7gBwCRlXQDiK2LO8ylQk6uzIFcjqpCrorpKwg3w0D6ojMjAneIde2+9Xgn2LOidAqfgBRNsXEa58H2+xUe5E0Ri8LlvlWBN+ajBkbQKIGVS8FIytq/3m1RxPUluCTzu51875p3iUUbERbtkhDOOaRjgxLdx7vcvY3Bj/fS1GlcpyS/+REFxkKUPUCLCn4gD1b3AfytbfspbxAduM04vXQ7rJWochpBKysYBstSN6GQfWlUwf38/Q37JTgUIZDM7RvWO6WkItNxDrFIivIa9IWwCjYPsc22wTlgguJwUeT5S/ykG4e83pwHVm2Bk6FntC3QFKrEjCdqRoUhtb3XQASf/AzaJVh3URSJ6Ld21IPHCMYocctNS0A4WPGJ44fayT5G1OwnAdIMXwf9dd4BeeCKz1iDY7G8ivtpzmPhfWDh4A5LnPV4r+VgUagAaEAiUVR0ep81Su80sM5myVe/keelOMr0d8IXXu+NpocM1+ZyOLGXq7LKXnYih9AVjsZN6EhnKqBg

---
 doc/maintainer-guidelines.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/maintainer-guidelines.rst b/doc/maintainer-guidelines.rst
index 44d3e258db6e..6f2d63d7c76a 100644
--- a/doc/maintainer-guidelines.rst
+++ b/doc/maintainer-guidelines.rst
@@ -98,6 +98,12 @@ do this:
 
 The above assumes that a kernel tree resides in ``~/src/linux/``.
 
+Also make sure to use ``_cleanup_free_`` and ``_cleanup_(free_func)`` when
+possible. It makes your code much nicer to read (and shorter), and avoids
+common memory leaks on error paths.
+
+If you need to return a variable that would normally be cleaned up by
+``_cleanup_free_``, use ``_steal_``.
 
 Rule 4: Pay extra attention to adding new files to the tree
 -----------------------------------------------------------
-- 
2.54.0

