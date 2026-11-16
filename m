Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847291;
	b=f5Wv+5S42kEY6nWEbQ8YSzPPWpgCRBxym5V2CsRjdjzY7h3lnn3W0lMjAOHxueJQVxmq
	 7MmnJ2Hhcmjajz9Zf3X0MSAaK2AkpWEqq6eI1OycCQcAqZiO0qfRZpw/GtiI4aHdWL3Jg
	 hOXPI3Ha+EMAdKlWpG8atF+bJT4wBhvBokMnOm3hcnhwGWJG/aVqE6XbLfmQDC5mfi2AQ
	 qdCWOy1ymuOVBDMYXKv3GV+Owiuba8cMNHY267iawpM0wEkY95G2UhF75cnDMLWMwZvfe
	 0AdgmdldfXktIQLYQv5YNssBrflFbSLpmLThQhi0cEgxCT6upwTfjzBA0WCWC0HeFkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847291;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4qZkLMxYkgUaxwhWD/DbkSL4PS0JBXcFsajsekbEWek=;
	b=wDDJblwAp6ENPLL9EXy9+FFOXH+Idysc8JXrt0+/e9nC07J82GpVZ3YvbTXRlrVmUtL4
	 fOscFI5+OhhlUb6yXf32ETliMDtEuTjwyNLCb3Mo5xs893bj7TLh9RkHCBprluNz8Co/1
	 Nv8r+ID5vdQ2wW+7EVdRpIubLKsJuz8OwFi/O9bBg3+8Upp/WE6el0rFp73kHZkyqK8I+
	 lL+lH0lTvYQwOSgfNkhnkqFzuvkqxF6SlJcOvlnCMF7WcQtf8jdRpauw28lAM6DuPjXvN
	 j1cPu8fQCCty+JudgXbaU0PgjIG00/Yw427SlHFRkJm41x+XJnjrHF5krtmPhRZN5ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hdgMF+NQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YQT91hEi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D9606A329
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 16:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B97D9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hdgMF+NQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YQT91hEi
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGI8QL1110175
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 16:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4qZkLMxYkgUaxwhWD/DbkSL4PS0JBXcFsajsekbEWek=; b=hdgMF+NQZkdok22p
	J6V91c1iTQKYBMuU583CO+qwTF8p14sGxX5UZJYMWPNi1XnOVTbLw2NlK9XlG+Wh
	NlyPiwjXl2Yt8P8wJB+hyk6ilZbCqvvNpOWU4GTPBqCLgwQXWx/jbFZAZsuXwcl7
	OaOvE2zUeNQXnu68HUNqHUpzEYJ8UZQU+u9Ngbt8AjRITg865x7+oavU5TTTERpT
	q+DY9gM3S+pvafoPt/yYyclOaf9RlLsfh2vyyB3mYoJ5fWg79EY/t/wqtSWneoJv
	y8gKOYcBex9EOudDoz/cfhSiHvMjVDYAss1R9Ul8sDM86oL+lsA5I2gxCpwGGMP1
	P+ZmPA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqghgy5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 16:41:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e92aad34aso734863985a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 08:41:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794847289; cv=none;
        d=google.com; s=arc-20260327;
        b=qVKqPx9hJBqkNn7Dm56p8R0YLfae/ZOYxcZWRQkFnLAxzg3UP/GU3faGhSiWVqTMlv
         lUH3TEaMMWNGCLvOvnqcK9JcIcK62vPzFzX4Lhj2zjTWk7jq+atqR6GXa9x0sZLDXkN2
         hsLAj0LlhUh7BFYZUzQ9tczEnElsyVp0cy+o8SHuy32lAD2D871sGAmsK/h8qC+as0GB
         QKRWjyByOTd6wecQxttUDZNbcuznq5z/IQZUpIe5mBc/wg4m1RAVDbbReaRPUWY/xQpe
         ULFq/5cTzzlGMPb7RnJ/5FwSij6ErK9AcKG0NpVKgL0NzPk7AALpbDRvN9ktUprOdvFK
         r89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4qZkLMxYkgUaxwhWD/DbkSL4PS0JBXcFsajsekbEWek=;
        fh=l8fmy4aJo/9jnyUx4yCCG86gHRQc5hpIJjK/XyUDeZE=;
        b=sH64oodnHSdiTeIBxfLBpwEg0Z3g6xQvaeYvD3ZfXxdVCUq+nnpk4FqYbG4EOQ+dt0
         9FYonDEES7R5PHD4iD//eqT34QMk3VOY1PMnNJhfi9mBQYaKomnkEEkkRQBb18diDWIu
         450OjTwDmtpt3u+N9/jUmknB8of/ISxk+FypbvY8hqdt4sDW2dXK4XO/7aZ4jw3D5u4q
         P4pfjAde6yJFl6lurh0jFAROCjizXQcWfhGBTpb0bCgk3LdkDUDlOEbhTRDAvA1ggrfE
         paFVjWuuvmxzk/zkOUVx1x+VEmqqwAhFrteP5egh14FSjRqajOzB/h6io21lIfuq4FhF
         9EAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794847289; x=1795452089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4qZkLMxYkgUaxwhWD/DbkSL4PS0JBXcFsajsekbEWek=;
        b=YQT91hEi1mgvC7LHU9A5iqE/RkiCDzcB8l5VCZPHtE2UAutrA2LWHKYjH23ni4LkYa
         f8oMN+MNHf3SeV+ZbuHBf3bqpZZKsKBWbDzy9hrA+yaegimxMZRQxUjmVQJ2MZwPPRaF
         tzuyR6vwMy1y+GUVm9mn8LiaGLjGQ4RiLBlqYk/c/m8Wg0r705o5bps2u70dsvf9fbZ1
         bKG49NF5/6vKOHN7AhoUfgP97rUHjhWa8bMl/wEnBqcTPVs6zD5ELmBcWlUWGBUG7A43
         K1hxi5dggQhVrc0uo9MFeeon6BqGyKmAmeXjCiJM/VAGYi/mpzQL1wFCRmxev3H+1lAr
         SU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794847289; x=1795452089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4qZkLMxYkgUaxwhWD/DbkSL4PS0JBXcFsajsekbEWek=;
        b=v4FQj+oHK+5pJrSocsJzYyadt4zmHsqBfp4POI+fSL3dHeOL1b4SjLfHKcGS3+Tohs
         zM7skKqfR7IqNY3Bp39rJ0o92yhhj/LarmSm2P4CQoyvJ6KNTibd+pfMRucywCYsn86r
         g9kj0mWR4/2zU1wqc80pMb+R8weE9xbM3+aUuL3qBR8QkPMeBdQqzSkmCvC+o2k8Ebpr
         6GopvwDzHRfWcehzqFrecSQ5DuJIqvegPlQBaHWJMo4hpOSpy/K7shDWBh0J1iCJWBfN
         NHfMfYAlWb1+v2pvIswzRVP2w86qX8benb3xA2aKEhbasKzA8ZQwgyoeF3xMdcM5sqEI
         4aAg==
X-Forwarded-Encrypted: i=1; AL+hErG5eVqU1yHH3l9vsIirOV3T4BvVXfpokbgEArd2yyPwP0Act1nS34n0y8a3HqTVuuvlY1AQRoGWf8yVolF1KQk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yM7Bulv7VskexpyE5bmg5RKupiTD2ahlvPceCrBeyL2xeUWSm
	IQ3cGorgP9tc/OCSPEn6iZciL0b0ePYInmF4PeWm300XwFQBKi6axvYymGOaFhLzLdAEtKPg0LT
	c3pLwMTIWeHFP5Ez48fIiPkkyGNAKJpa9uLTHkRNuWMB2DbiaAKg+z7IeR3GZ1jY4O3BfNu5X6W
	LqdqLco7qAXd2qBoTtgamTpgM0c5HQ6LNBy8CTdH+KcgpXhw==
X-Gm-Gg: AYBFou2AHtsv2gRTzYXqejlOPNO82v3q80Mt7DhdE+CSGIR466Oi040GWxsUuwZbZ43
	+2YuImRnvL+B2ZKo5SBfHWl5uR9BAVEtDh7bekAbhgSuaGuyDl2zMiASfepXPut+Hj7xWMkxAtW
	ASMfHElj3PXaXLnhSCPfJ7JFsCprPkLwHaLnqwbMxWdS7B4bjmaFF3Q0lFJnX/zZ+2pRxkPJwJY
	A6aR9CJXYP0/DpNT3G/ig8cweheejMeu5+YMOcKImFbQ4j/3svUgQV8iswZ5aBkV7wQqPh2ZCvr
X-Received: by 2002:a05:620a:4012:b0:93e:6f43:b2c1 with SMTP id af79cd13be357-9494bb85888mr1819994485a.16.1794847288650;
        Mon, 16 Nov 2026 08:41:28 -0800 (PST)
X-Received: by 2002:a05:620a:4012:b0:93e:6f43:b2c1 with SMTP id
 af79cd13be357-9494bb85888mr1819990385a.16.1794847288180; Mon, 16 Nov 2026
 08:41:28 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179467295518.97469.12346516231160594592.marvell-serdev-v1-0@michaelmcallister.org>
 <179467295519.97469.5747232754111917783.marvell-serdev-v1-1@michaelmcallister.org>
 <179484691454.54083.14464729860702732145.marvell-serdev-v2@michaelmcallister.org>
In-Reply-To: <179484691454.54083.14464729860702732145.marvell-serdev-v2@michaelmcallister.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:41:17 +0100
X-Gm-Features: AclHuK-gWxq45ZclJ4O6NsxbJ6zdZFq59VI-w6TmYe42xNuv57HyC9kyCgswmyU
Message-ID: <CAFEp6-1CG9Hah3uobRG1ZHQsmuN0JGhmVg4cXgbrDgz0DWBVgw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_mrvl: Leave the serdev port lifetime to hci_serdev
To: Michael McAllister <me@michaelmcallister.org>
Cc: markus.probst@posteo.de, luiz.dentz@gmail.com, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NiBTYWx0ZWRfX0kQs04Rzwe7i
 dsXrTVx0F2NWsWI4SFC1v8/3KeAn2gY++ekqp9ssOuHWvTJfHma3ZK7I0VmbuIxmIGtmDw7s078
 5/+46Lq0UFiWTJiSfQucPxvizdUyac0=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afb3239 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=JwJ85b4fAAAA:8 a=EUspDBNiAAAA:8
 a=r5qjpY2wa2NEgfoDGsAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=qg2vb7sgHZQYDKbllo_a:22
X-Proofpoint-ORIG-GUID: 8NBWo-JtTPT02afirqfJYH8pbAjIdQLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NiBTYWx0ZWRfXx2wp2vXT8X5n
 +JfIWMRP76xSoakJOVIDXA49HhaFiCjgDljnm38lR0sz+iYVhdz6Jd9s1leW61S0MYnvy2Dcx1l
 x/zsqQ1uE7NkCWDn2hGGUwWQ6kDyoGSJvwrQtW3LLRLlQgBI+n50qM0u16QgEobRN5waeW9U/kG
 pS4ZGiTVjYvNcYLL4RzDfNRhhx3XoJ67UElz41As9an+N8AlvDNlGXrfv32xlvOPO99f9gjgN9M
 Uod0Rgrrhkph4kAMoATz+Jt6rMEfkQzPMADVS7cP5es0K06o1p8jYSISJxCo4KRmaUpet3WyaO5
 UJZfPywaSxMHAOzXjL4fGbXtlWaf5W3VHxCox5h+708Lfeb2CQlKYzQRQ/AWIUCwhZ4b+bX1CRY
 gnmAi9p1crjoOXWs53zca7lw7VnhHLtHY0pXWZYXrYYa8h6O6+vgFGsnss0FifNDWQUvD+/PeJL
 gvLAB2FwkOw92PtAX7A==
X-Proofpoint-GUID: 8NBWo-JtTPT02afirqfJYH8pbAjIdQLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160066

On Mon, Nov 16, 2026 at 5:36=E2=80=AFPM Michael McAllister
<me@michaelmcallister.org> wrote:
>
> hci_uart_register_device_priv() opens the port before calling mrvl_open()=
,
> so Marvell opens it twice. Likewise, mrvl_close() closes it before the
> transport closes it again during unregister or registration error cleanup=
.
>
> Remove the extra calls and let hci_serdev own the port lifetime. This als=
o
> avoids failing probe when serdev rejects a second open with -EALREADY.
>
> Fixes: be70e5e774a6 ("Bluetooth: hci_mrvl: Add serdev support")
> Reported-by: Markus Probst <markus.probst@posteo.de>
> Closes: https://lore.kernel.org/341e56b1ff7d8a5b109e26e30dfed61faa54d603.=
camel@posteo.de/
> Signed-off-by: Michael McAllister <me@michaelmcallister.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> Hi Markus,
>
> This just drops the non-standard trailer that checkpatch flagged. No
> code changes from v1; still looking for a test on Marvell hardware.
>
> Thanks,
> Michael
>
> Changes in v2:
> - Drop the Assisted-by trailer. AI assistance was used for v1.
>
>  drivers/bluetooth/hci_mrvl.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
> index 5798a8db0..def19907c 100644
> --- a/drivers/bluetooth/hci_mrvl.c
> +++ b/drivers/bluetooth/hci_mrvl.c
> @@ -57,7 +57,6 @@ struct hci_mrvl_pkt {
>  static int mrvl_open(struct hci_uart *hu)
>  {
>         struct mrvl_data *mrvl;
> -       int ret;
>
>         BT_DBG("hu %p", hu);
>
> @@ -75,17 +74,7 @@ static int mrvl_open(struct hci_uart *hu)
>
>         hu->priv =3D mrvl;
>
> -       if (hu->serdev) {
> -               ret =3D serdev_device_open(hu->serdev);
> -               if (ret)
> -                       goto err;
> -       }
> -
>         return 0;
> -err:
> -       kfree(mrvl);
> -
> -       return ret;
>  }
>
>  static int mrvl_close(struct hci_uart *hu)
> @@ -94,9 +83,6 @@ static int mrvl_close(struct hci_uart *hu)
>
>         BT_DBG("hu %p", hu);
>
> -       if (hu->serdev)
> -               serdev_device_close(hu->serdev);
> -
>         skb_queue_purge(&mrvl->txq);
>         skb_queue_purge(&mrvl->rawq);
>         kfree_skb(mrvl->rx_skb);
> --
> 2.39.5
>
>
