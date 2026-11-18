Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984948;
	b=WF8Y+0OmNaqbDoF+hdqlB2QKqQ6cm9Aw9IAC6WRx6Cx0I7f+x8/pnP+jxnuOwFnGGv8F
	 N958SBj8N7Xp/FeTjgP4QZLvQC5H/YobWujEA+jubzgSrmSjvhzPQnGxFGdjdWEpHwwmR
	 cON74iICvf7ljyJW0jUy2+CX0TSyai6V8oPAJSqqqog/j+qKV0MwgaS20qZKNy6WjuJ4o
	 OGlescLMp8/1q+zgdxtmFqrRdQebcOLH6y7eixFNx9PwLv6doB+vT04m7WmEBgRI3B9Sb
	 MVeT2l0OfXH2dzsz5rjFI0crvJQdSKOivfj5UVtkD2edjjLpVkEGLWfu5b8ZBq/b9bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984948;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2YjN6HDSb5JreDhsAk99dgu0/WlUIetoSEDsPxefwx0=;
	b=PxtDc1TvSNI5FknD6cYbojxlvG8AhtZEirclnvAiegSn0t/p8JkRhDfRgiUavxm7O8sB
	 zO77pBwwjLY5634XC4uqbRVgzihCO+0G7yqtlrRcGUAgxl2xGnvsf4U7uIm9gWqxLowBx
	 JJR0f556PskCFqabWnFdvIq8GlcdwhVJcBG+JjCsuad1StOTH56kfVUtyh+lVLVeNv9uk
	 YD+bFO8MWKhN83soRklHjFcApjljd1/TzeKYY6z26eBz3n+K2b6X8VwRFOETqXFWGEyhz
	 UuFJZyRqr51+9Nrq35Uh3o82/L74bbTfd4dYQT3Rldpam7sYOPlZstB9IL/U5LfRlNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JYkx+mP+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YSQ1rSI0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04110606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04110606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JYkx+mP+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YSQ1rSI0
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2UumB2453536
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2YjN6HDSb5JreDhsAk99dgu0/WlUIetoSEDsPxefwx0=; b=JYkx+mP+bY3mbbx+
	c8gO1XLgOLS/PWZCG9GCUCokwVQtmcsi/vSXHeknvx0S0+GHTE+L9/MWouqIsMXj
	kxxoIqUHa70WbWa6LPCMnCV02aTVjMRTCXNiuhZTDYTpy0JnAHkT49TspV7z9L3w
	Vb4Ywv/WQr/+uguRPdHbzMwdMUB6UdLsucDwF9YbhkrF0hxPrA4M1/73vlTOkHgn
	txceOsU+vv4nGx8FhxoOaLvWPrdxJyx6bjscq2pikqb7PJAg1MoNwkK0h3gO6XWr
	hUONrzh4f1YELIzStqHmbwrlkE2/QpZ9cAA+VYvXLlHu3uLM4EhqaGPgKAWObmMg
	WNZZ6A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv99nj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:55:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a073778890so649607b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 22:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794984946; x=1795589746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2YjN6HDSb5JreDhsAk99dgu0/WlUIetoSEDsPxefwx0=;
        b=YSQ1rSI0xiIZrBGs8VHVq4qy2RyKNQ4iD8fT8OD4WrhrlDZ9ByRVvIZBxA6Sco7d1c
         7oAIhxuC+Rddzqkxu5SlS2fbaHYf1K9KinMU1e5+u/AYeCncetTCq6rRuO8t0XWG2wKL
         hNypTjoln0Jtx34HUGJDo3s6/w3aJzOoQoJtq+A7jeokxcZCgIgTzsAXbSEbVKKwIfTT
         W6I9EQ3Qg9ctJ8u6WfVK9Or10Ey1bSWOs2qhdF22zamT3IZ33favdppSLN5fI3J14U//
         h8UHC0I18CXyzVBB09hlitUWHyLZJ+0gsE6TM/sbL8DZ87K/w45elNkvwN1cBmIXiru2
         npfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984946; x=1795589746;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YjN6HDSb5JreDhsAk99dgu0/WlUIetoSEDsPxefwx0=;
        b=DRbBBS6ESIUypTpQ+rqCbAv29lVU+GrUyZilE3XdaPEjzUBSeXnC4RNqIm06xgt5M/
         WStAhwVHrboh1KLxbAYHlPch1aLHPQm4Me2Iy9u/0tO2NTRO6pN9y54myvh0yKql+WNT
         RFJzH9Ab4/6pTrFk6G7mCvlYKqIwe2JR0H7BkVkQ+8E7nV45ZML/YAuxzds+csXRNLxg
         KLoFUjfEh4JOsuSUUNfzUqRkNdc5d+FtTNmnNhgM2oEpxxDEEODAad+ZyOdOAxYmc6ss
         gmrtSgzqOnWzRWnfa/keQBAGr3XIqYv1JyA9p75y9C5XfpCAtNUIMa3FIaXPWyKewPYI
         a9WQ==
X-Gm-Message-State: APuU4Z+LZGRtdhmTA+84MlK84xrnfVB0WpfE85jEsD8UGlRAZ0Un825v
	lemQx9HTLJeomLWbY6MaIeyR2pVv/MoFDri2XJ9/XoMar0d3imLZyr49eGgztNKfy/KcL21BbmD
	b1bMDTYtSmavV0VJjPGaqFFu9naxXZqvS6AL9ipItfu6+zdomkxYxPa3Bi+LZy8XZQ+fbbBc=
X-Gm-Gg: AYBFou3BNrlzHR9tHVK4pC1LBIOrI5jefWz+bMV7jGdRoadN1NvfxU4M9hsyQN/BrCv
	nU5B3sW9ihRAtazjKj+n1OyHp7Foll9wkzQz0HYl3dqbVfqsSSFS8la+QdjqHd4WQMHjc57sbMN
	XKxqTTcDAPHMGSlXEPqSndmyEj83kkRWcGtXWMsofVApwmK19txdW3/ELKJmU7pQfiYI5UQN0HL
	IGfFX9zTOElYOKh2DSLyRpQfKJmn6hfLoKxgznizulX61ciBkyiEl+HK+jKjqW/1+USMgz9lINR
	UGLb3oeu1lvjCO61MQzGRBGQ6BpLd+GQxY4rUo4BhVv1bivN95baEbK+XmusW5tPW32CUF3MEnB
	X7x5JAcxB8/0vUpTdX19PscD+q4IM3JsWT+ZyIgsoeQkNDzZyU/CRAl4y5u45ijzaFH/jdREr8R
	bsAOQwd+e2uUJU3FcrwBSwyXA=
X-Received: by 2002:a05:6a00:4217:b0:8bb:1a7b:bb8 with SMTP id d2e1a72fcca58-8c5d0278603mr1425599b3a.3.1794984945518;
        Tue, 17 Nov 2026 22:55:45 -0800 (PST)
X-Received: by 2002:a05:6a00:4217:b0:8bb:1a7b:bb8 with SMTP id d2e1a72fcca58-8c5d0278603mr1425574b3a.3.1794984945021;
        Tue, 17 Nov 2026 22:55:45 -0800 (PST)
Received: from [10.110.93.171] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cad8cf28sm675939b3a.32.2026.11.17.22.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:55:44 -0800 (PST)
Message-ID: <1a1ad8e3-4aff-4b54-9b9f-47e63e7f514e@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 14:55:40 +0800
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
Subject: Re: [PATCH BlueZ v3 00/20] obexd/pbap: Update PSE support from PBAP
 1.1 to 1.2
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
References: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
 <CABBYNZ+jCVzF9TNjk9EAGiaOfejVcz3g1PNEKGq2Gy6=B-p=pQ@mail.gmail.com>
Content-Language: en-US
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+jCVzF9TNjk9EAGiaOfejVcz3g1PNEKGq2Gy6=B-p=pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyNyBTYWx0ZWRfX2cXB0uuLZHhP
 2Vnsbi+3G3SndOuv8uSXVE1Q2P4znXKrlDwQwXw6FRMSruYtGQxm5tdPlxlQst6E4MsqWKzG+KD
 SWRsa2anmWxCwH28rVNUaF1BB+744aA=
X-Authority-Analysis: v=2.4 cv=acT0Dhot c=1 sm=1 tr=0 ts=6afd4bf2 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=wzBUqQYaaH6XuHbcFzQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyNyBTYWx0ZWRfX1fnxePwrJWHw
 pOx2c6b9pcC+nw0XwW7Ed/U2Nc2Q0fJ62Z0HUGC+UYZcaIPgf4POLFXXE2aoIKE4Cq8qvqbbg2X
 ISU7Jb2knwuBF8HQ9AxAUXwntE2DpOcH0/eTUAC0NJ9pTBSQa790PzMQOKMIKCF5Ek/fAkXNjUH
 FUcMskdbsHNRVCci8Dh6EgAJmidd+iMrj4F1ggWkx0QSlsFEHPZWzAGB05ElVGl69524zj9eIif
 AHXH27JtPCfUd9CN8Gk+BcCbg8xoyRdEbNqt29TvtNoGjMko2DOVZEeroa8QddwiHhYXD78UWYZ
 LF5gTPTsUPmE+AV3huUBZP0S8Ra6gH8IGjco+yTCW6T22Z1+q3cXKngjHB9a9ixPNpV8OXrEdHe
 8VQyKqDIlz3TOhjLUJ9SFMwZJr7VIbmcA7EJq6yjBkBTpHQewYvEX8RMk9xlBYm0hOZPbZ0/m8k
 PYsnhRn0IHnZAzOFO0Q==
X-Proofpoint-ORIG-GUID: 4gCBs-pZGQK_Y_i7xioJQXMJmrC-QM4C
X-Proofpoint-GUID: 4gCBs-pZGQK_Y_i7xioJQXMJmrC-QM4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180027

Hi Luiz

On 11/18/2026 12:41 AM, Luiz Augusto von Dentz wrote:
> Hi Jinwang,
> 
> On Mon, Nov 16, 2026 at 4:06 AM Jinwang Li <jinwang.li@oss.qualcomm.com> wrote:
>>
>> This series updates the obexd PBAP Phone Book Server Equipment (PSE)
>> from PBAP 1.1 to PBAP 1.2, following the PBAP 1.2.3 specification.
>>
>> It adds PbapSupportedFeatures negotiation, Database Identifier and
>> primary and secondary Folder Version Counter response parameters, and
>> vCardSelector filtering for phonebook and vCard listing requests. It
>> also advertises Contact Image Default Format and updates the SDP profile
>> version to 0x0102.
>>
>> The dummy backend persists the Database Identifier and folder counters.
>> The ebook and Tracker backends report zero values to indicate that these
>> values are not persistent. vCardSelector is implemented in all three
>> backends.
>>
>> The series also fixes phonebook backend and request handling issues,
>> refreshes the listing cache for each request, and adds NewMissedCalls to
>> vCard listing responses. NewMissedCalls is limited to mch responses.
>>
>> Testing was performed on the OE-Core wrynose branch (Yocto Project 6.0),
>> together with prerequisite patches already merged upstream. The dummy,
>> ebook, and Tracker backends were all functionally tested. The dummy
>> backend was also tested against the PBAP PSE PTS test cases covered by
>> this series.
>>
>> Changes in v3:
>>   - Rebased the series.
>>   - Patch 6: Shorten the subject without changing functionality.
>>   - Patch 7: Preserve quoted-printable PHOTO continuations and correctly
>>     parse quoted parameter values while filtering unselected photos.
>>   - Patch 16: Associate persisted metadata with each virtual phonebook
>>     folder and reject incomplete folder scans when computing digests.
>>   - Patch 17: Move folder-specific metadata handling into patch 16. Keep
>>     this response patch limited to emitting negotiated counters.
>>   - Patch 18: Apply vCardSelector when calculating a PullPhoneBook size
>>     response with MaxListCount set to zero.
>>   - Patch 19: Handle folded headers, quoted parameter values, and
>>     quoted-printable continuations when validating default-format photos.
>>     Clarify that returned photos must use the PBAP default image format.
>>   - V2 link:
>>     https://lore.kernel.org/all/20261111094425.1444893-1-jinwang.li@oss.qualcomm.com/
>>
>> Changes in v2:
>>   - Rebased the patch.
>>   - Patches 1-2: Add the PRODID fixes.
>>   - Patch 7: Also remove the unindented BASE64 body of an unselected
>>     PHOTO property from dummy backend responses.
>>   - Patch 16: Do not refresh the folder version counters for
>>     PullvCardEntry.
>>   - Patch 18: Use PRODID in the vCardSelector property table.
>>   - Patch 19: Send only PHOTO properties that are BASE64 encoded JPEG
>>     images of at most 300x300 pixels and 50 KiB.
>>   - V1 link:
>>     https://lore.kernel.org/all/20261104083429.4111632-1-jinwang.li@oss.qualcomm.com/
>>
>> Jinwang Li (20):
>>    obexd/pbap: Fix PRODID property name
>>    doc: Fix PRODID property name
>>    obexd/pbap: Fix crash counting vCards in dummy backend
>>    obexd/pbap: Fix Tracker contact grouping across requests
>>    obexd/pbap: Include directly bound Tracker telephone numbers
>>    obexd/pbap: Reject listing without Name in telecom folder
>>    obexd/pbap: Fix unselected PHOTO in dummy responses
>>    obexd/pbap: Refresh cache for each vCard listing
>>    obexd/pbap: Limit NewMissedCalls to mch responses
>>    obexd/pbap: Add NewMissedCalls to vCard listing responses
>>    obexd/pbap: Separate vCard entry response handling
>>    obexd: Parse application parameters in CONNECT request
>>    obexd/pbap: Parse PbapSupportedFeatures in connect request
>>    obexd/pbap: Add persistent database identifier
>>    obexd/pbap: Include database identifier in responses
>>    obexd/pbap: Add folder version counters
>>    obexd/pbap: Include folder version counters in responses
>>    obexd/pbap: Add vCardSelector support
>>    obexd/pbap: Support Contact Image Default Format
>>    profile: Update PBAP PSE version and features
>>
>>   Makefile.obexd                         |   2 +
>>   doc/org.bluez.obex.PhonebookAccess.rst |   2 +-
>>   obexd/client/pbap.c                    |   2 +-
>>   obexd/plugins/pbap.c                   | 778 +++++++++++++++++++++++--
>>   obexd/plugins/phonebook-dummy.c        | 745 +++++++++++++++++++++--
>>   obexd/plugins/phonebook-ebook.c        |  88 ++-
>>   obexd/plugins/phonebook-metadata.c     | 257 ++++++++
>>   obexd/plugins/phonebook-metadata.h     |  52 ++
>>   obexd/plugins/phonebook-tracker.c      | 367 +++++++-----
>>   obexd/plugins/phonebook.c              |   8 +
>>   obexd/plugins/phonebook.h              |  84 ++-
>>   obexd/plugins/vcard.c                  |  71 ++-
>>   obexd/plugins/vcard.h                  |   2 +
>>   obexd/src/obex.c                       |  42 +-
>>   src/profile.c                          |   4 +-
>>   15 files changed, 2209 insertions(+), 295 deletions(-)
>>   create mode 100644 obexd/plugins/phonebook-metadata.c
>>   create mode 100644 obexd/plugins/phonebook-metadata.h
>>
>> --
>> 2.34.1
> 
> Copilot flagged 2 problems:
> 
> https://github.com/bluez/bluez/pull/2833#pullrequestreview-5942549908

For these two comments, I don't think changes are needed: the first is 
not an issue, and the second is acceptable.

1. Restrict default-image filtering to negotiated feature
PBAP 1.2.3 §3.1.6.2 ties the default-image restriction to the PSE's 
advertised feature, not mutual negotiation. Section 4.1 excludes this 
feature for the PCE, so using negotiated_features here would be incorrect.

2. Invalidate cached metadata after a failed digest scan
This can happen if a vCard becomes invalid or unreadable after its 
metadata is cached. This only concerns the dummy backend, where the 
phonebook files are expected to remain valid and readable, so I think 
this case is acceptable.


Best regards,
Jinwang
> 

