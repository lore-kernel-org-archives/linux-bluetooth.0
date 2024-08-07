Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9EF12A14C
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Aug 2024 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066107; cv=none; b=eDkZFX9laAwK4nh2lEXA4ldtPnWMZi96Wht7OO1zCXJETvvnpNaPsCrHO/DyLg68Di1YS3NGY4M7kKRRlfft502hutbJbEkT1DMiQD0LnOo1G67ZD4qJsYiKyEBB3GlRL6gdHjCafbzepSzI8dw3ZwgiJg+tsl1R7hsCBAr79TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066107; c=relaxed/simple;
	bh=rDRKh/wbB1HXhZ5felTU9Lk/TJ3f3E1lISOAzM1ymHQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmASG1TZVnVFQzNPDKvOVZYMexe8kEoRgry+OIvezFuHQtyYyJhb0vRXcLQZetwU9r6Gp5h/hHw7ksKy7DNrF/vk5OiPTl8L+5xwXx3ufJ9XMIN1acTM0ZOLxLy7p7YS9mN5Jx0ov6EoXoXPJRiMrtzCxg3JvHNaicQNpvHjedM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bj9NJrLa; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj9NJrLa"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-82d192d9234so72749241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Aug 2024 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723066103; x=1723670903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xotBsFysWKJhFlJNa+HKdfVvg2O/f7H+45WySWyoIKg=;
        b=bj9NJrLamjxz5xYqeIwPhHhOyR8ySWRZYyrmrPnYbbu6QU9LLDjyFBEklEpmx8GBNX
         JO38aYILyJWvtrRxMrF4gMtZNNecn0zBjZC+ataeMGKRtfiavIfnYZu9aaz/rb4skvq4
         JhGAJlxBXl1W8Vb4aBpGFBTgjM0YuJdza3NGpacB13Ls4LHY76oSl8H/XVJTR2i7ms0H
         g4Ln4qePSWp+rjtiOUECXzEZVDGImm3T4tWazD4rQ4WTnvCqTkioRZ7FD71CSfvOaM6j
         gcQ0qsVELAlnoS6Qj/IHSW87oLIpNwS/4rH9t1dNrG/sWRcTSgXH++lkmOxe7X/MPjUD
         mp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066103; x=1723670903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xotBsFysWKJhFlJNa+HKdfVvg2O/f7H+45WySWyoIKg=;
        b=VtCJt5EZkb8i7MxcGCmDCWVuZMVNPE3vGf451YTV2tnJp26EQbyLya2ld/rU3+sIEF
         3LB2mihOAUWzH+NV79naolFXf11D+V1Npc8w6GZCuJJfO2DmgQykGSKB7bZJV78qiMhV
         o3sTkDpVQJPvQl/9TQ/YE1z4fei79gJpUBHi99NPRtcFqbu8QIZdZ0FrEBXzy9W52SPf
         YUCf/9LB14Hp+QFD3nI7hftel9brae4avXCqk0VnUVsIlLXULi7OhwB/KdD6pGjDi5pa
         sx1vsKyzxYzBBLEIJLDNKQe0TjcWclXhvKRDYLvxGntHzEl6BpxMvmVONRtrIfYPEt4b
         vM/A==
X-Gm-Message-State: AOJu0YzHslIoRhgYufl8Dkf1uZhRRg98hwVz+hIx/KeecchZxToGSp1v
	iJqUmV8FrjxEM+V79gZN9A/fApr2/mbC8hCgBgbUBeOZCosQRO9N1Vts0Ad7
X-Google-Smtp-Source: AGHT+IEzcZEdqpwl3FtxE/nbIuwdFTRqoSyjmgs+s7YQi+RHhC99BsUecQLMRW7o9jM+bj6Ph7gxtg==
X-Received: by 2002:a05:6102:4189:b0:493:b006:e1a with SMTP id ada2fe7eead31-495c5b51389mr75634137.7.1723066102628;
        Wed, 07 Aug 2024 14:28:22 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-83c09450925sm1701772241.32.2024.08.07.14.28.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:28:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] shared/shell: Add support for running script command as part of script
Date: Wed,  7 Aug 2024 17:28:18 -0400
Message-ID: <20240807212818.193908-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807212818.193908-1-luiz.dentz@gmail.com>
References: <20240807212818.193908-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This allows running script command as part of another script.
---
 src/shared/shell.c | 89 +++++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 29 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 932dd7dd4a52..b3c343277ffd 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -60,6 +60,11 @@ struct bt_shell_prompt_input {
 	void *user_data;
 };
 
+struct input {
+	struct io *io;
+	FILE *f;
+};
+
 static struct {
 	bool init;
 	char *name;
@@ -71,7 +76,6 @@ static struct {
 	bool monitor;
 	int timeout;
 	int init_fd;
-	FILE *f;
 	struct queue *inputs;
 
 	char *line;
@@ -269,8 +273,11 @@ static int bt_shell_queue_exec(char *line)
 	/* Queue if already executing */
 	if (data.line) {
 		/* Check if prompt is being held then release using the line */
-		if (!bt_shell_release_prompt(line))
+		if (!bt_shell_release_prompt(line)) {
+			bt_shell_printf("%s\n", line);
 			return 0;
+		}
+
 		queue_push_tail(data.queue, strdup(line));
 		return 0;
 	}
@@ -286,6 +293,7 @@ static int bt_shell_queue_exec(char *line)
 
 static bool input_read(struct io *io, void *user_data)
 {
+	struct input *input = user_data;
 	int fd;
 	char *line = NULL;
 	size_t len = 0;
@@ -303,15 +311,15 @@ static bool input_read(struct io *io, void *user_data)
 		return true;
 	}
 
-	if (!data.f) {
-		data.f = fdopen(fd, "r");
-		if (!data.f) {
+	if (!input->f) {
+		input->f = fdopen(fd, "r");
+		if (!input->f) {
 			printf("fdopen: %s (%d)\n", strerror(errno), errno);
 			return false;
 		}
 	}
 
-	nread = getline(&line, &len, data.f);
+	nread = getline(&line, &len, input->f);
 	if (nread > 0) {
 		int err;
 
@@ -321,9 +329,9 @@ static bool input_read(struct io *io, void *user_data)
 		err = bt_shell_queue_exec(line);
 		if (err < 0)
 			printf("%s: %s (%d)\n", line, strerror(-err), -err);
-	} else {
-		fclose(data.f);
-		data.f = NULL;
+	} else if (input->f) {
+		fclose(input->f);
+		input->f = NULL;
 	}
 
 	free(line);
@@ -331,9 +339,9 @@ static bool input_read(struct io *io, void *user_data)
 	return true;
 }
 
-static bool io_hup(struct io *io, void *user_data)
+static bool input_hup(struct io *io, void *user_data)
 {
-	if (queue_remove(data.inputs, io)) {
+	if (queue_remove(data.inputs, user_data)) {
 		if (!queue_isempty(data.inputs))
 			return false;
 	}
@@ -343,18 +351,33 @@ static bool io_hup(struct io *io, void *user_data)
 	return false;
 }
 
-static bool bt_shell_script_attach(int fd)
+static struct input *input_new(int fd)
 {
+	struct input *input;
 	struct io *io;
 
 	io = io_new(fd);
 	if (!io)
 		return false;
 
-	io_set_read_handler(io, input_read, NULL, NULL);
-	io_set_disconnect_handler(io, io_hup, NULL, NULL);
+	input = new0(struct input, 1);
+	input->io = io;
 
-	queue_push_tail(data.inputs, io);
+	queue_push_tail(data.inputs, input);
+
+	return input;
+}
+
+static bool bt_shell_input_attach(int fd)
+{
+	struct input *input;
+
+	input = input_new(fd);
+	if (!input)
+		return false;
+
+	io_set_read_handler(input->io, input_read, input, NULL);
+	io_set_disconnect_handler(input->io, input_hup, input, NULL);
 
 	return true;
 }
@@ -373,7 +396,7 @@ static void cmd_script(int argc, char *argv[])
 
 	printf("Running script %s...\n", argv[1]);
 
-	bt_shell_script_attach(fd);
+	bt_shell_input_attach(fd);
 }
 
 static const struct bt_shell_menu_entry default_menu[] = {
@@ -1449,6 +1472,17 @@ int bt_shell_exec(const char *input)
 	return err;
 }
 
+static void input_destroy(void *data)
+{
+	struct input *input = data;
+
+	if (input->f)
+		fclose(input->f);
+
+	io_destroy(input->io);
+	free(input);
+}
+
 void bt_shell_cleanup(void)
 {
 	bt_shell_release_prompt("");
@@ -1464,7 +1498,7 @@ void bt_shell_cleanup(void)
 
 	rl_cleanup();
 
-	queue_destroy(data.inputs, NULL);
+	queue_destroy(data.inputs, input_destroy);
 	data.inputs = NULL;
 	queue_destroy(data.queue, free);
 	data.queue = NULL;
@@ -1529,14 +1563,14 @@ void bt_shell_set_prompt(const char *string)
 	if (!data.init || data.mode)
 		return;
 
-	if (asprintf(&prompt, "\001%s\002", string) < 0)
+	if (asprintf(&prompt, "\001%s\002", string) < 0) {
 		rl_set_prompt(string);
-	else {
+	} else {
 		rl_set_prompt(prompt);
 		free(prompt);
 	}
 
-	rl_redisplay();
+	rl_forced_update_display();
 }
 
 static bool shell_quit(void *data)
@@ -1548,19 +1582,17 @@ static bool shell_quit(void *data)
 
 bool bt_shell_attach(int fd)
 {
-	struct io *io;
+	struct input *input;
 
-	io = io_new(fd);
-	if (!io)
+	input = input_new(fd);
+	if (!input)
 		return false;
 
 	if (!data.mode) {
-		io_set_read_handler(io, input_read, NULL, NULL);
-		io_set_disconnect_handler(io, io_hup, NULL, NULL);
+		io_set_read_handler(input->io, input_read, input, NULL);
+		io_set_disconnect_handler(input->io, input_hup, input, NULL);
 	}
 
-	queue_push_tail(data.inputs, io);
-
 	if (data.mode) {
 		if (shell_exec(data.argc, data.argv) < 0) {
 			bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -1586,8 +1618,7 @@ bool bt_shell_detach(void)
 	if (queue_isempty(data.inputs))
 		return false;
 
-	queue_remove_all(data.inputs, NULL, NULL,
-					(queue_destroy_func_t) io_destroy);
+	queue_remove_all(data.inputs, NULL, NULL, input_destroy);
 
 	return true;
 }
-- 
2.45.2

