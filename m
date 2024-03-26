Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8C762F7
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466419; cv=none; b=a2dSfGb2W1IPOU527FEkLloIsbiBu2nq/WJ7TIy0IjByRAZ9E+zdcRUMz67X7XMr5P8HnO0B+0P7g8bLVXE8GXV/UlQXEURtlXTjoGGWJ+hL2I3/UfwGmc53PyOxt/95qM0SIfE5Pya0Qk4JiDsbXptGrLkruf1SIqB9ryrO46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466419; c=relaxed/simple;
	bh=Qeo/IMR1Af0B4oZnrj7HcnmHE4DDvzWyoDa1UlF/FsU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AMg5WJUJ7CdvFyYDt5AwWiASRx0sLcRO7ZjoDOq6XziROjN6Bj4W2cVT8oyQpebTqQVLhbSKyd9G9QFS8d7JoGMZvz/6iR44N7Th4Ca6REdng0MsgwyYO7sfT+AUoUsdgWwM0eEPIQm4PV7brO0xeqSH2kE804NHDgYHv57IxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFHYF+PE; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFHYF+PE"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7db123701bcso1521020241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711466416; x=1712071216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dYt7L8519WyOHNCKEsuYZugSLS2WHfHXim6xkEbKu4s=;
        b=ZFHYF+PEJYvIuaDnsC1PyI3o0lch4B626YEde9Z025WvhiGf8ZRZ54tI37Z5SUKOtc
         RVacOuJ8WP0VoSz4qm59O+HWRLzIyMNSPWGb9LtfwQbBwpvc4IxKvpFxhaQRvVXO7ph2
         7IxC1Amank86XS8rMrvjZZGvSnTnDtx4t78i+trVabHC1cr6itfic9EJyHI0wHDOxiXr
         a/dDHIUANUOXXp8RTP4qCdGg/dTDtzojPt61kl13rTibJE/OwMfHYw4s0ZWOP1Azp4x+
         gVqD4/IYL+fh11RVEVm3hMSNHMuHuUhZVKOWFIXjTK1WMvpE89GkRxyDkaTFpU0NflCC
         KSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466416; x=1712071216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYt7L8519WyOHNCKEsuYZugSLS2WHfHXim6xkEbKu4s=;
        b=EdTGj31sxcud5Jii3Vdlv/lVTxfCXluCx0jEi0Q40KBc/Z/90zgVPvVs0ecIuz9I/8
         Z3qq5w95LJQ9GSBbpwfhHrtMN+xcyRkN1xGOG0uD6GFxPBVn84a4SdantI4m9NhPzLbD
         m5s1b9vCKRLqhD/TjqRPITGDUllXvZ5zBsZXZzReCcW2T7woXcB6Md1CgrdJdfsZWQ5s
         Z7yt/uCZRE2hDM2EtvsG7E/Mh0k/kjRhjPhc9CeF2GsgPGOvtG0d3Zdo0mAoorZiI4sr
         brf/ICOceu4XruSNOiskpNTvzxNvTSz0/6tVVfgAX8z7wuleEb4N3sNRghagAfGJ1gCC
         NimQ==
X-Gm-Message-State: AOJu0YxXIXoEhpro9Z/UyLO+CdfVlNxU080qMd8hy1pvEzRUhKoA8wIm
	Is7RjcBXsfBO0VkAYhAoWDYwIUV/ywRTxSMsgUshHhOURsbjXNWFHeFzeRhU
X-Google-Smtp-Source: AGHT+IHVshJ6ExFhCbkOoQjWabiyLvI+87eSl1igFEZizuqGySleslHVUb5QJMVeWGEc7nwb9c2ttA==
X-Received: by 2002:a05:6122:6a6:b0:4d3:3b1b:aa92 with SMTP id r6-20020a05612206a600b004d33b1baa92mr15551vkq.11.1711466414935;
        Tue, 26 Mar 2024 08:20:14 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id q14-20020a1ff20e000000b004c880fc9728sm1382266vkh.46.2024.03.26.08.20.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:20:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/shell: Add script command
Date: Tue, 26 Mar 2024 11:20:11 -0400
Message-ID: <20240326152012.1432957-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds script command to main menu which can be used to execute
scripts at any point rather than just at the init.
---
 src/shared/shell.c | 186 +++++++++++++++++++++++++++------------------
 1 file changed, 110 insertions(+), 76 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 0e4cbb7b12cb..d68d6798f117 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -258,6 +258,115 @@ static void cmd_export(int argc, char *argv[])
 	}
 }
 
+static int bt_shell_queue_exec(char *line)
+{
+	int err;
+
+	/* Queue if already executing */
+	if (data.line) {
+		/* Check if prompt is being held then release using the line */
+		if (!bt_shell_release_prompt(line))
+			return 0;
+		queue_push_tail(data.queue, strdup(line));
+		return 0;
+	}
+
+	bt_shell_printf("%s\n", line);
+
+	err = bt_shell_exec(line);
+	if (!err)
+		data.line = strdup(line);
+
+	return err;
+}
+
+static bool input_read(struct io *io, void *user_data)
+{
+	int fd;
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+
+	fd = io_get_fd(io);
+
+	if (fd == STDIN_FILENO) {
+		rl_callback_read_char();
+		return true;
+	}
+
+	if (!data.f) {
+		data.f = fdopen(fd, "r");
+		if (!data.f) {
+			printf("fdopen: %s (%d)\n", strerror(errno), errno);
+			return false;
+		}
+	}
+
+	nread = getline(&line, &len, data.f);
+	if (nread > 0) {
+		int err;
+
+		if (line[nread - 1] == '\n')
+			line[nread - 1] = '\0';
+
+		err = bt_shell_queue_exec(line);
+		if (err < 0)
+			printf("%s: %s (%d)\n", line, strerror(-err), -err);
+	} else {
+		fclose(data.f);
+		data.f = NULL;
+	}
+
+	free(line);
+
+	return true;
+}
+
+static bool io_hup(struct io *io, void *user_data)
+{
+	if (queue_remove(data.inputs, io)) {
+		if (!queue_isempty(data.inputs))
+			return false;
+	}
+
+	mainloop_quit();
+
+	return false;
+}
+
+static bool bt_shell_script_attach(int fd)
+{
+	struct io *io;
+
+	io = io_new(fd);
+	if (!io)
+		return false;
+
+	io_set_read_handler(io, input_read, NULL, NULL);
+	io_set_disconnect_handler(io, io_hup, NULL, NULL);
+
+	queue_push_tail(data.inputs, io);
+
+	return true;
+}
+
+static void cmd_script(int argc, char *argv[])
+{
+	int fd;
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		printf("Unable to open %s: %s (%d)\n", argv[1],
+						strerror(errno), errno);
+		bt_shell_noninteractive_quit(EXIT_FAILURE);
+		return;
+	}
+
+	printf("Running script %s...\n", argv[1]);
+
+	bt_shell_script_attach(fd);
+}
+
 static const struct bt_shell_menu_entry default_menu[] = {
 	{ "back",         NULL,       cmd_back, "Return to main menu", NULL,
 							NULL, cmd_back_exists },
@@ -271,6 +380,7 @@ static const struct bt_shell_menu_entry default_menu[] = {
 					"Display help about this program" },
 	{ "export",       NULL,       cmd_export,
 						"Print environment variables" },
+	{ "script",       "<filename>", cmd_script, "Run script" },
 	{ }
 };
 
@@ -1033,18 +1143,6 @@ static char **shell_completion(const char *text, int start, int end)
 	return matches;
 }
 
-static bool io_hup(struct io *io, void *user_data)
-{
-	if (queue_remove(data.inputs, io)) {
-		if (!queue_isempty(data.inputs))
-			return false;
-	}
-
-	mainloop_quit();
-
-	return false;
-}
-
 static void signal_callback(int signum, void *user_data)
 {
 	static bool terminated = false;
@@ -1304,28 +1402,6 @@ int bt_shell_run(void)
 	return status;
 }
 
-static int bt_shell_queue_exec(char *line)
-{
-	int err;
-
-	/* Queue if already executing */
-	if (data.line) {
-		/* Check if prompt is being held then release using the line */
-		if (!bt_shell_release_prompt(line))
-			return 0;
-		queue_push_tail(data.queue, strdup(line));
-		return 0;
-	}
-
-	bt_shell_printf("%s\n", line);
-
-	err = bt_shell_exec(line);
-	if (!err)
-		data.line = strdup(line);
-
-	return err;
-}
-
 int bt_shell_exec(const char *input)
 {
 	wordexp_t w;
@@ -1451,48 +1527,6 @@ void bt_shell_set_prompt(const char *string)
 	rl_redisplay();
 }
 
-static bool input_read(struct io *io, void *user_data)
-{
-	int fd;
-	char *line = NULL;
-	size_t len = 0;
-	ssize_t nread;
-
-	fd = io_get_fd(io);
-
-	if (fd == STDIN_FILENO) {
-		rl_callback_read_char();
-		return true;
-	}
-
-	if (!data.f) {
-		data.f = fdopen(fd, "r");
-		if (!data.f) {
-			printf("fdopen: %s (%d)\n", strerror(errno), errno);
-			return false;
-		}
-	}
-
-	nread = getline(&line, &len, data.f);
-	if (nread > 0) {
-		int err;
-
-		if (line[nread - 1] == '\n')
-			line[nread - 1] = '\0';
-
-		err = bt_shell_queue_exec(line);
-		if (err < 0)
-			printf("%s: %s (%d)\n", line, strerror(-err), -err);
-	} else {
-		fclose(data.f);
-		data.f = NULL;
-	}
-
-	free(line);
-
-	return true;
-}
-
 static bool shell_quit(void *data)
 {
 	mainloop_quit();
-- 
2.44.0

