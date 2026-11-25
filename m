Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603584;
	b=sop8a8eaRKPlfwSv682ZhdEgofsi3KAotBRWkbYvr2RmLWDaCsmCIybeUR7XAV+mSsfg
	 6Tob6EMkA0Z+gMLeKhc/OHpCsbeN4zmrh1kN6bTgQgGnGowVSNx7QDbHPtsRPEKbCsZ9/
	 LRE1ZzyYWcg/NVhMlIZnK7TMplMj04ntEw3s6Y39uS3gJ3VKDi5bCMQqg+1odUyIkeuaY
	 9KiKMLAp1gcG6Dvv8F+pdYBlUdiqMz9wMRPqqnBScb8TVBmTMZFwgHQMjej8IQPDtM+QS
	 JbkZU08cP6ns7EEAV3WJoqVdLFsn7KM6HUfv7ciPtdCPFMv3d+X5RCXeHgwySMY/M6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603584;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=T2q2CMGoBZM2FU1ay/pNrM74/BS3f4bCyPWFilV8sKc=;
	b=b0SBia6vWmzLd52bNPXgViDgjXW5l3fN7dlBIu1/tJQzfcnShsFu1MM6zGwWa9CoHYwt
	 3FINY6BbNGXTTG5IpFXisu0rL+20UAk37GJs//eo0vpa7eIzkohuUPxZPZ3hPUmnl38ed
	 EIuN44S8thlne/t/816qDRIjheuWY/cTKyYsz5X/RNY8Z8ScV5GHyFa8UOH/JPYrggZvW
	 ce25HHQW31LVKcSAlu3gdhBi7+JkSqmfiOIbPotDiehCpot5mg/sJqL0e8DZdjVDyUR5k
	 WspYpBndmWv4SOfAXgpY7XcD2b3V+nqWaRXT4Pbw9w7xCfn7YX3LUIQs/E/v2pwUl2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F2hdKBud;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i2z1zUPN;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95C606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 10:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E95C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F2hdKBud;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i2z1zUPN
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mO4U2356539
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 10:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=T2q2CMGoBZM
	2FU1ay/pNrM74/BS3f4bCyPWFilV8sKc=; b=F2hdKBudjccg5RPReaB5Ji2lt7v
	jhhz/HHGzeblKAVQFItCQXofe3Gm35CVR1xL2ZsFieoXMWnlifPOkZGk5rAMQK85
	lXjx8W21edxL8ogFmqDIx4fbceXEA1Kc4hkNrp5p6a0pnoG+tj+VQF9Heq7Dmfz4
	LrCAXi5apE6/o4M0uShulkC8UbD6A709FOTUbIvH3PMbgoqKTE5kZ14dGMhuBOH1
	pBzDBOrGd06pXVPUfZB0rM7+zySRXORoGPL2uz3fGly+z7it2fY5fqByjD6Dx5Fn
	efvrlmPvo8/EjxHW/L1Y5NyErq0V9ufXACOu5T/trha9zHiAPSZotbpYARA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5nu6a4hb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 10:46:23 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-313c7315becso488236eec.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 02:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795603583; x=1796208383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T2q2CMGoBZM2FU1ay/pNrM74/BS3f4bCyPWFilV8sKc=;
        b=i2z1zUPNf9MQ2dOiYTXjRHCqq6YoEgzwuQ0k+aT143Hft+gNKrW1h/jP8E43cRcAUQ
         cR5mhRvIolNEjM3KpgM+Z5U3zbKpG1WkBojcxxjgfYXrCfpsX3r8N+lB+DokrYiW6uxj
         QYHzBb1hLprXPC/2k9O7SAmUlW9SUZlvG4NnhNLhxmHbdwMDXfOs0o2C+wOJWNtW8TS1
         7OL5JkoQ16j8LO5FDGdnx89GUd2QeRjcWyiBXoHmbCzsu3iH0F783P8dl/ZVRDYwsmF6
         BAl+UII194f4r8QiSH7lmPC3k6kV2KlfLMUzXpD0iPEKw37aN8AjLi+rK8E1kaKhXRYU
         JYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603583; x=1796208383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T2q2CMGoBZM2FU1ay/pNrM74/BS3f4bCyPWFilV8sKc=;
        b=q2e3hFNa3G8RMx4yMfvEXDj0cLDS/+BRXLQQ9FkjrnN0Eh9B1oCwL8RtR1e7ncdJY6
         MYU7sIrn/1XrqEEROQH91ydrt292j36pz7LP5umFNt/Lf4ofk2mTwAwcnksgiOkLJneb
         5fyoSnQtQC/x/9Cp+VYjwzadp7OFzdyz0C0/XHYtZ69SR+e5bE15aKsSSoJfg9BJiLWB
         dVQQ2Ah8gYUrkCBlbeqNEaf9QHZpxDYG9OQlfDUVJLqIFquNVpUBJASyEGetliHq8DXC
         FlsiyJKAtPSCdFbm60iYgNlSE3s71ScKJVY43rAfN7Fwao21DTaBvPi+D1BhU6Vaspm0
         Q7aA==
X-Gm-Message-State: APuU4Z8/vrPog9+J4EInOuNbJSR7q6ZGpxRPinKYoG/AaZNcFz4Fegp9
	CxNxmR0y92qzy7YaOCDhTRWmCFyfmwjIOE75SwKP0/n5K2fZTsoGT6o1ydOfpFXqy/agAp70UUA
	2xlxS/Z8xwYTMNx4V8YCVB4/qCR/uhjFk43Y3E9NU7tew20dwcvQMO1X+YS4IGx2OVuebWuc=
X-Gm-Gg: AZFdTZdKpZ9T0c7HdRkrngfuRfLaYSYtlNNeqWcAevfTWKqBKtT7xe4Cn+IKtJbeXYt
	7uYq3yDZFtp3KhuvCi+RbMe5A+nJGirrSTfcMwLeka9Hx+mBGU8Q8QEkxDR4LxcNAEwbdP4AZje
	QuwGBs811OuItmCchUK7dcKmYU0CAwJiY5LjgMyhtzS4P2rcuv7ZwW5+F+7PHJwrk5hvsVotaXu
	cMRzM8y0hCag9+9TM8vJJOe8svioqC/RbrrkjMRWtnhezBbeX8tZfre49100bw2cnQhJnHGPgXu
	1ltpMWId9eWKNbLrFp0LnaC1kLsQX25wCTQpn3Mk46d2gQNtzqnw9P5pOwJhJLJBjnNp5ZEZW5C
	wtfR1GbnDhepHAKxlbru3cCe224OvM185w8bey/O7VdZ+KI7XUwXJ8azMrGVSCIlBU9HLVlPRuC
	B8182MJTNwx3DOeFVpgLr1
X-Received: by 2002:a05:7301:1a08:b0:386:a698:6755 with SMTP id 5a478bee46e88-386a69868cbmr17231455eec.0.1795603582691;
        Wed, 25 Nov 2026 02:46:22 -0800 (PST)
X-Received: by 2002:a05:7301:1a08:b0:386:a698:6755 with SMTP id 5a478bee46e88-386a69868cbmr17231430eec.0.1795603582152;
        Wed, 25 Nov 2026 02:46:22 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm49893168eec.16.2026.11.25.02.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:46:21 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH bluez 2/3] tools/test-runner: Support running on arm64 hosts
Date: Wed, 25 Nov 2026 02:46:19 -0800
Message-Id: <20261125104619.3325760-1-zijun.hu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <80cec33b165dc54b1ed6ced34a6016a65ce7d6ad.camel@hadess.net>
References: <80cec33b165dc54b1ed6ced34a6016a65ce7d6ad.camel@hadess.net>
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
X-Proofpoint-ORIG-GUID: G7A2mzBf0r9K32qcNE3rb9J7n4omaiLv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfX5VMu+U9dYSU5
 0hAHD+uElZZcphaDNatBs9omi0Ukl0warKnMpfXFEKu3GXoi+k95wLDPMBEbLPVVWdFf73VesLl
 Cgfgzoz9etZHJgkMQk+HsMf9J2dLwn4=
X-Proofpoint-GUID: G7A2mzBf0r9K32qcNE3rb9J7n4omaiLv
X-Authority-Analysis: v=2.4 cv=Vra2kO2n c=1 sm=1 tr=0 ts=6b06bc7f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Ye1OXo1N41dSujSfXmcA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfX33CvBdFgsRA6
 Pbpn8QhkYN2MlKc9A7gEGUTsHcxGq6iFLl5i4eLIt5BUUd9fAAEf2HEtr/gWeaQNxFmm9CQ/DmJ
 14/YpvJYrMoBl2aDQGXXd3c7obp0xyuZSVo15RdI2bfT1OGlEAvxgudG4ZD4v4acus5NmP0ToFU
 vhlJaAdGB2XPyjhWMBfWJHc1rLmq4n7qp0gjtZPF5ITCYaEtR9h80rFy3Mbvz4qx0Rc/Pm4Gj4G
 drg0bYQ6WgXxCQ9TruYc5MiL4m3b0U4sSJPPDo+B+/SXq3aq4VxGEtyiaK/NFRQ31NujY3hl0cD
 rWSICiogFMzLM4pqNZS/5uAlcjW9nK7ptSHVvO6KlU52EiltGbxVFQHwFPflxF5cip4OVY0QMc2
 Qfp07M8WcAu/yC5l452MN6gdyUJoGn6PQtAcK4in/NjG6VLv3hgY2L9Brnm3rGKldoF+mGWhvIz
 lzErPT6GU1kwQp9i7vA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250042

On Wed, 2026-11-25 at 10:04 +0100, Bastien Nocera wrote:
> Is there anything actually stopping running User Mode Linux on aarch64
> systems?

No, nothing stops it as far as I know. There is no such requirement on
my side, so I did not look into it.

Thanks,
Zijun
