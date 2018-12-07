Return-Path: <SRS0=S+MC=OQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28413C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Dec 2018 00:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA4320882
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Dec 2018 00:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA4320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.zabtrans.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbeLGAHm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:07:42 -0500
Received: from carat.zabtrans.ru ([195.39.228.131]:39228 "EHLO
        carat.zabtrans.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGAHm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Dec 2018 19:07:42 -0500
Received: from proxy.zrw.oao.rzd (proxy.zabtrans.ru [195.39.228.154]) 
        by carat.zabtrans.ru ASSAMail sm-mta  with ESMTPS id wB707XO5017229
        for <linux-bluetooth@vger.kernel.org>; Fri, 7 Dec 2018 09:07:38 +0900
Received: from [10.123.236.115] ([10.123.236.115]) 
        by proxy.zrw.oao.rzd ASSAMail sm-mta-lst  with ESMTP id wB707W9U023661
        for <linux-bluetooth@vger.kernel.org>; Fri, 7 Dec 2018 09:07:32 +0900
From:   =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Subject: Small help needed, get capability info
Reply-To: ProklovAV@mail.zabtrans.ru
To:     linux-bluetooth@vger.kernel.org
Message-ID: <5C09C806.1060100@mail.zabtrans.ru>
Date:   Fri, 7 Dec 2018 09:08:22 +0800
User-Agent: Microsoft Outlook Express 6.00.2900.5931
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
X-KLMS-Rule-ID: 7
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, 2018/12/06 11:50:32
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.705, bases: 2018/12/06 16:54:00 #9375873; khse: 2014-01-23 rollback
X-KLMS-AntiVirus-Status: Clean, skipped
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Hello All,
I making patch for autopair device if pincode define in main.conf.
I'm not a programmer, and now i am having trouble with read capability info.

After "agent->capability" bluetoothctl crash with segmentation error.
Please help me get capability info.
If i using agent_get_io_capability(agent); for get info, bluetoothctl 
also crash with segmentation error.

My example:
--- ./autopair.c_old	2018-11-30 14:32:55.000000000 +0800
+++ ./plugins/autopair.c	2018-12-05 10:10:59.000000000 +0800
@@ -35,12 +35,14 @@

  #include "src/plugin.h"
  #include "src/adapter.h"
  #include "src/device.h"
  #include "src/log.h"
  #include "src/storage.h"
+#include "src/agent.h"

  /*
   * Plugin to handle automatic pairing of devices with reduced user
@@ -62,6 +64,8 @@
  	char pinstr[7];
  	char name[25];
  	uint32_t class;
+	struct agent *agent;

  	ba2str(device_get_address(device), addr);

@@ -143,7 +147,18 @@
  		}
  		break;
- 	}
-
+	default:
+	/*check capability=NOINPUTNOOUTPUT and use DefaultPin=0000 or from 
main.conf if available*/
+	
+	DBG("capability string %d, agent->capability);
+	
+	/*if (agent->capability == 0x03) {
+	    DBG("capability set to NOINPUTNOOUTPUT use defaultpin");
+		if (attempt > 1)
+			return 0;
+		memcpy(pinbuf, main_opts.defaultpin, 4);
+		return 4;
+	}*/
+	break;
+	}
  	return 0;
  }








---------------------
Best regards,
Aleksandr Proklov
