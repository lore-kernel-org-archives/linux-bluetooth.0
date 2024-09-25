Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C131D5ADD
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288861; cv=none; b=CVKe988rq6v57bBy1K/9wHhK0gVgU/GEP3ebIdRuAvJYQMdVzXXzpRPfyz6Ruk5lRqIoq25NU4w+Ar+kMug+7BQKhyLgjXyHySBUGS8D9RImJkcT8fhuQR1Rs0qw1HICkNZ0UPA98apc3xF/6DDHLUmHLJozovmvP8j5cAi2xXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288861; c=relaxed/simple;
	bh=otks7Y1lcbMoBKhUY+kqk8Ha12XKwE+OmuJVTzftNQY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D1aq54YihDDpuS0JsD3puX0is2CuQ5u361Veu0uL+TZ3QNpHIZlAjrC8PCN91Q4UGcuVL8jKG9IKpeAn4eJAeaGcVps+Dx/y/WOn07H8jZZhXkCSfkOHL6LXkpk2Ue/w/roLHxv85GxDbYD5XfOVBinqs04U0s6dAYifW9m4IXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6jpFMEE; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6jpFMEE"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4a156c4f220so79604137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727288857; x=1727893657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJuboAwvzablf1yOlgfczj1T9hT3GmqGns5fDX3Rc7Q=;
        b=J6jpFMEEaeLOrYE/xV79xNYTb+/Xsyi/bxhsPpion4PQsDimrhe20R+ae7XdJ61npD
         GepiDkFUpEFl6UKjSS4fn8qX/dOiG9YipSFM46s23Le5s9uQykz1a426NqVBhCmAyCm2
         jsbZo4MpnmaTAlM2f383nSkaZExIXGOw+VGAzwc2jJN42plnNfTvM0nEs2/vGVbyTqVM
         nhpouHSU5RofHMTkniTRKPJ6iNvBzS5EEpwXRmjWndMKROkF2pXWJhFVXMhcKK8f0x3T
         DMm8Gd3z4d522Io1JZGTePD5GBkavfNNyhLW1a4f8Nvbzp8PNB6va5cx7Ld/V2eqdiaa
         zfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727288857; x=1727893657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJuboAwvzablf1yOlgfczj1T9hT3GmqGns5fDX3Rc7Q=;
        b=agr8j8fMXn5yc40/DkkqsSbG8SK+3zMZCP0VZ4nSZa7UO2mKyI/E4qw/nQ/QzPGTQ4
         7XNqIhWub334WIgGw6BYCDjnKEfTn8q+syPplELHZKJt8+uDIHki1Y16f4lzVGzAldSr
         0YP77hkUKH8dzZVVCZ6KnAP7rWrRLao1dZ61VFjpQLnAV/kHcJi6PiXkqGoOP7jpSOvc
         BF+bRRSg7cujIS4YcTsbrR4yI5a68pOLZKOkynbNCariCqafBuFEABpQPymGwtoBRLaM
         oR4SdW/dO2B5ee5DWkV0ErEHKekhBWfeqYkK8xNqdhikpccLSu3Sn1l/JDF/NJnm+Ita
         OGgQ==
X-Gm-Message-State: AOJu0YyZhq7MT4G8oC1+Mcn62GM+euqLb1GwO27Lip8iPQ7wQ/Z1b7LQ
	OuLnIwM/bhX3HqQrHonkPeYYf3xaHNNAnaaznEcE/h6AwLPsNOVpEBKY5A==
X-Google-Smtp-Source: AGHT+IFUNMdkJkxPhQYdv9OayxZ+/Az/pshrGl/RCru8EMQu5QDF2cY8qo4D784iF3Cj9kmMNAjMdQ==
X-Received: by 2002:a05:6102:f0b:b0:493:bcbd:4633 with SMTP id ada2fe7eead31-4a15dc398e5mr3336603137.3.1727288857390;
        Wed, 25 Sep 2024 11:27:37 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a15187fe62sm2464683137.32.2024.09.25.11.27.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 11:27:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/shell: Allow script command to be used within scripts
Date: Wed, 25 Sep 2024 14:27:30 -0400
Message-ID: <20240925182730.2035299-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes script command to allow the usage of script within the
script file by saving existing execute queue and then replacing the
line with script command with the lines of the input file.
---
 src/shared/shell.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index c31487190d0f..2100434f6b15 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -291,15 +291,14 @@ static int bt_shell_queue_exec(char *line)
 	return err;
 }
 
-static bool input_read(struct io *io, void *user_data)
+static bool bt_shell_input_line(struct input *input)
 {
-	struct input *input = user_data;
 	int fd;
 	char *line = NULL;
 	size_t len = 0;
 	ssize_t nread;
 
-	fd = io_get_fd(io);
+	fd = io_get_fd(input->io);
 
 	if (fd < 0) {
 		printf("io_get_fd() returned %d\n", fd);
@@ -336,7 +335,12 @@ static bool input_read(struct io *io, void *user_data)
 
 	free(line);
 
-	return true;
+	return input->f ? true : false;
+}
+
+static bool input_read(struct io *io, void *user_data)
+{
+	return bt_shell_input_line(user_data);
 }
 
 static bool input_hup(struct io *io, void *user_data)
@@ -371,13 +375,25 @@ static struct input *input_new(int fd)
 static bool bt_shell_input_attach(int fd)
 {
 	struct input *input;
+	struct queue *queue;
 
 	input = input_new(fd);
 	if (!input)
 		return false;
 
-	io_set_read_handler(input->io, input_read, input, NULL);
-	io_set_disconnect_handler(input->io, input_hup, input, NULL);
+	/* Save executing queue so input lines can be placed in the correct
+	 * order.
+	 */
+	queue = data.queue;
+	data.queue = queue_new();
+
+	while (bt_shell_input_line(input));
+
+	/* Push existing input lines back into the executing queue */
+	while (!queue_isempty(queue))
+		queue_push_tail(data.queue, queue_pop_head(queue));
+
+	queue_destroy(queue, free);
 
 	return true;
 }
@@ -396,7 +412,10 @@ static void cmd_script(int argc, char *argv[])
 
 	printf("Running script %s...\n", argv[1]);
 
-	bt_shell_input_attach(fd);
+	if (!bt_shell_input_attach(fd))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static const struct bt_shell_menu_entry default_menu[] = {
-- 
2.46.0

