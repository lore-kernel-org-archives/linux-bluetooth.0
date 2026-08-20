Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77843D4EF
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230103; cv=none; b=J8fwHKel+xUwPTIGazY/HsAL/CwE3DLO5uXsUza9Brl60EjdqkG97p6nWSKfjFstbt6aG+hhV9h95pjLDr4GN38kamdLJNIU6sCK5q+7go16xNfCziBn8x3dAnEBvZNGnOVYhvvmwMHHlNVh+9jWrvqjcnHsuB12X+RKHOYAHDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230103; c=relaxed/simple;
	bh=1rd0Xqdoh5avQQhT1vHHFyOkWivCJPvrHR0QlD3T3pQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=cL8Dnt9JOKxMJiAG/9omwJkLO6vbdujBIbxxZbcoq0Z9tsPYSddsR0lGc3nSWG9NVc+WZjxJQK1K53rt2M5eoxLdlor+pCQrFFUn9wVnY5D+4SuNlkll8WNNEyrXmoCCWfOkeGVaicD+BTcCNqy/GXYSUFh1X3KVa+sDKEGdqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ep7YtsOA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CzkKfwWm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ep7YtsOA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CzkKfwWm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8tJVl3515487
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cSJ2JZNIVR5js1sCoMJ57s5g+nh89AyHHTrFjEK1jx0=; b=ep7YtsOAA2Ltdb+t
	wVM6/yqu1UlC3yR7EvP66TsZ/61Wbdhg3D8lL8roUo2a2DrDnTPjppHH3oi26CKi
	VW5AfzFmTdcJl16Zkpf3FAnCOAiUSCWGoA4uCfSt/GDYnAhn7AgBM11OFsc7vs9p
	bNphRBf26D7RcfP+TcM3c4OqxgkIuP8pckEgQIOUUjzks97SBOUdUTyxzcOIygOb
	antgdUcgDnclP1NcFebJwVv+yxNX8EaN2UR6dSZS4qcXW2cf5aEtMA5ug+Kep3Fa
	ktPWh4zN+XELh2D5j6m0fOjaOt6LU8/jfWGBTpuJoRq+gc4Y0E5BLGZ+3u3jWE2s
	Y26L7g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xgc8v1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:48:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9368f2b7b2bso232608585a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787230100; x=1787834900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cSJ2JZNIVR5js1sCoMJ57s5g+nh89AyHHTrFjEK1jx0=;
        b=CzkKfwWmyJS1VWeLrY9R6ksoClREaQZnyqVvYaFbeDNChuCjt90BhtksINCkPxsqlw
         /9P3m+V+ce6XjKmKPTqNEX7++POv4rrhqx9FchuuqdG9NiNbhWv3zFlxBlsFcUKNo0fC
         M502P+kysoN8R0IFD7ewg3NAwR2mM6+uSNGEgLhxdEsnG4XlZvWpYXdhvnW+w3x+w2du
         0S36uWSEL4yWcU7Q2+Roq4+HVZBKy2Gzna2ZBmE+Dg8E9n0fdQ8wTZybG/ARHi75gzw3
         13DeaGenseR6tYYwSYqdpz8X/UmscLhWj7CaPg+VZJsPrixqko1r70ZWFN8QG88+LTb8
         e1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230100; x=1787834900;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cSJ2JZNIVR5js1sCoMJ57s5g+nh89AyHHTrFjEK1jx0=;
        b=BddQbfnXYDWXExmmKiFofl5GYelFOVNhTtWxekGRjIEra6HfBQmz3cPWWapsu7OSND
         Bho7X0SIb3Ec8u3XlCYePJN+F95wEMh12sWGdz04UPZ/a20RPBqpCpQGeeG3oubXvbsQ
         2LR0OpS3DOdMyIhHRFweauAPWS+HdIzzgNvuzx6qW26zV+xBvOKq4q66uaegV0m2WNGv
         iqGtCWO3Y6VlX6y+pgOKstNZ9ZElAPRwsHJbuoSszZyh+HQLefg+S3vrPhWtjVpPuqH2
         OpYYiO/yKDsy/HNRHvVbXLoZKU6Q0t76hVs20PiLPXUTIIX8D6lLtjoLOgf4DUetL4My
         xutA==
X-Forwarded-Encrypted: i=1; AHgh+Roq/6I8BdVw//Jowi0AusKY/Qc3K5iuriTHDHI6BNjn66+UdnaBc1io7NAL9zx9zMZBqZIG2B0TBj7zkuvxzXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydBvE1ag9fq9MSm52qOfDAub44puAy+Jr+vMcKNeP49q2xwtnc
	4OBh3KEvb3Hcy+8pVLM5obCR6cI3GKhwSTH8NFLaaFiDPTVWjIWvU5sJJExeWbFlMMO0eUWpThI
	KRoOrmlMmkpPUsyTp0y8beSpdPwssngrNxHr0O+av2XBfsIhElpYL1w0YnI5vqWl6hC9KMKU=
X-Gm-Gg: AR+sD13yF+t97mVu7jkTNlBItcPyh3HgVByzHsD/Yz57ssQYa0UHLl+jjGTp6EF1BXs
	e+Q3EFvnRp9uG5TenMgiN5mffuzo/Z+v2oBn7fHom7UsVDU3PTrhGryESefIuCJ3p1ku5MXDLWH
	hX9zHJj0j9Ce4sYZfMrqdefRWR9iUwrXPPxydppk3dzmcKrDe2FAnV0oOkY4AIqBk9GKzmt+bhs
	8qhJSAHOuCYwL3OT2LK6BDQzsVsxIXUk/rnTc2nZmFI6CIMH3cSZoQIU8CjlQZmC3ChXiBpyz30
	JauyJUqeahpNrbhJ6PxP9doOKq6thl4vqstlyJFT3+0KdBR7/Ibnc3fBwgvTqpBOc56Bn6FDfYc
	uLvbLoatHhz2y3vtspL93eEpffr53q3vMFPayuCF8S8XS4ioOdO2xzwGny15rP+0CWfzm2RvBk2
	R/fMqpPoo1UNRhyxkE3YX0p88GXUw44IIESoK3bWaARs2a/RLnhYdyblk6lMx8vMBftF0=
X-Received: by 2002:a05:620a:4111:b0:936:9525:e952 with SMTP id af79cd13be357-9371e66fa14mr1064201785a.41.1787230099533;
        Thu, 20 Aug 2026 05:48:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4111:b0:936:9525:e952 with SMTP id af79cd13be357-9371e66fa14mr1064198385a.41.1787230098962;
        Thu, 20 Aug 2026 05:48:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b648f9sm62823466b.28.2026.08.20.05.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 05:48:18 -0700 (PDT)
Message-ID: <7ffe0c2e-0742-488a-ab6c-1dc2fabc049c@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 14:48:17 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/4] Bluetooth: hci_h5: use device_schedule_reprobe()
To: Daniel Golle <daniel@makrotopia.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org
References: <cover.1787185594.git.daniel@makrotopia.org>
 <607f76ae7cbfb5e04260f69634cbd276a1c1240a.1787185594.git.daniel@makrotopia.org>
Content-Language: en-US, nl
In-Reply-To: <607f76ae7cbfb5e04260f69634cbd276a1c1240a.1787185594.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GPM41ONK c=1 sm=1 tr=0 ts=6a86f794 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VT4XjZGOAAAA:8
 a=EUspDBNiAAAA:8 a=3ztaF3K77RXdcjtKaAIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: hD495Nq5U_ElXeO6c2Bg0HMofHk92E5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5NSBTYWx0ZWRfX+Z5tkoHo3+I3
 eLzWQG9TW2JQt0hxzh1kuLZQkQUYgLZ8Y3W8FHOtgvtDjETIp4xQMudlFUhasiEshQhOHzR/AUc
 ZPTFgCV6m3NbsACDmVB21iRvN3G/MoerdVtVK0jLqx3QB+NJu5ucwUzFUU+X9xlh9mMPPNC8Z9x
 PdgcdRUpe+ntGbtVxhyhVwOhvjEE7f8xJh2CUkJoc6YqTB7wOFm015vNv4PU0HgbohHfUT8Ky4t
 /H/KAM9POJaYoKemzwKBEcuqTCBguboF6OUtygxfpT6GD/UFRsQeSBjdp1vRN8CmQLGdTf+PJEJ
 1Od1CHuKnirwZbsxcU9SWWeRCA6Ty5E7OR1FBQiaveNhySg6Wn8fwUT5vwBSkF7IFeZ7hUkhEOf
 cc6w3SXYPIoXT1emsa6u2xGnFNjUwbBKsuzW3ZUsftwsESihSTKVQk4VKW9WDhkw6kgMzAKz8F+
 xHs3I9pjvetjgac1T+Q==
X-Proofpoint-GUID: hD495Nq5U_ElXeO6c2Bg0HMofHk92E5e
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5NSBTYWx0ZWRfX3gj4KMzSBXq2
 5Pj4acctSELff/h5OV8xix/pS01G+KBUze+MFyHKAKwI8jfwr3i0P8ZB24uvRh++aqt5FuZxViq
 dSpQJnPUHLR4g634fW5u7QXBJyF9Z9M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200095

Hi,

On 20-Aug-26 02:32, Daniel Golle wrote:
> h5_btrtl_resume() open-codes a deferred re-probe for RTL devices that
> lose their firmware state over suspend: it takes a module reference,
> allocates a work item, and the work function calls device_reprobe()
> and then ends with put_device(); kfree(); module_put(THIS_MODULE); in
> module text. That final module_put() is racy: once the reference
> count is decremented a concurrent rmmod can free the module text
> before the work function's epilogue has finished executing. The work
> also does not synchronize against shutdown or unbind, so a stale
> re-probe could undo an administrative unbind or detach a device whose
> ->shutdown() callback has already run.
> 
> Convert to the new device_schedule_reprobe() helper, whose work
> function is builtin text and which skips the re-probe when the device
> was removed, shutdown reached it, or it is no longer bound to the
> driver that scheduled the re-probe.
> 
> The old worker suppressed its error message for -EPROBE_DEFER; the
> helper needs no equivalent because its attach half is
> device_attach(), which folds probe deferral into the deferred-probe
> machinery silently.
> 
> Behavioral changes:
> 
> - A pending re-probe no longer pins the module: rmmod with a re-probe
>   pending now succeeds immediately and the re-probe becomes a no-op,
>   instead of rmmod failing with EBUSY.
> 
> - A re-probe scheduled before a system shutdown or before an
>   administrative unbind no longer detaches and rebinds the device
>   afterwards.
> 
> - A re-probe racing the next suspend now detaches immediately while
>   the probe is deferred until the following resume by the
>   defer_all_probes machinery, instead of probing mid-suspend.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Thanks, this looks good to me and works as advertised on
a device where this code path gets hit:

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/bluetooth/hci_h5.c | 43 ++++++--------------------------------
>  1 file changed, 6 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 93cdde981840..68eaa03a2005 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -990,7 +990,7 @@ static int h5_btrtl_setup(struct h5 *h5)
>  static void h5_btrtl_open(struct h5 *h5)
>  {
>  	/*
> -	 * Since h5_btrtl_resume() does a device_reprobe() the suspend handling
> +	 * Since h5_btrtl_resume() schedules a device re-probe the suspend handling
>  	 * done by the hci_suspend_notifier is not necessary; it actually causes
>  	 * delays and a bunch of errors to get logged, so disable it.
>  	 */
> @@ -1047,46 +1047,15 @@ static int h5_btrtl_suspend(struct h5 *h5)
>  	return 0;
>  }
>  
> -struct h5_btrtl_reprobe {
> -	struct device *dev;
> -	struct work_struct work;
> -};
> -
> -static void h5_btrtl_reprobe_worker(struct work_struct *work)
> -{
> -	struct h5_btrtl_reprobe *reprobe =
> -		container_of(work, struct h5_btrtl_reprobe, work);
> -	int ret;
> -
> -	ret = device_reprobe(reprobe->dev);
> -	if (ret && ret != -EPROBE_DEFER)
> -		dev_err(reprobe->dev, "Reprobe error %d\n", ret);
> -
> -	put_device(reprobe->dev);
> -	kfree(reprobe);
> -	module_put(THIS_MODULE);
> -}
> -
>  static int h5_btrtl_resume(struct h5 *h5)
>  {
> -	if (test_bit(H5_WAKEUP_DISABLE, &h5->flags)) {
> -		struct h5_btrtl_reprobe *reprobe;
> -
> -		reprobe = kzalloc_obj(*reprobe);
> -		if (!reprobe)
> -			return -ENOMEM;
> -
> -		__module_get(THIS_MODULE);
> +	if (test_bit(H5_WAKEUP_DISABLE, &h5->flags))
> +		return device_schedule_reprobe(&h5->hu->serdev->dev, 0);
>  
> -		INIT_WORK(&reprobe->work, h5_btrtl_reprobe_worker);
> -		reprobe->dev = get_device(&h5->hu->serdev->dev);
> -		queue_work(system_long_wq, &reprobe->work);
> -	} else {
> -		gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
> +	gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
>  
> -		if (test_bit(H5_HW_FLOW_CONTROL, &h5->flags))
> -			serdev_device_set_flow_control(h5->hu->serdev, true);
> -	}
> +	if (test_bit(H5_HW_FLOW_CONTROL, &h5->flags))
> +		serdev_device_set_flow_control(h5->hu->serdev, true);
>  
>  	return 0;
>  }

