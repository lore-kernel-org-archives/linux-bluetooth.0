Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C466C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 06:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjJ3Gxs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 02:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjJ3Gxr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 02:53:47 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20746AB
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Oct 2023 23:53:45 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 196903F697
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 06:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698648823;
        bh=eIfjSyNTcNCMdu0BwcyBXoOOLvKerxJ6fISDsi512yM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Gx8mlgIsEUtET7GuDAQnrig6EQ6G8F+71Drju+T9MqNBBcxfqKpj2IMaWs5MuUeQD
         zz1mRCwa4qUAEAf8Owe7MuO5f2c5ipAhXVN0NZMKFLUIv75TZIXPjT4JL0ftyX2ZSK
         FoIYPfqxtk+Qk3tHajcxyzci3cq/nm71RGnkWnZ3RiZgtu8rOMz9948n99ELAf/VuG
         vVTyy2Gmw8PqmZ83QuHKp85RFk+Mk4V3x+9rVG4fXzoZIck4CEj7/NrbvCIM88lzEg
         Efr8mEp+t80qDDRjORX80tLtFe5vGJYcRG9e8usFz3bfkTWDcf9c7fXClGj6FN79OA
         NhQTmQjeOys5g==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32f820c471fso631920f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Oct 2023 23:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698648822; x=1699253622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIfjSyNTcNCMdu0BwcyBXoOOLvKerxJ6fISDsi512yM=;
        b=rSwCYwDIcwWdeprjdgnz0ob39QEVQynzqAnWViURGxMT5aSbzs3HdwvYFuNRbav5yi
         eg5N1NVe09exV1elNb4Oo4xTDnUT5kN4ghvOzp2XCR6JQgFFwUcODeqD5ZsvhRo7D1zP
         k+uC770pFaRXVPM9nuYC9s89g4YXYWYt1f+cIkb/2qg1zntlZmXhEdTN2FJTS3V0wb3Q
         bBI7oveZEcCkQeYPYD3vElGp9UqKPC3ooAcQcJtWerrjDyWLKWkZa6unC18ALwPKzuL0
         yVvva/QQf0AVEu7fMU5QdR5MDU0AM/dFsFMQ8HWXQU/mJL+JZgtDLFz6+wfAi6DgeI7R
         /Azw==
X-Gm-Message-State: AOJu0YyC5nURRm2MvzqSrgP6SOxP0SbT7nOq3kZlGiEFh5bxySszViUS
        Bi4Jj4o2/Nee27L8iXe+YHcEX+WlDWO1aIgZdUQK10utxWOkOFXFV6vBFpd5IDfLfwSp29XTApH
        CUkA8I549k4B9Lh5UkWsZB1GzBdusn60xGvqpn5J6YbVRSQ==
X-Received: by 2002:adf:ec52:0:b0:32d:a405:b6b7 with SMTP id w18-20020adfec52000000b0032da405b6b7mr6933823wrn.32.1698648822810;
        Sun, 29 Oct 2023 23:53:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXlzd/q4bBQzJ6m7Xy9RrP/K4ZyD+qeNLrX98/G8cV0lDzvp2vx1eJIG04Pjh44/7w8FtIGw==
X-Received: by 2002:adf:ec52:0:b0:32d:a405:b6b7 with SMTP id w18-20020adfec52000000b0032da405b6b7mr6933814wrn.32.1698648822517;
        Sun, 29 Oct 2023 23:53:42 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id w16-20020adfcd10000000b0032da75af3easm7463377wrm.80.2023.10.29.23.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 23:53:42 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     juerg.haefliger@canonical.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] shared/shell: Fix --init-script commandline option
Date:   Mon, 30 Oct 2023 07:53:41 +0100
Message-Id: <20231030065341.8998-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231027055423.13617-1-juerg.haefliger@canonical.com>
References: <20231027055423.13617-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The newly added option -i/--init-script introduced a short option
namespace collision with btmgmt's --index, both of which use '-i'.

As a result, a provided --index is treated as a file name:

$ sudo btmgmt --index 0 info
Unable to open 0: No such file or directory (2)

Fix this by using '-s' for --init-script.

Fixes: https://github.com/bluez/bluez/issues/639
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

---
v2:
  - Replace reference to broken commit with reference to github issue.
---
 src/shared/shell.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index db79c882ca3a..fbccff5b54d9 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1128,7 +1128,7 @@ static void rl_init(void)
 static const struct option main_options[] = {
 	{ "version",	no_argument, 0, 'v' },
 	{ "help",	no_argument, 0, 'h' },
-	{ "init-script", required_argument, 0, 'i' },
+	{ "init-script", required_argument, 0, 's' },
 	{ "timeout",	required_argument, 0, 't' },
 	{ "monitor",	no_argument, 0, 'm' },
 	{ "zsh-complete",	no_argument, 0, 'z' },
@@ -1169,9 +1169,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	if (opt) {
 		memcpy(options + offset, opt->options,
 				sizeof(struct option) * opt->optno);
-		snprintf(optstr, sizeof(optstr), "+mhvi:t:%s", opt->optstr);
+		snprintf(optstr, sizeof(optstr), "+mhvs:t:%s", opt->optstr);
 	} else
-		snprintf(optstr, sizeof(optstr), "+mhvi:t:");
+		snprintf(optstr, sizeof(optstr), "+mhvs:t:");
 
 	data.name = strrchr(argv[0], '/');
 	if (!data.name)
@@ -1193,7 +1193,7 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 			data.argv = &cmplt;
 			data.mode = 1;
 			goto done;
-		case 'i':
+		case 's':
 			if (optarg)
 				data.init_fd = open(optarg, O_RDONLY);
 			if (data.init_fd < 0)
-- 
2.39.2

