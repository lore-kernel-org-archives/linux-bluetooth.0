Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A2C2F1FED
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652321; cv=none; b=V3WZumbUPW1TMp7HxdsH8RoRhRNTVYLDNbr455+3treYvwe/8jm2MqdUMsXUEgecXuwyxcBoIOl8vp6z8YNZyEss/dWsbkZk7Koh97odQt0YVV8I1UeMGPo1+bLJ0HdzoL024/r95TE2DMhqih/TU1oQ9hl7Tl3OdS7esm+g/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652321; c=relaxed/simple;
	bh=z8HDAkzFMZNpn6hBMimOcVP/mBpHX5xa0QTAjXUTTFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKFG8Eddp3wYCzmtiBcuWWJYQV48/ZN/2YAoc5eaBcUIbzr0IpG8JCsYk5w8xqWgIIhP7GSXOH5DUEZvsWVMpPpg4+J0ffSJ0kTY5MqpP6wgl+bFHvm65h/6nfz9IvwD7aCLrdICCtOFv6jmALFhyo+H4OuWybpMmEQ0EHv74lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZMeiu98r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZUkqoUU/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZMeiu98r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZUkqoUU/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6724afT1991180
	for <linux-bluetooth@vger.kernel.org>; Sun, 2 Aug 2026 06:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AR43rgTt7HZmR4NtGqpPU+uXAcmy6WuqTrXhfWgS5r8=; b=ZMeiu98rgszUZHnU
	790+LsI4lV1Fgk9bScfz1iIxOVcA3UC7LWiUQ3bloMXzwJZf657os90VyaRxisXx
	xA7nS0sxgPAI/HvnJUqproBnRiD6WO7AGZqa6i+6k0GK2I29d7K/eLWhTwZWw3bl
	MJpB+462j9AqYcefgJ1HlQKZzUZxCWh7zFFuYzX3xwkjCgKAjHoH3kagk5XmtTlL
	0TdZip0QphroKLoHhLB95W6RRch2SIAVu6iqYUe2bt3m1gn8Rm6Gyi91+CXxV3TP
	fehdEQehaptEMB9ZzTREubI8ORRM9LQGr04+x69JEdwNPxsxsCcLAwOcmVf7BK+d
	u4HqaQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8tx2deg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 06:31:59 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a67ed83a6so603608b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 23:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785652318; x=1786257118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AR43rgTt7HZmR4NtGqpPU+uXAcmy6WuqTrXhfWgS5r8=;
        b=ZUkqoUU/98czuY7aWQEI8nBueSw1EjybUjtKGhBVuOaFMTk+IrhPpJZ1phYvMY217q
         6v2A2rXO7XYJKqS2F/1oHH22suxcOBbaNsolQAflPBIH6hae184j354Ke3NbKYk2gGRq
         vMiNo+p4sjLxs+mxhz4B1P8zlE9mxAIDTLIR4/NgC1noWzgUTE8FAMDiEPaHPMD0qjlX
         7OD/tehH/in38QVXKp0I9GjSTZLyT5klXak5WzO1P/oPGFwQ/wEmQqBVQywHWqdsIiYf
         ZITwsUw8TCiu5EwEd3wmmvwQwvB95XimSLJVjd+9ujcRfsG9Vhl7H4y8hWjcYM0Zw3Yb
         DNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785652318; x=1786257118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AR43rgTt7HZmR4NtGqpPU+uXAcmy6WuqTrXhfWgS5r8=;
        b=nX+BQru8yO32BGgdfnShc29knrBWxtpzawP+wVU+DvM6M2nUSWnQJa5T6yC6cZUEj+
         AGiAb1qDuqTX2yLdZGcylfpt5XdkpcoxMmKc7EiEiiMfaQ8LU3Ns7BFAECNebzQ218rO
         BB+2a+h/iwSoJPyq0bs+aIFMRSVD3HoWSKEdAdIAuWTy4853oGmBarmXqrZlyvR98YrR
         1w9qoT/6DIHE743Z/ooqRBxQAbFRz/1bQ0IOWZS6sf7huHKqrsCQiM64JcN9anhcW/8R
         jdKg081yFaxP+c5LPmqIyv9xfLBL17wlz57GL7W9ZJS7Mz53PppGBXs2mXdLDrojan/x
         9vtw==
X-Forwarded-Encrypted: i=1; AHgh+RqTydqGs8SvXfxRwB8NMdUqwEGVWmVNcGd2QPsG1Tl6+TslTC3bkuLaVXZAeHLnkHe6WXakk1Zh2bd6xOnlOn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08ttySPrWaY8Gzd9oxmEPO6QY5XeXAJo8Yyj3vtK7c4adojBR
	Q9y2sG1rhR5HD5z9Sfkpas7z1kdlmhaQyGN/JIzaDrusCQBNngw4MQMUPRGlzQIaXdmlOUDElTC
	k2lib+KMLMGQ3E92+z/hliGPy4/4m5gQCrboTeqjQkp3TvxpOveDqwRWM444UMAy32UdynYU=
X-Gm-Gg: AR+sD102QipWaB6+ir+hrHzhJUgxxTrGsj4msq29vSNYvzSmJpz/UN8azSGmyfSicLM
	U0WbLt4I5jUhoWKuFxKAQgCR/i9iFUyMLIeofAW81/9xNwyVCG85mzVgHXzuY9n6FoRd0qTE15N
	TTavb9FdPQacL5s2C3hTJZYOqiIMtuWxT65qFztLA43YjHq17gKtDivkbuGtEww2hpYAjEFyMTC
	kgDd4QzkzajglZWp718nJTjO7lWGMPFDhp4FR6NY1bZykAmN/D/G5NNLmbQJUuuWqD71GQtxJHt
	qr3GVLgqR0DAYWwCo+f9wV9zxU2iQQYZvUpCFQ7MBDAHFIU3e8lXndfg78PVIF+Zmdg/wUKVMd2
	ZxdT9xqarCpXPyCWbuQc7LYi5mC5K3YnmCJOa6RuJUuJvpGk=
X-Received: by 2002:a17:903:1450:b0:2c9:d298:6c0a with SMTP id d9443c01a7336-2d05246fbb8mr85218115ad.2.1785652318153;
        Sat, 01 Aug 2026 23:31:58 -0700 (PDT)
X-Received: by 2002:a17:903:1450:b0:2c9:d298:6c0a with SMTP id d9443c01a7336-2d05246fbb8mr85217845ad.2.1785652317783;
        Sat, 01 Aug 2026 23:31:57 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c93dsm24233304eec.8.2026.08.01.23.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 23:31:57 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 23:31:36 -0700
Subject: [PATCH v3 1/7] Bluetooth: btintel: Fix diagnostics event detection
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-generic_fix-v3-1-efdd8dcf3430@oss.qualcomm.com>
References: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
In-Reply-To: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfX4jX6LITfypPb
 lJdTLcuIzrVYvzylXBf78jN0ACamSfOYUI1kQgPcT7e2NlgSW6rxRiSIiL0l9A57oYD6zYZMdD3
 /dfnX09TIrEehDx2L+Ju/IVlOxJs0NwuXSzphW4FEEmViXe+4BUfnpqNP6+gdUUS9fLn2ogiW/a
 CdKlmwtSIDJEnA/PW665zJwAQye/gtK9UqhGLlEMeI1N3T1KI7REL3m0tpMKNPlZuDXZms0KNwV
 w+BTDvyWoV0/hG24wRBWfDt833K/gP8EIoMeytPQPKXNEeSA5H3BLNsanW1AsnaSNPWi4Ewrf3q
 eDb2K2jlpfyYmR0rMZe9XgEATlMusInVU9x+6NKkzS28i8AHudt6huSbqdSPvynXb59FxnFi7pQ
 7gl/V+fzE1atKHpPDF0p1tfCKFtVyz176wOb9R+BepcZ7T4MeF3Si5YBYZ2EWazkDr4XvrCOcmC
 QLMvWxrvBUl+X7pVfwA==
X-Proofpoint-GUID: _blgjMBP8KI848LecChcuVNVGvuSir0f
X-Authority-Analysis: v=2.4 cv=T9C8ifKQ c=1 sm=1 tr=0 ts=6a6ee45f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=w585p4NK48lv-ZABhGUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfX/ftVC4aa1ICm
 IpPPSgucE58dDl8Fe+EDg0U77dyoeg2mMaBWtPdx5EW/otcXuyrPuUJoNeWvto/5uZlrhd8q4HB
 F/YX2a7EbkqfSuwqy8DfJ+TAtuo4Q2k=
X-Proofpoint-ORIG-GUID: _blgjMBP8KI848LecChcuVNVGvuSir0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020050

For a diagnostics VSE, diagnostics_hdr[] sits at the start of the event
payload, skb->data[2], but btintel_recv_event() wrongly guards its
memcmp with @len, which is measured from skb->data[3] for the earlier
INTEL_BOOTLOADER check.

Fix by using (@len + 1) instead, which ==
(skb->len - HCI_EVENT_HDR_SIZE) exactly.

Fixes: af395330abed ("Bluetooth: btintel: Add Intel devcoredump support")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 770b1fb371c7..d06a335ff1db 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -4016,17 +4016,17 @@ int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 				kfree_skb(skb);
 				return 0;
 			}
 		}
 
 		/* Handle all diagnostics events separately. May still call
 		 * hci_recv_frame.
 		 */
-		if (len >= sizeof(diagnostics_hdr) &&
+		if (len + 1 >= sizeof(diagnostics_hdr) &&
 		    memcmp(&skb->data[2], diagnostics_hdr,
 			   sizeof(diagnostics_hdr)) == 0) {
 			return btintel_diagnostics(hdev, skb);
 		}
 	}
 
 	return hci_recv_frame(hdev, skb);
 }

-- 
2.34.1

