Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216882;
	b=cPGQRPDHfkBHvhcpJIOwViGZyo8t1IA2UA5I2F0SbrvIs5KinggOY3qhPJXEXCQn0jsj
	 lhEmeBHFnzNZL4MToDT1tNZTm5xDk7CpSUQBltENyU8mSPlInuj8LdQ/zhNV/kplzk2LB
	 1kggFRs/d9kC5duAuxf9W+XoV21gXsP0eqa66zMxcviI5Evc+hn/HuaTopZ6cAOYBJgZf
	 kUdnXKWVaiL8RQ4Objh4xqNhta05YgiM7qDmn4ly4J8igsSjhigxFC54r9R9ZDHlVZIIV
	 kgHmurbC7ILbPjGrrFb4/O2rwFLe05B+uyUStjPNQZNXECWdpOhAqi5+WwnZiUB+tPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216882;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
	 From:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+vCoXDrbl9ZQk9oPZMP/OoXFcE9OnSqv5FLHNsMJ5TI=;
	b=YCTEqPBs4pGuMvBkPqUKrfmZLZD4DPjyY3mn7JMuHdqS8mEhScChmyizv/CIke6gE/VZ
	 MxfJXlyb2TJei9ZSOb8tm9itHLsx7/xLl1dC5kZwcu1svhtfDpLXwTBKeGMSCm0ycdwc2
	 ALpWpx2LqxiGffmFfdIVVB3ZySiuAObjc2yI2I+TGgpHlQa6eV4fPCGwFGgqwfFWXfShf
	 q777quN1bO2DmXaCV1AcPBTr07KDdl0Gkp2MbOQMBMoZIsMOYkLb/Fx10izNvOf2wkqHl
	 Xkwd/rATiJWcZb8iavoFuEk9E5+/bUI+mjn4Rs+HqPimfnAnq8cNToQCmxnzEeI9SmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H1TiCDKf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TU0XR31p;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B1606A323
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 09:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 575B1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H1TiCDKf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TU0XR31p
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96A5CM3611249
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Nov 2026 09:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+vCoXDrbl9ZQk9oPZMP/OoXFcE9OnSqv5FLHNsMJ5TI=; b=H1TiCDKfP0DEEO3I
	2COpLu7IaC979VpkTKVJudoOvenP3Gja/piKtYMkI/Y/PGqGFOYXfQPdjoGxoAvO
	u74RUI06YUJidaHGWYxmse3r7OotcZRikMQNzMJTh9xSuC/w0q9ytfyVyq/O1YMa
	UyXcaP3rN+eQvFokkDVr9l+qI981dDNVDP9V9+IhZz4MlOvIowDFwCpUZBf7Yx+9
	U1HurG04H3Cxf4ylgEBlvjd3NpkFrkPwmSpaMfNGqFfby1tAy71mt4PPA7L8RXbA
	AdmVbP15iYgQvqAdZICJtXNh0/glTEw1/WsPVJtx5zGqMp4rsAYjTBDwUDB0jjdc
	a1qLKA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hssbnx3nj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 09:34:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-37390b2989bso286414eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 01:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794216880; x=1794821680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+vCoXDrbl9ZQk9oPZMP/OoXFcE9OnSqv5FLHNsMJ5TI=;
        b=TU0XR31p5UyKVQRPDNH3erOLy5aDWsJnQCTHRMZ/SxRZnu0GP7i27x3PpWTgikuwHd
         HC8etOf55MWJFySTPuRte+28yz6xqzKLn35mD2MB3TwJcFbJDPWkLwO0JdltORVpKpCm
         utyTG+svpZpbb02KVvmg+Jqo4sYPTFQwat1iwAuGkj8jVlRdPXg/TH/R/0Tublah9V6W
         BayoaIXEQnm7pUCr96W2zWkoTouS0NESuH1sujAxuevYpSPMo2XcA926BsZCfUOiJmwr
         4FhfzrGiPF5TgjsNQDVvWBVT+aJ2xBVq1LLkfErBf8XmiK1AnBqoboJMmcYDJoBagZwo
         3F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216880; x=1794821680;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+vCoXDrbl9ZQk9oPZMP/OoXFcE9OnSqv5FLHNsMJ5TI=;
        b=F5enHdO1A3mKES1IV8m7NauvZMDzX7FAD4xyNPr6HLQTPHGeTeOxH2QWBJ14mgSFwd
         FvahrNVwEn/KxlXGtF5YbnrNZ/1Mhzbswc1U78l+S4UxsQtfgHnSyl2ofHVeSerLc65j
         ZT36Qgjl9ysjGbf5J0ZDGDjVy91JVPOvDo06ctrTRtPcl2b14XxlOa2YE5VO8ALIh7We
         LiG/FL9/+Sfc/W+ekHpmpZJC4VvdEOAgQ767gSySodHmWNyOFTL41nW7Xm2roXPOlblB
         Aga+8w5PweX4bZXg5eJUoxE7hDs/7BYvzYtjTB+uHZgozC4AXBaOIoQAPhvxyFY2/UBu
         6UtQ==
X-Forwarded-Encrypted: i=1; AL+hErFd6hgN9G7x5PmAZrPk4R+HjnTr1ZjdOFcUykr7yADg2oXmUD44P8rYFyUD+/0dfn1I3fmb9zReAEpSJhCqcHM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kgEw3l5VxXcD6vMHhdJpQQQyhDkdl+Up0PUc7VLWCGYFA1hWV
	8os4t9JP5sV7RwLBdP3tz1wHkMGETrZkSu4hNOdrk2wttzBeFDMRUCP9kglRJFErz6BZ0goRlLV
	wDx4ZssG1rDs/rFpq9xOsKbkV0on7C8kwCEAP4wu9iZFPPdwVSWsTjXdCEj88rSPSnwg+PMM=
X-Gm-Gg: AYBFou0dqPWn9/TMJffqX5prW2vEpW3Bv952jX67NA6M24UF3NGbKa9UbT45Z/7ng5s
	NduElEGzp0CZdAgdDIGugVFhRh4On6OVg6NXmNPIOzyX/D9jCcAXLIRVcDaH7CZrb0t/P2TphjM
	TduhxIefqsuU+664XIcQhpbR7BnqIooEedoY+lC1MPw1Y1opvCcXLEluC5QgnfMU7x3J3jcDYBw
	iERL+d3vSONsGIwIg+4CIcm/U32TTwy1rR0VnmMCWidBAqIzMC4BiGXrb0Md77vKf3uAmP6bX1U
	cxqevSEw+H82P8Pl8bSh6F+Eq6+EBIsoEMUMh4sr3wNaBu0zIRIoktk/JqHG8RtrCV72pXoujKO
	LISaGmMxKHuGNAW5LSnB083pMP2tIDrkwEU+/tlrx5tQTKk0syTlcxqulkCJt/VIKI+P9rpp9FX
	T1VOh4EKjvN5VKE4JK2T/RZg8=
X-Received: by 2002:a05:7301:7a0d:b0:369:fb01:2eb7 with SMTP id 5a478bee46e88-3725d77d84dmr6252914eec.13.1794216879689;
        Mon, 09 Nov 2026 01:34:39 -0800 (PST)
X-Received: by 2002:a05:7301:7a0d:b0:369:fb01:2eb7 with SMTP id 5a478bee46e88-3725d77d84dmr6252889eec.13.1794216879122;
        Mon, 09 Nov 2026 01:34:39 -0800 (PST)
Received: from [10.110.117.197] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372669d48bdsm19071242eec.28.2026.11.09.01.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 01:34:38 -0800 (PST)
Message-ID: <192181e7-5935-4f0c-8d4d-b54218d99a05@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:34:35 +0800
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: obexd/pbap: Update PSE support from PBAP 1.1 to 1.2
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20261104083429.4111632-2-jinwang.li@oss.qualcomm.com>
 <6aeb639e.87c3a088.228e9e.5ddb@mx.google.com>
 <CABBYNZ+6c45s-+_X7s8qE9DXihX5O7xYFTJnJmvnKT-sy96Ksg@mail.gmail.com>
Content-Language: en-US
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: cheng.jiang@oss.qualcomm.com
In-Reply-To: <CABBYNZ+6c45s-+_X7s8qE9DXihX5O7xYFTJnJmvnKT-sy96Ksg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sR47G6gFV84cttUuMDrH3n7Ynq7RY6kP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzOCBTYWx0ZWRfXxGweUzG9AjpF
 YoN4KTC8FqknfS9YIBTQlefNEMXqmzV9FCX5RSzVq2SkiJXbV8bIGM5ZeLuX7GFt9ArIHR6tvKp
 5RzhEmuL9i4QUTwQcQem8RNMT7TD/2Nxb8SCuP6mwvVziLu3DWPlTpy5wUeAjnvOCtBhyEmNoaO
 BDnn5DEcfKYzNtqhS2eHjR5G1W9XyGe7jcZgxiwCjIpcvKwtGMtw0VrJlMW5tEmiHyvyyqvGBCz
 OewrGM6+3Si5rieLOJAk26vit2MYRSjEn/sW0XhBv1MBU641k4Av2zAAPFjz4FZwce5O263expB
 DXS2n9DyYoA1PznZx+cgvEYe5JSPDi4dofYaZMb21i7ad3fzZYG9mtbI9vEuDD8MI9rxiVNFjLj
 k+v32FoDvOZini/2uXDsWU6fMMmYihXrlGYS+LdemCYLjfVZZ9+LNs76Uszycq5HwsdRwR6P/xy
 8T5H68NsBsnoA0E1i1Q==
X-Proofpoint-ORIG-GUID: sR47G6gFV84cttUuMDrH3n7Ynq7RY6kP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzOCBTYWx0ZWRfX29xW6U4NAN1P
 cu1ZLCg/4kMUN7gUcuBaOWPPplYdiORHbXejXruVgKiZFXszVC+s2aAobMfsdMCpMvH2oR1ZwqO
 s8vGDx+FwvZA1VxsDZeJ46fikNLdRAI=
X-Authority-Analysis: v=2.4 cv=JtBkP84C c=1 sm=1 tr=0 ts=6af193b1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=fIdqnI_Px5Tpd_Lh-S8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090038



On 11/5/2026 11:37 PM, Luiz Augusto von Dentz wrote:
> Hi Jinwang,
> 
> On Wed, Nov 4, 2026 at 12:14 PM <bluez.test.bot@gmail.com> wrote:
>>
>> This is automated email and please do not reply to this email!
>>
>> Dear submitter,
>>
>> Thank you for submitting the patches to the linux bluetooth mailing list.
>> This is a CI test results with your patch series:
>> PW Link:https://patchwork.kernel.org/series/1201470/
>>
>> ---Test result---
>>
>> Test Summary:
>> CheckPatch                    PASS      8.55 seconds
>> GitLint                       PASS      4.70 seconds
>> BuildEll                      PASS      23.33 seconds
>> BluezMake                     PASS      197.66 seconds
>> MakeCheck                     PASS      13.22 seconds
>> MakeDistcheck                 PASS      105.32 seconds
>> CheckValgrind                 PASS      164.16 seconds
>> CheckSmatch                   PASS      173.53 seconds
>> bluezmakeextell               PASS      69.20 seconds
>> TestFunctional                PASS      885.71 seconds
>> IncrementalBuild              PASS      250.73 seconds
>> ScanBuild                     PASS      687.43 seconds
>>
>>
>>
>> https://github.com/bluez/bluez/pull/2760
>>
>> ---
>> Regards,
>> Linux Bluetooth
> 
> Copilot flagged a couple of problems:
> https://github.com/bluez/bluez/pull/2760#pullrequestreview-5775992507
Hi Luiz,

The first three comments are valid. v2 will fix all three.

I would also like to discuss comment 4, "Clear JPEG image capability 
until photos are normalized."

The Default Contact Image Format feature is mandatory for PBAP 1.2 and 
requires PHOTO to contain a base64-encoded JPEG of at most 300x300 
pixels and 50 kB.

The three backends currently handle photos differently: Tracker uses the 
photo URL directly, ebook passes through inline data or a URI, and dummy 
forwards the PHOTO value from the vCard. This series only advertises the 
feature bit and does not change these behaviors.

I don't think obexd should perform remote network access, image 
resizing, or transcoding, as that would add unrelated networking and 
image-processing dependencies.

Without those, I see three options:

Keep the existing behavior and only advertise bit 9.
Validate inline PHOTO data and omit non-conformant or URI-based images.
Read local photo URIs, base64-encode JPEGs that meet the requirements, 
and omit unsupported or non-conformant images.

Do you have a preference for how this should be handled?

Regards,
Jinwang>
> 

