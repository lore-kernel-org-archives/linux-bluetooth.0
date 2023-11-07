Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9120FB
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 02:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OYA+cwuq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD72811F
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Nov 2023 18:47:07 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A710C2N019140;
	Tue, 7 Nov 2023 02:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RsoWNKC3UN2XfcrsKv9ZmBvfpnXK36rQ+eshqsR+pPY=;
 b=OYA+cwuqzyogqQcGGYOAVcVX5jZzwWaFexc+eshPU1Fx0OqaWyHeKXgOw841s1kFDZIa
 Kx2bq7Nzu93+wxjFPzSLE5j/GQRxKlMM8qdsP7fY1PlTVNciAmd2J1IaqgBgFF8Khl9h
 jGV47pNADpydeqy3YAJ3nMIvNKAWtr0qtnV/Y442QWlHL0cqUwLUSyjZWSRP6oXDLtje
 F74xJPZnEPWYPXWKIDuSU88jo1WmTMsuuViipKNutNeL1I/OthsxMIs9HlTxPQz3AQKg
 LVASp6+YihV1+tZ3XEEKvBiRxF6tlHvxPVL47HG1jFbUF9nb1wJM2kvXyVZQqI61S/Ir uQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72r2992m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 02:47:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A72l3h7003831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Nov 2023 02:47:03 GMT
Received: from [10.253.35.13] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 18:47:02 -0800
Message-ID: <b767f792-912d-0386-c891-4f571217e846@quicinc.com>
Date: Tue, 7 Nov 2023 10:46:16 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 0/2] Bluetooth: Support SCO offload for QCA2066
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>
References: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
 <CABBYNZK6UNm9SWhmJtvp-bzObTk-UR7GhK2U16ffFEe-bdpOoA@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CABBYNZK6UNm9SWhmJtvp-bzObTk-UR7GhK2U16ffFEe-bdpOoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QWxvCfaE_3QZwIGlcYdtXydywTyQnEO4
X-Proofpoint-ORIG-GUID: QWxvCfaE_3QZwIGlcYdtXydywTyQnEO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=875 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070022

On 11/7/2023 12:16 AM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Nov 6, 2023 at 1:19 AM Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>
>> This patch series are to support SCO offload for QCA2066, ALL BTHOST
>> needs to do is specifying both Input_Data_Path and Output_Data_Path
>> as 0x01 for HCI_Enhanced_Setup_Synchronous_Connection, does NOT need
>> to configure data path by HCI_Configure_Data_Path at all.
> 
> This part it doesn't need to use HCI_Configure_Data_Path seems to be
> non-standard, if so it needs to be handled by the driver, also it is
> probably a good idea to explain how it works, what are the commands
> used and the result traffic using btmon to collect the HCI trace.
> 
My change does NOT touch current BT core driver logic at all. i just assign NULL to
hdev->get_codec_config_data within QCA device driver. so it follows current kernel
offload design.

BTW, Core spec also does not specify standard procedures for SCO offload since it is
vendor specific.

>> Zijun Hu (2):
>>   Bluetooth: hci_conn: Check non NULL before calling
>>     hdev->get_codec_config_data()
>>   Bluetooth: qca: Support SCO offload for QCA2066
>>
>>  drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++++
>>  net/bluetooth/hci_conn.c    |  2 +-
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> --
>> The Qualcomm Innovation Center
>>
> 
> 

