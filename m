Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795181996;
	b=ToMWFCcOHW59GkArZ7Zr8hkk+2s6xzCdSK9fx6TEhycq6d6aqX7lZi3zrcg1LxDhASfg
	 caKa9k7muXycDhKa5hXye/yfvhqT00AgpFMKnIQbF6vnwl7Ck+PMP4opoIdZL0i5N32Sj
	 u1M7iixhI8B3RIarpoPLEE4ENfJA3VjB6/XCGhril96XoI/30AHiVNqmCvjQadPWqVpCY
	 WCy4uMPyy+yJh1Bqbt0P7rkCvYN+t78O1tNvvCeja6xJTT4JdrTLrUdEArr/T6fQ+k8zr
	 5VnPEKFehqwJRJ88aSFFownhKu9tJdkYc/GAmN46RrSXpojgiy2T6imF9SHucYl/0fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181996;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HqMv/OV8MsEdJinmIa+2n6ss2Bycp38BjbJR4HiUnm8=;
	b=P+Z5dZsqsJE8QaqHQL9oLS3Bs0jWFp/Jd8ZebfYVGZ4Xk2KWzdSLwwVFzTIx0GbwCliK
	 YLLvL0IobmaY8ZWJTgFE5rNmXoyHkM5iLUIWWf/4smE+uwWSOd9T0Rbg6kbWsfJscKfja
	 YnNEfN1Qa8SEDEw8IQ3Z6R6GRceFK36qDbYdeLYPabL5dMh8YpzV/r9TWYRekIL7KMmJz
	 FgFd9YAUihpGKTfDPCBL6mnCvgTm9jAN53D3Kk/Wqj9Yo/3PtQonNfJ46DV34B2Tetolj
	 oXO79GIJp0imK03Um/PiADmCZ9m6kA04qpqNdgILjRHB5mnBOI5c3C0iee0J4LqlZcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ks+vR7iC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gH6eyv1Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452A5606A332
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 452A5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ks+vR7iC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gH6eyv1Z
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjrDs3731042
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HqMv/OV8MsEdJinmIa+2n6ss2Bycp38BjbJR4HiUnm8=; b=Ks+vR7iC0Clge7z8
	SvQ6m6iddv/cAiMHm5PvlZAwXCnYSHBBD9oXyLDBLyhgnrWlzBqvSlvZFSTF26n7
	IsSOcxGYyJ6an6d3PrTcZm/7aPWRsItbQdRhWC4cFU29gwSYLu20Ihh8W9LKP/nx
	79a4VC9fHjdBNMIFJ35mwZoyE0xkbB71sOdqeVCNcmmpx+GJqdTGjPqbcRVe4cqO
	AKrMMqW4P6c1C1jmuHO28JzzbYOtgLF4IPo5FcFsz1DbgzgWrK/RD2NKazv14qa7
	LefMfCi5D0uMoSb6lGxwOK6+WYGYy7ITeGWIAbys+Mib0dSDAf6lvn7xNk3YecjT
	E63yUg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2mm4gn2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:39:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-949b0d322fcso169997585a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 05:39:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795181993; cv=none;
        d=google.com; s=arc-20260327;
        b=D0DfF+xCrRLyq6Va14REe1U3IwFcPaECBOa0OazEuIdcZTnk/siUQOFdg8tVCTBu5K
         tYdZSNmC2WETSCM4qQbVELrnPLM3QrC4ax41ReqBLPnKPR0RAQHTSFS+p1t+IkiY2YxX
         h/PgWGfK3PwDdjRLIyuc/hHhsXMZGjIgl1Xs4KZaXh3+Oq8/exCz0Z9r7kV0AsvmrVEN
         HCql7qahJd0FUis7ptn4UkgYvZTVPvYHzZDeEK+n4cATpKZffnamN9thMFd7f7vOd3W0
         KRvQJOxaY3vU93BiJlvSq/BAvsYMtullBS9Sxg9VaHz1td+6mB9aFCi5UzXAuNittDzT
         gHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HqMv/OV8MsEdJinmIa+2n6ss2Bycp38BjbJR4HiUnm8=;
        fh=yZ+EYHNlYC0lz5qJ2iKq9p9rBjMA8KdsVaEawjhxZM8=;
        b=lskgytxYy6EptJc2wINyu/mlNOpqoy1OCDdnA0ycXN0xJS021mjdrm0cqkZFkrvdms
         KbCla25hxDtw1GFtKEyNoEMfxgXwKd+43IsIwWzTZJ9/KWU6/cBJCIvjHFZsQR5Z9sTR
         f0Q0aemaTh+piW2r+6MT9icZ7PXSvyq/YvuaaGnmyshVDcrpiHw7lCGpwU2be+ZVOp2W
         ZLQOEGNzS4aazkBIiifBdmrIgFtd5qtrX1wb0ZzZUGp48dSFS2O0unPvuqecoWiK6VA+
         zhDg3OszBuDaX8SMug/8eoOrs1dPh6kkJUbAHR1iUuQJxLh6p5ch/6NPZH7G3z30lTMZ
         sJZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795181993; x=1795786793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HqMv/OV8MsEdJinmIa+2n6ss2Bycp38BjbJR4HiUnm8=;
        b=gH6eyv1ZC4qIyQO7+5eYFf2Ss01DCVVc8R4Wr45fkhie29q9Xki8R9BAmEQMR7uZ9h
         3odaNlmtRttWZjvz9Og369y7uPj3nv47hNLVtoieJAWmgN3cxxL1XH2tky2Z9xYqMtFz
         ORlx59ZcgR+A5l4YvlgIY4ux60RbFR/Q+3Oi/e1kdC98lWP3PkgtwZpoIgXmPb3jO5z6
         psH4CtKyf3JBjka9jiNFkwCB7RtgZXxX6GirWAH6iENnE7OdpkVUY7okQuC6zxkqR4H/
         xKdQ3pWq6avxltau/fa7v94GMh9mOfTOmQBuuGVkDzsM+AC6U46P7O0V6Ap4AHSbYzot
         NHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181993; x=1795786793;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqMv/OV8MsEdJinmIa+2n6ss2Bycp38BjbJR4HiUnm8=;
        b=kfh9d5TwvcMFjuCgjeIHDhpM0ZVQXptcCOTIBJzVEFq/lH6+4fxbvZOxfegMtxIMqI
         jJQp/KTrgGnGDHeXl+e4a0L2Fv9GB8/rWsRlmez8pvX/owqV2+uURBjPR5d1ReOwlYak
         RFRB5oFBkYk0kLRX5GfdVsKzImgmfViDt9XlFB7HWOMebiYQW/8y42ftbFL78vcmFok+
         XOVBTcSeTT/L+Ry3ffTdzCo1eUFAks1xAma1P9pm3v0hWeGQ3E8RI+CxUucQD0RNMKMP
         mYR9nOXqw68wCqS8qVJMGKmoriznd+Brro4E2UsGJ/+ecd0jTu0Fq9qMD8aaymqYZtnz
         gK5Q==
X-Forwarded-Encrypted: i=1; AL+hErFRwdwPCZdTXcFOjWUggguqDaLu7/80L4+g9NESMPCNL7KeVmhxKbkTc5vgJM8LY7tbsfTSXQFPWbFC3MN/D0M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wN9dGJdlEthoxF6CtV17CQgS024Ri8ziqv7Bz54yJRhW4glJp
	xhGmt2AEOgCAClcQW0s4xStreNxolk6Miln2djxC0OBMfOsQ0gUDAy/sYSQ1bNnbpCwTq6VGBb2
	opQbLsG4XnEd3uyeUDL4zoW9jGXRhOpjZn1MkN3SmY8TChp7Mg6wDLyr46pS6vWG5R//npyR9UH
	s8YgaFOxTrncgpVgMrv/YiCIbnuwlj3Egj6oLv/hM9iJse8w==
X-Gm-Gg: AYBFou2GTrasBG8GqMoNEBlGSogHsnKrlLRmpXmYygAL6dGPe1yluLilvMDBrJkzqYN
	vBzr+W5zEtafM8rz0a7Y1jJoXpd4iMaP2NKDhWhDv9SvDsKwd/g9JX105BP9QTtxgbW6B6Q1tEh
	cSkPwx4RTAJoOQuzV+AB4v4u1gWxSN3I0juJmk2IEGtOBZ1MzD8HlPJLJ+qTPY5PoeJAf+AX4TC
	lNjAuBywCJ+6wltkuHzx5IF8xt4h4bwf5KQDitngjOkCXZ85I/GG1bJU06FH4SJ4ojsXgOTFK0=
X-Received: by 2002:a05:620a:2949:b0:949:673f:72ca with SMTP id af79cd13be357-949ba9b4a76mr483537885a.42.1795181993366;
        Fri, 20 Nov 2026 05:39:53 -0800 (PST)
X-Received: by 2002:a05:620a:2949:b0:949:673f:72ca with SMTP id
 af79cd13be357-949ba9b4a76mr483533885a.42.1795181992773; Fri, 20 Nov 2026
 05:39:52 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120062048.40310-1-enderaoelyther@gmail.com>
In-Reply-To: <20261120062048.40310-1-enderaoelyther@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 14:39:41 +0100
X-Gm-Features: Aa3M54qlRjeHgSFR1P3wHaYy6O8vflIlT3vP_wsr0HOLoZAnrHp26MLwOWOnWts
Message-ID: <CAFEp6-37+O4BoSL414Njogr-34G7se-8Nu+O7B0zjBY1Jw7UWg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_serdev: stop write_work before closing
 the port
To: Zhao Li <enderaoelyther@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael McAllister <me@michaelmcallister.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: egDP0Ux6S25PnBwyQesfLxLmYuYw9zGc
X-Authority-Analysis: v=2.4 cv=RZYFmFtv c=1 sm=1 tr=0 ts=6b004dab cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=gJp14KxlFVqSh94YCh0A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX2QaFxxdB49bj
 MSQKj7aj5ckMVrR3t63Y3CjxiTF9MuMqVpDTbZXq8m2+GBIhE6vCI3SRLinyooGrC2WlT62VhC8
 9FHwo5Xz+MCJnxSMKGi+mCKldUWTyqY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfXwrSnPGQzVAYS
 T18WKpbvhBHPmTnFl7ywcGKdOTBV6GWkKLfPyGqvwwlK37/5Q+6gbM/CpYmTojWPihn2tlCN0Rs
 fKdziQbKJcjhCzehxjmMrs5YTJNuTgBirSgRr91nq8LeNDkgIyfytG5k/SU26IRmknMLd9085iQ
 EX3+1OqAGTQ0iZVTDMzTMAnk0aXDOLSrgqk+sUu7uqeoh5sPqjuSy6gmcOX053p4hdtWDch6BKf
 sUcGiCTCqvVh4rm5txp65zRMOH+E7QVXsUEgmfkG/wwbVJucDaZZUjErdAUJayv9gV6WFVMa/Fi
 9h3eouWXgMTnX0jgIffiAuoW7UIifL8v1bHQgu8mzHhTetO8y0yhndQfphrdI8C2VLGZO+sOISH
 s10qHgOscVP3Ey9LHwTqv74aKlqheUWDfUiVWxYzjk7iuhlST5A3o3504pEhOs4270WQXBGHllU
 czt1o0vC4SYLL2K5EqA==
X-Proofpoint-GUID: egDP0Ux6S25PnBwyQesfLxLmYuYw9zGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On Fri, Nov 20, 2026 at 7:21=E2=80=AFAM Zhao Li <enderaoelyther@gmail.com> =
wrote:
>
> With HCI_QUIRK_NON_PERSISTENT_SETUP, hci_uart_close() clears
> HCI_UART_PROTO_READY without hu->proto_lock and closes the serdev port
> without waiting for write_work. The hci_uart_flush() just before it
> re-enables write_work and may replay a recorded wakeup, and
> hci_uart_tx_wakeup() queues it from any caller that passed the
> HCI_UART_PROTO_READY test, such as the serdev write_wakeup callback.
> write_work can then call ttyport_write_buf() while ttyport_close()
> releases the tty, so it writes through a released tty.
>
> A partial frame that write_work leaves in hu->tx_skb also survives into
> the next open, which flushes nothing, and would be sent first to the
> controller after it is powered on again.
>
> Quiesce the transmit path as hci_uart_unregister_device() does: clear
> HCI_UART_PROTO_READY under percpu_down_write() so that no wakeup is in
> flight, cancel write_work, free the leftover frame, then close the port.
> A wakeup sets HCI_UART_SENDING and HCI_UART_TX_WAKEUP before it queues
> write_work, so clear both after the cancel: a work cancelled while
> still pending would leave SENDING set, and the next open, which reuses
> hu, would never queue write_work again.
>
> Found by code review. Compile-tested with W=3D1.
>
> Fixes: de8892df72be ("Bluetooth: hci_serdev: Close UART port if NON_PERSI=
STENT_SETUP is set")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> ---
> v2:
> - Clear HCI_UART_SENDING and HCI_UART_TX_WAKEUP after cancelling
>   write_work. A pending write_work cancelled there left SENDING set, so
>   the next power-on never queued write_work (Sashiko's review of v1).
> v1: https://lore.kernel.org/linux-bluetooth/20261118124821.3990-1-enderao=
elyther@gmail.com/
>
> Before 6.16 the quirk test in hci_uart_close() reads
> test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks); with that
> context line the patch applies to 6.12.y, 6.6.y, 6.1.y, 5.15.y and
> 5.10.y. It applies as is to 6.18.y and 7.3.y.
>
> No new W=3D1, sparse or smatch warnings.
>
> AI assistance was used.
>
>  drivers/bluetooth/hci_serdev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serde=
v.c
> index 194f11251cc5..a5e4b3d32144 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -164,7 +164,20 @@ static int hci_uart_close(struct hci_dev *hdev)
>          * open may drain the battery.
>          */
>         if (hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
> +               percpu_down_write(&hu->proto_lock);
>                 clear_bit(HCI_UART_PROTO_READY, &hu->flags);
> +               percpu_up_write(&hu->proto_lock);
> +
> +               cancel_work_sync(&hu->write_work);
> +               clear_bit(HCI_UART_SENDING, &hu->tx_state);
> +               clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);

Looks like you are mostly re-doing what has already been done in
hci_uart_flush()...
Wouldn't it be simpler to have a hci_uart_flush parameter to not
reschedule tx on flush?

> +
> +               /* Do not send a stale partial frame after the next open.=
 */
> +               if (hu->tx_skb) {
> +                       kfree_skb(hu->tx_skb);
> +                       hu->tx_skb =3D NULL;
> +               }
> +
>                 serdev_device_close(hu->serdev);
>         }
>
>
> base-commit: 1d79f61152c315e30e758116e525871732181a98
> --
> 2.56.1
>
>
