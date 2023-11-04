Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FF9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Nov 2023 01:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjKDBkG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 21:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjKDBkF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 21:40:05 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CD7D49
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 18:40:01 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-779d0c05959so43960585a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Nov 2023 18:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1699062000; x=1699666800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GdiVLQENCpXVQxF1p4p75FAn4IaNPjZJJ2eYyHdYOY=;
        b=Gu8XQmOugDa3lbSzZriO/sHXD9ID2L0UMcmAl/ig7hro7cR7PiWONMijWkhR2c8i69
         cw/LNb75KYMMUJBtc3DXAtAnCMPS6uCqDJNnvHSgQ/+fK9YWho3rO6mDqW+ad0dL/U3l
         964KDZH2ooIPS0vIHWIx+ajxMLtFNNxwBGulbPVbKwU6tulUGW1D8wloCotEVY8byJmj
         65qkSw0StpBSXLqFONXrcHbfjPOSiG4BTXkuvkmrAeCaHD11wK617SDECWsXjD2BxGkB
         L3OKkDY/RZKS+ONNdCWs3guNbVbmFkKvRG6qX63kE4j1D5mPx26ngPmrrJwx1GmK1LVM
         DZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699062000; x=1699666800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GdiVLQENCpXVQxF1p4p75FAn4IaNPjZJJ2eYyHdYOY=;
        b=FUl2TuaqpGzyRQLXKl1I1JrlLX27wp9fZn5Gccv8694h34KTmnaFQF3Ddzpr4UEErx
         uUQc53fJtZ65s+DnyjDHN5DZpkP6C2yFwHeBe6NjJxBCqRd/FO/yKcC60RIWV/ANSakA
         Lf1UWWrZsh8/24HEQNfP4+1fY2nwkXl1RU2Fr3S0AsH0hesiR5loBiT0OSN26DM5TYcY
         gMiJEM6eMt8Fe945/8CvQlrWCm09MIQVR0wdvEMnW2yWpT/qunoXEL3/LCV7/efPOthp
         fXa5K8l/sE/IOzz4vc3ChPWMK/+bLkWM/MW3j5woNyzGBShocvuGfoveaSG3XTiaE33P
         FPCQ==
X-Gm-Message-State: AOJu0YxgRzxx3RuIZGmtc7ZF02c0NBKagGOe3vOkxWh8vY9FI0tewErA
        76ENMl12NBYUYB3ZnBnJyz6vz/XprEpfw7YLR7udoQUWbGjjCSoLvfxF9Mvwvl1f6h5VDvu/jbF
        /RHOwmRgOMfuIHlVBlppDoHaAa9GSy2GvnPKKUHiEy1L8M5J5/exojib1EwJtDCu+BDhHwLvxSe
        zh
X-Google-Smtp-Source: AGHT+IEwCI43seHP/Ve/jmoJn3PbJWF7o1UQflxR9Mzg5k8fmWFpPrk6oShNC2o14BFF6oW5CWxXmQ==
X-Received: by 2002:a05:620a:9041:b0:77a:69a1:b6a3 with SMTP id rl1-20020a05620a904100b0077a69a1b6a3mr3487516qkn.1.1699062000251;
        Fri, 03 Nov 2023 18:40:00 -0700 (PDT)
Received: from debian.localdomain (c-73-177-243-39.hsd1.va.comcast.net. [73.177.243.39])
        by smtp.gmail.com with ESMTPSA id l17-20020a05620a28d100b007770d47c621sm1216955qkp.66.2023.11.03.18.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 18:39:59 -0700 (PDT)
From:   Paul Otto <potto@vt.edu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Paul Otto <potto@ieee.org>
Subject: [PATCH BlueZ 5/7] update doc for bluetoothctl-player.rst
Date:   Fri,  3 Nov 2023 21:38:48 -0400
Message-Id: <20231104013850.24182-6-potto@vt.edu>
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
 client/bluetoothctl-player.rst | 200 +++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)
 create mode 100644 client/bluetoothctl-player.rst

diff --git a/client/bluetoothctl-player.rst b/client/bluetoothctl-player.rst
new file mode 100644
index 000000000..96960c45b
--- /dev/null
+++ b/client/bluetoothctl-player.rst
@@ -0,0 +1,200 @@
+===================
+bluetoothctl-player
+===================   
+
+--------------------
+Media Player Submenu
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
+Media Player Commands
+=====================
+   We divide bluetoothctl into main menu commands and submenu commands. The submenu commands control options 
+   numbers for the commands can be hex (0x0F) or decimal (10)
+   
+list
+----
+List available players
+
+:Usage: **# list**
+
+show
+----
+Show player information
+
+:Usage: **# show [player]**
+
+select
+------
+Select default player
+
+:Usage: **# select <player>**
+
+play
+----
+Start playback
+
+:Usage: **# play [item]**
+
+pause
+-----
+Pause playback
+
+:Usage: **# pause**
+
+stop
+----
+Stop playback
+
+:Usage: **# stop**
+
+next
+----
+Jump to next item
+
+:Usage: **# next**
+
+previous
+--------
+Jump to previous item
+
+:Usage: **# previous**
+
+fast-forward
+------------
+Fast forward playback
+
+:Usage: **# fast-forward**
+
+rewind
+------
+Rewind playback
+
+:Usage: **# rewind**
+
+equalizer
+---------
+Enable/Disable equalizer
+
+:Usage: **# equalizer <on/off>**
+
+repeat
+------
+Set repeat mode
+
+:Usage: **# repeat <singletrack/alltrack/group/off>**
+
+shuffle
+-------
+Set shuffle mode
+
+:Usage: **# shuffle <alltracks/group/off>**
+
+scan
+----
+Set scan mode
+
+:Usage: **# scan <alltracks/group/off>**
+
+change-folder
+-------------
+Change current folder
+
+:Usage: **# change-folder <item>**
+
+list-items
+----------
+List items of current folder
+
+:Usage: **# list-items [start] [end]**
+
+search
+------
+Search items containing string
+
+:Usage: **# search <string>**
+
+queue
+-----
+Add item to playlist queue
+
+:Usage: **# queue <item>**
+
+show-item
+---------
+Show item information
+
+:Usage: **# show-item <item>**
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

