Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3CEC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 11:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCKLPo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Mar 2023 06:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjCKLPK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Mar 2023 06:15:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4261CA1FD
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 03:14:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id k10so30636053edk.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 03:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfgCmRHhyuo5ShiG6WferUkA8idmPyC77QHmmLyRsDA=;
        b=Ai+YLS2y4PGHC/9uJ4BYXqU5tqHi1DFst28xlaZKWWk9gVF3EsLVrdL0yWig3YEsEi
         gnXeHIs3lmu0ACB//f1T0iLrRF8wPLkXBAnIFeExpOIJk9VaIMaYY8CvoHCS+8XGfrt4
         pWgDo7akzGrq9lBaPKCziSeN3YuM6vHTc7MJyDymuOK6hNCvTC/oE2zIartOpjjoQ4YH
         0xU4yzxssXi+MKm1fODdikQ7QG4RhDRP/Pw8TpTZFwZxM2/FuGv+JOfajSbPAUKTB5T7
         16knGigsXQVyzxrjTtuDqUe0m7Wj2NDqNVGOrVSdkocENqWx9qk4betrEFkRoIfeSSBC
         3vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfgCmRHhyuo5ShiG6WferUkA8idmPyC77QHmmLyRsDA=;
        b=b9on+YT7D4nHfkqro4WAvkZiU0m1ECFfHEEI87WPzY4Ww4dog+R23xYWekBXTqKAvX
         qFvXJJzozL0bThukJDLN5hGFZEbgqHWPGMBsuC+Et7n2KzdfeI7GUWaUoBbyGuvgrMq3
         2wGTXZytWFq4o3ZjfvK5RDfG0/hllVpWd6X7ae2N/voBw+Amk4GBPloIHi+VRVs8zYZs
         DZjz1wcnnQD+bsAnI1obTvakA4MD++PP5WwX9TTpgoJLzlqd4+EAgkz0vXF+5BsR6OFa
         AwznEeEDg4lM5hOhDfyQnj+YDNkq9+C9suo3xiDbyoAmpAwWOg5CjqWBcIRNH1CTzIge
         53Mw==
X-Gm-Message-State: AO0yUKXWfN7zZ3Ai1Nr8h5rRu9YyspQIr6cQN+5nLE/B8VOOQkdep3EM
        NwE1CwcoCkKySFkGmasg7iAbew==
X-Google-Smtp-Source: AK7set8PoInSY9NcKc9iYDRrupBgkkVpQ/KTRtw7UUXM703e5cPSAELCnEraa7b6ZjIBERltsVtOIA==
X-Received: by 2002:a17:906:948f:b0:8f6:c7cc:92ad with SMTP id t15-20020a170906948f00b008f6c7cc92admr30328442ejx.43.1678533246400;
        Sat, 11 Mar 2023 03:14:06 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id q12-20020a50c34c000000b004bf2d58201fsm1053859edb.35.2023.03.11.03.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:14:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] Bluetooth: hci_qca: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:13:53 +0100
Message-Id: <20230311111354.251316-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
References: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/bluetooth/hci_qca.c:1869:37: error: ‘qca_soc_data_wcn6750’ defined but not used [-Werror=unused-const-variable=]
  drivers/bluetooth/hci_qca.c:1853:37: error: ‘qca_soc_data_wcn3998’ defined but not used [-Werror=unused-const-variable=]
  drivers/bluetooth/hci_qca.c:1841:37: error: ‘qca_soc_data_wcn3991’ defined but not used [-Werror=unused-const-variable=]
  drivers/bluetooth/hci_qca.c:1830:37: error: ‘qca_soc_data_wcn3990’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 3df8c3606e93..a199ed52d76d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1827,7 +1827,7 @@ static const struct hci_uart_proto qca_proto = {
 	.dequeue	= qca_dequeue,
 };
 
-static const struct qca_device_data qca_soc_data_wcn3990 = {
+static const struct qca_device_data qca_soc_data_wcn3990 __maybe_unused = {
 	.soc_type = QCA_WCN3990,
 	.vregs = (struct qca_vreg []) {
 		{ "vddio", 15000  },
@@ -1838,7 +1838,7 @@ static const struct qca_device_data qca_soc_data_wcn3990 = {
 	.num_vregs = 4,
 };
 
-static const struct qca_device_data qca_soc_data_wcn3991 = {
+static const struct qca_device_data qca_soc_data_wcn3991 __maybe_unused = {
 	.soc_type = QCA_WCN3991,
 	.vregs = (struct qca_vreg []) {
 		{ "vddio", 15000  },
@@ -1850,7 +1850,7 @@ static const struct qca_device_data qca_soc_data_wcn3991 = {
 	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
-static const struct qca_device_data qca_soc_data_wcn3998 = {
+static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
 	.soc_type = QCA_WCN3998,
 	.vregs = (struct qca_vreg []) {
 		{ "vddio", 10000  },
@@ -1861,12 +1861,12 @@ static const struct qca_device_data qca_soc_data_wcn3998 = {
 	.num_vregs = 4,
 };
 
-static const struct qca_device_data qca_soc_data_qca6390 = {
+static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
 	.soc_type = QCA_QCA6390,
 	.num_vregs = 0,
 };
 
-static const struct qca_device_data qca_soc_data_wcn6750 = {
+static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
 	.soc_type = QCA_WCN6750,
 	.vregs = (struct qca_vreg []) {
 		{ "vddio", 5000 },
-- 
2.34.1

