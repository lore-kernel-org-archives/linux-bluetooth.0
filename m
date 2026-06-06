Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358492745E
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780725856; cv=none; b=tkVPF/tuC8wPsEeOLzBo0Er+t3NqDM7YBWxqvy1YYuFkELpIJdRq8DJfAGi7LmGFGfN12zfcY9BAP5Qcmax+IYVp0XdLJ9TNsJPVO4AZkIxCM4pVUPApP6H5IYwRs0ZC7qOndeB1go0iX15tpzwU6iqfh/b4S8irgE+2xYXycpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780725856; c=relaxed/simple;
	bh=8KLqA1605EtB9ayF7FnIfHYKEUQT7bwv2OoZp85NfnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f71q6mNRQnUG28oaxCTqB3K4wLnYR12cw7umEHDMtxNHHB4lyRbV3AAyaUit/EhV42IEbBL9VHlo55IjlZUBBAYvpnbmHfVI3nhp1S+Xi3I/YJzVdRt6LiToBtil5O3cIG9tvtNXz2gWy5MSZc3eOcQZCN0gkY0WOsVTz+Rjd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=XbspUYhU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="XbspUYhU"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68e5f7c1131so4868643a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2026 23:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780725852; x=1781330652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ry53LpkJcNge25zDmEPOq5WqqWs39kiCYBujIiPtsA=;
        b=XbspUYhUitOPDAJSN9cpCFIN3w77GHZNEWpZUjGXe23cG/uxXhLllADqLyqCrRlxKc
         LpUWoiOZsm6gjihGjK9rkcReMXOVqChvp5BZVHiuPS9YOUP9AqiDR0TKuPnicSu8frRE
         tGVDEjvwrqjpHC8XbKftZEZly0D3CZIyNhlHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780725852; x=1781330652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Ry53LpkJcNge25zDmEPOq5WqqWs39kiCYBujIiPtsA=;
        b=HJhFQ+Q55OntDAOyHGnG5eWTF9L/s+5iW16x7iaZNf7QrBwuRCKcBUUdEG1XwCCiQM
         7ceLyN9vVuLZqKk7kJdrtNahPJRa8pMGM3dIn1DzT7zRqeczBfUViDWVoaU5SbteHgng
         8JaZfNieZNDmxpJgV75Na+7l3pJgNUn2aWVLUfuwGp/47fqyayZXgp5Aa6H4DzriTwhF
         Khaln4lgSZEljl84e6oVrFkouox/is/sc4sM7wdG7MuQcGg6EgMRRKJHKjwzE7V/sdu9
         gZ0qUO9ko6Irakb+rpiV/t1seKRk5/zHj0fk5yGow6Lr33hexWCLuq/bdJQEOAjv5vW9
         NoEA==
X-Gm-Message-State: AOJu0YzP524w7xn+G3fInD9mYbrl6vmD9POhcn/sCn8hUENkEeU2bmN2
	0WaPn9905SbP3IJ0rgUCDEnn56sFLecdPlocAwEThlwU0ckpht4cJeVw1FcegFsE6twZ3Ydw2Sw
	jj44=
X-Gm-Gg: Acq92OEYLEUpcuslxHHhLoWXTTHWCf2Wlu1l9YAIbFWy8h9StEB6lk8eUXZmEiKlrA5
	YR0lHCpSI9auPZQAMlnVPTTfwOKNbbuFcVp9qj0wW4hugjL1Z4b36xM8i+rrQUWXDBj6ZAz7hy0
	59dN95p0pu+oF28WFzjAs0OB7R+j0QHzkxlZA4TwmVHSy6nwgFQbFw51swYimMntDxbKU2WbLBS
	SjkQrkA6juCmdgZ8PutxjYkASzdQSLWYtlAxN54RtER9+NFe7qwymMeQyNbcDZh8YxufQMFVjw1
	I3nZtt+wX8RDzsCmFmoeIbH1HuQO76fvfZa8CsXWscyZc1d/5XMCyWIg/mSnEtl3EC5ZmHHQTqc
	tuOehnuJapXCnJE8P3Rn+WrNipZp4J6z/OWHNOcKFVsAPQp1hps6cmUf/xtcIRyVX6Dw+MmQeEN
	ny/U6batLYmExGh9wvA/Sje5L7ueRR/G2h/qnXHWonf7GVbf93NCLgix03MmSnKh9TGL6Ngq+eQ
	sg33HJSup7CLrLNGXQ=
X-Received: by 2002:a05:6402:5242:b0:68b:d10a:a48a with SMTP id 4fb4d7f45d1cf-68fa4f2d6c2mr3572125a12.11.1780725851659;
        Fri, 05 Jun 2026 23:04:11 -0700 (PDT)
Received: from great-eastern2.home (public-gprs207019.centertel.pl. [46.134.147.236])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64e2c810sm4593197a12.9.2026.06.05.23.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 23:04:11 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] btio: handle error from broadcast ISO socket
Date: Sat,  6 Jun 2026 08:03:47 +0200
Message-ID: <20260606060348.2240980-2-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606060348.2240980-1-michal.dzik@streamunlimited.com>
References: <20260606060348.2240980-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If not handled, server_cb() will be stuck in endless loop of calling
accept() on the socket.
---
 btio/btio.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/btio/btio.c b/btio/btio.c
index cfaa9392d..39d4411f7 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -252,6 +252,26 @@ static gboolean server_cb(GIOChannel *io, GIOCondition cond,
 
 	srv_sock = g_io_channel_unix_get_fd(io);
 
+	if (cond & G_IO_ERR) {
+		int err, sk_err;
+		socklen_t len = sizeof(sk_err);
+
+		if (getsockopt(srv_sock, SOL_SOCKET, SO_ERROR, &sk_err, &len)
+									< 0)
+			err = errno;
+		else
+			err = sk_err;
+
+		if (server->connect) {
+			GError *gerr = NULL;
+
+			ERROR_FAILED(&gerr, "ERR on socket", err);
+			server->connect(io, gerr, server->user_data);
+			g_clear_error(&gerr);
+		}
+		return FALSE;
+	}
+
 	cli_sock = accept(srv_sock, NULL, NULL);
 	if (cli_sock < 0) {
 		if (errno == EBADFD)
-- 
2.43.0

