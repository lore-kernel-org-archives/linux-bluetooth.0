Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260D34DCF3
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154794; cv=none; b=OIX9KW1ZPU4YsLM012DeNCiOf/9voDBNONfxZWWJMWaBeEWJ9Q5hzaSE9oWd4gBLBQdHSEOcVbDuYSaWav7/MnaWr+kAG4DFkUrTKWsxfUcm94LJKmUEIEdXdEaZZ/5OHBNpu/c0+70V7PSArlEdKMFmRrPiy5cKWOMAiJf48ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154794; c=relaxed/simple;
	bh=vuzh7hgdtKyYtxFJ2XjtOb24ZxicNrnp/UrYxAACeCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCtp7OcT0+qT1Px+Wpp8T9nU92Ay6rfisfgYIHL4E57PfRO/dnyJTs7f0TTzsFsl7fjIQzrVijEX48wtamda1ljokfV+vOAA3uVGqZ4231HK6oJll883eiVkKqJW7r2DV7yFfSGoNR0I7WjKoii9cSWzOZ8n68pPpJUPnE9gv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iOPa3HVu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vrmz4rNK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iOPa3HVu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vrmz4rNK"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52pdF2522792
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2b9XMG+5n0yvwRWMa8laymeJqPNPiDfYxqL7x7M8sX0=; b=iOPa3HVuAN2kUYG1
	k+nFieKgEmeTegcUejqk/km3CTbrcmC8GFBX4lPn4cD6fCN3REjweKcLWpQz95J4
	EYPcMGte9M3V0lFwKjehneYhQoI30AJvLoJI5GmqR4taFFa7dULmw3fipy2xgzjy
	I6YW8tBf/KGyPhDMzpc7MJIy3VzSaS2efO11Ee6Z3xBRTyngjV3iS37/JZoVh8VC
	5n7AdSf8F6smPrp19M1o3xvyiIJPgs4nfFDWxLW1ibrVnWOuQ4Xdw8E2uXA24/QL
	y2RZX/E5oR/+M54iLIurBsuaTPUVy2S+7m0RAOvJWPwfAcKPjz695LY2LtFCgooA
	j/47gw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7w90ep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:39:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398d3a12589so377573a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 22:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788154791; x=1788759591; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2b9XMG+5n0yvwRWMa8laymeJqPNPiDfYxqL7x7M8sX0=;
        b=Vrmz4rNKgA9G7H7m+bMZepJgXtUBMEr4UZlX9erW8rImHiK4bLfORnzuNYFUtLqWlw
         wINDrYTHKQUhbvtq572qjrjfra0lZishr5WXzSqq/KQCh8ts5xoXDxqKjpt8YOlvJlJz
         kCDlT2gF0CXjLgxWspYhPm8yQQbnbUdbLY5Vtdrju7jwTM6uoSTPNDRcdJD+8i6eDWuI
         NB2S5uwnopBcJrhGSmL4DCvwRGYuMc4H+rHFD6gzLQ2D42eVhMGoHrsjJVABRB6f0fp3
         djPc1PuMAbXZ4AhGvGPnaK+c7eYYRUUTg2obAUTwyf1xCrofxyIsVWmxfj33y8wx6siD
         5ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788154791; x=1788759591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2b9XMG+5n0yvwRWMa8laymeJqPNPiDfYxqL7x7M8sX0=;
        b=FgFdJI0J1R0wFB3BWSsIEWPXtKMbKmpBJkhuj9VQ+o3QmDJZop1qKg6D12dJoeZWm5
         92ijV2eRTRv/eWQeN2+UxeTMufVptYzqpYtf5MeNTbPvRNRv4Xr3KFgGH+cxayuUZFVX
         ihW/hGErdTqlG/pMQvQjqA+zke/z+lHQ9cxyfJgnfQW5RJbFJUMPn4P3iIz5CWolTc97
         JEU5lyNXyz7Bdv3BwyqcnY3eb9oltkm/Xb+vOTWlhov9EFzSZ9VbtRKthMY/O8uzBjde
         ukn8rJfPZcWddL+6bEBxfINRbFkV2Ro3CyRaFOQYjZoBzlh/j3AMMsLkeAGdPYUChIiV
         Iyyw==
X-Forwarded-Encrypted: i=1; AKwUvBwQClzL6pZBAOb7swCUeBvIE5Mn8cOFDRUKgluh5jXNxiEOKoEmUTiVvbbRyzSH5BvmVTZVsoaUayquIVhtcRM=@vger.kernel.org
X-Gm-Message-State: AFuF++lttgjO8RMG2wPw8HQZCfhnpddIhcI6jGHiRXY3rpxU+SZxs4Xa
	Z/7CvyDrmLQ7s/L52cio7MlYRDcOZH1zfi1/5W0ibCxhVJ7k95SQXSNzTYDx12bR0KQ/0E0b8Eo
	S2uvDj1t/BnMncTIgBbq+RSV6VwVcChdbaKc/rxofekG6sj7F0wUUnNBzmJ/4ODDMmLGySy8=
X-Gm-Gg: AYBFou33kCiozsKUVCFezILyqUTpIlH+vdgio4HYTHuCtF9H/WSXwBDkyALLdEf27bx
	V8rAa1n8V7DtdGKUeWXb7XDNlLyEuFTtHr+nJasUxwchvZTQGOcY6a5f4I55VYbgnge5i7Scb5M
	8tpQJU7krkTjmt3rkDzalKXQZjPDDp8EYTjgDEWXHzFUkLlm7vIXuZRDVdhui4I8eDXdKGLIFdB
	ze//NbtCFO6B2fNQhTBnkUWlrNiL6zyisDDGnsXLsN0DJo7K2bCyyWqlS+IpaaFjTBPA2eDWGfn
	qr85EgHLcJTs2jURwMGfya7JmfKkq5J5Ri1qn/aGPoH9RsfcJKpQmKmmxib0vMEpbe+Uf+iNwUP
	aIrvTBg9Apk7o7hVKqKridMYFEJf+yT3PiPfs2gg8QbQuK7M=
X-Received: by 2002:a17:90b:5288:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-398babbaa1bmr11399717a91.3.1788154791364;
        Sun, 30 Aug 2026 22:39:51 -0700 (PDT)
X-Received: by 2002:a17:90b:5288:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-398babbaa1bmr11399690a91.3.1788154790945;
        Sun, 30 Aug 2026 22:39:50 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d3fdf6sm25566085c88.6.2026.08.30.22.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:39:50 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 30 Aug 2026 22:39:29 -0700
Subject: [PATCH BlueZ v2 1/3] doc/hci-protocol: Fix missing & on mtu
 argument in BT_RCVMTU example
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-vendor_hci-v2-1-9903760957ab@oss.qualcomm.com>
References: <20260830-vendor_hci-v2-0-9903760957ab@oss.qualcomm.com>
In-Reply-To: <20260830-vendor_hci-v2-0-9903760957ab@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a9513a8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=wa7QpaTpAAAA:8 a=zpTOe8WlNf4vmfFp-y0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0NiBTYWx0ZWRfXwnzZ44luqkCF
 bom9DuZVr67sa3v4omhP7hSbVFsxENi1NulcQVJIM7OFB9d19vjw07Ns1BC3c7ymZ+WB7a/Hjgq
 GF3VDmMyR8bJWS/Ffk9mXfSkWjPkaWw=
X-Proofpoint-ORIG-GUID: oJA7WE3MhE9uUkv9Fyc4yatcAp4tF-ia
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0NiBTYWx0ZWRfX+rg1HHObrQKk
 7YUjw2hKDeOBzA5zKwh2d3t2fkBIaQclIwUwapmn69G7hbZw3mcCdWmKjCEPdvsrvM7etKdBMUt
 SUVlHGgS6mjb5TDlmMW49Ex7poij8tFihiEZWNhIZO0rG7c4CnwlzSB2i8v+3KQM5RMu6y968Or
 vi3hniBHDjvgdls5IwWPTD7Cp9xCWo74n4DODE6OfEf2B+twQPSVQ2ioE2+DN22Lx3pJx2kX/t6
 ALkri4v8Y/a3Rxl8vVlBK+lCFgnbzsNk489oNNcAlp+ZEiYYED67+Ok5CFqM09tWnXg23k3IJhu
 IH368KgUZG9eaV8l6izNl63j7HVTcmm51Mjmi61mO6e+xT7ocrJXrV5GfGRsTuZ3cYYE2cQ2qDR
 vp8BS7EZo3Z+Mu4jQp9X78VkrpDHDXXo5H/aYwZC+POa+fBqx5uIFWYcWfaoMJA4O1kXJWxDaKA
 KQgUwBZJlEHKZB5iphQ==
X-Proofpoint-GUID: oJA7WE3MhE9uUkv9Fyc4yatcAp4tF-ia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310046

getsockopt() requires a pointer argument, but mtu was passed by value.

Fix by using &mtu instead of mtu.

---
Changes since previous version:
- Improve the commit title and message
---
 doc/hci-protocol.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/hci-protocol.rst b/doc/hci-protocol.rst
index f28684655842..db10b35df736 100644
--- a/doc/hci-protocol.rst
+++ b/doc/hci-protocol.rst
@@ -129,17 +129,17 @@ Example:
 
 .. code-block::
 
     uint16_t mtu;
     socklen_t len;
     int err;
 
     len = sizeof(mtu);
-    err = getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, mtu, &len);
+    err = getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, &mtu, &len);
 
 RESOURCES
 =========
 
 http://www.bluez.org
 
 REPORTING BUGS
 ==============

-- 
2.34.1

