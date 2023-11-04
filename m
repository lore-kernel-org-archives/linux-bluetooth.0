Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70798C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Nov 2023 01:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjKDBkA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 21:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjKDBj6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 21:39:58 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA1DD73
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 18:39:54 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-671188b2d44so5540516d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Nov 2023 18:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1699061992; x=1699666792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C1F2NzerxolOnMz0Xy0fZHAjq+p3zDVnV17MgfXTxc=;
        b=S+3JrlEZPrio8PJ9ZD8BJsK1kO1eFRxpSUV8oelkP3BdilAMQVcO0EkfN7+xz1E0ki
         IuCAvRq6iD00Bj2yjr7ElIKnpj4Qkxv4+FvaGo4wxvCssJ/zN9edQqIqPjsDq51wYpCD
         8RWK3sYCggDHCdexTv947SBjcK6mkVG4NlU30nCsQHDiFqG3b0qC0xiJfjdeh9OcxQqf
         VsyhBbXgFgH+oWJr+hfqk2l6YtJzgPWYa3sBa14xKvZ1zdTX4Mh52pDQxv0t8Sr9nJg1
         wxuZmZpXDgqngncMaom4pLK/cgG1pGCtt1mjLCwoZoCCOBc+oKmv1r7cIaSCu/ffe+aD
         iG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699061992; x=1699666792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C1F2NzerxolOnMz0Xy0fZHAjq+p3zDVnV17MgfXTxc=;
        b=pz8JMIR6TcU0V8z6C+XRzdl8ANCQLVFjJgGCrM+OPOPWhVDcspCvPsE5A5O/1wuhQd
         OrlwxiX2+4JpRcijgeUyWQVlVP71XS9SjMy1M3sUjfeb2VlauNn1/DAS3oc3gzQ6GEXt
         sdkHjtJ1hQ1Mjglb7S2krnmF7ck06i9/N0MKe+aU0DT0USV2XZyXwlCbMqjbnhtBZ43W
         sx9qmeMgYhFAeIelejIxp3s2FtYROVjmDnHfKhxcZEcBdI9udKzfv3/B98GtPkUx32Ur
         v4wjCZ2l/dplBylRmZMf8zhTakNVhDoyHHlhoG0LY2OI0Cu/5MDD7OvKElLeNmP7vmh8
         E2yw==
X-Gm-Message-State: AOJu0Yy7+GgWBHu/GveBUIF1zBEsI3/snxy0Y6nNaQU3QpmyP3evg8lg
        ebusY+hSDSMrxR/uWZ5KxwO66rgplR1KqUOYmSsIXHj4nO6nYktNaFXTMdUy0GPVzZflXXzoxk3
        VeiJde2AQlNC5M9JJPGszRscjVI4VS4nBtGQ6NjE9LXh4bjPMXhrnIBNme3OrN6GX4lroLUf4oJ
        1E
X-Google-Smtp-Source: AGHT+IGMABOswc9/eu8SYsAPCdh0fe8KUO6XNbZRLJkQ3BeH1o/wh8zo7MNCrKHs/j1wsHd8XyVl9Q==
X-Received: by 2002:a05:620a:19a1:b0:778:8ae9:2247 with SMTP id bm33-20020a05620a19a100b007788ae92247mr28026804qkb.5.1699061992044;
        Fri, 03 Nov 2023 18:39:52 -0700 (PDT)
Received: from debian.localdomain (c-73-177-243-39.hsd1.va.comcast.net. [73.177.243.39])
        by smtp.gmail.com with ESMTPSA id l17-20020a05620a28d100b007770d47c621sm1216955qkp.66.2023.11.03.18.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 18:39:51 -0700 (PDT)
From:   Paul Otto <potto@vt.edu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Paul Otto <potto@ieee.org>
Subject: [PATCH BlueZ 2/7] update doc for bluetoothctl-advertise.rst
Date:   Fri,  3 Nov 2023 21:38:45 -0400
Message-Id: <20231104013850.24182-3-potto@vt.edu>
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
 client/bluetoothctl-advertise.rst | 243 ++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)
 create mode 100644 client/bluetoothctl-advertise.rst

diff --git a/client/bluetoothctl-advertise.rst b/client/bluetoothctl-advertise.rst
new file mode 100644
index 000000000..7b9911158
--- /dev/null
+++ b/client/bluetoothctl-advertise.rst
@@ -0,0 +1,243 @@
+==============================
+bluetoothctl-advertise-options
+==============================
+
+-------------------------
+Advertise Options Submenu
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
+bluetoothctl advertise options submenu can be accessed by the command `menu advertise` in bluetoothctl. If the error "Failed to register advertisement: org.bluez.Error.Failed" is received then check /var/log/syslog for the specific error such as "Advertising data too long or couldn't be generated.". Assuming bluetoothd has the -v option set.
+
+Advertise Options Commands
+==========================
+
+Advertising packets are structured data which is broadcast on the LE Advertising
+channels and available for all devices in range.  Because of the limited space
+available in LE Advertising packets (31 bytes), each packet's contents must be
+carefully controlled.
+
+This is a long form description of the commands that includes examples. Values can either be hexadecimal (0x0C)
+decimal (12) or octal if  a leading zero (07). Footnotes are indicated by {x} and can be found at the bottom of the page.
+
+
+uuids
+-----
+Set/Get advertise uuids
+  The assumed format of the uuid is hex. Therefore uuids 0x1234 identical to uuids 1234.
+  The valid uuids are:
+  - 16 bit uuids - ex: uuids 0x1234
+  - 32 bit uuids - ex: uuids 0x12345678
+  - 128 bit uuids - ex: uuids 90f95193-35de-4306-a6e9-699328f15059
+
+    .. note:: 128 bit uuids must be in the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx where x is a hexadecimal digit and the dashes are included.
+
+:Usage: **# uuids [all/uuid1 uuid2 ...]**
+
+service
+-------
+Set/Get advertise service data
+
+:Usage: **# service [uuid] [data=xx xx ...]**
+
+manufacturer
+------------
+Set/Get advertise manufacturer data
+  updating is in real time while advertising. This is currently limited to 25 bytes and will return an error message of "Too much data"
+  if that maximum has been exceeded. However, this does not check if the advertising payload length maximum has been exceeded so you 
+  may receive an error from bluetoothd that it "Failed to register advertisement" which means you need to reduce your manufacturer data length.
+
+:Usage: **# manufacturer [id] [data=xx xx ...]**
+
+data
+----
+Set/Get advertise data
+  This allows you to advertise data with a given type. You cannot use a registered data type value {1} with 
+  this command. For LE the advertising shows up in the primary advertisements
+  Example: Advertises a nonregistered data type of 0x0C with three octets of data (01 0x0F 13)::
+
+    data 0x0C 01 0x0F 13
+
+  If you set only the type of the data without any data (data 0x0c) this will cause a parse error when turning advertise on.
+  You can only send a maximum of 8 bytes of data. data 0x0c 00 01 02 03 04 05 06 07
+  You can modify the advertising data while it is advertising 
+  To get the currently set data use the command data without any arguments
+  To delete the currently set data you need to...   (clear does not appear to work)
+
+:Usage: **# data [type] [data=xx xx ...]**
+
+discoverable
+------------
+Set/Get advertise discoverable
+  For LE discoverable on will set the LE General Discoverable Mode flag to true in the primary advertisement if on.
+  This feature can be changed during advertising, but will only trigger LE General Discoverable Mode even if you had previously selected 
+  discoverable-timeout this will be ignored.
+  Entering the command by itself will show the status of the setting
+
+:Usage: **# discoverable [on/off]**
+
+discoverable-timeout
+--------------------
+Set/Get advertise discoverable timeout
+  Using this feature in LE will cause the LE Limited Discoverable Mode flag to be set in the primary advertisement and 
+  The LE General Discoverable Mode flag will not be set. The LE Limited Discoverable Mode flag will automatically turn off after [seconds]
+  discoverable [on] must be set to use this feature
+  Entering the command by itself will show the time value
+
+:Usage: **# discoverable-timeout [seconds]**
+
+tx-power
+--------
+Show/Enable/Disable TX power to be advertised
+  This sets the TX Power Level field in the advertising packet. The value is in dBm and can be between -127 and 127.
+  Entering the command by itself will show the current value
+  When this feature is turned on the LE device will advertise its transmit power in the primary advertisement
+  This feature can be modified while advertising.
+  Entering the command by itself will show the status of the setting
+
+:Usage: **# tx-power [on/off] [power]**
+
+name
+----
+Configure local name to be advertised
+  Local name to be used in the advertising report. If the string is too big to fit into the packet it will be truncated.
+  It will either advertise as a complete local name or if it has to be truncated then a shortened local name
+  advertise.name "0123456789abcdef0123456789abcdef"
+  Text: 0123456789abcdef0123456789abc
+  There does not appear to be a way to tell if it is advertising with a complete or shortened local name.
+
+:Usage: **# name [on/off/name]**
+
+appearance
+----------
+Configure custom appearance to be advertised
+
+:Usage: **# appearance [on/off/value]**
+
+duration
+--------
+Set/Get advertise duration
+  The Duration parameter configures the length of an Instance. The value is in seconds.
+  A value of 0 indicates a default value is chosen for the Duration. The default is 2 seconds.
+  If only one advertising Instance has been added, then the Duration value will be ignored.
+  If multiple advertising Instances have been added, then the Duration value will be used to determine the length of time
+  each Instance is advertised for. The Duration value is used to calculate the number of advertising events that will be
+  used to advertise each Instance. The number of advertising events is calculated by dividing the Duration value by the
+  advertising interval. The advertising interval is determined by the advertising parameters that are set for each
+  Instance. The advertising interval is the maximum of the advertising intervals set for each Instance.
+  The Duration value is used to calculate the number of advertising events that will be used to advertise each Instance.
+  The number of advertising events is calculated by dividing the Duration value by the advertising interval. The advertising
+  interval is determined by the advertising parameters that are set for each Instance. The advertising interval is the maximum
+  of the advertising intervals set for each Instance.
+  The Duration value is used to calculate the number of advertising events that will be used to advertise each Instance.
+  The number of advertising events is calculated by dividing the Duration value by the advertising interval. The advertising
+  interval is determined by the advertising parameters that are set for each Instance. The advertising interval is the maximum
+  of the advertising intervals set for each Instance.
+  The Duration value is used to calculate the number of advertising events that will be used to advertise each Instance.
+  The number of advertising events is calculated by dividing the Duration value by the advertising interval. The advertising
+  interval is determined by the advertising parameters that are set for each Instance. The advertising interval is the maximum
+  of the advertising intervals set for each Instance.
+  The Duration value is used to calculate the number of advertising events that will be used to advertise each Instance.
+  The number of advertising events is calculated by dividing the Duration value by the advertising interval. The advertising
+  interval is determined by the advertising parameters that are set for each Instance. The advertising interval is the maximum
+  of the advertising intervals set for each Instance.
+  The Duration value is used to calculate the number of advertising events that will be used to advertise each Instance.
+  The number of advertising events is
+  calculated by dividing the Duration value by the advertising interval. The advertising interval is determined by the
+  advertising parameters that are set for each Instance. The advertising interval is the maximum of the advertising intervals
+  set for each Instance.
+
+:Usage: **# duration [seconds]**
+
+timeout
+-------
+  Set/Get advertise timeout
+
+:Usage: **# timeout [seconds]**
+
+secondary
+---------
+  Set/Get advertise secondary channel
+  The Secondary parameter configures the secondary channel used for advertising.
+
+:Usage: **# secondary [1M/2M/Coded]**        
+
+interval
+--------
+Set/Get advertise interval
+  The Interval parameter configures the advertising interval of an Instance. The value is in milliseconds.
+  A value of 0 indicates a default value is chosen for the Interval. The default is 100 milliseconds.
+  The Interval value is used to calculate the number of advertising events that will be used to advertise each Instance.
+  The number of advertising events is calculated by dividing the Duration value by the advertising interval. The advertising
+  interval is determined by the advertising parameters that are set for each Instance. The advertising interval is the maximum
+  of the advertising intervals set for each Instance.
+
+:Usage: **# interval [milliseconds]**
+
+clear
+-----
+Clear advertise config
+  Clear the advertise configuration. This will stop advertising if it is currently advertising.
+  If you want to change the advertise configuration while advertising you must first clear the advertise configuration
+  and then set the new advertise configuration.
+
+:Usage: **# clear [uuids/service/manufacturer/config-name...]**
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
+NOTES
+=====
+A byte is defined as an octet
+{1}  `Generic Access Profile Assigned Numbers document <https://btprodspecificationrefs.blob.core.windows.net/assigned-numbers/Assigned%20Number%20Types/Generic%20Access%20Profile.pdf>`
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

