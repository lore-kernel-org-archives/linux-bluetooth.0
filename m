Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D195402BB7
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459588; cv=none; b=rNWzwXv8LfH6toWaVEUm9n7ILuoHv2/23NB08pQnBMxiFFbBpLSmStVTc2ImAmxt5KfhGYrdwXiG1d55hgFYntmwUMAB+rSHGpx4BXYzK7PSG/epcHN5i91ufTGyMklgCCdA820Jyl7EMpQwdnO7dlL59UXhvHj0bDdON45P1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459588; c=relaxed/simple;
	bh=nlhwD1TnjFIKn4FnqEWgsp8KPK7T74oQB93SFxPxztQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtR8l7ISaqR3GQ52aWYI0PY6+eZHgfVYgTNy0OPKycyZ+LXXCSidtY7U42jPVbyYLcRUr6qGje0k9DqcS4lPE5XoT2YCgqnlS+k12MDSQVk1N7p2+vh39WIbvwb/+aX4xrADrQqh/cwWl5NxpOyS/4SaNcQ8JrGd3ufQu2FXe0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kFYDhm+Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MKUd6vLm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kFYDhm+Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MKUd6vLm"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MCNX4q779220
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 14:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QALT+lqGX8YNkBTxqKWDpjn0
	E/tfJGp0u5h8Wo7ogaY=; b=kFYDhm+YQ8496HKUBCdSCdCELD08GwsG0wphx8rh
	JXSRpeOmhDPAWRJ76er3d7HH0UYQjx/5raL3oCQVPqGt7MiRmIYZi50sBDPDsSpW
	sTqQnP/vlYqfDJwq54lEH/X/+DC351UImNbyrrHrpAzBgaiYZsfZs+XHA72PyBHi
	SZMx6GiIQPutweRhiRK0O46epBEjjMvCGW6zsfyV+x1a+2mnp3MoPg/Is7CUcUdD
	Q0AZXJm1mnH3emG0Bk3wTOGRiXZ68LxrYlzNQs1EWpKIwLaamgUw8N6YRfbyWJKq
	VxSHYtVhtC1vs4FYUu+mtAlu7rV1SrDn1vduvfixq9NP9w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7au42p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 14:19:43 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95fd70270f7so11493466241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779459583; x=1780064383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QALT+lqGX8YNkBTxqKWDpjn0E/tfJGp0u5h8Wo7ogaY=;
        b=MKUd6vLmwTWyyAB50bTAXsKy2GC9x7qrnt3vV8JHxrSvMuGAnbwrNIEVkQKyAdAQGG
         yhJwMTJHVmN3gqop1OlOc3jCj998EHDJBhJ65yaRjdYZ6DLdOKRIqT1VR0jSMh8lROlc
         ShvVBj99P0eXs/s2XzTRbSyvF3VtKjyMbopqsvksqyEQgDpGg7JFILJOU+j5cas04LJo
         dGZAoyKelNwVvv1COyyWX3nw0cvSO3jfyFyq+/eWmz/pW+hIn7POBVMt9zkn4W/lwKL8
         8l/G8Eq+OlkrvrEAVbb3HR4vANc3IJwOPd1uaLWlo/bsx9ul9d3aYD7ql9O9JkRuOwSJ
         fwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459583; x=1780064383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QALT+lqGX8YNkBTxqKWDpjn0E/tfJGp0u5h8Wo7ogaY=;
        b=AvDXg8wl5gtMgGc1AxS4OY6dJXw5WsrmVFY8pl6CaySX+Iftfv68pjFRfygVQmWAaD
         tYUmaZQw7BIV3aDUmo8kPs9sCkNIBYlcb0FucEUmPcYdt7E/dvUAFLqc4/noCL96pm9T
         r7f33W9fGdtEtK3FVPMMeQI8txOxGafp9QMy2zPzgKTmQAmDLtCfDnkjxcdJ0l76unvh
         GscB70UXCwjsSuXHPYF6d9eZpFH+VePMcWAfsjk1A96C7+b8+P2TnrIpZyQ83jHmKDVm
         dEKAIFb1wjDdJyG7Dm/o+sgFJdWbNrJNyl/oQ75Dc3HFWqAZy8xs5CjQju6kkv3r6ijM
         T5rg==
X-Forwarded-Encrypted: i=1; AFNElJ/FLiVs999np5Jsk6SSiTU5SeSj1vprx4fM0aLiFsBsBER5ZRWomdg4SNJNzAwQsPuCx7m3se4MEviSaAlAGPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOY0RjAk+XjFEzag8dPEI5wp9JPSKSxAYdhofYYosShkoA4Gsi
	Uw+JERsPtJnQN4mk4dzzatFKz+Csi2ll11AvcS97CCuR79heBKSFseQP+GbpTo1YcksBmrFB3Pj
	R2E/XBspYXKOULfkP20ONvB8Z2SkZLdEo5VpCjbueajRY1FaAOtYVoAPQ7s5JPhpB8oYK4nQ=
X-Gm-Gg: Acq92OF8aTQ78kmXIQvCX9WnUX8liZLH4oazCRyQxNg1CteAn9dI+y1iupysgiURWxu
	IIC928imkuzQFnhy7gxnNPLjWXwoSvcz4aO5QHGIwnz5/daedmSqp2XB05BzbRhA/ZYtZg1pL8r
	+8I9KIkZp/kZLG1iQUiOESTNofDqspXH6/GTBNpCkxgYrhXLNDfNUjtS92AyWNmfGqSpJCkQ9KG
	zwmgn+AphTG/f8D+AuRo92tkCcsD+RbBCZuHurTquizs/J3OtIadNxFocyEUsm5Anc2/O/DJZEC
	Q1nM2fTcFetnmkvp+Vu4Kr561rtCmJLNYir/qpIat5VRcyTFWqOkC4YIFBTRkAlkqU6OXrxihyY
	IlOEEuRgamtexoZyjw6TlQKZY/k4uKJTXWfvE+8kQCwMaKs6XJw+IXJOe5Vmg6UIEq0eKTbTrkl
	GPalO/TW/6QjGFzLp4KWERvBZNWoUb6FmbWfg=
X-Received: by 2002:a05:6102:504f:b0:632:d8d5:2908 with SMTP id ada2fe7eead31-67c8b3aa864mr1915568137.26.1779459582753;
        Fri, 22 May 2026 07:19:42 -0700 (PDT)
X-Received: by 2002:a05:6102:504f:b0:632:d8d5:2908 with SMTP id ada2fe7eead31-67c8b3aa864mr1915528137.26.1779459582386;
        Fri, 22 May 2026 07:19:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dca74c88sm3715591fa.12.2026.05.22.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:19:41 -0700 (PDT)
Date: Fri, 22 May 2026 17:19:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Increase SSR delay for rampatch
 and NVM loading
Message-ID: <jbpujugiw4gbgx3hxnseop6q3w2zvqigqd6pcdg4shdnyy37it@6ytmgq7jejhp>
References: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 0gBL2jAfL0GBFsDL7peRa527HHESs1Ry
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a1065ff cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=qPZ7hrfojItUN558QmcA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 0gBL2jAfL0GBFsDL7peRa527HHESs1Ry
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MiBTYWx0ZWRfX4XUViRJ0+Y9U
 FzvEsywydqKyj6fIN3TwvJIJ7lC0xm6SF2CODWbqJDu2ta/HhetsDQm0beku4QsysAMV3UNBLvY
 fwaXMLPhsNugz1t8a+8U74szjfDYlEzdGMeH8tR0aIDpFe8a8cMmh3f3QYVfIcSrlbafsOC3K4k
 bFhMXowmgRKSGj0C9NQ+qgb8CoPt5n7E9+LOpiR9klxm9bdM4jpACts8Xsv8qltDNZv2GF77yIW
 dgSLdOQ1ja9BwFVSicur7VHWsgSPgvxBW4BIO5n12y8s3QDf9RO1Upe0fJJivdOmQVeOxiBaaNB
 lx39riU8F5wvqf2uO+Pg8crgLnXaODaXDszYC549Zvo9C908267Z8bkvxnb/SgaV7a+Uh8LVA7R
 oElc3W9B/qCkBj/N+opw4JXH1RDkheooOYlL7eFW3FM8ilk47cnuf/HnvKH/Wi2z5NR2H2No2eJ
 T/E34r+lQZCpxZcP2Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220142

On Fri, May 22, 2026 at 07:08:38PM +0800, Shuai Zhang wrote:
> When bt_en is pulled high by hardware, the host does not re-download
> the firmware after SSR. The controller loads the rampatch and NVM
> internally.
> 
> On HMT chip, due to the large firmware file size, the
> loading process takes approximately 70ms. The previous 50ms delay is
> too short, causing the controller to not respond to the reset command
> sent by the host, which leads to BT initialization failure.
> 
> Increase the delay to 100ms to ensure the controller has finished
> loading the firmware before the host sends commands.
> 
> Steps to reproduce:
> 1. Trigger SSR and wait for SSR to complete:
>    hcitool cmd 0x3f 0c 26
> 2. Run "bluetoothctl power on" and observe that BT fails to start.
> 
> Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
