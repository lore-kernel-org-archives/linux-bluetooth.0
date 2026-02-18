Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36702C08A2
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421445; cv=none; b=bvbLHtwJnUG8TkRYtGboEvKm7lAoEjgIG6QJqNX2QD2gy9mTW8JcAFmJauOB+sNuL/ar6Yt2lMcii7PQjCvr87Zwkv6kHRInhtQRUA82jw8UOeiIrjrRk8afsCuMLRC+1YtaXr/lUyG/MXAqY3DaE6n9cnt9Au0ZyGBSgiEHARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421445; c=relaxed/simple;
	bh=sK9sxcL7bUxj96qolK1mg9GG7JfrD+HtOBVMurzYXCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwBePDvCfC6iy6j37Um9bajRqL4ni6QeC9JhzXuyDhzeqIipw5ppgiF9DVuoH3F/CkO+oKIhUisMDN78GYRetOEp4ndKj5pfk2auW8avF39EmdfQCMsw6Rc3dJ++Z2dcVivMRI4LHOQQb0+MS1HKLWHP/0XHiVPd1ZUhZYntCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu1n40dj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu1n40dj"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b884d5c787bso724467766b.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 05:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771421442; x=1772026242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX2mMauvCCn4kbGS1M9ePj2kZCv3MrERHBrIZRNfL0o=;
        b=Yu1n40djtImVyrfokbQ/kbhTsFdcM1UTBaOxWnVH25pHlKFGm5BbzSiGKsmgrRP9YG
         TKx42HwnS+urMrqLAzjBXNx2BxYwKZS6HF/cdpb5Cr+15g7R73eaAgdlENVErpKdiVM9
         jpzCjn7e/mnogS4qri2A/sdduzm9YosziWsRVI2aUJxCzpcMhpML4M9zbdtzmYeBATO+
         V7O3tDkIkEOCJpHsJnMWXUHG4w5lbP2g6cY2tJhXE5NVrf5UniB9oz7hUQA/Fq3jxrAu
         ohxbVdZHQE5IGeDWzQfHjniTXrJK8zdZaiST3XtPzLEyEB45BJ5aTDQXEIgIt6cFIiXn
         35cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771421442; x=1772026242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PX2mMauvCCn4kbGS1M9ePj2kZCv3MrERHBrIZRNfL0o=;
        b=N191GIwanUnF5P/vWfyig+I+5Ih0h6lb96OiSl+ZaYKz3gsf5ZAsOqrBdLnFuMy8GJ
         mwe4diinWg/5X0UMFZ2wCByef+taQ/LHYfeSJn4hVk2JeuDHfpHExXZb4jPtg5K9p8U3
         v11sbhTM5M7HLZGGHz2C8IsYi0XAfDYcXR/wMo3wK/lls5YkflHovbQ/R3RYAvHNM1fE
         XNeJrWwHrks9ml7ZrchcVYyOIYB+3mEbXqPJElRw8bQNPekuZxhJ9FqF2Y8iH2lYsnFr
         VS8H6F1K1zEzti1JG/iQ21EvXp8z4QEHuJtpvw6raKX47TiD703fuuDKzHyY4dwKx8sL
         6SXA==
X-Gm-Message-State: AOJu0Yz4iYq/E42u7KQAwR3fT/CyJOIiLLR3HxnR+f6u2cnGmV5hD/GM
	5vK3MI21Of6GFBAjNCZIMZGwAapP77UjjNzGKMbV+Do+WMAtofRjxp5cKSPazg==
X-Gm-Gg: AZuq6aJOtJsfEZ4lcNZRcOpxF6/2gRP9waLtJM9VSNq1vZ7By/EI1EGRmkMtwuUBQQo
	DRjlUxKRuTmIJwMAZP/j3Rdo6Bq5n/XzwrVch/xHyM3NerBr/o0xY49YLunwE2OoSUgsIJxA3Ej
	kobhHnFV5b2bw8yu/odm84gQSoYUQtYXWs6T6iQbFRpuvqrY0Z0yIZO4GJo1JJSZG8GAsYa1ICA
	43xTA/YitcMWg4z9PwfQW+0Xnj4goHX+eReoj4X1voDAGsFdOCj3NkFssGsapoA/L57yA0Pzdrv
	GtiwxWI8UxEAAPKF80EYaLt5r/gp89SzpZPbiFszeUa3znTUR1ETTmeo2WWZ0pFxvJL0vvuLI+5
	Qp0yBy+SOsxUnRvl/5zEu+jfrtNd3BmwLexuETCdSKrBkI0UFfawx7pReRM7k+TeUkAZDCOi4Ni
	4/o7pDKZvCNmoTd3XWua1jfqKxS6j1QE+qfw5xWpqL9xSfKaqsGY1urhLj7TYbekmaRW367z2y0
	gq6UN6DlxCFo49D0ns=
X-Received: by 2002:a17:907:7250:b0:b83:e7e:3732 with SMTP id a640c23a62f3a-b8fc3c7dcf6mr872068666b.30.1771421441924;
        Wed, 18 Feb 2026 05:30:41 -0800 (PST)
Received: from localhost.localdomain (46.205.203.39.nat.ftth.dynamic.t-mobile.pl. [46.205.203.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc967098esm441576966b.52.2026.02.18.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 05:30:41 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: larsch@belunktum.dk
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: [BlueZ] shared/shell: Fix bt_shell_printf in non-interactive mode
Date: Wed, 18 Feb 2026 14:30:40 +0100
Message-ID: <20260218133040.977435-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217222954.432676-1-larsch@belunktum.dk>
References: <20260217222954.432676-1-larsch@belunktum.dk>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix this by moving the empty inputs check to after the
> non-interactive mode check, so that non-interactive mode can print
> using vprintf even when no inputs are registered.

Such approach fixes the problem with no output in the non-interactive mode,
but does not restore the behavior that was before the e73bf58 commit. It
prints some additional initialization messages:

> $ bluetoothctl list
> [NEW] Controller 8C:68:8B:00:5F:D4 MYHOST [default]
> [NEW] Device D0:16:B4:25:BB:AE HWM20
> Controller 8C:68:8B:00:5F:D4 MYHOST [default]
> No agent is registered

Such output might break some scripts which relied on the output formatting.

Below is a naive approach which fully restores behavior prior to the e73bf58
commit:

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 78d58c513..3f11f696f 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -81,6 +81,7 @@ static struct {
 	bool monitor;
 	int timeout;
 	int init_fd;
+	bool attached;
 	struct queue *inputs;
 
 	char *line;
@@ -712,16 +713,18 @@ void bt_shell_printf(const char *fmt, ...)
 	char *saved_line;
 	int saved_point;
 
-	if (queue_isempty(data.inputs))
-		return;
-
 	if (data.mode == MODE_NON_INTERACTIVE) {
+		if (!data.attached)
+			return;
 		va_start(args, fmt);
 		vprintf(fmt, args);
 		va_end(args);
 		return;
 	}
 
+	if (queue_isempty(data.inputs))
+		return;
+
 	save_input = !RL_ISSTATE(RL_STATE_DONE);
 
 	if (save_input) {
@@ -1660,6 +1663,7 @@ bool bt_shell_attach(int fd)
 				return false;
 		}
 	} else {
+		data.attached = true;
 		if (shell_exec(data.argc, data.argv) < 0) {
 			bt_shell_noninteractive_quit(EXIT_FAILURE);
 			return true;
@@ -1675,6 +1679,7 @@ bool bt_shell_attach(int fd)
 
 bool bt_shell_detach(void)
 {
+	data.attached = false;
 	if (queue_isempty(data.inputs))
 		return false;
 
