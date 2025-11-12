Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00C25DAEA
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931524; cv=none; b=sDqGJnYJpXiIpbKxxSkb1n9JCZxx0JH+1b/Qw7by6XkBELT+B5HM6boXCl6yBNk1TItl/q9MYVMokmhW8QlLBGC2/iPHP4l9GPfKhZRn9fApJob+MS1oJcdh0eyHAAcH3WgLfe8iYM9BOgG6APYIo8thfZA+gtiHA8l8GanyZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931524; c=relaxed/simple;
	bh=QNm5as8w03q1nGnq6y4/Xul5+GATbCaXYGCv41u750c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B6aDPKNzqS0eQs6Lmu2+hXxhaQwgr6DJXA5kjdoqqnOjtmfBnj2hoh5h9jieQoq6U2x5T9U6p6lwiDFbb63bvHfIIBWgGH1OimggDL/Ze2NpGNokxV/7vcJrcB8PEaFKCGLIKhxtL7WvOyalYnHGcVJFMATgYNEAaUrySuPq3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EqCO58Lc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fUjJLjik; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EqCO58Lc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fUjJLjik"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC0vnC14007672
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 07:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VYEoLUJo/ySlT5FF5Bj9pc
	H7SQ22bq/f+2ySX8qIxTI=; b=EqCO58LcydOvucTFZE2VAX+sxkdxUEqH7fA127
	M3Ea8cPFY6a8NGyMr92G5TkrIgu0/iLrVTdfDpyZtcSWKWQ1Rgl6EyYp1aHdaIqF
	uGMdo1EIAi67mGqLjuhLNsdSd5oTnqazBLnAaBYVByDQFgrVLFXIASqbx0gK2NyE
	l2F59H5RHn8LByp1IoCLfXAx7kVFVf1w48jfW8UpABKKKpKiTb7wTpqb8PBwh7gA
	83ET4RQZLOmwTz2bIgRAFOSTaDre9B8eS8QkBZ0dtq9YwBQtuhXi2rZS25Z8hv7t
	lT5I65fhu18OoekFtLMhkFFJHXlTcXG6pFMsnPg8KXqeU94g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acg5bgwr2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 07:11:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bc0f8e4b21cso25322a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 23:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762931516; x=1763536316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VYEoLUJo/ySlT5FF5Bj9pcH7SQ22bq/f+2ySX8qIxTI=;
        b=fUjJLjik1yUJv3uhB6xkx6At7Sb1hRJXXdUtFulapDEpEKum88xT2cSVW2plfb+Byj
         vZqUdd1K9aPYWMoC22aaL1fLEolqhCmYgM55t8jLtMXOGn2d1g+8xL+TFJLLyOJu36Sy
         YkwKkQUFbV7R00AEC4N/6gisRTlYDcrEv0PWCROEtcnosRVuybRj53HY5Zm0KdCNcGv7
         0qAERMNwtGk+AuQTwX3FedZM4+qndBjv+SoS1vpjEQtyzEtUTfQ7jDiDVVFGCK76xCdL
         65TKMrgqkzwcnTa3nH9YbKlkih8eyj1Y4U2ImuVEL0QqucKTBRXMTMuCFxabik1H6j8V
         Ahew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931516; x=1763536316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYEoLUJo/ySlT5FF5Bj9pcH7SQ22bq/f+2ySX8qIxTI=;
        b=M7oau7foj5ywi3hkUWIb0wUA9bESomSoCVuBydWcYFTdo9moxHKVYVX3QKVBZhv75D
         VHdx5Ry3seN+2AfHuRaPDtWzM7ZLZqSpJfZ4DWhO8ielws4llsWFeFqt0yirtTKrVFxT
         9U50bGDcPmTBYdfWy+gY9ibkjvPbsXLGbN8eM8N1F7h39G40pUhUe/X8CgGhWyYMV01I
         1IY/4WFVoG+1iWdJUSuR/XWlnvmUU84O4XChrRNKCdvDyKkLcT7M+HD8LwIq6GnuGFv8
         Zty9qvMgNo4IJNg9ZRHPjE0rNiU/Tl1U9rgJe+jLJ8kPfskN+O3MX1hexpBn4M6Ds+yu
         BMBA==
X-Forwarded-Encrypted: i=1; AJvYcCUJKr5Swvg27aqbcuH3neThBPhb1TnfUJDudlqVKUuA1ghVlIYH3w/GGmO6/+uOuoKFnO+WheSifWlxYFQWa5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBQWOLOIvPw27mCdI9vZKqIAe7hc38crTrFV3oM+5g0AZoQHI
	6d/l5Luze+ahNo9Inzb9GzwxcSIXlU0+RhdTdJvUmOm1ErPsKUf3FOwnGgsxb+OwPOW4txpVsOq
	pyhQmMaL5raIkhSTUaRpROLcaO9o8S6FQh50dcR+BxsgVO+Obfhi6qXkem8fKZcn0EBcezrs=
X-Gm-Gg: ASbGncuqZIxjlc/e6IaQmCIsz6KhWmWjuo+2zD68ff9KicJhhS/DNrHfqlcLph59AFL
	CYyumRtSOpFCkVBVCt6tXDRFL9QLi5LDtf7xzBEcdti01LNrm3UoMBainVrdHvHufFJ5ZEoBiTs
	xl4O/FRqWoxFCSKdTnOXgFUJovGW4b+YUS3YAV+5Yozv13KV4dlUBI3QgMV7ZjGQsL6ygxW0Wsh
	mR4G7pe86x4CMCixKye9Mnv+us68pEk7V+ZxGh/vsQDObEbbxW7FCQhfUkaeElJmTMAaiEGSmMB
	RNjvm29D9Qn3yqfYJVxJ9fdeMyJeZKtn6gjt0lpgKoeKQ23OFpUpvh5zAlOFgjL9RwqQOkFf4nU
	ImSGIYkz/P2eBNCz4Q9k1YQ==
X-Received: by 2002:a17:90a:f482:b0:343:e0f6:3770 with SMTP id 98e67ed59e1d1-343e0f63b57mr641746a91.1.1762931516054;
        Tue, 11 Nov 2025 23:11:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6k7LYAcjTwU20hULchBA/1gc516UaI7nND+8Cli7IGNCnIJbqmEzeFagjXs9CcwySY8ED6A==
X-Received: by 2002:a17:90a:f482:b0:343:e0f6:3770 with SMTP id 98e67ed59e1d1-343e0f63b57mr641729a91.1.1762931515562;
        Tue, 11 Nov 2025 23:11:55 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18968e1dsm1748045a12.33.2025.11.11.23.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:11:55 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
Subject: [PATCH v2 0/1] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
Date: Wed, 12 Nov 2025 12:41:46 +0530
Message-Id: <20251112071147.1450258-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6bKLxMG4DWBWbYVi87KbDETKn6ZJdgrm
X-Proofpoint-GUID: 6bKLxMG4DWBWbYVi87KbDETKn6ZJdgrm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA1NiBTYWx0ZWRfX1H4ng3aLa5uW
 XGNOAICpses9L/U0NcFdglR9A9O5PkfykoHfU49an3f+4CEI5xkznEGq5uZO3PSvjO9uiA4RXiH
 gzURJ80KL9rSabnloxakwwbSip2aUTLXvKflqJ4c0uDJCm2NlSdYTMJsjdeVzD+5mncJZFlGeIU
 aO4AOrnSXGJHFpoIhT4EjQiatsUYXYWHCQ++mo4vFIQeqNK2qaQzQM+VvS9iIEe8A+4vny9ARkM
 6TDCJHlVTAr8K6N7nLZq4kMBdDZq1pAI4gdoxHuAAi/9VBSuJzrwG2ML4SRe746HUTCVYTDp5wx
 K7l4Fwghd3+6G5yudMwvkzh0dUbTW3wHkBaLt6jOMlzOjfcDaxXFTEkh2YJ7zXazQZPjAbIZq5z
 3SBHK4hL0BLa3Y1Z29nQDm9vSy9Fsg==
X-Authority-Analysis: v=2.4 cv=YYawJgRf c=1 sm=1 tr=0 ts=6914333d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=NzzfBly6y60KycMFBWoA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120056

Changes for v2
- Update commit message
- Remove qup_uart17 settings
- Remove CC stable
- V1 link
  https://lore.kernel.org/all/20251110055709.319587-1-wei.deng@oss.qualcomm.com/

Wei Deng (1):
  arm64: dts: qcom: lemans-evk: Enable Bluetooth support

 arch/arm64/boot/dts/qcom/lemans-evk.dts | 99 +++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

-- 
2.25.1

