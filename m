Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0C17084C
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343258; cv=none; b=ITN0BAUpS5rKpUtcCRPwvkR6xkZYczCBxbFH7aYLQuvlK/f9CyNNJB038bSyGjnqkrhD37V8Izi51ynxE0awDUWZUVF/uZ95wLI+jLcxRmxeNmNwVBfszrkUE3h9MCVOdAC4P/GN6N2VCdYvYMI3aDWH2UHswaAmxBW28cw+hx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343258; c=relaxed/simple;
	bh=1b+p1b7GIT78GDQGbHD5A5ndMiK4C9pGS2ldUhTTJEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxeEFqw4aAFzI3Pfmo+9q1eUvPdRqZ8A6aQtNtb3hh7xbuimqoIEJXnj1EamIGrj2/c6VHZNmEAbDWiS/VK3kQTWWouEQkfR7yydGQ4lji6t1+LrVpwwboKKg5MGCOibnIWYrdmdP97mvy0gkBNL8gjCKZ+6L2DmN64A3O2W/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3ECB260014;
	Fri, 10 May 2024 12:14:00 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 15/20] isotest: Fix fd leak
Date: Fri, 10 May 2024 14:10:25 +0200
Message-ID: <20240510121355.3241456-16-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510121355.3241456-1-hadess@hadess.net>
References: <20240510121355.3241456-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def65] [important]
bluez-5.75/tools/isotest.c:923:4: open_fn: Returning handle opened by "open_file".
bluez-5.75/tools/isotest.c:923:4: var_assign: Assigning: "fd" = handle returned from "open_file(altername)".
bluez-5.75/tools/isotest.c:953:3: leaked_handle: Handle variable "fd" going out of scope leaks the handle.
951|
952|		free(sk_arr);
953|->		return;
954|	}
955|
---
 tools/isotest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/isotest.c b/tools/isotest.c
index ddace0da3044..58293133a304 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -950,6 +950,8 @@ static void send_mode(char *filename, char *peer, int i, bool repeat)
 			close(sk_arr[i]);
 
 		free(sk_arr);
+		if (fd >= 0)
+			close(fd);
 		return;
 	}
 
-- 
2.44.0

