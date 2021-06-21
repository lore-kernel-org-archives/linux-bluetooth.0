Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB085C4743C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 22:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E9061352
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 22:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhFUWeJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhFUWeE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 18:34:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC03C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 15:31:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j2so32748016lfg.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 15:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QHx4lPVuLgrkbYf8vHia5iLzhseB4SWEXJbfsdqWkv8=;
        b=TU2PbbIf7czYnoGY2jhObwIuRV669cWODpa4obBiKhfbq+paEHe2fDx2tBXoZgmMuu
         isGcF8UFk50IbKCENjFiRFImY/cJ/sj2EqAgJbyjBD8JRs95N/KOn866SynmbnBWaYq6
         Ssos/lcKbUBntpLuCFSyikx6gvGjjqq5xx/Bmr1eNPs8CQwpisQkgSagxODUeJGa8gDW
         56Idk1jWqOmAgu93x/e/SDVGezVpMyUIROCJOn8jazqIDfmqs4um27iLdcPwoH59wcTi
         tRosi115cReiQ4P3j7Xg9i//rJxWVh+RRuwDztOud/SaG692S/pdrjXeEv6JTY9Pm/Ob
         p0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QHx4lPVuLgrkbYf8vHia5iLzhseB4SWEXJbfsdqWkv8=;
        b=GLAOFVx3NcIjFcXZVPUOqJmBw/CHSYlHg32EljbBg076FAHzsmPdVqqrLnzyZGCfpc
         xvwxXnWQFEhD9bAmFyXqLQZQQN7I82Q018GkmxQqOMc6mCDcVIxjgHw48+9viQoxY8xV
         EPGhFYOlXaCVwZXmT9dbdrpchc/RYK3xjt4fS37fXX02yIUahJTXJNrFspalfxrVNIy6
         noY104xxI4gsjCy2O1vm6B3+gPS9EEHa4C0tXq7g9F//SbnLk71XqBBMFH1vJBGjNje5
         hFSSR/aOTOoWAe5wKfu7a9/d2DdIONSRM2b5sjzCCh7OOHYld3I5bB7YgeJpmRYRuTBM
         vGsA==
X-Gm-Message-State: AOAM532xQyeePDVfnrIeY6Wj1AWpr7aYwa0T1ktcEsnsMruVZeNZs8U4
        QsBrTKznx/ODVl+k96uQSiwzNg==
X-Google-Smtp-Source: ABdhPJxnA3LhLY66TfvahxeoPfG2LD8ALEpGrQB5AxrwAtExTQuaM7dYLOWAT1jp624hkIeoUqMYmg==
X-Received: by 2002:ac2:4d81:: with SMTP id g1mr381309lfe.319.1624314705927;
        Mon, 21 Jun 2021 15:31:45 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b10sm2516025ljf.72.2021.06.21.15.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:31:45 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/7] regulator: qca6390: add support for QCA639x powerup sequence
Date:   Tue, 22 Jun 2021 01:31:36 +0300
Message-Id: <20210621223141.1638189-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
References: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Qualcomm QCA6390/1 is a family of WiFi + Bluetooth SoCs, with BT part
being controlled through the UART and WiFi being present on PCIe
bus. Both blocks share common power sources. Add device driver handling
power sequencing of QCA6390/1.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/regulator/Kconfig        |  13 +++
 drivers/regulator/Makefile       |   1 +
 drivers/regulator/qcom-qca639x.c | 157 +++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/regulator/qcom-qca639x.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 3e7a38525cb3..7a560cddea7a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -909,6 +909,19 @@ config REGULATOR_PWM
 	  This driver supports PWM controlled voltage regulators. PWM
 	  duty cycle can increase or decrease the voltage.
 
+config REGULATOR_QCOM_QCA639X
+	tristate "Qualcomm QCA639x WiFi/Bluetooth module support"
+	help
+	  If you say yes to this option, support will be included for Qualcomm
+	  QCA639x family of WiFi and Bluetooth SoCs. Note, this driver supports
+	  only power control for this SoC, you still have to enable individual
+	  Bluetooth and WiFi drivers. This driver is only necessary on ARM
+	  platforms with this chip. PCIe cards handle power sequencing on their
+	  own.
+
+	  Say M here if you want to include support for QCA639x chips as a
+	  module. This will build a module called "qcom-qca639x".
+
 config REGULATOR_QCOM_RPM
 	tristate "Qualcomm RPM regulator driver"
 	depends on MFD_QCOM_RPM
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 580b015296ea..129c2110b78d 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_MTK_DVFSRC) += mtk-dvfsrc-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_LABIBB) += qcom-labibb-regulator.o
+obj-$(CONFIG_REGULATOR_QCOM_QCA639X) += qcom-qca639x.o
 obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_SMD_RPM) += qcom_smd-regulator.o
diff --git a/drivers/regulator/qcom-qca639x.c b/drivers/regulator/qcom-qca639x.c
new file mode 100644
index 000000000000..a2c78c0f8baa
--- /dev/null
+++ b/drivers/regulator/qcom-qca639x.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Linaro Limited
+ */
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/slab.h>
+
+#define MAX_NUM_REGULATORS	8
+
+static struct vreg {
+	const char *name;
+	unsigned int load_uA;
+} vregs[MAX_NUM_REGULATORS] = {
+	/* 2.0 V */
+	{ "vddpcie2", 15000 },
+	{ "vddrfa3", 400000 },
+
+	/* 0.95 V */
+	{ "vddaon", 100000 },
+	{ "vddpmu", 1250000 },
+	{ "vddrfa1", 200000 },
+
+	/* 1.35 V */
+	{ "vddrfa2", 400000 },
+	{ "vddpcie1", 35000 },
+
+	/* 1.8 V */
+	{ "vddio", 20000 },
+};
+
+struct qca6390_data {
+	struct device *dev;
+	struct regulator_bulk_data regulators[MAX_NUM_REGULATORS];
+	size_t num_vregs;
+
+	struct regulator_desc desc;
+	struct regulator_dev *regulator_dev;
+	unsigned int enable_counter;
+};
+
+#define domain_to_data(domain) container_of(domain, struct qca6390_data, pd)
+
+static int qca6390_enable(struct regulator_dev *rdev)
+{
+	struct qca6390_data *data = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = regulator_bulk_enable(data->num_vregs, data->regulators);
+	if (ret) {
+		dev_err(data->dev, "Failed to enable regulators");
+		return ret;
+	}
+
+	/* Wait for 1ms before toggling enable pins. */
+	usleep_range(1000, 2000);
+
+	data->enable_counter++;
+
+	return 0;
+}
+
+static int qca6390_disable(struct regulator_dev *rdev)
+{
+	struct qca6390_data *data = rdev_get_drvdata(rdev);
+
+	regulator_bulk_disable(data->num_vregs, data->regulators);
+
+	data->enable_counter--;
+
+	return 0;
+}
+
+static int qca6390_is_enabled(struct regulator_dev *rdev)
+{
+	struct qca6390_data *data = rdev_get_drvdata(rdev);
+
+	return data->enable_counter > 0;
+}
+
+static const struct regulator_ops qca6390_ops = {
+	.enable = qca6390_enable,
+	.disable = qca6390_disable,
+	.is_enabled = qca6390_is_enabled,
+};
+
+static int qca6390_probe(struct platform_device *pdev)
+{
+	struct qca6390_data *data;
+	struct device *dev = &pdev->dev;
+	struct regulator_config cfg = { };
+	int i, ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+	data->num_vregs = ARRAY_SIZE(vregs);
+
+	for (i = 0; i < data->num_vregs; i++)
+		data->regulators[i].supply = vregs[i].name;
+
+	ret = devm_regulator_bulk_get(dev, data->num_vregs, data->regulators);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < data->num_vregs; i++) {
+		ret = regulator_set_load(data->regulators[i].consumer, vregs[i].load_uA);
+		if (ret)
+			return ret;
+	}
+
+	data->desc.name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
+	if (!data->desc.name)
+		return -ENOMEM;
+
+	data->desc.type = REGULATOR_VOLTAGE;
+	data->desc.owner = THIS_MODULE;
+	data->desc.ops = &qca6390_ops;
+
+	cfg.dev = dev;
+	cfg.of_node = dev->of_node;
+	cfg.driver_data = data;
+	cfg.init_data = of_get_regulator_init_data(dev, dev->of_node, &data->desc);
+
+	data->regulator_dev = devm_regulator_register(dev, &data->desc, &cfg);
+	if (IS_ERR(data->regulator_dev)) {
+		ret = PTR_ERR(data->regulator_dev);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static const struct of_device_id qca6390_of_match[] = {
+	{ .compatible = "qcom,qca6390" },
+};
+
+static struct platform_driver qca6390_driver = {
+	.probe = qca6390_probe,
+	.driver = {
+		.name = "qca6390",
+		.of_match_table = qca6390_of_match,
+	},
+};
+
+module_platform_driver(qca6390_driver);
+MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
+MODULE_DESCRIPTION("Power control for Qualcomm QCA6390/1 BT/WiFi chip");
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

