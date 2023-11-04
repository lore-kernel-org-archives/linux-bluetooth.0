Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3394C4167B
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Nov 2023 01:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjKDBkI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 21:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjKDBkH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 21:40:07 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62543D49
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 18:40:04 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-671188b2d44so5540976d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Nov 2023 18:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1699062003; x=1699666803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kItXK8IfAw5zGkCx/+0mLlASj+bZH+aDao3uOHR3q8=;
        b=V7a7/RW5lB7JH13TESlm4g01B/7+2eybWqhv/0R0ykj88qVYMOmQuIe34dmqaAOaJe
         l516gxyg27+LiwMMLYGAD/+QZD7gcztuo69Er59vGhAYZZ51ttGmdQxZ5WHknATVg6Ac
         V7IILQchqJvt7buv0bGRq2Anx6kjNIgQegGrK32Rf/KJSmV9Z+ydLLBevmJbVI+4fnRd
         7+8c/85SSIr1JrYpwHcdKSXoSshr+k24X5JwLjcRo3I99G2qUEyFeSvxzT70ChsF4uKm
         NBraG0csh2F52eecHk84HxZoKnTfkeHDeZ4RwJQBjK5FhLyzJn/JZgZX7XRzdHb03v7P
         uLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699062003; x=1699666803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kItXK8IfAw5zGkCx/+0mLlASj+bZH+aDao3uOHR3q8=;
        b=bcarWBCQVeCCgKTYZZgbD6+W/KzKetWW60s1Yiu13IPJMZpBTr7E4kkMDUiL9iUnFQ
         y7T3YgKawCRE/+g8xJgA7EBatSur/89OXvqpkFKPGqNsCxMvW54/fBSUC/J1B81KI0WD
         1sJVDYDfs3SqWIwvmX6vYm4LpUlan47e6mPtf3Q2E8owcG1vee+/FC/gUqY7uqjTfjmV
         ZpJqprHKFT7Xc/mZcbbzY2z1ARuHS87N5jZjC+0Egs7NimchmwlZ78r0H34xU38C6qXc
         dNeu8GBcn8twubxWOep69iTbf+/G1DDjbHPA2XuP/JFlwUserwJJ4/2bJ2vSmaeBuLh1
         X/vw==
X-Gm-Message-State: AOJu0YxVRY0SPJT6JI/lpxmrZnkj8AY5LktmMaEIczETJY5ej7s7dvvj
        gzTCR1yqV9su6YwOEJjbpg4LJRjIT9fnR4m5jaV4zHqdxsn6IR/deLPewtAh8mkj7fHp8YPr15g
        ZdrDrtb1ivDFSNoJJkk0G6T+uDGlougucnmcKwTZoO5QNyyW1m8DP0SrriJJb406EAwb9yVMco8
        wp
X-Google-Smtp-Source: AGHT+IGmoAIGGXh1Fd9otrPi1kAh4K1vQm+1DWDENIgWsmaZJoUFqEMRrUwH/QXzgi0nS2poN8xsKg==
X-Received: by 2002:a05:620a:470e:b0:775:82e2:dc19 with SMTP id bs14-20020a05620a470e00b0077582e2dc19mr26495730qkb.2.1699062002473;
        Fri, 03 Nov 2023 18:40:02 -0700 (PDT)
Received: from debian.localdomain (c-73-177-243-39.hsd1.va.comcast.net. [73.177.243.39])
        by smtp.gmail.com with ESMTPSA id l17-20020a05620a28d100b007770d47c621sm1216955qkp.66.2023.11.03.18.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 18:40:02 -0700 (PDT)
From:   Paul Otto <potto@vt.edu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Paul Otto <potto@ieee.org>
Subject: [PATCH BlueZ 6/7] update doc for bluetoothctl-scan.rst
Date:   Fri,  3 Nov 2023 21:38:49 -0400
Message-Id: <20231104013850.24182-7-potto@vt.edu>
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
 client/bluetoothctl-scan.rst | 146 +++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 client/bluetoothctl-scan.rst

diff --git a/client/bluetoothctl-scan.rst b/client/bluetoothctl-scan.rst
new file mode 100644
index 000000000..4bd06595d
--- /dev/null
+++ b/client/bluetoothctl-scan.rst
@@ -0,0 +1,146 @@
+=================
+bluetoothctl-scan
+=================
+
+------------
+Scan Submenu
+------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: July 2023
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**bluetoothctl** [**-a** *capability*] [**-e**] [**-m**] [**-t** *seconds*] [**-v**] [**-h**] [scan.commands]
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
+Scan Commands
+=============
+   The scan commands control options numbers for the commands can be hex (0x0F) or decimal (10)
+   
+uuids
+-----
+Set/Get UUIDs filter
+
+:Usage: **# uuids [all/uuid1 uuid2 ...]**
+
+rssi
+----
+Set/Get RSSI filter, and clears pathloss
+This sets the minimum rssi value for reporting device advertisements. The value is in dBm.
+Example: To only show devices with rssi values greater than or equal to -60 dBm, use `scan.rssi -60`.
+If one or more discovery filters have been set, the RSSI delta-threshold imposed by starting discovery by default will not be applied.
+
+:Usage: **# rssi [rssi]**
+
+pathloss
+--------
+Set/Get Pathloss filter, and clears RSSI
+This sets the maximum pathloss value for reporting device advertisements. The value is in dB.
+Example: To only show devices with pathloss values less than or equal to 4 dB, use `scan.pathloss 4`.
+If one or more discovery filters have been set, the RSSI delta-threshold imposed by starting discovery by default will not be applied.
+
+:Usage: **# pathloss [pathloss]**
+
+transport
+---------
+Set/Get transport filter
+Transport parameter determines the type of scan. The default is auto.
+
+Possible values:
+
+- "auto": interleaved scan
+- "bredr": BR/EDR inquiry
+- "le": LE scan only
+
+If "le" or "bredr" Transport is requested and the controller doesn't support it, an org.bluez.Error.Failed error will be returned. If "auto" transport is requested, the scan will use LE, BREDR, or both, depending on what's currently enabled on the controller. 
+
+duplicate-data
+--------------
+Set/Get duplicate data filter
+Disables duplicate detection of advertisement data. When enabled, PropertiesChanged signals will be generated for ManufacturerData and ServiceData every time they are discovered.
+
+:Usage: **# duplicate-data [on/off]**
+
+discoverable
+------------
+Set/Get discoverable filter
+Makes the adapter discoverable while discovering. If the adapter is already discoverable, setting this filter won't have any effect.
+
+:Usage: **# discoverable [on/off]**
+
+pattern
+-------
+Set/Get pattern filter
+Discover devices where the pattern matches either the prefix of the address or the device name, which is a convenient way to limit the number of device objects created during a discovery.
+When set, it disregards device discoverable flags.
+Note: The pattern matching is ignored if there are other clients that don't set any pattern, as it works as a logical OR. Also, setting an empty string "" pattern will match any device found.
+
+:Usage: **# pattern [value]**
+
+
+clear
+-----
+Clears discovery filter
+
+:Usage: **# clear [uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern]**
+
+back
+----
+Return to the main menu
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

