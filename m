Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C84FECE0
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536556; cv=none; b=jdYDWETsbAo9m3TTslzc14XLFY4bxb6/daW+DZXlYH2z7SjONOTgQIsq8zHL24Ez5ReIHgiMWXUbu8LVxY/Kdns5i4DbLNlLO6TzJbI1j9TWOPwmKlerYyzlc7zN6eQJtKgXsRqWqFEaVKe5wA6gSEHX9mM2gkeo7WrewZjijYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536556; c=relaxed/simple;
	bh=EV1IQL++muBemnHDLd4zHB8KbYjgmJunDIYzAh6oWWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sVfCCrxU5BF0RcGb7TC1GaDxxy7WWcfAyzBzOcLQhJPJ/1gYjuuOFQ8ooUcPGp8vgVEDNAHUKn1ZHJ2IneeEybmkHxVAiR8jW1Jl5BHYDGiuX3IQ2u0mgkuioI9lVfIfAFD9jPIR8VivP413yy6YsC99h7mu0VAeqK/D6yievsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lyPrPgco; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WwzqHixX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lyPrPgco";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WwzqHixX"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684DhWq63720640
	for <linux-bluetooth@vger.kernel.org>; Fri, 4 Sep 2026 15:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UrNjtqPRiinyny6O8iHF+XsMQr2twrQF5BAL+YJEb04=; b=lyPrPgcoMx6wkJ6J
	96FvB+YbEic6pHI+WXpBScG7OBlwSwg5gl+oE+glnYMaR8d/OH9HEtqgAgP96RS0
	1eAz2CcKr+ua/ZxoNvO5wRVWTIy/8FF/BdSO4HXJR6c9GO03Hq7nWlf4n9DIbQSV
	30T7pmJ7eczFgBKakAAHBdDXJJV6VWNOJfLJvbYGhLTiq1h2pVeHssn8C0CRR+mN
	rmzzDY3ZI9Or+tp5Ugp+wJQLxtG7KZ/uNOVia60BPu9pbuoDYComHudSoFZ9Vvsq
	jJXAKSV93XeBASePLJ8tJyMIzjs0G7ziceWU6pnFvJ3N7fO7T4fGJ92Y4ebtmpe0
	i4NVJw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd2p19-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 15:42:26 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97c176d45a2so136720241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536546; x=1789141346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrNjtqPRiinyny6O8iHF+XsMQr2twrQF5BAL+YJEb04=;
        b=WwzqHixXR35YYDJqO5BwtcM/SmyGs3fZz6gtRHEzULi6XjwyHZ2eDkL7UskRNHbdYx
         z+50BVyuvsWwq0GdvlPxUf/RnVevpa3FjtBpB7zkN/aehiiyqk7+u+D8hErh5cEI+eM+
         qffrxJmgWsCq8hIZXQgk+U2DHGrCs8YTB29d9rGzk0qyEEvOOEpRcu7UterEIcGLvv8t
         7IPiWZRIkKen9wN95lZ42qjy5vVF2h6P0eZjmMTwy68RhTcBRMk2rb/64bUAwCzH8mog
         VbveKjHXD/g4ZKlMZx8PvrTzMzD+o//Ays85QshPW5uTXoBEK98GtvcsmlzavNNhWYMV
         GoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536546; x=1789141346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrNjtqPRiinyny6O8iHF+XsMQr2twrQF5BAL+YJEb04=;
        b=TdVwcpRPMiuxljkOCObRzVU2wFZ2lMKvW+LZw8MiblDgjZt/k0V0l3VRNBhNlTXLOO
         Wv092JLrvX7NcCrqcz4X6Qs0QrziMRG9+dqW7HJPK3pODOkm6ICLSIRNlQ/MDuHLYj/u
         v+ndiqVhH1+pVCtTHiDKVKFs2/l+ya3AhpaffZCjo80aaB+DqH9gnGgvZqYQ7bKqO7US
         uR4pYMYbay73fbp9jYtdnxeViVwEBaYUvzQzGuCKOlP9oNAjz6gVDOZNPvY2tXX72xsd
         fQWTFKsK+ggQJX3H9Ra8eqiw14nz8m+AAr13NGjNQsaqs3/omaVtdPCAKGruHT+kHtDd
         c/dQ==
X-Forwarded-Encrypted: i=1; AKwUvBxACvwd8dvxIAHShb0rabLDSksAzJwj+phgxVdgkVLyWoq+N2ddOtoWCjl0yBFv7lFkePAfraEpNdOR7hPfuQg=@vger.kernel.org
X-Gm-Message-State: AFuF++mb4Rj6sPzPa4mf/8tcF74L1gkfZeS/myuSbBiHucGzZRQBbZ/+
	s9UfoFlXhqKXSKqc9NSvHgkrcpsMcP4E6Kj4oh2X2yo79K5XzcBkF5wwGzuPaefWX9Qfz/iSipB
	xuKMP06eFaqXkW3gB/hjHcBYYCbIae8nhl++Q2KhTIXQuFfFqqxFQrUIapnxMMtkFqLESYVI=
X-Gm-Gg: AYBFou1Hkpw8vD4Rdmqe7n+SqfeB2wfnIGHArk1RH340Ch0+O1mKISaaPhyhch+7i3t
	sfYoPrgcM2lL1u5cATD1Pl0R9VxMe9beOIHn9dTluPt8gwvzShxnd7aZIp4KE/C58dNMxeHIPIx
	1qSWgA70X9FXSDUSKQmCUcJlwj3OuU13E27WXrEZ3iHskl0rMlrAUbW6uWjt4zS9YDzbv2Jks9i
	x60w2+3j+TkmMmZXClbHXRL2KyFYvJ81A+oj+uVu5LfxxN69fHiNdWR+tcpweMp95mlLaeEkG2O
	MdUc8Ry1TgdnmKc34TPZOs87ETvutVCsYIkHu5KNUIShgpzaat/unDefegnmL2oTmW16mWRq8NS
	oT+qqdQyTiH21C/KkeF6rTv9sARqRa8sRWZNEDCVFffDw2ZNk0BfUB6IRMZxceOhmy6iYh1egxV
	XMoJUCRmBNIsHmtMGQ/AegH9OLvMmj569pUisA0banEjMQa+D43N0=
X-Received: by 2002:a05:6102:943:b0:782:de7b:eead with SMTP id ada2fe7eead31-78a4a68089bmr2121554137.1.1788536545777;
        Fri, 04 Sep 2026 08:42:25 -0700 (PDT)
X-Received: by 2002:a05:6102:943:b0:782:de7b:eead with SMTP id ada2fe7eead31-78a4a68089bmr2121526137.1.1788536545349;
        Fri, 04 Sep 2026 08:42:25 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:24 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:18 +0200
Subject: [PATCH v6 03/11] power: sequencing: Add pwrseq_is_controllable()
 API
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-3-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: vm9PpBs_Hq7PptXD3deW3-ZCdsuP-QuX
X-Proofpoint-ORIG-GUID: vm9PpBs_Hq7PptXD3deW3-ZCdsuP-QuX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfXxSfQcx8Y2IEG
 6Y28Tx/a7IH6vVy8ryaYQZQRUI2Fdt4qBJCGxrsVxUYB7SXWqV7W+/ltf2iRoTgr5acEp3kV8Cq
 KIp4304ZDnWH0B3vBFhAmLs71E1bKkM=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9ae6e2 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4a-8Ivk512-2hps7UIkA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX6bkX67Aq/aOd
 nUFUNrMX+9cgkExtHVwsLPJSFemk9jdhrB7MhwRLjfg+g3f6145ShxH2voamN73upm0S1qwu7HV
 ulYmKnM8bc4hT7cfA7ajqw5P0hbs+FN6PuBue4Sa1N71miJTWWmqbICgym6PJZUUhcP8rlZLxC2
 Jx8hp/dQPYTJWwulmz/kvD2PO86tRDAuYzcDnl2spUpxNhR/WFXH99ljfwPdo+0b1i5A0jAU+lE
 /TdCaMpT7Ay3oKtgXbznAe3S8pGWLNdE3RCukq98J2b7B7tR8LX1sKqavQJwHzyfeVPJz8ouXvu
 kohHgvp7LH79sM9F1V83mIXCe2Q+qrB6HN8RIiTWBa7scgOFr74YLxIRCP5hX7c1GJpFKTLGCGA
 4VHowY0gJxfWzJthTwTQ7zXaOmca2bhMfXcpZQHOQK6ZM3vmIvbCmGsGI3jyFNjdCawKF0U1iJi
 vA1t5RPF3YTseRzoorg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040143

On some boards a power sequencing target has no host-controllable enable
for its function, for instance when the enable line is not wired up to a
GPIO and is hardwired to an always-on level. The pcie-m2 "uart" target is
one such example: when the M.2 connector does not route the W_DISABLE2#
signal to a host GPIO, its enable/disable are no-ops and the consumer
cannot gate the Bluetooth function at all or exclusively.

Add a generic pwrseq_is_controllable() helper. It reports whether the
target's final unit provides a host-controllable dedicated power actuator.
The target can implement a new optional is_controllable() callback,
reporting whether that actuator is effective on this target (for example
depending on GPIO presence). If the target does not provide the callback,
it is assumed to be controllable.

Note this only describes the target's own enable actuator. It does not
imply that a power-off reaches an electrical OFF state, since a target may
have multiple consumers. It also does not mean that power is uncontrolled
for the target's dependencies: those may still be gated on their own. And
it does not restrict consumers from calling pwrseq_power_off() either,
which remains valid to drop this consumer's vote on the (possibly shared)
resources and dependencies of the target.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 49 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pwrseq/consumer.h |  7 ++++++
 include/linux/pwrseq/provider.h |  8 +++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 721e888b658d1f254513e126bb72f2d0487a8383..88a507deedda30c2d94ac1ce95151cc300e3a77e 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -182,12 +182,15 @@ static void pwrseq_unit_release(struct kref *ref)
  *               the state lock has been released. It's useful for implementing
  *               boot-up delays without blocking other users from powering up
  *               using the same power sequencer.
+ * @is_controllable: Optional callback reporting whether enabling/disabling
+ *                   this target actually controls power.
  */
 struct pwrseq_target {
 	struct list_head list;
 	const char *name;
 	struct pwrseq_unit *unit;
 	pwrseq_power_state_func post_enable;
+	pwrseq_is_controllable_func is_controllable;
 };
 
 static struct pwrseq_target *
@@ -206,6 +209,7 @@ pwrseq_target_new(const struct pwrseq_target_data *data)
 	}
 
 	target->post_enable = data->post_enable;
+	target->is_controllable = data->is_controllable;
 
 	return target;
 }
@@ -991,6 +995,51 @@ struct device *pwrseq_to_device(struct pwrseq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(pwrseq_to_device);
 
+/**
+ * pwrseq_is_controllable() - Check whether the target provides a
+ *                            host-controllable power actuator.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * Some power sequencing targets provide no host-controllable enable for their
+ * function on a given board, for instance when the enable line is not wired up
+ * and is instead hardwired to an always-on level. For such targets a call to
+ * pwrseq_power_off() is still allowed, so that the consumer can drop its vote
+ * on the (possibly shared) resources, but the host cannot gate the function
+ * on its own.
+ *
+ * Returns:
+ * True if the target provides a host-controllable power actuator, false
+ * otherwise. Also returns false if @desc is NULL.
+ */
+bool pwrseq_is_controllable(struct pwrseq_desc *desc)
+{
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_target *target;
+	struct pwrseq_unit *unit;
+
+	might_sleep();
+
+	if (!desc)
+		return false;
+
+	pwrseq = desc->pwrseq;
+	target = desc->target;
+	unit = target->unit;
+
+	guard(rwsem_read)(&pwrseq->rw_lock);
+	if (!device_is_registered(&pwrseq->dev))
+		return false;
+
+	if (!unit->enable && !unit->disable)
+		return false;
+
+	if (!target->is_controllable)
+		return true;
+
+	return target->is_controllable(pwrseq);
+}
+EXPORT_SYMBOL_GPL(pwrseq_is_controllable);
+
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
 struct pwrseq_debugfs_count_ctx {
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 16fad5f3e3ab563110598f733e4a6c10a7b13f2d..b69117ad3fa72aa46ea1f6adc0d4ea3bdd1cf695 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -25,6 +25,8 @@ int pwrseq_disable(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
+bool pwrseq_is_controllable(struct pwrseq_desc *desc);
+
 #else /* CONFIG_POWER_SEQUENCING */
 
 static inline struct pwrseq_desc * __must_check
@@ -58,6 +60,11 @@ static inline struct device *pwrseq_to_device(struct pwrseq_desc *desc)
 	return NULL;
 }
 
+static inline bool pwrseq_is_controllable(struct pwrseq_desc *desc)
+{
+	return false;
+}
+
 #endif /* CONFIG_POWER_SEQUENCING */
 
 #endif /* __POWER_SEQUENCING_CONSUMER_H__ */
diff --git a/include/linux/pwrseq/provider.h b/include/linux/pwrseq/provider.h
index 33b3d2c2e39decafac6c6fca9254ad4329d90e94..7285ad94a2214070a1c27f25c783f51105705b36 100644
--- a/include/linux/pwrseq/provider.h
+++ b/include/linux/pwrseq/provider.h
@@ -6,12 +6,15 @@
 #ifndef __POWER_SEQUENCING_PROVIDER_H__
 #define __POWER_SEQUENCING_PROVIDER_H__
 
+#include <linux/types.h>
+
 struct device;
 struct module;
 struct pwrseq_device;
 
 typedef int (*pwrseq_power_state_func)(struct pwrseq_device *);
 typedef int (*pwrseq_match_func)(struct pwrseq_device *, struct device *);
+typedef bool (*pwrseq_is_controllable_func)(struct pwrseq_device *);
 
 #define PWRSEQ_NO_MATCH 0
 #define PWRSEQ_MATCH_OK 1
@@ -43,11 +46,16 @@ struct pwrseq_unit_data {
  *               the state lock has been released. It's useful for implementing
  *               boot-up delays without blocking other users from powering up
  *               using the same power sequencer.
+ * @is_controllable: Optional callback checking whether enabling/disabling this
+ *                   target actually controls power (for example when the
+ *                   controlling GPIO is wired up). If not provided, the
+ *                   target's power is assumed to be always controllable.
  */
 struct pwrseq_target_data {
 	const char *name;
 	const struct pwrseq_unit_data *unit;
 	pwrseq_power_state_func post_enable;
+	pwrseq_is_controllable_func is_controllable;
 };
 
 /**

-- 
2.34.1

