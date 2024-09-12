Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E86F2FD
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132978; cv=none; b=nmKoZrzZ7U2UNYUjmzYyjo1OnzQ4l335/UNIsmPZpJy4Wvu8HLalzHI0c7wJnvO1f7/1/A/O51rjA4vknKwTgwiNtbBPmYHvPHx+5bZZU+xqOlvlplK55JQml6I1QhFUX5h6TIzfhHdWLiSonkk5FGfFXWtuKDncxAXq9E7YsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132978; c=relaxed/simple;
	bh=RPjfOAPrLYaMqhu9raQN/AYa3j8Mne2Ng6YluaducBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJ3LlXyd7Dd0/8JhVmdA3rYHN5ZmD84Dk68MyLDEC1vwDrY0b9uEVr/WsFPFGdbCvF3jTd2SkTVZdK8phnuerKYvoNctSyNObazfYgSv8andfaKF8t5ZHExU4KmX8EGBEtgMHEZkhxC2lvLECS5RZhqvfc/5bUDwVXaV4bBz6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8AD3E2000F;
	Thu, 12 Sep 2024 09:22:54 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 1/3] shared/shell: Add bt_shell_get_timeout()
Date: Thu, 12 Sep 2024 11:20:10 +0200
Message-ID: <20240912092253.119754-2-hadess@hadess.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912092253.119754-1-hadess@hadess.net>
References: <20240912092253.119754-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Make it possible to get the value of the general --timeout option.
---
 src/shared/shell.c | 5 +++++
 src/shared/shell.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 246de209e41c..c31487190d0f 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1670,3 +1670,8 @@ void *bt_shell_get_env(const char *name)
 
 	return env->value;
 }
+
+int bt_shell_get_timeout(void)
+{
+	return data.timeout;
+}
diff --git a/src/shared/shell.h b/src/shared/shell.h
index a9a635bda959..b03250cac80f 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -85,4 +85,6 @@ bool bt_shell_detach(void);
 void bt_shell_set_env(const char *name, void *value);
 void *bt_shell_get_env(const char *name);
 
+int bt_shell_get_timeout(void);
+
 void bt_shell_cleanup(void);
-- 
2.46.0

