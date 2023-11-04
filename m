Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B40C4167D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Nov 2023 01:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjKDBkD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 21:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKDBkC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 21:40:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79BBD54
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 18:39:59 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77891670417so44077885a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Nov 2023 18:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1699061998; x=1699666798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+XmwslSHI6aiYhUgryxeACv4fY557OUpCRJYsq9njk=;
        b=jeS0w3II8o8DCiZyKieacvsUPXU6t6lcdCLAVeGgtyREWONCbh2wD6ZFHkkaku02Vm
         Chf9X9gKm0w0xne3Pkcjk6YQDn0KggTOM5UAsKkWhtTULJjXVgN/9CJKptL6cAdqRi3O
         y9IEl3Ui378vwgxiDxbDdFu14O01v+zyfmtbn2nADuqTaR1LGSTL5cVmAhakWs22K3Zs
         flvd5nRjPoVuMOK26dTje91VjdzYnIs77R5vmnPNw3kpTu2ohuJtqls6KTpD24ltKoDX
         dplR97Q4IqnO8atQzDadFLZ9XibXtgA8b30aeRn05BbkT7avw0nbqliLefoIK6LRwa0j
         wQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699061998; x=1699666798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+XmwslSHI6aiYhUgryxeACv4fY557OUpCRJYsq9njk=;
        b=Hveeo0KHNzAmj5A+KrZmJ45UNTN9tEHZfwUGRqrfiHbYqCHamBJt/e0fG4oUm5u/YR
         DraxfbXaYsc2WhiLy0IcTXVCeAGKN1P8cZc4HoWUzLhMqUjfRXLpdBmsP+vBPLvzve+4
         JwyrmVGdgpn9bIhC7t2iKOsWN2Htx5rPxbHXRoMQnceD2iOEoaeHa1m6x0hGV+tc6TO0
         +JkcZvd2l28D0jbKOt13hHYz2xKHZgKgBdbdNm5qprEoh6pV+qYyypOppJuYGLeW3VES
         bDzhuYteOl/C/ILEsaFhP1GlUUaJfvzIs4fXyr+XDh3WRMpv+o1J057+KXypq4lqvACH
         aRJw==
X-Gm-Message-State: AOJu0YzB0N+H3WT+51XDe2HvivjZD8sAh77jc6M6eGpQpB3nLuhhmELT
        wmDxsk7gY14RVV8712p1C8+yADgmBi2xhAhQbLXEQhDX06vUlhE0ud2Z6LOCHpmgh4xOoqLGA8g
        wK+FiHm+nKGLDx5+Y05UwjjIq70GM1ik4VpkBr7LNe77J1z+A7u0437716+c9YnNcUkuTbP4BdZ
        gM
X-Google-Smtp-Source: AGHT+IEZM4LabqFnBPLB6zwBu4WRWDSPGbdZjVOQh/eDvSYguFhne1a8uvZ2W3b1D33FV5S0FGIgEg==
X-Received: by 2002:a05:620a:4052:b0:76e:f686:cacb with SMTP id i18-20020a05620a405200b0076ef686cacbmr26722275qko.3.1699061997960;
        Fri, 03 Nov 2023 18:39:57 -0700 (PDT)
Received: from debian.localdomain (c-73-177-243-39.hsd1.va.comcast.net. [73.177.243.39])
        by smtp.gmail.com with ESMTPSA id l17-20020a05620a28d100b007770d47c621sm1216955qkp.66.2023.11.03.18.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 18:39:57 -0700 (PDT)
From:   Paul Otto <potto@vt.edu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Paul Otto <potto@ieee.org>
Subject: [PATCH BlueZ 4/7] update doc for bluetoothctl-gatt.rst
Date:   Fri,  3 Nov 2023 21:38:47 -0400
Message-Id: <20231104013850.24182-5-potto@vt.edu>
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
 client/bluetoothctl-gatt.rst | 212 +++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100644 client/bluetoothctl-gatt.rst

diff --git a/client/bluetoothctl-gatt.rst b/client/bluetoothctl-gatt.rst
new file mode 100644
index 000000000..346e7f388
--- /dev/null
+++ b/client/bluetoothctl-gatt.rst
@@ -0,0 +1,212 @@
+============
+bluetoothctl
+============
+
+-------------------------
+Generic Attribute Submenu
+-------------------------
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
+COMMANDS
+========
+   We divide bluetoothctl into main menu commands and submenu commands. The submenu commands control options 
+   numbers for the commands can be hex (0x0F) or decimal (10)
+   
+
+
+Generic Attribute Commands
+==========================
+
+list-attributes
+---------------
+List attributes
+
+:Usage: **# list-attributes <attribute/UUID>**
+
+select-attribute
+----------------
+Select attribute
+
+:Usage: **# select-attribute <attribute/UUID>**
+
+attribute-info
+--------------
+Select attribute
+
+:Usage: **# attribute-info [attribute/UUID]**
+
+read
+----
+Read attribute value
+
+:Usage: **# read [offset]**
+
+write
+-----
+Write attribute value
+
+:Usage: **# write <data=xx xx ...> [offset] [type]**
+
+acquire-write
+-------------
+Acquire Write file descriptor
+
+:Usage: **# acquire-write**
+
+release-write
+-------------
+Release Write file descriptor
+
+:Usage: **# release-write**
+
+acquire-notify
+--------------
+Acquire Notify file descriptor
+
+:Usage: **# acquire-notify**
+
+release-notify
+--------------
+Release Notify file descriptor
+
+:Usage: **# release-notify**
+
+notify
+------
+Notify attribute value
+
+:Usage: **# notify <on/off>**
+
+clone
+-----
+Clone a device or attribute
+
+:Usage: **# clone [dev/attribute/UUID]**
+
+register-application
+--------------------
+Register profile to connect
+
+:Usage: **# register-application [UUID ...]**
+
+unregister-application
+----------------------
+Unregister profile
+
+:Usage: **# unregister-application**
+
+register-service
+----------------
+Register application service.
+
+:Usage: **# register-service <UUID> [handle]**
+
+unregister-service
+------------------
+Unregister application service
+
+:Usage: **# unregister-service <UUID/object>**
+
+register-includes
+-----------------
+Register as Included service in.
+
+:Usage: **#r egister-includes <UUID> [handle]**
+
+unregister-includes
+-------------------
+Unregister Included service.
+
+:Usage: **# unregister-includes <Service-UUID><Inc-UUID>**
+
+register-characteristic
+-----------------------
+Register application characteristic
+
+:Usage: **# register-characteristic <UUID> <Flags=read,write,notify...> [handle]**
+
+unregister-characteristic
+-------------------------
+Unregister application characteristic
+
+:Usage: **# unregister-characteristic <UUID/object>**
+
+register-descriptor
+-------------------
+Register application descriptor
+
+:Usage: **# register-descriptor <UUID> <Flags=read,write...> [handle]**
+
+unregister-descriptor
+---------------------
+Unregister application descriptor
+
+:Usage: **# unregister-descriptor <UUID/object>**
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

