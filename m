Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDBAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Nov 2023 01:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjKDBjy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 21:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjKDBjx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 21:39:53 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A7AD5F
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 18:39:50 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-670237ba9b1so5713486d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Nov 2023 18:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1699061989; x=1699666789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3Yhy9Hf5+nnSUNmSBL33gHvI8iid5vFUHfOckgKkt8=;
        b=XYBGqBcdjqxWKxQhRzZdm7F/jWdSrupHEcne3YsUywa+B7XWXPTTSrr+oY/hBnbBjW
         1Rf+gCG5W6SaLRqePWKxnEc8AyAeoIOPeQgCtsCMo1Vg26473xAG3lB1CSytyOr3aux5
         fwEpyMHRiZgDjU+1cXq3LAtVXp7zO7iEb30YoYrDTZzdlwkdF0xl3zxYz0J/RiIfcO2y
         UXl6y3lKtdjJep50zjbPExyXywEkejazJugxJ3ZWO6ahIzJp1WioXgVv+Iuw5WA0+h83
         c6FjsHUgdEmNaF976czqcCgTTLzPZ/THB3yIdrWHHhVtVnB/W1sx2EDKwKzHRnFJLA5i
         0yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699061989; x=1699666789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3Yhy9Hf5+nnSUNmSBL33gHvI8iid5vFUHfOckgKkt8=;
        b=KMgR2GYZ05JsDFxw++v1eBfOHr9H+t8n0/SiIG4gLzqOuI2+wEsPnH5qcvlPybSJv5
         M6ri+MAgHbAax7ZZj3gbEvwsZpKPU+gX/AeYB/cQa+UNrlCL0O6wZ9xY/P9q8+zScAKH
         +/lcUiwyrXF7x+NP8NANNU4hxS3sPVTcNcfbbx2/712ByE/1iXNtDZeMKlk851/zJdRz
         jexdZ0Oy9GT3JuNDjiRPtvHcgwk7t4inTQ7IXRNSENwb+4q2DDo4SpG7YVNXal4IeATf
         FlutyMoL6EHGAnuzve++8i3BDOYC54Fose4I4QHn90wqBdRcuucA4ULT0YaVg5xB5sA5
         zY4Q==
X-Gm-Message-State: AOJu0Yx5W588Z+MafMXLN50Qcvv8B9yfnZyogZiDVu5Bu7hAYvJ1Iir9
        r+jFc0XHkq4oZfbNRXOprKm3u2fJt+rwZdhwB8Kwar+BsqA7jcturm7of0XHVPWOTm0/4vJaKrr
        abgYX7Owkgg6DDjfzX7va9ki9E9RgeuBV3IvZ16d6Yz+syuxp0O5Wv5JwISM0jlZI40q6KZdxc4
        Rq
X-Google-Smtp-Source: AGHT+IF4EVlBDx/Btmv1it3nFf9FZgDV/8FIUsZCNXZeRGVIQ3fLesJ/A/d68HUn+KyNldvgG3njwg==
X-Received: by 2002:a05:620a:24c3:b0:76f:27af:2797 with SMTP id m3-20020a05620a24c300b0076f27af2797mr26864388qkn.0.1699061988678;
        Fri, 03 Nov 2023 18:39:48 -0700 (PDT)
Received: from debian.localdomain (c-73-177-243-39.hsd1.va.comcast.net. [73.177.243.39])
        by smtp.gmail.com with ESMTPSA id l17-20020a05620a28d100b007770d47c621sm1216955qkp.66.2023.11.03.18.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 18:39:48 -0700 (PDT)
From:   Paul Otto <potto@vt.edu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Paul Otto <potto@ieee.org>
Subject: [PATCH BlueZ 1/7] update doc for bluetoothctl-admin.rst
Date:   Fri,  3 Nov 2023 21:38:44 -0400
Message-Id: <20231104013850.24182-2-potto@vt.edu>
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
 client/bluetoothctl-admin.rst | 98 +++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 client/bluetoothctl-admin.rst

diff --git a/client/bluetoothctl-admin.rst b/client/bluetoothctl-admin.rst
new file mode 100644
index 000000000..7084bdad0
--- /dev/null
+++ b/client/bluetoothctl-admin.rst
@@ -0,0 +1,98 @@
+==================
+bluetoothctl-admin
+==================
+
+--------------------
+Admin Policy Submenu
+--------------------
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
+Admin Policy Commands
+=====================
+   We divide bluetoothctl into main menu commands and submenu commands. The submenu commands control options 
+   numbers for the commands can be hex (0x0F) or decimal (10)
+   
+allow
+-----
+   Allow service UUIDs and block rest of them
+   Syntax: allow [clear/uuid1 uuid2 ...]
+   Example: allow 0x1101 0x1102 0x1103
+   Example: allow clear
+
+:Usage: **#allow [clear/uuid1 uuid2 ...]**
+
+back
+----
+   Return to main menu 
+
+:Usage: **#back**
+
+version
+-------
+   Display version
+
+:Usage: **#version**
+
+quit
+----
+   Quit program
+
+:Usage: **#quit**
+
+exit
+----
+   Quit program
+
+:Usage: **#exit**
+
+help
+----
+   Display help about this program
+
+:Usage: **#help**
+
+export
+------
+   Print environment variables
+
+:Usage: **#export**
+
+EXAMPLES
+========
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

