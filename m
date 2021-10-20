Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE33C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 12:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF7B611C6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 12:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJTMNv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:13:51 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54627 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTMNu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 08:13:50 -0400
Received: from [192.168.0.8] ([89.1.56.22]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mbzdn-1nGd3p1brj-00dU5J for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct
 2021 14:11:34 +0200
To:     linux-bluetooth@vger.kernel.org
From:   Bisseling <spam@bisseling.de>
Subject: [PATCH] avoid garbled names and segmentation faults in "hcitool scan"
 command
Message-ID: <c44d5f62-31b3-02f1-49c1-e3fd14a33ae8@bisseling.de>
Date:   Wed, 20 Oct 2021 14:11:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------AA580AB32007041A5C037B6D"
Content-Language: en-US
X-Provags-ID: V03:K1:YZUkJMyUizxgdNHF+RNS577TqluOmDeFFNGBncR8+vmHTyzMlgD
 lvyN8wtkv7z9q1IwWELVqutgHf/TYoDVWjMT8hyeC5bKZyCoXWRstRLRB0lDnTO//2NkDeP
 DZOMSxrt2TQgXAkXKq4Jf8zxJ5luv7rgUNbwUabYj21aU3zG6iOu2oL53Uvg3vkUpL4O0Ne
 7hep7SfMoWHMhexl6gzIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UE1XuWjZYSo=:Kg9nj5p3speyeaANvhEOla
 FMvsLHEWCi3Au+im6jrPb3te2oyE7trTHqL1DtHlsjMFJt8TYMbvMcy114ZKCYuIk0RCXquIc
 z7tMd5IPZyxpownwGzfwLsty6DDi51zEDkOzmWxK0KVYs0uJA99unIQYixylAaEdv1m89kWHZ
 UZYwQFA1r0OiahwqSDAaq25lMz6UkPu8obt7La5Q9BKokOws1TveCfN6Nze2OSNBCrJRENhw4
 LcLrh/2BJHpEJV6x2WSuAJdg8ZiaC0fxr4pruBQ2PPJh6L29Szxf2RZKOU0eWtKFdFTcAOsE/
 ecVNXHo+s2Jig4hsPvxDiUQ0QjQwOnQ33lQ6C2+IFfRKnyiEcfACN6W4KzmSVHEmxNXFPLlxo
 kelyRuufs1ACEzY9IEOc2XFxJto2S+krcnW4xMJc3rjmpo2Bn8lpZZzQ3QWyPI3rS4ZHAVdJe
 g3wZyGpzcrFMrOrhoT+OZaFovpZc5ZbZ1ihpast0yJJXiFTGhrfhtV2iuJPy5mdmvan97uTHp
 HBZSSJyX+Fz/0d4JlQtgaYad6+1SAJGov8sBE9Y6G+fNmqhjSgW3NLhsmKNKOgzta7lumWoyL
 eSVvyg5Q/AWPlMwds9layXaUPID3tiS0r+kNFiGxMlHwEVMlIFl6L05yRh/DU06ytLds2+Y5i
 /XAiHp0D2UE565CglTiuRyGxWDDLTsz5uWv7qCS6rv9oKXsyrzVqq+BREMbd1ZVtxBl7i9U6k
 XVKTs1BjRTmnz3xoKM7tsPn0KKFmxF0cSHxQRw==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a multi-part message in MIME format.
--------------AA580AB32007041A5C037B6D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

diff --git a/tools/hcitool.c b/tools/hcitool.c
index b6f4a4e66..11e2f7841 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -673,8 +673,8 @@ static void cmd_scan(int dev_id, int argc, char **argv)
                                 strcpy(name, "n/a");

                         for (n = 0; n < 248 && name[n]; n++) {
-                               if ((unsigned char) name[i] < 32 ||
name[i] == 127)
-                                       name[i] = '.';
+                               if ((unsigned char) name[n] < 32 ||
name[n] == 127)
+                                       name[n] = '.';
                         }

                         name[248] = '\0';

--------------AA580AB32007041A5C037B6D
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Use-correct-index-variable-when-patching-characters-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Use-correct-index-variable-when-patching-characters-.pa";
 filename*1="tch"

From 9843309ca33dc33d9c9ae989cc9dee19cb5ad219 Mon Sep 17 00:00:00 2001
From: Georg Bisseling <spam@bisseling.de>
Date: Tue, 22 Sep 2020 16:06:02 +0200
Subject: [PATCH] Use correct index variable when patching characters in name

---
 tools/hcitool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index b6f4a4e66..11e2f7841 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -673,8 +673,8 @@ static void cmd_scan(int dev_id, int argc, char **argv)
 				strcpy(name, "n/a");
 
 			for (n = 0; n < 248 && name[n]; n++) {
-				if ((unsigned char) name[i] < 32 || name[i] == 127)
-					name[i] = '.';
+				if ((unsigned char) name[n] < 32 || name[n] == 127)
+					name[n] = '.';
 			}
 
 			name[248] = '\0';
-- 
2.17.1


--------------AA580AB32007041A5C037B6D--
