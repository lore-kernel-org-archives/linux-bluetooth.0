Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AA3890E0
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835978; cv=none; b=NROJiO3mJ9WHRF5tsmfjg56fF904z6Hjwa3Td+vipC0k79w7vhR0wrutVabdfclII7db+pEozqGT+3IpFG+7qohD6Eie60+m4F49xtAUOtF77VCHN59YVO6OgaPy8VoizfZ/yFK48lIHsNB1KyF1c6A54Yf2xbe7PD963kfhFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835978; c=relaxed/simple;
	bh=f6m+MjVluBwQOrBV+UlvyZlagmeScpeMJrIr2qlK2Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODnSN5V+q5ellUpVJRbjbCaNl76wXCPFnk6UIDtVuamoeKrBoMcnquKtY8u3ZrgPuQ4+w+L6mm6QoIwBQJ+e1vNIJrYWjKdh50Coc30YY89BdGOLZUBTOrhXqLJJUDO1E2HCW5MCSmIbn6cenG8r4dwYYkp+IIrv9i5dHlu60do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TniK7qS1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CLQu6Iqu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TniK7qS1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CLQu6Iqu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748vYeY325612
	for <linux-bluetooth@vger.kernel.org>; Tue, 4 Aug 2026 09:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f0/ffgDEcjjXA9y0j+W4lkEJvU8/s6OfIKNmngJqTvs=; b=TniK7qS161cDijBC
	+/VsFiCX/QIww927cY52Dv75rOR1qRhJzyTDwy7gno2ZfC4OEF0sGTyiiwPv8gw0
	wV00fR1DMdeXah0RYGvbzLcTk5JID82MR09mpkqkGPxzwrDWzbWqVcWWv6IgnxGC
	R+wLXrD1GlgqIBwEAgUD7YiJAMBZfdNDewPYcPEwwsVS9QOySSr+JjPWkxNAwLog
	bXIoahS9Nlwb4FG0TTjvb8Z9aF/1jwwPb+/wJ/lj/bwVKJQ0ug2CAKOrBLzZlEcl
	pz/FASWVtVn6hGvpfcKr4m4Ioh8ArHIRcCUFgdOjTgOA3cqEz84ad3pH0PwZc1XX
	mzFFSQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud1dg533-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 09:32:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848860def2cso5243475b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785835975; x=1786440775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f0/ffgDEcjjXA9y0j+W4lkEJvU8/s6OfIKNmngJqTvs=;
        b=CLQu6IqubUhL0BtDm3Q+jMj8SuVGoufR+VefzjSwZiD6k+uQtYdcNVvniHDHD6CStn
         EQqZ9GJdtDf77zx4VNvwNTLwUyU7Xf5s4qVg1GIhzj8bbJ0QNhA3lKpM92l7hyWKy2pn
         TYvr8yTwa44lfeyJHhalTMVxz3uUHt93dEPaH1QFzY4stCBlIWMFg8zT7VcOT6IoaXgd
         3G0qb4r5ZK3Y34f6t/CWRl+UgXT+AqHtP8ZsVOJm2yN5BfjcXSJyoJ5Q3INHUuCRsqET
         nBsc6YQuMGZS4Xp2nVNnROa++fNN5LbD3AfvSBGn/VD0c6Rxnkr7OzI7IaD2y+gNFxSO
         dmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785835975; x=1786440775;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0/ffgDEcjjXA9y0j+W4lkEJvU8/s6OfIKNmngJqTvs=;
        b=s85C1NczxHsJ/5pxSFNVrumt/0UF12vD6N9I74zvbocHJH+EQOx7k0jQK+jXXtsRi4
         Ci1hnl9T13MvQQ9P9sPnW/7/0R24SznQVZiE7BFgXmV0uvrmyhmIu8hAQNIKIRM1jfeR
         vwjpeylx5egwZ8RkxXFO5SwhUljz6aaRxp4OhXd6j+bY/JtvURmkdpWsZU2WdASCzH+p
         5f6jGUYNmxkKKPocPJQMi/lddBTC4xnheW28LJrBapykcOVRe5sceu+bEuQTOJNlS4kY
         0wHBQMqquVXAm5MxivsaTuukH/uYX57jiAPNIPFH5PdjhQTYEWBLANYKXvSZNZPOPR+q
         Rk7Q==
X-Forwarded-Encrypted: i=1; AHgh+RoBIMaKW4ijAOcSWN++jQl152yBPWypqOA6NGAwVXE+A7iiLRmkPgaweQMqR/pjObJcpoRhZYgNCNHE1WxvlZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzynaJ0JuEcPdNRuL3guK2nNlYOPhCfsFKc/BtQ+Rsi1fRlymvu
	sna7/pVG0crrSJwCd8YEL7BZ6FzSW17BHbbWg9M0awTpbcY/29fDVLaDvEjnd+4vlJPxZuP4GcU
	Oxr3crV/Wltdn1MkzJ5vFY4beHu8GeGJrKpGQN/Tq8PDSmUXG7gL1b155AQZExafAgYvyCTs=
X-Gm-Gg: AR+sD12e+JJx8mc9VKJtKwKy5q7KC1YN1rh47us7+4UZJvagbQ+qRvtW1zBM8n+6+ca
	f4yfcSQuG2Uao9sBdpmqqG4biye6w9Ba5ZuMbrxiA8BV5u7ovdGKQtpxFtsfLcZ9e6waY5YP+WJ
	Pm/yWpsQAk+UjMqzgXAbBjBM3EYTprAFAnsZX/Rt0iZBa5jsHroatBJY2n3WY2JHO4cK3djU5VK
	yY4GYOcVnHIgLwE94ZAkxK7sgzZMHjIkNTLk7ZXDK0peCcv+0b2UwP9JeX+qil35uAM5+PK+E9v
	7BrM0Lf6UQCZW9TGhfMyNqdR6o0R+nDFzVkBlmj4VKpYX9Mk64ukaAJ1JfmMa3Gqy1ruxlY1AEe
	pB4y1Ug+i/Dl/yQHZT77RqXRZfmkV
X-Received: by 2002:a05:6a00:12da:b0:847:5ec4:9a1d with SMTP id d2e1a72fcca58-84ee4995414mr11427141b3a.62.1785835975373;
        Tue, 04 Aug 2026 02:32:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:12da:b0:847:5ec4:9a1d with SMTP id d2e1a72fcca58-84ee4995414mr11427107b3a.62.1785835974964;
        Tue, 04 Aug 2026 02:32:54 -0700 (PDT)
Received: from [10.219.1.122] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d45afsm4849189b3a.41.2026.08.04.02.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 02:32:54 -0700 (PDT)
Message-ID: <59e76c3a-91ff-4fbb-936b-9a8464c60347@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:02:49 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Allow capturing QCA debug logs in
 snoop logs
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, rahul.samana@oss.qualcomm.com,
        harshitha.reddy@oss.qualcomm.com, yepuri.siddu@oss.qualcomm.com
References: <20260804-qca_logs_enable-v2-1-587d584ef4c2@oss.qualcomm.com>
Content-Language: en-US
From: Dishank Garg <dishank.garg@oss.qualcomm.com>
In-Reply-To: <20260804-qca_logs_enable-v2-1-587d584ef4c2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Rkv6aGWsFZ23U1lplZex_zZNByC8Dnri
X-Authority-Analysis: v=2.4 cv=SJRykuvH c=1 sm=1 tr=0 ts=6a71b1c8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=8xjHuzqBk6beOtrGZs0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: Rkv6aGWsFZ23U1lplZex_zZNByC8Dnri
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3NSBTYWx0ZWRfXz9azJOLkB/4T
 XL1BSWNJ3wRuKSuwM8qFNlfpljGF//+xgh8T45fKx9Tfupol66dIsLamzG3fqc3GNA/7fOoS91N
 gaOJ+dPbbW6DgdF1KfGixq/4LFPKSRM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3NSBTYWx0ZWRfX+UGfOkD3cZQX
 QwgC1ed2WX1Jfz4Sk7+PKqpgS6pk80fwToURp2GV19eqtkLpkF4iKKeY7+/S5MVJMslYxk3xC3P
 CrIxmr88lydMlY5LyPslKJMWg6eIujHMDmVr33lf8dYJikBv8qeJCc1bku+LjGsO/ZBBrHv1DOZ
 xnj+oZz90v/qGIuVMDyuSer5k5i+VMSCIRrj2A8i+DwpHSffLJIFHcAr/8G5pWg4qJgiVpawiPt
 QMt/E8F+/SEAS9ChyUAsMN0awemxFwvSoEGfFcDvFRfRQy5Pe7a7bc1QuRY2qyi/7OEpyTXaOWu
 BYmALPJbC7IohHi4ugMNpH74F87+GYeq1jiSU0r2c06H46/0UPZp4kWdlq7Rwmnn5jLkCVJxbIk
 v/dq4tLuo/LeWAevUHl13591D/V9ymq4erahcXamgFpbEzyRiUdvH6xIy983e0YTJi2cZ5EMjhU
 kweeRnNca5fIYcJKrvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040075


On 8/4/2026 10:47 AM, Dishank Garg wrote:
> Add a debugfs flag to forward QCA diagnostic ACL packets as regular
> ACL data, enabling their capture in Bluetooth snoop logs.
>
> Signed-off-by: Dishank Garg <dishank.garg@oss.qualcomm.com>
> ---
> This series adds support for capturing QCA controller debug/diagnostic
> logs in Bluetooth snoop logs. Currently, ACL packets carrying QCA
> diagnostic data are intercepted and routed to the diagnostic layer via
> hci_recv_diag(), which means they never show up in snoop captures.
> This makes it hard to correlate QCA debug logs with the surrounding
> HCI/ACL traffic when debugging issues, since the two have to be
> captured and aligned separately.
>
> The series adds a new debugfs knob, diag_as_acl, under the hci_qca
> debugfs directory. When enabled, diagnostic ACL packets are forwarded
> through the normal ACL receive path instead of being diverted to the
> diagnostic layer, so they get captured in the standard Bluetooth snoop
> log alongside all other traffic.
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://patch.msgid.link/20260804-qca_logs_enable-v1-1-4e209447da0e@oss.qualcomm.com
> ---
>   drivers/bluetooth/hci_qca.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 1222f97800f4..6996966319e8 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -182,6 +182,7 @@ struct qca_data {
>   	u64 rx_votes_on;
>   	u64 tx_votes_off;
>   	u64 rx_votes_off;
> +	bool diag_as_acl;
>   	u64 votes_on;
>   	u64 votes_off;
>   };
> @@ -698,6 +699,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
>   	debugfs_create_u32("wake_retrans", mode, ibs_dir, &qca->wake_retrans);
>   	debugfs_create_u32("tx_idle_delay", mode, ibs_dir,
>   			   &qca->tx_idle_delay);
> +	debugfs_create_bool("diag_as_acl", 0644, hdev->debugfs, &qca->diag_as_acl);
>   }
>   
>   /* Flush protocol data */
> @@ -998,12 +1000,14 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, struct sk_buff *skb)
>   
>   static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
>   {
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct qca_data *qca = hu->priv;
>   	/* We receive debug logs from chip as an ACL packets.
>   	 * Instead of sending the data to ACL to decode the
>   	 * received data, we are pushing them to the above layers
>   	 * as a diagnostic packet.
>   	 */
> -	if (get_unaligned_le16(skb->data) == QCA_DEBUG_HANDLE)
> +	if (!READ_ONCE(qca->diag_as_acl) && get_unaligned_le16(skb->data) == QCA_DEBUG_HANDLE)
>   		return hci_recv_diag(hdev, skb);
>   
>   	return hci_recv_frame(hdev, skb);
>
> ---
> base-commit: f5a7e2ae5f0a9a5caf59501457938eeb249a7dc8
> change-id: 20260803-qca_logs_enable-9b8197aaac09
>
> Best regards,
> --
> Dishank Garg <dishank.garg@oss.qualcomm.com>
Apologies for the confusion - the "v1" of this patch was sent as a test 
email to myself only, before I had added the actual To/Cc recipients. 
When I then sent it to the correct list with the full recipient list, b4 
auto-incremented it to "v2".
There were no changes to the patch content between the two - please 
disregard the v1 test mail and treat this v2 as the first real 
submission for review. I'll continue versioning normally (v2, v3, ...) 
from here if further changes are needed.

Best regards,
Dishank Garg
