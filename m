Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25CA419304
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574353; cv=pass; b=EilKWyxLqDNrPcPU/IQM8rPXFO2vI1laR24hT2ofOVSRyTU//gYHg5R/fpN8q1ligoMmM5OwHo+V8TAKj0tY03t6JENESn9bIGPQG+92iJRptI2TOU0of3zmxHnkjtj2bgRrEmvKy+/AKvp+7NqcrhEovlQcmzXzk0TlTvVujXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574353; c=relaxed/simple;
	bh=EM9bCzQQJ4OUvrhTi7qLp/7RXgiqouvqN4wUHge2o94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSxsx2NINes61e2vSs5wOIOxE7RNsWEG9DgArBM6dL55zq0m/0BWI48IkMLNIS+DUbfKbQThLFUJq0pRXcIW6PY742gcL1euh4dJaM9q6SbxF+ZQ/pxjBVb1YUQwVDSBF97EKslsK63GgV/Zud6+7p195gAUaUurrE9XU8oHMAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jnAlhD7t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JxYBLeul; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jnAlhD7t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JxYBLeul"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMSWV2376843
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 12:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cWWhsjdtQXy+Cxts6bCE7RM3GSp55+P++lOKTU6EURc=; b=jnAlhD7tSvpdPHA8
	fwbhDki6Ow82A9JO5/Lw7OtxpuPF9c1/cxuxBJo/MpCb4nAfAAi8tJCfMBRBINli
	Y10Mu17Pr9Ug/HapI5tqLOPtGhnNpVkGuuMkjhfoT3VguT/xsrzAFX1oWyhue8jU
	PsQcZVuoxHZSB97145sYaIxguMUoUq3olvXi90A8YNNhSc2zrXpvU9hNJuZpeYz9
	z8c29vZ3NAo4+X86gL7AHG/fQxXFTdUFrmavBxDiMYohWt2FLszruqysuWWnqWQT
	lUlUUmWUvi/DVlXPDxIKH6yAu4JOz5YoEsCEdiRge1sauV1BLy/c75QcpSnyYzAW
	bBk2pw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hbth8g7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 12:25:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92ef13b61bcso511632385a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 05:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787574350; cv=none;
        d=google.com; s=arc-20260327;
        b=Z+20ROAEe1OZHEqkp0X/ClfqrXeDaqZPcT47Bl9T7nqGkr2Ii8fWnP6vZgf7YH8zWl
         KQUE2eVCc2qJlq60FumiGSc94NhvHzQN+Ed5LWazOmnzo6m5GWt8t5haXiMoMDVvs8hL
         yOpLJkRxgbvsIHRsR/7/XhFaV1PesO4JhyFw0do+P7wfF/NcDhTLoNGORC/kdeIv6CK/
         bjByW+o/DM42UcDOdqOY2X9ZQo0IPHc5zfS4cKmE+IWqaILdbWwcQkhJG5D5Jw2UGW0W
         lYzLYvMBBWv43JJYJZ4ncFHuep0nUlrB1qh8DLbao5luPyXQdfs+jCobtS/kT1RUJEEd
         jFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cWWhsjdtQXy+Cxts6bCE7RM3GSp55+P++lOKTU6EURc=;
        fh=H2IlIWQ6Ivn3n7J5kaXZXi02YwonRaiEHjPlr5oUjt4=;
        b=InJBoXLJhBuKnB7byoTqAed6Tqz2hQzZMEgSxovD6QNs1jNAu3WPE4yjbs9iPw47L0
         qpS5ea9Iewc/aeTZpyd1RxVJLwYw1j3Mg8LZ6puQLYyTVe1Y6cCeIVYmVEUyuyTjyBE5
         vS1DgsAeXx1/NS5doYgKKDbONSjOQm1D7m5NQcUABXapx7IgtUSicm9XQk+yq6lmGH/B
         Vtb3cPR2zgBbwyBwi0rM/+ANheQqwYv/6TI7+XEaq4+pxrmt0pEoidKzVB2jjNKWGCPl
         TW8hWWHQ863M7p1MiMphylmrQTzasHj4tn/1KcFrYHxnrpt2uCIcOgW60INgfWfTLmTH
         UQqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787574350; x=1788179150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cWWhsjdtQXy+Cxts6bCE7RM3GSp55+P++lOKTU6EURc=;
        b=JxYBLeulzV9TYsIWMBD8qjBJIknkDoEMpK8J5IN7L1ytQ0zsWwTrK8HgACUYh6zP4A
         LdHiiRlIDnnQz+ry5NTKexFDbO3suJjcieHWEI/z1P1SAUkTKIYiL42Xe9crhuFDyhBz
         VcRqwbWjuZzc0BBlcaxm0shBwEvDBzoz9R/M+wtILDTwBMjcE3h05MquLb0zEqATWcpe
         ZdZ+iQFgjlAS8pekhKkBFnw1isqOdSCbzvVwSTzimUjOf/TjcbXgpznNxkGmUQfD7Siz
         vTZcR4R+ffj2G+wvBw3iKGF5FHnuItYx00Rz0suPPEfi008bQCABbzEVkzbqr/OnKcR6
         JK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574350; x=1788179150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWWhsjdtQXy+Cxts6bCE7RM3GSp55+P++lOKTU6EURc=;
        b=guxUPAvDnA3BKJ/nsjtLLGdUH0PNxqUsFCQPrxIqcLWJ6DxhKkxuEMKPzdbo+9JTcX
         7UmElR7EhUvAe/CzacRnMWUCI2TPEQqf+1ehiNcE7RA8zvHqPT3fA6T42jZUv9G7ikwW
         ze+JuMzk4q3D37aT2wbqA2SWRQBtfssdn2xLBkZLmJv9VkXw0Shpx90DAjynv2npEn4m
         0rMh8MRKVBiIPgUDFdZSnpJJAkGMsU9DBUL09Y8rUAtPExZ4FoWa48LQ3OC4LrOQRZOW
         j/iDZ+KhCgAwFxcFBKlgBzfPZGGBomWjX8hc6EfedyJq9yY9pk5dYOGsojlcxDuLEHJ9
         v3lg==
X-Forwarded-Encrypted: i=1; AHgh+RrrJrdX6JqGteuLXRwiyF88Hh3ekW64a779EtDfTJ/Ay51KA6y9FXVJF2hkRnob0ySgh0sYZJMI8fVYfaVKJ8s=@vger.kernel.org
X-Gm-Message-State: AFuF++ma+aU6WmRaMsPx11YdRA9tgjsmlODaXKpGk2I7bemqvY46iYF2
	NsM4PVUHlBqwbNvMKdxk1gZMcY9eMUjxfmUnzq7wZZU+y0x6NPZLWygTH9wWoqEM566mRcCunhB
	kbnL/1tgSqc9Yx0o7xZAokbxbhrPVVRZvzTntktL7Lydnf++jQ96qHcGWtXbUC3UUeXhh26IeIX
	U+fCylzZXyA/uOw5y4N88Y4fa29l4M3yUq4BK9uwgHl64v4Q==
X-Gm-Gg: AR+sD124IjKZzdK28MYWxSKRqgPxq4WrzUHAhWPKcW1d2IlHYYyDb0yIlU2CTNPi+Us
	/6Z0bZTCHTR4O5Yu6XA+X9AQnStgE/trIKbCPpvzBi4/WeujJiD1kk255rRfXTyb5NyWo+QUAkn
	doWA8UcHBLaGkKPSEQdh5VAcg+9zuIblMGRfkAmAai9Ii/WhWp8sFCRBCol7OSfLnixcKsYiS8B
	NWzrVri0gld9b1DNKh09UbUYRnpscJKyJIjSP1tHXGWuOVVScCA7NBec2/hS8Cfu9gkprR/JFTh
X-Received: by 2002:a05:620a:280c:b0:930:f129:1a45 with SMTP id af79cd13be357-9374695204bmr1543599285a.30.1787574349735;
        Mon, 24 Aug 2026 05:25:49 -0700 (PDT)
X-Received: by 2002:a05:620a:280c:b0:930:f129:1a45 with SMTP id
 af79cd13be357-9374695204bmr1543594285a.30.1787574349249; Mon, 24 Aug 2026
 05:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824071257.2791009-1-13875017792@163.com>
In-Reply-To: <20260824071257.2791009-1-13875017792@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 14:25:36 +0200
X-Gm-Features: AcwNN1WMsvQhCbXwWQQkULzbGu9Fca-AXDKhvudAj8poBVT6ObG-MCUlr0ImWAY
Message-ID: <CAFEp6-0Z+Y9ym=eMx6i-bpS4R+46H6p51KcdaSPG++8R05JKXA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()
To: Gongwei Li <13875017792@163.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gongwei Li <ligongwei@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwNCBTYWx0ZWRfX6TvFTJRAWHms
 5qF7qXbouii1SbDisSDGStRCz4qKgZc7DHWfbrjBkswcwC0hxo7+Oi8vCB7ppQeWOsNP7oGTUEr
 Ota61UMVgpdZ+O5w0MqiixKafpvVueIgbpY4MOAv7y1ahdR59JAq0eUzGEfRNIq5+jF6Ogsndhm
 u2HtrwE5GNy8QCB19Zg0YstL1PlAoUUEJFdl+yIGLLMUyTNsT/gV6oade06j/s0aD3DF6AsRdEi
 zR7yZf5fat0qB6aALud3UByPHpgh36jeSJuM4EIv0hWXq4dRG2cjfL2O9TOMbjIFUTyw14EU4/E
 GNR4D8UCPtCXrnanccj1w30sgiy8fJTpO11HW+xbHcSSp7E0alvpHadOr6QUKc0GeAHkI5Jl0v3
 j6qQl4vN8fml0L8VK4ns1R2nzXdt4scxDHnsU6Q5QAD6LMZdqF6iJJlgb+ZGXyafCQMC49AFthH
 QAqTGVlK1ZloF2b52+A==
X-Authority-Analysis: v=2.4 cv=JL0LdcKb c=1 sm=1 tr=0 ts=6a8c384e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=Byx-y9mGAAAA:8 a=-KoH-AusqlqdFvwdIOEA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwNCBTYWx0ZWRfX94hfJ7tH6pmQ
 hWqyejclQSQ/dPM74V6IK/w7F8Wc9iXBr+7jvFTv6F+ipQIUBy8b6YC4DCAtuyuJHz/X+J+/OJ2
 iXLZByv0MRL7O6Iuz8pUKPgRFrSe5Y8=
X-Proofpoint-GUID: vqFYLWuioRT6T5Pi4gIe5qFZu1hzykSO
X-Proofpoint-ORIG-GUID: vqFYLWuioRT6T5Pi4gIe5qFZu1hzykSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240104

On Mon, Aug 24, 2026 at 9:13=E2=80=AFAM Gongwei Li <13875017792@163.com> wr=
ote:
>
> From: Gongwei Li <ligongwei@kylinos.cn>
>
> wait_on_bit_timeout() returns 0 if the bit was cleared, -EINTR if the
> process received a signal and the mode permitted wake up on that signal,
> or -EAGAIN if the timeout elapsed.  It never returns 1.
>
> Hence the check "err =3D=3D 1" in mrvl_load_firmware() is dead code: when
> the waiting task is interrupted by a signal (-EINTR), the code falls
> into the "else if (err)" branch and misreports it as "Firmware request
> timeout" with -ETIMEDOUT instead of propagating -EINTR.
>
> Fix this by testing for -EINTR so that an interrupted firmware load is
> properly detected and reported.
>
> Fixes: 162f812f23ba ("Bluetooth: hci_uart: Add Marvell support")
> Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
> ---
>  drivers/bluetooth/hci_mrvl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
> index 516b8f74c434..52badd1fe81a 100644
> --- a/drivers/bluetooth/hci_mrvl.c
> +++ b/drivers/bluetooth/hci_mrvl.c
> @@ -307,7 +307,7 @@ static int mrvl_load_firmware(struct hci_dev *hdev, c=
onst char *name)
>                 err =3D wait_on_bit_timeout(&mrvl->flags, STATE_FW_REQ_PE=
NDING,
>                                           TASK_INTERRUPTIBLE,
>                                           msecs_to_jiffies(2000));
> -               if (err =3D=3D 1) {
> +               if (err =3D=3D -EINTR) {
>                         bt_dev_err(hdev, "Firmware load interrupted");
>                         err =3D -EINTR;

Then we can drop the above line.

>                         break;
> --
> 2.25.1
>
