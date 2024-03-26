Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA2811E2
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466420; cv=none; b=HSMI5aTM5jHc92ucRydNuUTrBzX5cNtAxww5sRsjvCMq3wXdPLu6N3kR5/PCthIQ8dz8auKHSa7T7kVDtc83cD1yHqIyXWwtskkFXxvbOqac6ZwFT/VGAXajxguTWlhw7qmeWQBWMWJDJR716bGqR5lLBj4T4DSyM5f6F+UCGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466420; c=relaxed/simple;
	bh=4fEIHR61NgpUtS7IFlNCDDxfhdnf5SIwgozkQq8JgQw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHrOO4Dv78I8xsq4deimTa/elXXtIKwwQVJxusW/7+iQD/ZNFCxXxIHz90lPV39Iq32REJUBVmecOjWKz2YLgvLAGPx2aT3MIGibBE1xv+XwLxp3Lrtyf6RAllxve/GSkagqP/8fgNCv8FGn6DxpInHkCeiGdOfcXqxzytRZZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxgWV2pP; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxgWV2pP"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d43c633fecso2294953e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711466416; x=1712071216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfxy2vEf8T5TZWebfbgqwWLFPCtX3gyaDX3PcUYuFoo=;
        b=CxgWV2pPsgwmibFtf0w5PX4+uPAkSUtkCgDo+QEpoQmZTqfWvuFnlO0i9FqvXiNxic
         t/9MVOGaJX62/GJCiN+1Qu5nXJGJYFWQDtM0NKnK1BdR+5TLtQYp+WZHJzPHGoWZTXOD
         /+noXnTEmE7TVwdjjLAzwDPmaQUxKrCtY/ZAr30PuKENFxhNs0Me61+dmfZA5M360O3b
         yds1MNBmDsZmkao9IP6360HMOoWR0xDglmJMpLFcFYqajkDKUWoFe9svCYt49JIoLiIp
         dJCvTIyE+DdKB9B+aGHXFQ9kXCZyA9dA74Oyzx3t/bc15pM0Cl0w0QZMRfPccJLog8SI
         J7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466416; x=1712071216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfxy2vEf8T5TZWebfbgqwWLFPCtX3gyaDX3PcUYuFoo=;
        b=I0Mnrybm/ZQhU8DlLLa5S463R/xn6pnTstLo52B0GV2lBp7CkWZnpC7D1yioNHlfUb
         2hZwX8hz5rV9dMpL13B3EXgdnToCwYuhHKciACnVDKTPgXqEAkmlEUm91DIGa8vXFQCj
         CSdONocKZO9T4rzNAqZHrnY4cjJmisFr12q5lkncPfI/lPfKHAPcETiy1g5gcwnhRuR6
         HjQ92yAljDJx9pRbgWIDmxYr3ovuTG/3hqW5BjEsv3F+SF2e8DvO2r2aeM2fBmOH/ac2
         qerFzGQQMZAM/nAbMe27IRf2Iz7mt2CPkThAgwABWzSQjw3q4XFoFA5O5/yGcAoqm0s3
         V2og==
X-Gm-Message-State: AOJu0YwwfrOR9hWoNeEQHQIW2+NY++q3QeBHFPfE2pT/H4mNuC0vDHw/
	hGYi6kyNn/gr9mjjCGIWNAcGAMTUe22o5PlaOkYTjd5jfNSyeEf0nPS/FlWc
X-Google-Smtp-Source: AGHT+IFDwlyZsW8/DWsoCtlWHlVZ3I9lFlM75ywmSeBUjNepOQxOUQdtyidxqCoqPkrBhiC4TlIR6Q==
X-Received: by 2002:a05:6122:54b:b0:4c9:b8a8:78d4 with SMTP id y11-20020a056122054b00b004c9b8a878d4mr9267573vko.3.1711466416437;
        Tue, 26 Mar 2024 08:20:16 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id q14-20020a1ff20e000000b004c880fc9728sm1382266vkh.46.2024.03.26.08.20.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:20:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] shared/shell: Add commands from scripts to history
Date: Tue, 26 Mar 2024 11:20:12 -0400
Message-ID: <20240326152012.1432957-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326152012.1432957-1-luiz.dentz@gmail.com>
References: <20240326152012.1432957-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables saving the commands run from a script to also be visible in
the history.
---
 src/shared/shell.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index d68d6798f117..f3f7bab9a616 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -863,8 +863,6 @@ int bt_shell_release_prompt(const char *input)
 
 static void rl_handler(char *input)
 {
-	HIST_ENTRY *last;
-
 	if (!input) {
 		rl_insert_text("quit");
 		rl_redisplay();
@@ -879,14 +877,6 @@ static void rl_handler(char *input)
 	if (!bt_shell_release_prompt(input))
 		goto done;
 
-	last = history_get(history_length + history_base - 1);
-	/* append only if input is different from previous command */
-	if (!last || strcmp(input, last->line))
-		add_history(input);
-
-	if (data.monitor)
-		bt_log_printf(0xffff, data.name, LOG_INFO, "%s", input);
-
 	bt_shell_exec(input);
 
 done:
@@ -1404,12 +1394,21 @@ int bt_shell_run(void)
 
 int bt_shell_exec(const char *input)
 {
+	HIST_ENTRY *last;
 	wordexp_t w;
 	int err;
 
 	if (!input)
 		return 0;
 
+	last = history_get(history_length + history_base - 1);
+	/* append only if input is different from previous command */
+	if (!last || strcmp(input, last->line))
+		add_history(input);
+
+	if (data.monitor)
+		bt_log_printf(0xffff, data.name, LOG_INFO, "%s", input);
+
 	err = wordexp(input, &w, WRDE_NOCMD);
 	switch (err) {
 	case WRDE_BADCHAR:
-- 
2.44.0

