Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78537AA83
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218720; cv=none; b=jcFckuKZdoAFDto27nfzfxUC8MGf0DGXeMMjp6ZO+NeM7FFrTbbc94T7st4w2BZuq7kxAgQJJNpt01HTZFQOZ5m3RMN50OeZrDJzR1DI2x4Mo0e7D0OzkydbKAn9gsnjHXPbvvA/5KS4szNvF9OAjwG4Jgtt87nsp841NTMgjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218720; c=relaxed/simple;
	bh=OvZGQdRrKQ1cKCtBZ2vJJlctMXShVHIPX/EnnD1FRmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNmb1aeByCCZOMlRff1lqTer3JOXjsF4iokS+10TYjkbwmygjRs4PtWvNtB/iaZYVvmira6WTTqkc/+ITnAaqXm4ULxKEX3Ya8i4hUr1E4EHw9h3b21Rb+CAKYhbW/IOL7TgchVcwomfY2KbOdXx9n0AcOyhVXQkT+we8Ekln8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CnSn1BRp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cee2PhCU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CnSn1BRp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cee2PhCU"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJcJ03042949
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rBvoXcE6fyfh67dFVJmu8Fy0oBNY0thH0kUQWM4o/d4=; b=CnSn1BRpTHnJbFGf
	+T/6tewwxH6wTIdT0lXcjtg3atp9yuC5+r1BGMEx/6ME8clCZqHN5QYZY29MyPRV
	vjlbCxinuqm/0qULVrWZt7GEfSOr5TGDUFPLIgPEq3x+wPwJ/vvFoC9s2MTLjTa2
	n7Xkzy4O8QTcG0fYsJGuuxylsYuPutVCSEdlPlRUhHIuAB2DPnTr1GlbTYSaDXI7
	3NfO/kFdk/q7jZTftR/lKDXGmMHcx5UQb0Neym0uUucX3JvFftGrEOaShPJxc5ub
	3vb06u/V/pAEh+j0BF1E7neqB1N6Bre5F7nSOnCYaDFShH5CtThMyq5xm+mu6/Ju
	nJZp8w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetcf2c4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c21c01cf3so67929601cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218710; x=1784823510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rBvoXcE6fyfh67dFVJmu8Fy0oBNY0thH0kUQWM4o/d4=;
        b=Cee2PhCUpNC0qgL6vCWKsvZ4mBjxWOLNy9vb/OpnJjTaRP6eigmrGuojT57dOrN0Tz
         2tdvQkTAsM8UMeGr5j+7UGxfxmWpDYnDOevs0UHACK01hrnRnfona3/yklqUTjHhf+cb
         Q8HdS3aj9u3eJCv8LxDQtwnMg2gL7IWbiMeLFYY/mUTbHXjzpH/cy5ejpzNsiEjOMN5N
         5ixqNSMw+FopT/Q3p3QkP888d5hDJ3ri/USWWFr5/vg56ZTQd7yDkd5sU/PVxIBBIwk9
         WiDjIHe680FMHkWcyshAY0X6TX8R6wR1XeHgrz89Xxmw335K2yBtdSShOxi4ZhmEoKY1
         aCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218710; x=1784823510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBvoXcE6fyfh67dFVJmu8Fy0oBNY0thH0kUQWM4o/d4=;
        b=pG7nLft+Vigf1A55JqXEyDFHilI8kNzHweapA6FsjSGHBv+k6CGhni6faO0T8G5rth
         E30cMl2qEYn/og6CAmgMj/NWPIUDuNfGmqY7C7IKIYmrt9NazSN6eiU06V3kyOvPgBXQ
         FOmLgXfrceqylM4EpB1amZeAl5/B5eHS36/bT8PUgLApwx4jZszFKm0a6Cmj1Qn3TCGg
         JQZ9h/XA4LDnr3YuiIAOraG+CY7wClD2z5J6tnjSb+A/WIYvcnzmH3L/TIEDiUA3CRwP
         XNi62evQKReO/sZ9xjqki2UjVHEVcSWNfSBhXABrRVytONgcqzmbkWVoVNKhNW6B9zx0
         jjZw==
X-Forwarded-Encrypted: i=1; AHgh+RpqyeJt35w8JGuM8+SwY5Sl89eaAJPhHOL/yWn6Gjou11Icp5NXphK2yX3t3tFho3AdnTpH6vtRFLWFnnjz+M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZ0fSztYCgGDCnkJXbLlGEj6/tlI+icq2EUQ6GdDzaIX/Za4x
	L3SJ7Gu3uVciTYiss4jPwLDkAXcmw+ZhjTc4dp5nODHYHZ7QscJaF2j5GwvUOwRi3HyLtbm7ATk
	BDAIDcj3ihHdzjRWxYpbF88DDGdDxTxjpJ+J9y8HRyDVzEGF9xX8ZEmfn8p9Cy0x6CK3sJvI=
X-Gm-Gg: AfdE7cnceIcAugp8CsKnSxM46gNaG8P57ovCJuFfZN/2lLGAifFI5nBlWkrlsgO0g8P
	kh9Y5ULxvJt52VaOb7c9RyxMNDwsbzuy3kgoxGTUpJyq92vwpx1nnAYxvZN8uIFXD45TaASlX6Q
	JjIEmkkrpWuMxlIcFG2ObX6nJxq2Rh+QpYhuSq8nncGXKUUFS9YXx/RGP+M/o3iBOt0L9+QlXgl
	V8X3FEdNkhIeW5+hmnq0QUukXNbQsIUvXVurdAdC/ru/RddrolzVc6Ls4T7rg6aVSXAQMW3H/Xz
	+7ndPpLf7yzIc/L42jduGCB0Tc1eGPBc0OVz112EVz7RVsu679B/3PxMPT/7XXP1QuZcFHI9LfV
	EZRqWAq7FqlWZyROCK25lFwxBQ+gi1vWprf93ALlWNNNSrG0GAF+JUvYpnG9PuWkE6FsCaqe/FX
	paBAEUu9YxsawTJr3K+NiBmDVry2BPhpzYuxycgZZFWmMKOqGnD+k=
X-Received: by 2002:a05:622a:112:b0:51b:f40b:2fac with SMTP id d75a77b69052e-520be692394mr2841351cf.50.1784218709887;
        Thu, 16 Jul 2026 09:18:29 -0700 (PDT)
X-Received: by 2002:a05:622a:112:b0:51b:f40b:2fac with SMTP id d75a77b69052e-520be692394mr2840331cf.50.1784218708837;
        Thu, 16 Jul 2026 09:18:28 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:27 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:20 +0200
Subject: [PATCH v4 03/11] power: sequencing: Add pwrseq_is_controllable()
 API
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-3-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: cXYz08YNoVq1TwEchb-hnkg4pY0B6fgF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX9GYLWhCwMHaX
 BWZZzJmSTJkkZDDhVQd+kCiKUH1zxSNfGT/M0NJJ+wmeqFrSrfvLnfuIdTJGoI2XFo4387PPrbb
 n8fGFPf8hRYCvM5TBRPP5TeNEmhqQaujb8UI3zxT0xuxnyXUxFqqPvIPukVzdROJRGmWLzB0t/j
 1XgyyHwfdX9fBqmMA13A92NrJi70mp74T39XJLVBqLwSyDn/Lvj22NSt5qfJRuvn+7symH22yYS
 IbWj1QLL2+kwFwl2mB594Qam7B/j1flzjxYbDDEzTuXT15gmLlzy9Xd4Zx4TBrkJyE4Iz0jf2Zv
 C0mMBYz+MX9cCN30ESqfbbApIrKIwBL4/wSByl5gKk71pk+DUDzNNtWg8xVr559wr9CNy6SEKNd
 quB8D/3tmN34yUuanQDGeS2vSNayU65Sd44bGgPFVKDL/CSNY5f+R/77y45NJVdWSwJXNMvdDJL
 G15E6Bz+ye4Ag1D5OGA==
X-Authority-Analysis: v=2.4 cv=f8R4wuyM c=1 sm=1 tr=0 ts=6a590456 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=4a-8Ivk512-2hps7UIkA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: cXYz08YNoVq1TwEchb-hnkg4pY0B6fgF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX8H7ipJdWxYRn
 FUzJI0paLDDm3A6OS05tOs67tKsNF9+AV+JZc6Hcq42v7cMzuSrtkSzGT6+3/ckBuWvXfIC/9k6
 IxD+Ama++WdYKqj3l2Rpvgr0VQN9LPo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160166

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

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 49 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pwrseq/consumer.h |  7 ++++++
 include/linux/pwrseq/provider.h |  8 +++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 02f42da915985339d3de507fc36dd158b0035a99..cabb3d0885f94d9d70e0631861ed6905d91ad3bc 100644
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
index 3c907c9e1885dc2958043a9a733fbe20bdf95f6e..f70f694c19ab73f70ccf775aa24902bfcc982a42 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -25,6 +25,8 @@ int pwrseq_power_off(struct pwrseq_desc *desc);
 
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

