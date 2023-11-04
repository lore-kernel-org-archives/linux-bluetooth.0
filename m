Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022EC4167D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Nov 2023 01:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjKDBkJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 21:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjKDBkI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 21:40:08 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E11AD42
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 18:40:06 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77891670417so44081585a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Nov 2023 18:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1699062004; x=1699666804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L/sMvot63NywAIROe67VDyVaO6P9By3Y5eBlsF9ET0=;
        b=dlfSBmhu9o1nufBwuqYgobw6yyQdcvL39MTiU183ssLz5mdNuWUFCMbFZtVMFSOdQW
         vBzcbsBj+mAfwvZtcJW4dYmGKCYcXuenjR+8IAkH3/JZoDjOc5iGczyl78y1FvA9gIm0
         mR9mIs/6jOLP2y+cpUL4+mJKfSj5XA9ka8ZU6Dw7QadxnxXKBL3ONXcQC3vkgSJDv5MW
         9bNsLRQGAJ7JLbj4Za37Q46P9k38WnPlCSi2Oi1UQUHQPP59lRoiwxQ37wJ6OhVmdUUg
         E8kNA8VonaWo/jmETX1nePJbrSjegSk2xn39lJvTGg/bNQV/xfva7KuMhX1Gxlub6lyI
         Yi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699062004; x=1699666804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9L/sMvot63NywAIROe67VDyVaO6P9By3Y5eBlsF9ET0=;
        b=GefvqA0x30JRzxO5t7yt2tro7+rcf5O07qpnO+yrty13bY5uWWEcVJbyAuIaOXWS/7
         r2iogASuzj84IkHB7dYUeQ1aMj2QzKZJGxpth5ZP9LgQDQavjlYjTkFDOUTbCXE3yKt1
         4qGm8m4FnKInj1Vbe8Oysupb95mMj/85zp4ISmGOJyf055LM3nXZPP6SwWzh1Fzfm/+2
         X0pHy/v0AOkckQ6UOvZNfVaGrENnsLP/163UX+Mef8t1KUMlLp6pByu89bCCnHx6fKvR
         wOnI0dExMEn/YI6p+DwBghA4ZnFOcJqPAWJDk/GlTSql2lxgFHx13VmWK+leGFLDtVoX
         qV5g==
X-Gm-Message-State: AOJu0YxNy6PllhMmH+38PXj4GoeUNFpWJh2ZyzTf1BuCIlKicHZkB0pU
        dOrmCdUtsHJnWiNkMArf9E+LqgpsxwByYC1M8aov7UteWBioQvitBzwzqiq7EA8TnXxASzwIjNO
        C4D+qyyVjhkMoat75caC1xvcUGkgiJyBcLgWcH3/n7OyDKN49K8RLqJXWadYkV+vkCMTXV9Fne+
        Uu
X-Google-Smtp-Source: AGHT+IHWKD0P3O8pkriBxEu4wKOI8k4ojdurGsa2XCZuSsLuXQ49nPlbWkHMpNZpfLZxqTYWA39UkQ==
X-Received: by 2002:ad4:4e8f:0:b0:668:e31b:5576 with SMTP id dy15-20020ad44e8f000000b00668e31b5576mr23753782qvb.1.1699062004325;
        Fri, 03 Nov 2023 18:40:04 -0700 (PDT)
Received: from debian.localdomain (c-73-177-243-39.hsd1.va.comcast.net. [73.177.243.39])
        by smtp.gmail.com with ESMTPSA id l17-20020a05620a28d100b007770d47c621sm1216955qkp.66.2023.11.03.18.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 18:40:04 -0700 (PDT)
From:   Paul Otto <potto@vt.edu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Paul Otto <potto@ieee.org>
Subject: [PATCH BlueZ 7/7] update doc for bluetoothctl-transport.rst
Date:   Fri,  3 Nov 2023 21:38:50 -0400
Message-Id: <20231104013850.24182-8-potto@vt.edu>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231104013850.24182-1-potto@vt.edu>
References: <20231104013850.24182-1-potto@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Paul Otto <potto@ieee.org>

---
 client/bluetoothctl-transport.rst | 128 ++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 client/bluetoothctl-transport.rst

diff --git a/client/bluetoothctl-transport.rst b/client/bluetoothctl-transport.rst
new file mode 100644
index 000000000..3dd4d4a75
--- /dev/null
+++ b/client/bluetoothctl-transport.rst
@@ -0,0 +1,128 @@
+============
+bluetoothctl
+============
+
+-----------------------
+Media Transport Submenu
+-----------------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: November 2022
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**bluetoothctl** [**-a** *capability*] [**-e**] [**-m**] [**-t** *seconds*] [**-v**] [**-h**]
+
+DESCRIPTION
+===========
+
+**bluetoothctl(1)** interactive bluetooth control tool. The tool works with Bluetooth Classic (BR/EDR) and Bluetooth Low Energy (LE) controllers.
+
+OPTIONS
+=======
+
+-a capability, --agent capability        Register agent handler: <capability>
+-e, --endpoints                  Register Media endpoints
+-m, --monitor                    Enable monitor output
+-t seconds, --timeout seconds    Timeout in seconds for non-interactive mode
+-v, --version       Display version
+-h, --help          Display help
+
+Media Transport Commands
+=========================
+   We divide bluetoothctl into main menu commands and submenu commands. The submenu commands control options 
+   numbers for the commands can be hex (0x0F) or decimal (10)
+
+list
+----
+List available transports
+
+:Usage: **# list**
+
+show
+----
+Show transport information
+
+:Usage: **# show <transport>**
+
+acquire
+-------
+Acquire transport
+
+:Usage: **# acquire <transport> [transport1...]**
+
+release
+-------
+Release transport
+
+:Usage: **# release <transport> [transport1...]**
+
+send
+----
+Send contents of a file
+
+:Usage: **# send <transport> <filename>**
+
+receive
+-------
+Get/Set file to receive
+
+:Usage: **# receive <transport> [filename]**
+
+volume
+------
+Get/Set transport volume
+
+:Usage: **# volume <transport> [value]**
+
+back
+----
+Return to main menu
+
+:Usage: **# back**
+
+version
+-------
+Display version
+
+:Usage: **# version**
+
+quit
+----
+Quit program
+
+:Usage: **# quit**
+
+exit
+----
+Quit program
+
+:Usage: **# exit**
+
+help
+----
+Display help about this program
+
+:Usage: **# help**
+
+export
+------
+Print environment variables
+
+:Usage: **# export**
+
+
+RESOURCES
+=========
+
+http://www.bluez.org
+
+REPORTING BUGS
+==============
+
+linux-bluetooth@vger.kernel.org
-- 
2.30.2

