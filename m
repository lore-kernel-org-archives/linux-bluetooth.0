Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31228468E
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881059; cv=none; b=gih3fiy+qdJk8cVIbHzF+rKP9ae3rt+J2QbjGinqZK0d55cVNZdi59TyQ/X1B3u3EA2+/nFjWc++ZyOedojprxXjKl7U2YC5IVsrC7pr9FZKz7EDvzN5eSTxUfhnWCKNxZZKX1yNKLMdfCZJeFUXXeLrj8eI1ILh6a9udCVSdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881059; c=relaxed/simple;
	bh=TDnoHUeTmp/TjrTdqiKdWbIGgtIRakvdhmzo7viGBGM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdB/cOOA+rsAg+zrwPU8Sdd2rKleXLEAwOQdsSV4as9rrUsBYbmBxmXY75/AnLLVwmfRS/XfkXgQ/006fYWzVnOVVgfBiXoC8vlSCVgwfXzZCJfxlsFkUWk7ZvyP62skQwJlFnRBvHXjP/8Fbnx5DGFh1t878kakXQvMoPf1gOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6019D3EC2B
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:30:55 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] emulator: Remove compile-time header only glib dep
Date: Mon, 30 Mar 2026 16:30:37 +0200
Message-ID: <20260330143046.3497403-2-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330143046.3497403-1-hadess@hadess.net>
References: <20260330143046.3497403-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFsF92b/unuq6pG0IVvhM6MBqnJA4n+t99dWaNjPNT8PH0w3mG76J5qL9YCALZgebTS6E4JFKXtlBoXm2vABgt5OdzTkK1/BMKL42gX26aeOWIWZASBZ4j6xPybCj90OeatbD5AJyaf3S0mnydSOJ6KjkTbcJbUYnpGMHRLWbLvXq2f7kXMUN+wq5GUOfpd5tonk86qLF9fYVEU9haKbjWSD4j7XmpVjVIcNdF4PQq5RvOUxATWyVFQ7zU4e47puoRlOwa3YJSmohZztKnzQiMtZD5Nn6GnZqSFV7CyxsTECy+vW04GKv27ezpftQbNgdDRxeyF1vQphShw3bop1GAktNgoCktTSOdtaUNMmSrJjab1hF5ePQWIfuCPB9X0BhJ22etfx4aU6cw4hzBui4jA7zDIeAbq120JXF20XgJ9t2i7iqdM4FZ8x87FpwO5jFyRdtnyBSzq9qFK4/416aKDeJexE9KJxA8gqfiUxbmJPwcOz0Al8s379pPgMTKjKvdlgZnfwpp9NcWqH5VhEsP4w3NO//yO1hP8oCNKc6luLK3noNhr9COe79tuKkauCbU+UzoAMjxR9QJepuXW01ErXZ3AZ8yyGz3p1tDWIqKHXVT/4CsYm/8y5lJBBfYQh+/rDybGakedhe7YzmPdX4ZVIblkzCc5eR24cd1GRO4r9Q
X-GND-State: clean
X-GND-Score: 0

btvirt relied on a glib header macro to use MIN/MAX, but didn't link
against it, meaning that it was dependent on other programs in the
project using glib to compile correctly.

Remove the include and use our own implementation instead.
---
 emulator/btdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d3a9c6735ff1..3a295b679f34 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -25,8 +25,6 @@
 #include <fcntl.h>
 #include <unistd.h>
 
-#include <glib.h>
-
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hci.h"
 
-- 
2.53.0

