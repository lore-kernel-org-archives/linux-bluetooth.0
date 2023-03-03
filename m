Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9474BC7EE30
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 01:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCCB1u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCCB1s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 20:27:48 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46C15886
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 17:27:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v11so1157822plz.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 17:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rRjKc5vWPc2pLQz5iSZQl3km6b+r3dZiPi8ZuHNI4Y=;
        b=QE09XuuFX9ITtqhe6G6i/cm66LM56imQpXsDQ9OEmfeWc3yVZuJlLXTmsSdRWtGILv
         ctbTbYFkj7Hw37pTV0YddpfhpBLPJrLF/PnJK8KQ4ZUX51rnqCdCWSjEPOateU8AtUHR
         miP3DAKiVSl4IqsitTk/coW8P3CjF9NoNxxPeS5kCS79KaNARLS4IfrDDxVMn8089BYi
         wY8Ids8XzSvavw4RWC5UcIE/AnQEIvCae4jbhiL0iC5CfLyU51ybyDVKjh165xhD0MQh
         GXSLKtxTXLYyjy9SYhC3PSVNlv17xKxZmftJtWd3vNyETtccPrZ91DbeJawsZTkxAuLz
         SxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rRjKc5vWPc2pLQz5iSZQl3km6b+r3dZiPi8ZuHNI4Y=;
        b=of/K23ro6lCIdWE2Jgjwpsd/GRTvGE6sLPvwdGmp4/+/WWBczzDHI88jf/SgJC7Xtb
         TR+l2MrBj2ucOLPKyH8X71vHp65TifAGcUHUmbTqBYUCrDJVkqKadbzLHXP1ihd4y8yw
         fKLlybhXgsp8ozv2S/c3oU5ZqJDbh5Ebh+fAuyK/TnJv35UvrYupyY8DSjDDQJ9kqTcp
         sxH+3AnwhlJp6HdXAhVC8XiWg/pGw2ost0CIxA6cTJR0zWb2tgHKzR3yL3s+b/F9rEhz
         RABB/rRdb7wyw3PLFIg++51mg7dAYiDsydgx1dmC3GjEKi9rIIdj5QvrfPzZVVAFAv6K
         Axjg==
X-Gm-Message-State: AO0yUKVd6xAsqpbUTDIz+PoRF9lfmy9Kt2iiNlE0QEBpdeFjsaqw5yH7
        3S7rB2aOE0IdErID2UJLJ/5rBDW8cow=
X-Google-Smtp-Source: AK7set8SJ6wqJU8jiWqem6b3/jitABmcEqgcWe/pKreU6+hVHnO5IVCv2gQhoZOSoTilRHc5C10Z3w==
X-Received: by 2002:a17:902:f689:b0:198:f8c9:7f4b with SMTP id l9-20020a170902f68900b00198f8c97f4bmr4048179plg.2.1677806866120;
        Thu, 02 Mar 2023 17:27:46 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id kd3-20020a17090313c300b0019a6d3851afsm284622plb.141.2023.03.02.17.27.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:27:45 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 3/9] doc: Add set-api
Date:   Thu,  2 Mar 2023 17:27:36 -0800
Message-Id: <20230303012742.1386291-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303012742.1386291-1-luiz.dentz@gmail.com>
References: <20230303012742.1386291-1-luiz.dentz@gmail.com>
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
index 000000000000..17c5f93b6b86
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
+
+**byte Rank [read-only, experimental]**
+
+	Set members rank.
-- 
2.39.2

