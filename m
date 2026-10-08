Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B514EF137
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483242; cv=pass; b=FNNKF0nSVWwgQcIUQ7w4zNRaFqOt7SCOSC+TJHAg3XjkStN2SGomJ1IBmpOIOALmDv0HHL3VRgyUp30ZDIFgoRcKshNpuJdkNlG0Xp78pvasBylNN/x2BjXGUWyTMfDyzqbiohnZwAykljGw5Llj8ledG+W+34Mp0qEp1RJJPiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483242; c=relaxed/simple;
	bh=/1n/KVOXHUKL83RAxknIXFU1ift0jtUSvjQpMlySaPA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZHZ82KEFQbcPEa1iimRoAJPoPBghfyQi1RRgj0FspMFSWArzVbZBaR+H6MrsSO8wx+bR77G+A6EZZsEJff9YYOsXvOgu3/Wa4yWcP1Fc3DMjVRch6hVNgRq5tkm4voZ/++T2OrPAyezvEW96aMxOmuzSmHJlABSHieC5huL5xPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRKw7s+Z; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRKw7s+Z"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso6124429a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 11:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791483234; cv=none;
        d=google.com; s=arc-20260327;
        b=jzh4QfOhv9bvcAJ0dGhxwdVEBjxiBhtW+THDIxdZyTQqfG9vtJ4BTg7F6IkQYvFDhX
         L7bPAFaKHo7GRy6tDDOXnj7Ucvt2806KeZbF82V0QMI3r5VmWfVUTWWYugYf/NR2dr+h
         0CRzbY4Q5ubhG+n1xtXeh9q5dZqSl7+Isq3d4MdcNClmTQ5X6BoCfauL6le3Re2ANJoo
         pyRM/PWsYnlt2NLqgytSqCqeUr3lNUdGXe6g/AIsh73JzHYnnbCPkMRRNxmZgDEUPeSf
         v/wHJRtpxHVDwJUnEk/Iyw4ppu9YiPNKeAxQaTHvOpihVP/DXBPmHnizRf3M9g9wyhho
         9ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0iaQv8rVXD9BmgHLRVDtfHBLkYyTPyvHBbxFyB6nVAw=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=s/nkrKeccr3IxDMirQz2O6SnYWbIyYl+ZDnXiPrAjxJ2ILRBg1h6nIrTH99mQDBAj8
         r8GYoNJP/Zv8jg4y948AFmayd0gPuSF65aaZSoBPefn+SiR73sTiukHjRwifvF1Kpa4f
         lHY/8meuOlGdipGIvVlIOFf+BwkHQbDWPid3MPLEKaacBw0kdqiiZgP/UcAbGNnIgbY8
         iQKR6W7h1jzx5x5Y3G4VXxxC/+zFoZDyveGB56YmUvaqrYSLcOLrXJUZP9C8xXuIGQB4
         DWwHR4me5mM0nNQCnVrAaFMQROlKx4B6vP4BeJOe1AOsHO+XXbnS1fpejTJNw6qnxaB5
         x2nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791483234; x=1792088034; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0iaQv8rVXD9BmgHLRVDtfHBLkYyTPyvHBbxFyB6nVAw=;
        b=cRKw7s+ZW8ziKfztqXnyyUg9hPRb6S1tQilzxO0GeukOcA0/VnAgu1StI2jboijaBO
         60GybCHIFBDMiHrRvaxvCoYG2sT8OohdPOJENQU04oNJE0ALVHA73iyVXiTH60XFS7WC
         d5lA/KNl3XjwSiBYupPDsjlcFF33/qFi1Rkfe8ThPO2VTttGnwb32IJJJxGXNEwFPLrv
         aRzS8UH3ZDmyfhb4KNxuUwze12Gd3XpYJv5nmT63/h6goT9jnrbI7gCqSlEsXl6u5fjM
         cVcCJWJW/IBiTiIXwaxbn4X+J8eHQxClBfm9d/wzuz8nOpbV/hG603IbGb/596raOuyQ
         3mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791483234; x=1792088034;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0iaQv8rVXD9BmgHLRVDtfHBLkYyTPyvHBbxFyB6nVAw=;
        b=praBlcAP6e90PArSRvqGbZKiQfYL9gC6ybEtLl9q0AHlcB1NJ9qurKkMtjZSFZIV9C
         bfdM1hdFCedmy05MOFIhsj6aHIfb6OzkOPHhGu3HEvhkY9n32G+YFeBvkFS0pDGsE3Wk
         DAzFBcsgAXP4sDAdqQekxkw9YOO0HIM9/Stjf5fw505Ud4yLTFS4X96g7Q/wKJAZZsHG
         mVrfnAPTmIFmTrvhe3OHPVnEROoxEcoI0JstHUC/hFLrXFhxdYjxvAILenW+wt1xt4yN
         mTIoKMSSfCAj95989t/if9pfxQmjJNa/SZj8cljg7Io1g+3pc1BYodJAI7eWzTWeTFd6
         chHw==
X-Gm-Message-State: AFq9FYJiK6EsHk543CEIyd57cg197PiOcDYCD+Q5UF/JPbAP0dGulpxk
	qLk6B43lctb1aBuqFJarIPkpglZqFiWbEYUL9SETUBCK272vSENeK1ITS9X+MflCmfqILzpRuGz
	rOg1xiJ1MudcUjcH9PUpYwj5vpltCi1diNA==
X-Gm-Gg: AYBFou0jDX3LA2BE6ugkQ7hEDu+4eLW3jJbw2kIDaFMRk7Cw8h96FQwYjQpxPUYJaJg
	ONLpkPQC/CBC6xtA6oe93tGh+h5oI2HeGsxfxBxPxoE4PRRDq1Z2f5Dq19JfIn9lmmGqR4b2G30
	786x29okEOlBNztDo/yufY70X5uemCbbSEL/KWCdfr7inaEXqFLm1mCsjJyNJlcdHoZzULZT1SJ
	x0G+V7ovEeXhUvgZ4WQb7rWgmwlALtzjavooWgXH7VfAEFOCJ6IrBWjGjt4UU9EkO/OF93wOicZ
	rDEvULJlM+XBALVf1xpu00w0UOWqjlQ2I077BZPJw4QnYHOEHZE99o7Y
X-Received: by 2002:a05:6402:325a:b0:6ac:c82f:3caa with SMTP id
 4fb4d7f45d1cf-6aff374fd0amr4800528a12.1.1791483233445; Thu, 08 Oct 2026
 11:13:53 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 8 Oct 2026 11:13:52 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 8 Oct 2026 11:13:52 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gabriel Berfield <gabriel.berfield@gmail.com>
Date: Thu, 8 Oct 2026 11:13:52 -0700
X-Gm-Features: AclHuK_mlz7NC_V9pBCApoMmFgBPEYwqxX25ZDJ9k6d_UM7ET59qhrestYOrvJM
Message-ID: <CABNtnOZr1q7J6_bY4qr3Sb_jugoEyiR=a+6GMvK0JeK=psw7NQ@mail.gmail.com>
Subject: [PATCH BlueZ] client: Handle system bus connection failures
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Report the system-bus connection error and exit before attaching the
object manager when the connection is unavailable. This avoids a libdbus
assertion abort in restricted environments and releases the initialized
shell state on failure.

Fixes: 8a05f2b1ac91 ("client: Add initial parts for the command line client")
Link: https://github.com/bluez/bluez/issues/2446
Assisted-by: Codex:GPT-6
---
This is a current-master submission for the already reported issue #2446.
Related original submission:
https://lore.kernel.org/linux-bluetooth/20260828-master-v1-1-4810753bb693%40gmail.com/

Base: 866b0b8b162f52fa8a5452d2017093806ba1b570.
Validation: client built; all 35 make check programs passed; checkpatch
reported zero errors and warnings. With core dumps disabled, an unavailable
D-Bus address aborts the unpatched client but the candidate exits 1 with the
connection error. A read-only query against the live system bus exits 0.

This only handles client startup failure. It makes no claim about mouse
idle reconnects. Preparation and tests used Codex/GPT-6 assistance.

 client/main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index f5fdd7d12..fff75056e 100644
--- a/client/main.c
+++ b/client/main.c
@@ -4203,6 +4203,7 @@ static bool timeout_quit(void *user_data)
 int main(int argc, char *argv[])
 {
 	GDBusClient *client;
+	DBusError error;
 	int status;
 	int timeout;
 	unsigned int timeout_id;
@@ -4234,7 +4235,18 @@ int main(int argc, char *argv[])
 	else
 		auto_register_agent = g_strdup("");

-	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	dbus_error_init(&error);
+	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &error);
+	if (!dbus_conn) {
+		fprintf(stderr, "Failed to connect to system D-Bus: %s\n",
+			error.message ? error.message : "unavailable");
+		dbus_error_free(&error);
+		g_free(auto_register_agent);
+		bt_shell_cleanup();
+		return EXIT_FAILURE;
+	}
+
+	dbus_error_free(&error);
 	g_dbus_attach_object_manager(dbus_conn);
 	cs_set_dbus_conn(dbus_conn);
