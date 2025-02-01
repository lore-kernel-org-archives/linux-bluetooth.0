Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86AB1C3C1D;
	Sat,  1 Feb 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738427078; cv=none; b=KaqLRQy6ckk1UiD9kZOJX4+wanrn8Jc0It/6TmLR4UQpN03PiVGBlTObWQuWXee1OEISDn8g/F6Qj7gf14FCxubTzz5NyCyov7dqYvo8F7KycBdsKLfDIBALRCb6VYjDFDQVTa0KOFLmqCkpHdt41/wFiT1gfYtb4tgAbs+fcFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738427078; c=relaxed/simple;
	bh=c/Gnr8zTuYCxXBcOoa/O/fFahhv9XBlXvIZzf9L+ol4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=okJy2ArqOrCIOTDFDzS4rpM6QhX+aXiYMBcA7IaALbwozAPAYgks243TGdJdgWITlnLyG5XXv5zfUnNgsFSPd04CdyiBAq1IpdwMiwtMxdrjUFhajyjHH0d+3NcVokrlYWdOg+Z0G2WOOkcr7FVppUc8dgq/qSnfezay946GKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZEUfKNK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZEUfKNK"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53f22fd6832so3304525e87.1;
        Sat, 01 Feb 2025 08:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738427075; x=1739031875; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfa6xROmzpdH/yGe/fiT3u8Q/60K2pSupbPaueCZuSg=;
        b=GZEUfKNKF+Hmv6evA+oom9Eq2r0o0/baWjQY5Y46Gb/srLrTjSgER7+SPvGlq8G1O8
         kdkzb9qUvHh6WqNPIQyn8VXfo11Qk1BwPXiivLzLoburl2RFh6EkFK/Gh3T1hynYGPne
         pBunhf/qJuYIVnPYdJDj0HJ99gvlqhfpoZjIxv4bi+D6Kf3QAQdyXrxpqCQwcpHZogxx
         HPjNy6B2EIjpL65opWOS2l6AP1rS9g5QH+FgD+nGLT/DNAspNMalY58CyjbOiwjflo89
         IeMYGEg2XLrKB05Z+IgrVZfXVLzQq7wytwdNkv+94D00M+tDAmWlShhZkrPpYbdRvuXp
         7fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738427075; x=1739031875;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfa6xROmzpdH/yGe/fiT3u8Q/60K2pSupbPaueCZuSg=;
        b=Z6F9r8Sveb6aPIz/vO9tqRFpv43PfHyDEekKjKDZVzOCLBliIWdk5OdsAWBCNZVySR
         PjgqNVkzweOWlZMuGb0L5ML+RSMD+C+iaXiUuCMgCtKAkoTu03c+iByN2S6nLIUHP7rr
         ouyvIzvDawE4vve7Xz1AgnX33f96lrgS19LDJ8NDlAp4lsbfyors7mJZCE0/Xc+0ExlR
         VXSbztmpapxxZpyfpFqTaELimqXIVlKWPP1ew+ieLTPap9ohPfdFH2JAwYDMQQ63NYDI
         uTPRtkGd49CuWNKJ00Wy6vR/wloOBPLyBohZIhJK8hw/TRF8KK0ksQ8XTB27YfqVN8f7
         34Yw==
X-Forwarded-Encrypted: i=1; AJvYcCX+b8FRINLsv/MiQLy2sc8qafGRl7iZhxv3saqeXMYDC6rpD6eio4i7a2gwWBeIAQXftw83fmM1QPJDxuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJduuflqrBy9K4RrUYmH7I6sVNuh5P9wg5e/UkCJPxf1/Mt6jr
	Zq4E6pXlCaZYgAr3u6LEbbj4YfPeAWqj1v99xuWA8a4Fz3b65q4LGU4L6C8ilWU=
X-Gm-Gg: ASbGncuWba/LDgyAtsKHc0QJ/Y/1527x3Nap7qzuaBqfSDm62D/krImzk/BGlykJHWs
	D5wHNa7EBJwLzieV9f7Y38BMx7gQvlxvbkkvI/7v1UYS+vjto4OF99mr5w57+J4P9KH8ydIOqvB
	Vz1sdi6XtN4eCCpsfTxn3NpWqhxuPukvdlcGJVpuDyzN7NAh6DCbNTumO6bJSXubqqKvLIC5Xds
	pNBf+lfRmiKmctNTr1GL7ja7TIf5bq5C0y9bUjBJcHqKoN6rjwmsQI3bHkSx449N/iIE5O6bRgY
	G5GBDnAFBJzkP0bG1hvT2euZ7guoxIxdxzbM3ApU7KT90dEgWvm0OG3HBJsP
X-Google-Smtp-Source: AGHT+IFr2GmDfYmOCC0JGSyxPP/y8D7nMDrYWY5021IoHz2IQ9dfUQDW6RuYmZ1dAXw3+9jxzGlQaQ==
X-Received: by 2002:a05:6512:114a:b0:542:8d45:cb4f with SMTP id 2adb3069b0e04-543e4bdffbcmr4126486e87.1.1738427074616;
        Sat, 01 Feb 2025 08:24:34 -0800 (PST)
Received: from ?IPV6:2a00:1fa0:26b:ef8c:233a:7c35:f061:a3a5? ([2a00:1fa0:26b:ef8c:233a:7c35:f061:a3a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebe0fef2sm776416e87.75.2025.02.01.08.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 08:24:33 -0800 (PST)
Message-ID: <f5ea6c5c-1904-22a4-72f2-d4050878dd26@gmail.com>
Date: Sat, 1 Feb 2025 19:24:31 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 oxffffaa@gmail.com
From: Arseniy Krasnov <oxffffaa@gmail.com>
Subject: [RESEND PATCH v2] Bluetooth: hci_uart: fix race during initialization
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

'hci_register_dev()' calls power up function, which is executed by
kworker - 'hci_power_on()'. This function does access to bluetooth chip
using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
be executed before setting this bit. In that case HCI init logic fails.

Patch moves setting of 'HCI_UART_PROTO_READY' before calling function
'hci_uart_register_dev()'.

Signed-off-by: Arseniy Krasnov <oxffffaa@gmail.com>
---
 Changelog v1->v2:
 * Move 'set_bit()' before 'hci_uart_register_dev()' instead of
   adding new bit 'HCI_UART_PROTO_INIT'.

 drivers/bluetooth/hci_ldisc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 30192bb083549..07b9aa09bbe2e 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -704,12 +704,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
 	}
 
-	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 	return 0;
 }
 
-- 
2.30.1
