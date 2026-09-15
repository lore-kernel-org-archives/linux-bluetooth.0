Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334BB463B89
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463629; cv=none; b=FskySLavkRX+7+gp2WjWI3yk0bpx9LEhdhICbtRM7E1DLAyYW81VJDsBz6lDYfwtZ21wsc4GF7tLgoNhwYADOPWyQ1DhIdC0ZvitvMeFrKYHqRnUT3Saz8lpgpUDgCWRvxZwxtWrMywNl935TwoU+CU1U4czw/pHMdC/M/eYqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463629; c=relaxed/simple;
	bh=LAHB+TdCn+Mq2sZkQXd+KOrPqxDNZYnhIbuOP09gO3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLwAxrFh3htkrgb6B3BNOsc0XJRDlG77Fc6OHV4Jtcy6b4eLwqdUGsSIMSZUd6X11ACIJX60TXFl7qrgHO20SIOMYGff7Yl0B5XTf8jslyzyYR8w7mU0womqyGcbMuX7Xq5Mq2memXRYz4XZCyxJ5GoRoFB+3OhZCdU2hVkoOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HXb4jNXC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OmfS72S8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HXb4jNXC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OmfS72S8"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6ZWTe3316585
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 09:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yK36FUkJqsPnyV4EB9Xdp/mswiMYw5WzkKGITyZqa1o=; b=HXb4jNXCzWiSYPTi
	W71qZ6AqgqTKvZVQZ7FzvekmJZ1k8LJVbYivQ1yNr6sBF9KZ4u+vwYC5EgMInOE3
	V7PFl0umP0aYyxmzZmIHH1vAU3aph7kyPm0zgv32VEY28CNPw+f+6IkKaSx/0zOl
	XLJqJG0SBt3355VdokCEGDbDwgBI4Ivo/9+KGbdEr2UzMYADhr3p08VDVMFGB6Lf
	X6adkUZhvhPrsWDhGC0zWtafgbyLkYXZH+POln5r1Klbx1iYuF1nGTAIEWX/nfX+
	MJFs8+KGnhiGP/C4NOOX78plNQFYYBCc4KfNv7GD0i0cn4td0vYrkUqbcOSrup83
	o4C/IQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux0wva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 09:13:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f005ae3d1so1108311a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789463626; x=1790068426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yK36FUkJqsPnyV4EB9Xdp/mswiMYw5WzkKGITyZqa1o=;
        b=OmfS72S84CWsxdnG+HiBgtC5uFpYVkIe0PUVXV9JuExH+LNIXyVZUOJ71oDThVRPxP
         h5oqTFtdCWW7MVxm4pw8eIHtQYaqZ5q4LOYzkE2jH5vnpJn360HqTO7Ny9mt9rXvCjwY
         tk3hjSYPjj1RVW1Ue2vHw6DbORDXNCVvyKSOCnCW7xkiijC62KPKAuzxDXD+xvLdk3C7
         xtTbwczpuV+Y44Vh/McwIP2IbE1dHOGRbNuOolJm6CrBax8Sb7uCfXKL3BQ+Gn+X05l6
         4lhQJ5M96RmFI+SfKytkJlOIhADOMCVpLD1ujEvbiC+D0XvFRETZFwE0AJBdb3/O+cvf
         rIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789463626; x=1790068426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yK36FUkJqsPnyV4EB9Xdp/mswiMYw5WzkKGITyZqa1o=;
        b=nDctrZigi81oBToCifSO6KICjjmpjJXWJpqmlLLzjX2aSxL+WamDJlxlGDXJLu0E89
         zH8FWTdJS6FlxEa4ceXY/5zgpSHhGJ2J5NyKZooK3ioXz7OdlMLl7VzNyb6K5sw/4XS6
         5dC+aCGQSx6St+crXyYqh0VEHLFcqJwi4aw4XGrrawoP5e9PPJLb/+42wvHH89pzzQhD
         S7o/gB337nZ9iP1dzWXIt/wUf8YcZXKIw4EtqlGq72BWWKWf55l18coVv0WSfCIpk7Fb
         OU8ULjr9k9wspMrohYxLQWOEAxpgJe6Zo9ttooWjDwIo6WcbX2xBjHUJ7ZrZcQmrWzR3
         //3g==
X-Gm-Message-State: AFuF++k+ztM3ZPDTHh4maAlb8f1Q9oxQ1NX+LBmFcGwiUc70/dq3REnh
	yErDWXjYvfAYOBx0f9M/tNLNCCTz/SaAjETOeSkXwzgQTpUlhYIgJKQ3CwlEdlH62X6yaANSb74
	ewlIaFVQU38dpl0o2BLtyT4VkwcRafcnivx7RBHocnqPTKPsU2FL1xd7D4VJkVDRdXIat4SiY0K
	wKeR4=
X-Gm-Gg: AYBFou3/9ygrSbXA2/O0O4AbZh2/uNHRgs8MLMb3GS8bWidfbKCGa75PGRDJRVaHxzn
	tDhVn2j9Y2+kjq1ZHDiLhMb4Sk9e+96c4NsxL9OiF72iI/eYAlPsM8ipnYfJjdhqM8uZwlaZMEs
	CpNs91LvzZ/scxsEp/mXaL7jb3U6CvSGTlW/P9i4EmbMd6vH/e9AAosdRRhdKEy5UJl5RVAi3Sk
	G5aJOvZlHOtqx9lyKm+sitQ1+SCgu7tzrC9Ga9aLtzhILP3/od/9HiVHuB7w+0iUlp19yFgIwsh
	7v94j1FUEm7zjJfCG1Tj9cRirlWnZIOqKm9hbzTUwNFLR90S1qsFy/fZsh211XwBE1wupwfSm/V
	81IscivHSTwcUDmtw+51V5g7Sp33j/WY3aE4j4bKhNOkHcmA=
X-Received: by 2002:a17:90b:2541:b0:390:af7c:fe5e with SMTP id 98e67ed59e1d1-39debfbe500mr8747008a91.2.1789463625698;
        Tue, 15 Sep 2026 02:13:45 -0700 (PDT)
X-Received: by 2002:a17:90b:2541:b0:390:af7c:fe5e with SMTP id 98e67ed59e1d1-39debfbe500mr8746973a91.2.1789463625315;
        Tue, 15 Sep 2026 02:13:45 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14390c0be29sm3493044c88.9.2026.09.15.02.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:13:44 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 02:13:21 -0700
Subject: [PATCH BlueZ 2/2] tools: Fix btmon-logger heap-buffer-overflow
 triggered by HCI devcoredump
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-fix_heap_overflow-v1-2-8fc39dbcb303@oss.qualcomm.com>
References: <20260915-fix_heap_overflow-v1-0-8fc39dbcb303@oss.qualcomm.com>
In-Reply-To: <20260915-fix_heap_overflow-v1-0-8fc39dbcb303@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEzMSBTYWx0ZWRfXws2xCGwu4WJE
 170W0RpekH7ylP/1gciEDaD/K4K3dIEONZ9YKxlOVANAzpzouJJokeQksnRmihWCEkuJtJlMO0R
 U15mRMjV0Np07P8PGWhWoKKp04b1qN8zWmOlMeURgns1yBr8f4VpvGIuX80onJrL5vB4kBwtSv+
 gTfxVFCoe3hJQykmFvqpNp3p+RqZgk0YMzgJzJVs5wZWXyjp0YzUcLO679qLeRPIB7NPL0TnH/i
 NuXdDjT/na4xoCQFhnArMKXZnkboEuxPo1ZZVH/zcSUbpwORZlGZ3jG8eSOYsmSeNhRteMYBYN9
 4SjyeB6Ae+z7ELzs83X26Y5xh5iB45pbB3s9cLWAgMJW+wBbdBlMHidLiGdbLcSIqf1G2cxnllJ
 nLYnW+QONcFVvySE/PG1Ca6mmoBSsUQiqgbtmgnDIVjMeU0RaEUqExoFTmxUiqTP4t5G1FJY98M
 +qYtzjChGOatM7pJBZQ==
X-Proofpoint-ORIG-GUID: 13ZuUZ-wZJMdAc50DImEXs5S16iQNU7B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEzMSBTYWx0ZWRfX3Q0+1NWa6GVT
 RSWV/h3lrzpx2wGd3o9odSxRicRvKHwcNWkIwEgHJQ0XzPnCsyVkcftqYFm3OWje0OphEQ9A+tR
 zzw01t5e8vhtRzID/+OzT1uTaWlja9g=
X-Proofpoint-GUID: 13ZuUZ-wZJMdAc50DImEXs5S16iQNU7B
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa90c4a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=kEP8u9lKm2yaboKPa_EA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150131

Kernel HCI devcoredump can accumulate a large amount of dump data from MANY
packets, then send it as a SINGLE DIAG packet to the monitor channel, so
cause payload length @len in the header exceed BTSNOOP_MAX_PACKET_SIZE, but
btmon-logger uses @len to access the payload in @buf without validating that
@len fits within @buf, causing a heap-buffer-overflow.

Kernel:
include/net/bluetooth/hci_mon.h
struct hci_mon_hdr {
	__le16  opcode;
	__le16  index;
	__le16  len;
} __packed;

BlueZ:
src/shared/btsnoop.h
#define BTSNOOP_MAX_PACKET_SIZE            (1486 + 4)
tools/btmon-logger.c
uint8_t buf[BTSNOOP_MAX_PACKET_SIZE];

Fix by clamping the payload length to the amount of data received before
accessing @buf.
---
 tools/btmon-logger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
index 261d998a6664..b9a81965a464 100644
--- a/tools/btmon-logger.c
+++ b/tools/btmon-logger.c
@@ -94,16 +94,19 @@ static void data_callback(int fd, uint32_t events, void *user_data)
 				tv = &ctv;
 			}
 		}
 
 		opcode = le16_to_cpu(hdr.opcode);
 		index  = le16_to_cpu(hdr.index);
 		pktlen = le16_to_cpu(hdr.len);
 
+		if (pktlen > (len - sizeof(hdr)))
+			pktlen = (len - sizeof(hdr));
+
 		btsnoop_write_hci(btsnoop_file, tv, index, opcode, 0, buf,
 									pktlen);
 	}
 }
 
 static bool open_monitor_channel(void)
 {
 	struct sockaddr_hci addr;

-- 
2.34.1

