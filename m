Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367D53AC
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401057; cv=none; b=WaRZ1zSXUk50jf60u+XwJ64p7WlS4Fuuwq22qx2M8Nx9Uz/tFzKx6I8+RE4XjQpZRzsXOiFd9GNMLe2lF4UwSAl9JSur5oC7/oGT3CeFOyWr1W+0ucdcYqEuELe5RCEdHHqj4Eq/hHA8HxaubGt8+A0qGIayRYUbSGT7CNrMvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401057; c=relaxed/simple;
	bh=aA/hzPDFwtes2tr83iy94JIEdPxIYnMbOjQ1pvaUxhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YU2cjiFQuSDVGxL3s6Sn2oD2Hls1RGslhRY7v+LDriaeLNWXDkvdQz3SgE6quDejmVadSP26+edtgqsi8wi8Hyachpfsw/BFfsRnE0UYEIv5dkHNSCfenUSvTEpjF69VHV90EFNcIXzIw/zOF6fYHudbgg70QDHuZRPF8/tM5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WtsjMMHq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WtsjMMHq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HNdAwP014608;
	Thu, 18 Apr 2024 00:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rD+mHmtU4mAFLFQFVxtNM6N4AgCUPCAOpF1iYtnrnPE=; b=Wt
	sjMMHqxLTYivoHYg4CAG/1fuX0Gs1cbYECtMrwRWCXF6hRbUCaj6IyD5/LJssry/
	QCdcbb7oJp1VmF1nYOeY9yE+RVHrwFmBss4oZNLmSXScT9OBMgqadjGCS3+rI9y/
	aigXlb3tv4qjNSvvRGzblUkdqTUihTGfpzg8K7fN4HGPqsbv3OUw+DUC9tktHfAX
	wVjK6IeeHTWf35Z1ycwnW47pMtGNGMPbNzGEeoKQitNynraYGumyKwk69f/ZAOux
	aAxtKqzkWnNT4ztmUPykw5sDpmqAtIJuUqHQx6/gEx2NN+S5S98WMX74yh9HUIQg
	Yy8IkVLpEtNRh5uyqQdA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjr92g41j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:44:11 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I0iAe7018326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:44:10 GMT
Received: from [10.253.9.153] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 17:44:09 -0700
Message-ID: <85d93186-f792-4b53-b885-fb2630dd9c6c@quicinc.com>
Date: Thu, 18 Apr 2024 08:44:00 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] Bluetooth: hci_ldisc: Add a ioctl
 HCIUARTSETPROTODATA
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <",linux-kernel"@vger.kernel.org>
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713358336-29619-4-git-send-email-quic_zijuhu@quicinc.com>
 <CABBYNZKPK8d2yKKDnpNrr0vYj1u4wygvL-bSuDva31mY-4BwEw@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CABBYNZKPK8d2yKKDnpNrr0vYj1u4wygvL-bSuDva31mY-4BwEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Hdla6IFl1e9g0WZvsLS9UpUzdR1mx62F
X-Proofpoint-ORIG-GUID: Hdla6IFl1e9g0WZvsLS9UpUzdR1mx62F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180003

On 4/18/2024 5:27 AM, Luiz Augusto von Dentz wrote:
> Hi Zijun,
> 
> On Wed, Apr 17, 2024 at 8:53 AM Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>
>> HCIUARTSETPROTODATA is introduced to specify protocol specific settings
>> prior to HCIUARTSETPROTO, for protocal QCA, it is used by tool btattch
>> to specify soc type.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/bluetooth/hci_ldisc.c | 10 ++++++++++
>>  drivers/bluetooth/hci_uart.h  |  3 +++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index a26367e9fb19..4be09c61bae5 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -506,6 +506,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)
>>         /* disable alignment support by default */
>>         hu->alignment = 1;
>>         hu->padding = 0;
>> +       hu->proto_data = 0;
>>
>>         INIT_WORK(&hu->init_ready, hci_uart_init_work);
>>         INIT_WORK(&hu->write_work, hci_uart_write_work);
>> @@ -795,6 +796,15 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
>>                 err = hu->hdev_flags;
>>                 break;
>>
>> +       case HCIUARTSETPROTODATA:
>> +               if (test_bit(HCI_UART_PROTO_SET, &hu->flags)) {
>> +                       err = -EBUSY;
>> +               } else {
>> +                       hu->proto_data = arg;
>> +                       BT_DBG("HCIUARTSETPROTODATA %lu okay.", arg);
>> +               }
>> +               break;
>> +
>>         default:
>>                 err = n_tty_ioctl_helper(tty, cmd, arg);
>>                 break;
>> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
>> index 68c8c7e95d64..fc35e9bd4398 100644
>> --- a/drivers/bluetooth/hci_uart.h
>> +++ b/drivers/bluetooth/hci_uart.h
>> @@ -18,6 +18,8 @@
>>  #define HCIUARTGETDEVICE       _IOR('U', 202, int)
>>  #define HCIUARTSETFLAGS                _IOW('U', 203, int)
>>  #define HCIUARTGETFLAGS                _IOR('U', 204, int)
>> +/* Used prior to HCIUARTSETPROTO */
>> +#define HCIUARTSETPROTODATA    _IOW('U', 205, unsigned long)
> 
> Don't think this will gonna fly, Im not going to introduce vendor
> specific like this, besides if the kernel is not able to discover this
> data why would userspace be?
> 
i don't think so as explained below.
1)
For the final product, BT device will get many configuration info from board configuration such DT|ACPI during
driver probe phase, But for tool btattach case, it has no way to get such configuration info due to derived from hci_ldisc.
so i introduce a new ioctl to let user specify some such required info when possible to make btattach work.

2) present ioctl HCIUARTSETPROTO has been introduced specify vendor protocol, why can't introduce a new ioctl to specify
protocol specific settings ? is HCIUARTSETPROTO vendor specific?

3) ioctl()'s designed purpose is for variant non-standard settings, do you have suggestions about how to specify device driver specify settings from user
if ioct() is not suitable?

4)
hci_ldisc driver don't parse and touch such user specified settings and pass it into vendor driver directly
does it has any problem?

>>  /* UART protocols */
>>  #define HCI_UART_MAX_PROTO     12
>> @@ -71,6 +73,7 @@ struct hci_uart {
>>         struct work_struct      init_ready;
>>         struct work_struct      write_work;
>>
>> +       unsigned long proto_data;
>>         const struct hci_uart_proto *proto;
>>         struct percpu_rw_semaphore proto_lock;  /* Stop work for proto close */
>>         void                    *priv;
>> --
>> 2.7.4
>>
> 
> 

