Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9F38F94
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 01:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403595; cv=none; b=RokrQu7Jcl7Bz630YKxyfOXYg3x5i/4k/DW432QIQBYkOVd+psu1X6/x6Pv+R1+DLpNcSFL4NpBaxrmCnl8KuDNTL/7gHUUuJ0xeuaZdacGa9C/7gBp2lk9a/p3F4pG3NX2OZ8v1m1F6RqPFcprGf2yLR3YMTJ2sJ63CfCIc88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403595; c=relaxed/simple;
	bh=WyllHhmZOKdd4Ms2fFbhBoTfHFi1FdCdtSbmb8JKTgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RuLyCOQBHq4F2VA2pOfRv1f68Ttgp1lf61JN/2Xut55ZgRmTUi6Nv05td+HTU1qMXI4GFBxnRpXygKSib818tzu/KN7OcOGLS1F/OYoOltQrZ6hlJ0Ux3VsekeyzUORZLrxu2EYvQtzZ35n4ijAtj0CcT+zlJgf5XJ+3i3TjKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gW3IZD0B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gW3IZD0B"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I0fw5Z014482;
	Thu, 18 Apr 2024 01:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1LNbQBuXpRmKddiIQvA5UYSDIET2v7RLrdvOSKvcBck=; b=gW
	3IZD0Bifv7vqqwnYZsEewv8+WUBWhj7MJigw1BNT6aY2CeuKuErtk/X/e2fzlkrv
	HUYolRExYvsGhROFJ4rwYJpLnwlKNyK+wCHZIorHVR83ICXf0EUukiCQjnIxYLKX
	dRSxLLgpyRveOMxOeL2gFC4mllgoUfy0lSduwA8+sYTs9Qf+v7cntyMxY9awIEet
	xDSlmRQme1QoaAxVtMAuFp1cqJ+dn3QxFalF5kea6mOleNLwZwX3j0a1D0J88i9Z
	x3HxEVjMIfHQKbUEb7IcJarNr3dJ99pRniEGpmZlkBqiXcEyxMd25MKzc6FbXR97
	8f1WsPAbYCoLdw5IQOIA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjf8a205d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 01:26:29 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I1QSxV009088
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 01:26:28 GMT
Received: from [10.253.9.153] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 18:26:27 -0700
Message-ID: <0d7c43dd-6301-465f-b881-5efef708a96c@quicinc.com>
Date: Thu, 18 Apr 2024 09:26:24 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] Bluetooth: qca: Fix wrong soc type returned for
 tool btattach
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713358336-29619-5-git-send-email-quic_zijuhu@quicinc.com>
 <CABBYNZLRyZu5mEtMjfoQA0VFZrBBbNK5KSYGM4uUrQ5EgmZS6A@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CABBYNZLRyZu5mEtMjfoQA0VFZrBBbNK5KSYGM4uUrQ5EgmZS6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CosjuRVDeSCIFWfwKMmmouDFKO1J2O1O
X-Proofpoint-GUID: CosjuRVDeSCIFWfwKMmmouDFKO1J2O1O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180009

On 4/18/2024 5:39 AM, Luiz Augusto von Dentz wrote:
> Hi Zijun,
> 
> On Wed, Apr 17, 2024 at 8:53 AM Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>
>> qca_soc_type() returns wrong soc type QCA_ROME when use tool btattach
>> for any other soc type such as QCA_QCA2066, and wrong soc type will
>> cause later initialization failure, fixed by using user specified
>> soc type for hci_uart derived from tool btattach.
> 
> Then we have to fix qca_soc_type or explain what is going on that it
> can't detect the soc_type if initialized via btattach?
> 
perhaps, my commit message is not precise and cause some mistook.

for tool btattach, only default QCA_ROME is used, there are no way to 
get right soc type for other BT controllers. so i introduce a ioctl to let user specify
soc type info used. so i fix qca_soc_type() to use user specified soc type for tool btattach
case.

1) different soc types have different responses for VSC which is used to detect soc type
as shown by. so soc_type is can't be detected and it  is needed by config by DT|ACPI or user specified.
int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
			 enum qca_btsoc_type soc_type)

2) soc type is a critical info, and it is used everywhere by hci_qca driver, it is also used to
decide which BT firmware to download as shown qca_uart_setup(), it soc type is not right. it will download
error BT firmware and cause serious results.

i will correct commit message for this patch.

>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/bluetooth/btqca.h   | 1 +
>>  drivers/bluetooth/hci_qca.c | 8 +++++++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index dc31984f71dc..a148d4c4e1bd 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -153,6 +153,7 @@ enum qca_btsoc_type {
>>         QCA_WCN6750,
>>         QCA_WCN6855,
>>         QCA_WCN7850,
>> +       QCA_MAX,
>>  };
>>
>>  #if IS_ENABLED(CONFIG_BT_QCA)
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index c04b97332bca..7c3577a4887c 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -238,12 +238,17 @@ static void qca_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb);
>>
>>  static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
>>  {
>> +       /* For Non-serdev device, hu->proto_data records soc type
>> +        * set by ioctl HCIUARTSETPROTODATA.
>> +        */
>> +       int proto_data = (int)hu->proto_data;
>>         enum qca_btsoc_type soc_type;
>>
>>         if (hu->serdev) {
>>                 struct qca_serdev *qsd = serdev_device_get_drvdata(hu->serdev);
>> -
>>                 soc_type = qsd->btsoc_type;
>> +       } else if ((proto_data > 0) && (proto_data < QCA_MAX)) {
>> +               soc_type = (enum qca_btsoc_type)proto_data;
> 
> Like I said a vendor specific ioctl will not gonna fly with me,
> specially since each vendor may need a different size to describe
> their controller version, etc,
> 
i have comments about this part of this question in reply for  [PATCH v2 3/4]

hci_uart->proto_data is a protocol specified unsigned long data, it is parsed
by specific protocol, for protocol, it is parsed as soc type. so force cast to 
(enum qca_btsoc_type).

hci_uart->proto_data is mostly similar as @data of struct struct of_device_id defined by
below header file. it is assigned with misc data type and explained by specific device driver.
include/linux/mod_devicetable.h:
struct of_device_id {
	char	name[32];
	char	type[32];
	char	compatible[128];
	const void *data;
};

  
>>         } else {
>>                 soc_type = QCA_ROME;
>>         }
>> @@ -2281,6 +2286,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>                 return -ENOMEM;
>>
>>         qcadev->serdev_hu.serdev = serdev;
>> +       qcadev->serdev_hu.proto_data = 0;
>>         data = device_get_match_data(&serdev->dev);
>>         serdev_device_set_drvdata(serdev, qcadev);
>>         device_property_read_string(&serdev->dev, "firmware-name",
>> --
>> 2.7.4
>>
> 
> 

