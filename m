Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C72DC32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446131; cv=none; b=p8NT1CMkcZB3pyPUp+3enZEX2OVjhWnJL9imrrBPZICzXi7RV9NbpHZPzwVC0CBMcnTbB8xr9IlWrN6K/D13K9TOZ0C841DtiWE3QMwZ1gMIxVUvDnS3t+iWSdcBHOu8cNoRcSeRzIm+ptBnSriIr6ND8ph7gJoDW6BnWzSzNFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446131; c=relaxed/simple;
	bh=2+yZtpEZjwtu9PFm+zS5xw9Xzg6lp4JOcXbE3FdUjiY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=WkUwNsgf0/verose0+4e3rhUegqVWu88c82GXBib/rheK3wXoBgLgt3usqWS003R0t1sGURCKK7NbyN3xh8qloEkGpX822xI7qh5QHah3QwBK/C6VO4hKxVVUBYUtmF2Q3tnX17j059Hi5N7HovRUQLTWtfGFigSVFG3+ko4iXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JK5/w9hR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kBcp9El7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JK5/w9hR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kBcp9El7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BAM7UU384755
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 11:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q0CBqDzUBMWkkmGLJWwO6MBllI12zw+bsJYjwa/xfLI=; b=JK5/w9hRNyCulgQu
	EbupFi3BFyVGTHp7YI6nYSWDxz/kCVx3rOiM49nYznbw1FKp/LrrW4fZziU+UM8w
	+Az2eyDqbCcrGKz1zANVaIQJOPErjEFDynbba7C7NdqDN1PXAJXVHHs6eJbMn68d
	hZVnafgqI5UuY2/7h93ZYvajBOPRFKCEKJ+N9E+e3vWw6ZILvKSd+wZtnic9Zl1+
	NqIJEGO7A8R5OL1/VXpB9HF/RjAWtx+8MtAAOejOgRWoq4xlPPb0dM90+d5RBXAc
	wqumsSITDOdYL7CWEp8rkHms14wFocl4DR45nrc2U7518FnRz9NFf7j34ALPHQKx
	T/4uXw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk23u5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 11:02:09 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f08560ea44so4504116d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786446126; x=1787050926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q0CBqDzUBMWkkmGLJWwO6MBllI12zw+bsJYjwa/xfLI=;
        b=kBcp9El7Kzex6hoUW7DHFrYsLDyZ51VL03ySgi0e8ws5Mm1/0hWKV4TE/pbWs9HAy0
         kSbbW/7pNGpB2deC9WQUP0AVBbYGjF007k7KRg/y0z5j72wU6f5vu2Ir6Pnn3vNqKhzZ
         Mthm2rnwUrshZNuUGbNz8pi1d10LghD+nGpSaNqd0OyHlL3Bsm27JNUXYCBOP1l6c8ae
         zIf3iWA+AKwpM2knIbVnjhHgsnKa2mNw9N4xCchq27ma4Okas8M7etYu5QESxlVU4MIu
         mCB9O4CMlkpqmGp7mns8CSXqLQJsWE0Jrkz2Rig6ClFdHwkgGPFo5NHDUsL0AHzuckJw
         BewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786446126; x=1787050926;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q0CBqDzUBMWkkmGLJWwO6MBllI12zw+bsJYjwa/xfLI=;
        b=YdgHfNKKLZwaiLeqZ1epOp8r9Ymjpx8WzAKOVlOdLl1wegTWzfM5KeZ0bWT01Ra1bk
         MJScUHCt4Egv4JEgeEHUsbMIcmqgH0yBchy6CUBBj+RxE+2l2wbJyA4kfeqeF+uxgtTH
         vG0W8bBxZpqvLq1crhP9VrJw4YXIZ5nMzLbdipVPx0ie4GQXrM2aYw0BFrmXUS83kCLl
         KXRijHUi79QbcyTRthfx8Smu9OT2yWZQypPYxCkc8ig2rf3BH8Hr4ajw0TjKNUsqrZbh
         pm3g2rFlM32QXvvjDT69ArA6yeG3KKE+Zxz81vLTPPXkV+yD5qZiQ4ht6cEyOX/hq0J3
         7iWA==
X-Gm-Message-State: AOJu0Yyeawc92AjorkY0jm8ozLIrIsplSoDfhOCQFA3QXq49mcHyQoxb
	8O9buM7oazhhF3M1IN3TIvee2Gl7fdsWuxPIh7DB3BArnF1B5hqvNZdoz7+oT4p9AUCKUfEU83j
	3itmiipCY5AiIwl5Q8nfA+dn+id/tIrtzcEgYoU6BA2n0rv9IwYssFNnGPbuq5+0Uus7Y0s+JB/
	PZGg8=
X-Gm-Gg: AR+sD12gtuyIa/MDsaPs9NVLiygDfUoMXc5rHdCZ6N395qp0fDbXcHSPPMBzIFrA2PH
	jJhGVletdS8PmxwFIKUPM3OXOdjCPhRPCm6fE2VRuteZqNf9hMNmAmDpsWNPNqPYGOvcrDro0X4
	15kbjno7IXd9fzafUUI6AwwOg7hfP/rRDOBLwPSxAG9SSQZjVCFS/sdoNOhX3xWCG9xG8QXJove
	zEV1xS9CpseUvEIwqeSwAYo/DcA25pVwYYBue2Y1kCBp5N1pqsn+Ftd3pxpjaDj5q0T/ggyudUL
	kI7BAJEmwg8GzB53HUQqKG5mib/1qUb5BH5uewgQN9fXHAjdl3pULVadATf5DLJALlcX33b3fyj
	ohuyC3LYua8aJDXXCaqI0SLRyp/D8GQzlkjGLFpWYKXhNhE4WBHM/wp60QEYGmjNPhx5j3JVKsU
	e2hSMIrPFaExx2+JI+kr/OUzo1pCRZAak35wQ7gmZud/Xl1EO0dtmQHl1mmFvDK9CEBOg=
X-Received: by 2002:a05:622a:1e16:b0:51c:1132:c80d with SMTP id d75a77b69052e-52d585d8e12mr20069371cf.28.1786446125701;
        Tue, 11 Aug 2026 04:02:05 -0700 (PDT)
X-Received: by 2002:a05:622a:1e16:b0:51c:1132:c80d with SMTP id d75a77b69052e-52d585d8e12mr20068731cf.28.1786446125223;
        Tue, 11 Aug 2026 04:02:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e410066bsm37703866b.14.2026.08.11.04.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 04:02:04 -0700 (PDT)
Message-ID: <f1e1dcdd-cca7-4670-abf0-febf16c72e15@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 13:02:02 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [1/2] Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping
 the last request
To: linux-bluetooth@vger.kernel.org,
        Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
References: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
 <6a7ae9ed.9e118ab0.227f96.1808@mx.google.com>
Content-Language: en-US, nl
In-Reply-To: <6a7ae9ed.9e118ab0.227f96.1808@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MSBTYWx0ZWRfX3aFgJiWt2h+Z
 8oEiBdcxyAzIGD1sC4hOEmvnXmMAmlDDMq95EwhX93PT1Hj4cSIs9+SvyH4idqxL9pnQxfLeqs4
 62Z/suCWA81/epD1JRpGXBMsQ/eZLAI=
X-Proofpoint-GUID: ocRzBsyEvnYPtkUqYHVMtM8g95vRexxv
X-Proofpoint-ORIG-GUID: ocRzBsyEvnYPtkUqYHVMtM8g95vRexxv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MSBTYWx0ZWRfX8URacHhFPHKu
 LM3KBoGTh8NGOusyqjH96ONzrwMwICPekWTtl4ccDcjZ+8iX7wLJN/0ptiuL3vRuINOMRRSUz/H
 Bol4TmLZbUmBGZ4aA+zpytQV1W+ou9n+vfq2Kg6YrFzhhJdhR8SswhfKkhLFP+2yArvfPlhHbCq
 +sgYa3s/8o4XXMwRt4gdmcpfA6zHOjuEOs2i2RHEHqzNzI70q4JRr+N5GDxIidEsvjfngfVhq5c
 D+FN9mF69g9bY6XJoA/J9YtR9rW663jvTxSJKN9RkIgOnq98KfPqrS3XhT9M1V/PoB38hxsFf7v
 yIC4WEIVblPNI4Rumjo9/yt67jqfOtujiQKKC3PTaHCCL34IxmO/yso2yb423LqLWgGeE4dFkQU
 z0eyKwYh1LmaazK3r7b5IU1rD1OUOEJci1gZiG69/u3VCgIAU43BS0FBRFg7AQfpIxDZLeRQBBY
 CEvzkmg1iKcrOC+fsnA==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=6a7b0131 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8 a=8HR8Mm1p1tuL_I0jY3oA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110091

Hi,

On 11-Aug-26 11:22, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1143947
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PASS      1.86 seconds
> VerifyFixes                   PASS      0.13 seconds
> VerifySignedoff               PASS      0.13 seconds
> GitLint                       PASS      0.67 seconds
> SubjectPrefix                 PASS      0.26 seconds
> BuildKernel                   PASS      28.31 seconds
> CheckAllWarning               PASS      30.35 seconds
> CheckSparse                   PASS      28.39 seconds
> BuildKernel32                 PASS      29.13 seconds
> CheckKernelLLVM               SKIP      0.00 seconds
> TestRunnerSetup               PASS      503.14 seconds
> TestRunner_l2cap-tester       PASS      64.96 seconds
> TestRunner_iso-tester         PASS      81.82 seconds
> TestRunner_bnep-tester        PASS      19.39 seconds
> TestRunner_mgmt-tester        FAIL      226.68 seconds
> TestRunner_rfcomm-tester      PASS      26.62 seconds
> TestRunner_sco-tester         PASS      32.84 seconds
> TestRunner_ioctl-tester       PASS      27.17 seconds
> TestRunner_mesh-tester        FAIL      26.97 seconds
> TestRunner_smp-tester         PASS      24.42 seconds
> TestRunner_userchan-tester    PASS      20.61 seconds
> TestRunner_6lowpan-tester     PASS      24.04 seconds
> IncrementalBuild              PASS      29.81 seconds
> 
> Details
> ##############################
> Test: CheckKernelLLVM - SKIP
> Desc: Build kernel with LLVM + context analysis
> Output:
> Clang not found
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4
> 
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.252 seconds
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
> 
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    2.102 seconds
> Mesh - Send cancel - 2                               Timed out    1.984 seconds

I'm seeing the exact same failures in other CI runs from recent
patches, e.g. :

https://lore.kernel.org/linux-bluetooth/20260808062541.3705446-1-zhangchen200426@163.com/T/#t

So I'm assuming that these are pre-existing CI issues and
not caused by this patch.

Regards,

Hans


