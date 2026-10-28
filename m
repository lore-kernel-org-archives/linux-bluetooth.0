Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195731;
	b=OfNc1FYw5iM2kIonFAE2jn8bhKA2u2JAkij3p8acx2zIYF+mWE8niEaeSgR7pBgSERP/
	 yMhfqiIHQYImyAqC8UdKGr+oTzlQyTkD+ODBFiT7FJVlmBOqxYgCiE4ORRzcjsWJMnAny
	 aNFO0l5ClNhIQnsM0XFdBt1Y5jcgGc9ipZl+yLuFEdQxgsBbUtjTeitnnWpkKuFIWovCr
	 DbKC1Ejzh/B0RlsSOWnpyB4Orn6cIJNT9i09Lx6SF/f+0xvXJimlzmoHNOrSpk5AHdwfz
	 oaf/6lJ2iScDq+CzPRBvaUY/G+FEgzW1ra6TcSonddcFVebJELJb7/xh7Ch1tNqXKrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=obVxC3KbKgBKT9rwhOquCXE+meDlv2iDyi7V8+38jUQ=;
	b=jl+8g63UXgIbQdif5NEaILSMEmblU8mRISWEwOB9+5A883RlOjeagqXHcx+1fGxV/1+0
	 7MavTMN4Dt5PJ0A026HlwjPxLp6pdB39NG+KP+cIiOPeGsRUmVEDa1JnyQNBAogoDhiWL
	 rklHxXfU6ug54fLHyp7biEUyPKEJRThqKM3RtRz/leskUJO9+RnPFo9EbUc+134CiVrUA
	 ecE1998oqUwJbVGnapUJ/p9q7KaNypB0+kJHSmVtJS18+5o318mEskOK64jst1m22kFyW
	 K3HNKE8Zf2BMsajKm1V08xRwnz+JJDbfCusLZI3niqQ1DnDmcOiOYv1tbUzV0oZZ9Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="k8/I/8JX";
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4BF606A31F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F4BF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k8/I/8JX
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso334701e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793195730; x=1793800530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=obVxC3KbKgBKT9rwhOquCXE+meDlv2iDyi7V8+38jUQ=;
        b=k8/I/8JXEfBLdqUbkrrOMb7Jp13gGtY4RK1CezTEbMmB+MEb/7drxDxCa/Q5q1Xex2
         UzuRSB1SOWwg1N+vZNgLiNE5DuplMqeRDy2k/3ai/weMM27VtydkH4jmJdCsFLQjIfqp
         u0A3OJdW6RCA2w6kB5wuO9eKmByHHCRPgjMFgIYxpmDm7EJgwV4Zy8kheqCdGFFm/Mdf
         QMJPTYk7LFBS2UQOCZhNv8TJ0H/eYlAhBTFrnnaacMMNqZV8733QWNY/X0g/YizwSmls
         mDKBDJrCrbSOSIqXC8kqhOERNE/9fbOJRBIwR0vY30nt9nBhOcsGNaOQ7chd8GovfUJd
         NELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793195730; x=1793800530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=obVxC3KbKgBKT9rwhOquCXE+meDlv2iDyi7V8+38jUQ=;
        b=eObrK2dVNowXWENNGeZr6xY5BG/ysogYGnV33zYBMIGiz6vZdlsjwgCCIR6gTOZABY
         yuqVszm9c9mqzOsS6444hdv5K/ej/LguHI8Xo50N/UprsPqJuRihcM4olZtETJYPT4O7
         sme8Jkhm3SDglYe8MrI4mF7OpAAnycj7wjZds6Ui9McRv8EJfs3aN8zKE7VuaVEgEifP
         S/woQL1uqdXqkdwstr2AfiAQl0O+Fb1/zwkGQ+eW1YGmAnCNhaEexhXS0n5RO3zBpS9e
         FV4fj8XOzK0C4S/NumcX8w1MwjzHGVj8QClJrJCUjhaymmrbavEroJobH/T8x5Pe07pm
         Qd2Q==
X-Gm-Message-State: AFq9FYKpZ4a4KecZmE/EkJ+85zqmdPFWuCOND+kt+2hFAsqYUKHwm5ur
	cBzS2AwVqoKcAy0skpr+rJzUc9ImQV8hDb6pszRpHiMr1QXlBPPSzzChHcWMVqztapg=
X-Gm-Gg: AYBFou0VPBrnogaqbRpLglV4dxEFfj32QjPXw+odU7qXNu8HjreruNd0mzO6mpQuVGg
	smdQLjxcJkxQQImo3ncWYs9ou+BQgC1LGIbnLWtpA/2hAe6f+5b/jivOjY0lJHjEEGMVlry5thH
	5gwTxPMmLR5sQJxMmA9oAbLki10AOWGsJ+Mz6SznrYEdF/VETwl6pZQB0fmDXMwnF7ZFuvi9DVL
	aFbpnNHKLSZwQyV5EBLOS5o7LY5vaq/d3wec8o0zyCYWkUTiLtBO5sqJxhik1vtma43J1AlPAx/
	PIo1Dvq1pqGRyBXyudxvOOyuCUABMBG9iiEH9yHtPET1nMFZ145puTz36/M7gGeuBiFOZy9ifRV
	rUuWbxHk4Pa9JjlV/BmmR2akapOcf2hns0GsbSZ6AEv6Wh+toUsUPKk4GtfE5SMIKu1G/dzy5SN
	zB8BDECH1F8beEiQBruxRETxPkwq/2RxMCw5oFGViprn5DxX6eXm/1mpYHyCCD9OUr5qBQtnzXD
	L60f3F1d/JhzEXdAq1tZrYzpiB8piBeJTyaVUqoJ7Yoo0GVnrRvU05zSRHdINU/fv21oldgMIBl
	dMYI+ktwDugKXSmcoeN0GoWh/vjlbgRAB1vg6IallSTtVtLLX9W+d6M3m8ORVf1F+4yM/p7IvcU
	mtpcbJUNGmM/t52XGkyw=
X-Received: by 2002:a05:6122:469b:b0:5ce:ab22:1749 with SMTP id 71dfb90a1353d-5ec4cad0b8cmr1044753e0c.1.1793195730327;
        Wed, 28 Oct 2026 06:55:30 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f99442fsm1809767e0c.15.2026.10.28.06.55.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:55:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] shared/bap: Accept all defined metadata types
Date: Wed, 28 Oct 2026 09:55:17 -0400
Message-ID: <20261028135517.2395290-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028135517.2395290-1-luiz.dentz@gmail.com>
References: <20261028135517.2395290-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bap_metadata_process() rejected every metadata type other than
Preferred/Streaming_Audio_Contexts, Program_Info and Language with
Unsupported Metadata, so valid LTVs such as CCID_List, which the Client
must include for content control, caused Enable and Update Metadata to
fail.

Accept all types defined in Assigned Numbers 6.12.6, and reject
Parental_Rating, Audio_Active_State and Assisted_Listening_Stream as
Invalid Metadata when their value is not 1 octet.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/bap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index d1836afc9ad2..3bdeec2b82e2 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3443,6 +3443,21 @@ static void bap_metadata_process(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 		break;
 	case BT_BAP_META_PROGRAM_INFO:
 	case BT_BAP_META_LANGUAGE:
+	case BT_BAP_META_CCID_LIST:
+	case BT_BAP_META_PROGRAM_INFO_URI:
+	case BT_BAP_META_BCAST_IMMEDIATE:
+	case BT_BAP_META_BROADCAST_NAME:
+	case BT_BAP_META_EXTENDED:
+	case BT_BAP_META_VENDOR:
+		break;
+	case BT_BAP_META_PARENTAL_RATING:
+	case BT_BAP_META_AUDIO_ACTIVE_STATE:
+	case BT_BAP_META_ASSISTED_LISTENING:
+		if (l != sizeof(uint8_t)) {
+			ascs_ase_rsp_add(data->rsp, data->ep->id,
+					BT_ASCS_RSP_METADATA_INVALID, t);
+			data->err = BT_ASCS_RSP_METADATA_INVALID;
+		}
 		break;
 	default:
 		ascs_ase_rsp_add(data->rsp, data->ep->id,
-- 
2.56.0

