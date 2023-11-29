Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fq8gJM3a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02941AD
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 19:30:02 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT1VGKi010168;
	Wed, 29 Nov 2023 03:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TMxUY4W20UVsApuoA9XSrYF76gY5Ef7Zrgch7FDZ41Y=;
 b=Fq8gJM3aa5vgL+o8UsELhR9D1J4xezDCeDni6eLgKT3UDncBpaJWlTG414brilP463vV
 1k6PXd49PpiRXLrXKnGTBuI6r0p+4PtidOn8HcPI19UMhbKZ7xsr+7QwwV742cQPefXo
 kU1Hp5HP6YJX+2HfkRyJq9LpzcqSdpxnqT43BCP212hyPLjQZuAPizpzVe7eISA9ej+9
 0NVuJ9sfn2qBUtmaetthcYclgONOMzaZkOFES+QMsbpuwasYpLOxfmfzypY6J6UF8w53
 /7cAqiN3emRDz/9sZH7O1WTfZn7z7CEfRECM1DM8aUELsQm9+FTZCR9lgzrGfHG07UMW ew== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unhrpsqfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 03:29:59 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT3TwVE013679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 03:29:58 GMT
Received: from [10.253.77.169] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 19:29:57 -0800
Message-ID: <bdb15439-52cd-4727-843a-cf6250a5a984@quicinc.com>
Date: Wed, 29 Nov 2023 11:29:55 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Bluetooth: Support SCO offload for QCA2066
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>
References: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
 <CABBYNZK6UNm9SWhmJtvp-bzObTk-UR7GhK2U16ffFEe-bdpOoA@mail.gmail.com>
 <b767f792-912d-0386-c891-4f571217e846@quicinc.com>
 <CABBYNZLrdX5pxWNL86NcE7DvSzvLN0xMTaMvJ265=CvKYmMMcw@mail.gmail.com>
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CABBYNZLrdX5pxWNL86NcE7DvSzvLN0xMTaMvJ265=CvKYmMMcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -i6ASJlCKUX5YM2OxqTj8ViGACB1yafx
X-Proofpoint-ORIG-GUID: -i6ASJlCKUX5YM2OxqTj8ViGACB1yafx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1011 bulkscore=0 suspectscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290024

On 11/18/2023 12:02 AM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Nov 6, 2023 at 9:47 PM quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>
>> On 11/7/2023 12:16 AM, Luiz Augusto von Dentz wrote:
>>> Hi,
>>>
>>> On Mon, Nov 6, 2023 at 1:19 AM Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>>>
>>>> This patch series are to support SCO offload for QCA2066, ALL BTHOST
>>>> needs to do is specifying both Input_Data_Path and Output_Data_Path
>>>> as 0x01 for HCI_Enhanced_Setup_Synchronous_Connection, does NOT need
>>>> to configure data path by HCI_Configure_Data_Path at all.
>>>
>>> This part it doesn't need to use HCI_Configure_Data_Path seems to be
>>> non-standard, if so it needs to be handled by the driver, also it is
>>> probably a good idea to explain how it works, what are the commands
>>> used and the result traffic using btmon to collect the HCI trace.
>>>
>> My change does NOT touch current BT core driver logic at all. i just assign NULL to
>> hdev->get_codec_config_data within QCA device driver. so it follows current kernel
>> offload design.
>>
>> BTW, Core spec also does not specify standard procedures for SCO offload since it is
>> vendor specific.
> 
> We should probably document the expectation so it is clearer to the
> driver what to expect, also the offload must be selected by the
> application via socket interface as the HCI routing is the default, so
> if the controller defaults to offload that needs fixing.
> 
i will add comments within hci_qca.c to document QC offload usage as you suggested.
the controller(firmware) supports both offload or non-offload, if setup SCO/eSCO by
HCI_Enhanced_Setup_Synchronous_Connection with data path parameter as 0x00, then
controller will use HCI for audio data. if as 0x01, it will use non-HCI such as PCM.

From current kernel HFP offload design,if hdev->get_data_path_id() is implemented by
device driver. it means HFP offload is ALSO SUPPORTED. whether to use offload or not is
decided by user (upper BT application) as shown below:

if user wants to use offload, then they must include offload UUID in config option KernelExperimental
within /etc/bluetooth/main.conf and use setsockopt to config BT_CODEC.

if user does not want to use offload. then they just need to remove offload UUID from option
KernelExperimental

based on above understanding, i have below points even if out of discussion scope for this change.
1) term data path selection is more suitable than offload for current design.
offload related to performing HFP coding/decoding within controller. data path selection related to
transferring audio data by HCI or non-HCI such as PCM.

2) perhaps, use setsockopt to config BT_CODEC for offload AS DEFAULT within upper application or BLUEZ,
            and just ONLY use the config option KernelExperimental to controller if to use offload.

> As for this change in specific, the configure data path function can
> check if the driver does implement it, so we don't have to check it
> before calling avoiding duplicate code.
>
current checking is simpler and more suitable than below 2 alternatives to prevent 
send HCI_Configure_Data_Path since they need to take this scenario as error and return error code.
even if we indeed can't take vendor special design as error wrongly.

alternative 1): check and return error code within configure_datapath_sync().
alternative 2): implement hev->get_codec_config_data by returning error code within device driver hci_qca.c
                besides, there are no suitable error code for this case.
>>>> Zijun Hu (2):
>>>>   Bluetooth: hci_conn: Check non NULL before calling
>>>>     hdev->get_codec_config_data()
>>>>   Bluetooth: qca: Support SCO offload for QCA2066
>>>>
>>>>  drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++++
>>>>  net/bluetooth/hci_conn.c    |  2 +-
>>>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>>>
>>>> --
>>>> The Qualcomm Innovation Center
>>>>
>>>
>>>
>>
> 
> 

