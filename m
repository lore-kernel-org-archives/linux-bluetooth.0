Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18917C678D5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCGWZ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjCGWZE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:25:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40EE9662A
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:24:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so146408pja.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMJPH4LKfsC1gbsemoIowAUoRkGzTRKYvd8HxwE27iI=;
        b=oVmz0OhGsIGBeMNscSZe+bnkuE7yuxo0GgC1uJRoIUf8nO6x+bF9TBmqlk1i2Ntkin
         aHdTn5c+6QbulVd+CQk9KPkGpYZeMewYZeOd34RByEJNDUo9Wj0kUKSYiAuC682eX2HV
         dK6dyEj+oCvwvpXqaEQbD6hqNoadCrsUrLaM1KtSi3PfLmDiof4kNVBIXbbNFb6qt/Dm
         zuy+QiVuaDtb9YVo9/udPATtQDsWaH5KDqVcYr7etosCJf33q8Tv+oYl9dWNha+sGB6q
         te6K/7RKYRCtk0m2gc0D3fQneQZQoUFGnEkOeiChadqvPgd8xUVvkUS5SUE8ZMgcMe/V
         3xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMJPH4LKfsC1gbsemoIowAUoRkGzTRKYvd8HxwE27iI=;
        b=EXOdQ5lK3M5OeAgJDGtLThQjO9lC7vVO9nLFhoOcQeMZYGF21ZtkwLyn4G/G5qi5jJ
         M1NF/Mo3PuxRUzuOucPrCvUfrzomNpGcZqp2EbEw0na3+WTUHOYWerE3lfVoQJSTO4f0
         pd954BDGYu0E0F+VUfRZbkFitK/BSg+hFkhGdFVfdu+5tq9cFy6acyrwp0QCpruHVvl4
         pH8KxN/I1a99hlttjqoW9nuSlN3CmmPXwvrs3ZqxwwQzubMjITmVNrjqaWvJOBNxIpkc
         Wcav9B6Xdh0mm8M/NW5EmDrdzKjy9ppqf20UkxvKPRaWBgzo/xdLBRtYXQAkdWYZlApN
         id0Q==
X-Gm-Message-State: AO0yUKWGr0TRyue2Dhud9h7d3o1jzk1dI2KDIRCiAb2V5s/1Fq0seJC5
        DXzxfN226bLP7oRPvrw0O2l75AhfzjE=
X-Google-Smtp-Source: AK7set8Fcpc1PWnax/xBF0IqR1FsKpkyWyy6uO5zYtzG/mvfqo4dU8NydZGyap6tu8wEWd4vU4NaEA==
X-Received: by 2002:a17:902:9b84:b0:19e:7d66:ff29 with SMTP id y4-20020a1709029b8400b0019e7d66ff29mr13250691plp.61.1678227866912;
        Tue, 07 Mar 2023 14:24:26 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902729200b0019c901b35ecsm8814392pll.106.2023.03.07.14.24.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:24:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2 03/12] doc: Add set-api
Date:   Tue,  7 Mar 2023 14:24:13 -0800
Message-Id: <20230307222422.2608483-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds set-api.rst which documents DeviceSet interface.
---
 doc/set-api.rst | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 doc/set-api.rst

diff --git a/doc/set-api.rst b/doc/set-api.rst
new file mode 100644
index 000000000000..c49be1ae0514
--- /dev/null
+++ b/doc/set-api.rst
@@ -0,0 +1,53 @@
+=====================================
+BlueZ D-Bus DeviceSet API description
+=====================================
+
+
+DeviceSet interface
+===================
+
+Service		org.bluez
+Interface	org.bluez.DeviceSet1
+Object path	[variable prefix]/{hci0,hci1,...}/set_{sirk}
+
+Methods
+=======
+
+**void Connect() [experimental]**
+
+	Connects all **devices** members of the set, each member is
+	connected in sequence as they were added/loaded following the
+	same proceedure as described in **Device1.Connect**.
+
+	Possible errors: org.bluez.Error.NotReady
+			 org.bluez.Error.Failed
+			 org.bluez.Error.InProgress
+			 org.bluez.Error.AlreadyConnected
+
+**void Disconnect() [experimental]**
+
+	Disconnects all **devices** members of the set, each member is
+	disconnected in sequence as they were connected following the
+	same proceedure as described in **Device1.Disconnect**.
+
+	Possible errors: org.bluez.Error.NotConnected
+
+Properties
+==========
+
+**object Adapter [readonly]**
+
+	The object path of the adapter the set belongs to.
+
+**bool AutoConnect [read-write, experimental]**
+
+	Indicates if the **devices** members of the set shall be automatically
+	connected once any of its members is connected.
+
+**array(object) Devices [ready-only, experimental]**
+
+	List of devices objects that are members of the set.
+
+**byte Size [read-only, experimental]**
+
+	Set members size.
-- 
2.39.2

