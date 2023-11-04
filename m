Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD921C4167B
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Nov 2023 01:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjKDBkA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 21:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjKDBj7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 21:39:59 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DECBD5F
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 18:39:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41cda37f697so3524761cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Nov 2023 18:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1699061994; x=1699666794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEYc3C4e01vd8hxswTLpWySMc5vBXViucBe9zio26pk=;
        b=CVekjqyvc+007Eie2xLWox1SdUpU5073gap3BSJmO8mtQB8w9bAIs7Yf46L27HshFd
         N3dTKv2sW+lxmsoYN1uTZ0NuwcXEon8oHyx5eUDV7Gn8B+zhbdngBd7hEa2HmBlmjLec
         117ZEDI87Fd8vc/bGjXHGacLJqLWEgJulNVYFfPROEWlh0nrbid2dXBmfZjPNA5k7i99
         CZQtDmn4EzzGdRXNo+5WC+duafimQAoLkzehPQuzhWdQ1SoqrCITR0lD68ndR3TuCGM8
         WKw9VIZ5gTqwxrmhK+dDFmcJ4VP/5WtZDRWems1mNM4sgBjz5w6h19dh1sVEI3v/gfsT
         qQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699061994; x=1699666794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEYc3C4e01vd8hxswTLpWySMc5vBXViucBe9zio26pk=;
        b=hI11dADjj0pc6O4wrRF9T0zsh/R11veEqAzl0cRm/CZ95iMJzawS/SE2kbQlbjVgxF
         dHyHt5eHEbNuWPabQ0PaQtM6OAxFjrWGih1VcrRoN+Hd2PVp7lTYFpAxKJEzRP+yskYc
         pV4W2C/urHixUjzp8NxUg27uJF/Kqz8IkIhmupFl8DWv/wnBptS8GhAvyKnw7AEIciSP
         llnm03fiOwCsiwtE2PXqAE3fc0yynJNRsFShxhszM2rMyWbFoTnB/iEFFXP0MYPcnZOg
         aImm8kjMS9RN0x7hljBR+pmkgjEXisaXeREDZIwpDtxbN7l4ycSyS19JSd7eyQmwWSKv
         BZYw==
X-Gm-Message-State: AOJu0YxbJ0UBfeqWeJScT2rcumh9Mb3qKkT1G5oMXXIEs9YEHtTufzEs
        osU+b9egfxPNgdRyu54wA+Txn4YBwspiwysbar62EVvc/atC5o0hP6qXdXQ4Y7ztuWpeCwRWn8F
        W1FfMjuWNapN1fZaK0ctWAy9ZrYZMRCotslp5CYd7OQExb1V35WhCRcOMNdNJXZRplarU100ayh
        Qy
X-Google-Smtp-Source: AGHT+IHEoj+exOGbB5jh5Wv34Yx09vO8WekZMUFuCpwon3KOeuaxwLAEb3cl2uxHIVfRxlPoxPamKA==
X-Received: by 2002:a05:620a:190d:b0:774:17d6:31dc with SMTP id bj13-20020a05620a190d00b0077417d631dcmr26507934qkb.4.1699061994554;
        Fri, 03 Nov 2023 18:39:54 -0700 (PDT)
Received: from debian.localdomain (c-73-177-243-39.hsd1.va.comcast.net. [73.177.243.39])
        by smtp.gmail.com with ESMTPSA id l17-20020a05620a28d100b007770d47c621sm1216955qkp.66.2023.11.03.18.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 18:39:54 -0700 (PDT)
From:   Paul Otto <potto@vt.edu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Paul Otto <potto@ieee.org>
Subject: [PATCH BlueZ 3/7] update doc for bluetoothctl-endpoint.rst
Date:   Fri,  3 Nov 2023 21:38:46 -0400
Message-Id: <20231104013850.24182-4-potto@vt.edu>
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
 client/bluetoothctl-endpoint.rst | 121 +++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 client/bluetoothctl-endpoint.rst

diff --git a/client/bluetoothctl-endpoint.rst b/client/bluetoothctl-endpoint.rst
new file mode 100644
index 000000000..95f981326
--- /dev/null
+++ b/client/bluetoothctl-endpoint.rst
@@ -0,0 +1,121 @@
+============
+bluetoothctl
+============
+
+----------------
+Endpoint Submenu
+----------------
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
+Endpoint Commands
+=================
+   We divide bluetoothctl into main menu commands and submenu commands. The submenu commands control options 
+   numbers for the commands can be hex (0x0F) or decimal (10)
+   
+list
+----
+List available endpoints
+
+:Usage: **# list [local]**
+
+show
+----
+Endpoint information
+
+:Usage: **# show <endpoint>**
+
+register
+--------
+Register Endpoint
+
+:Usage: **# register <UUID> <codec> [capabilities...]**
+
+unregister
+----------
+Register Endpoint
+
+:Usage: **# unregister <UUID/object>**
+
+config
+------
+Configure Endpoint
+
+:Usage: **# config <endpoint> <local endpoint> [preset]**
+
+presets
+-------
+List available presets
+
+:Usage: **# presets <UUID> [default]**
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

