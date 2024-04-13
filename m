Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628041B7F4
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Apr 2024 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712976266; cv=none; b=Nu8MeWm/YijgpdVjaAR0X6D+Zamq1+Nr237vUnC42Oi8qpLqE0gWRO1Dd/NLJU9rz9TMncXlxKJHZXRF7wLX58eNZnwkszKgiKc6d+yqh2urTc4nYE9rAUFbsc60jl2pKjnG1YiyXESa5bmKfndOpM50M5mT+5qUyNzyf9pHmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712976266; c=relaxed/simple;
	bh=x9SuM9YQOZ9QZulFCq55OzVml36BWoJI3B4D7Ur2a4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FIR4oy22aNrne+o5u+74xAfJ5SPla6Q2kpXTQzt24+wVduCGH0x1t9qCmqY2jE3xNdJH7XbiOB9/vuBoIAHvkO/w6nx77jpCNSH120qkaC/Dr7AikmModTM9N/JUmtgGiADOCZduD98RrCY4NkgTFBom0Plkon+4cngwIH6WlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F4K89wNU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F4K89wNU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43D2HJv0009891;
	Sat, 13 Apr 2024 02:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ePSf3f2CM37AKrg7GeaMktgcf+KyrlUK2AdJiLzd7is=; b=F4
	K89wNUfAfVGUTt0Dl2rCYIFV5JN63s5qOXgZOlwhemXTXDKb8N5CBQ82FHrZHyWQ
	oxIi41Ekis0pDJsiu2wCH7uwoRZ3lnHTqoze/lrs9ocIqYcVVqvx5X4vtrt8cwaU
	zYtUl7we2VsaNL4uTyOcYAuwzxxu3Zp1CY0LQ9QR2xiB+xGsxsLXMzYgN6bebKHH
	Uv5hN8tPmyE/Q42DDGy7XtRLDzJIw4c/jDYRDCJgpqJ0PJXRSLdIX4GkoooBZEF1
	WyddC6yyer2v5ovMP5U7T+luDROz4GkpNuIzyN9GNw0SnUaqDpNc6Dd5nT+0V3f0
	AaGjMn+Is1ZodGoZpMFw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfdwcg9v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 02:44:19 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43D2iIFA017357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 02:44:18 GMT
Received: from [10.253.73.88] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 19:44:16 -0700
Message-ID: <5bcf5034-fea4-43c6-ac7d-db6f24b88512@quicinc.com>
Date: Sat, 13 Apr 2024 10:44:14 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v1] tools/btattach: Add support for more QCA soc
 types
To: Wren Turkal <wt@penguintechs.org>, <luiz.dentz@gmail.com>,
        <marcel@holtmann.org>, <jiangzp@google.com>
CC: <linux-bluetooth@vger.kernel.org>
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1712939188-25529-1-git-send-email-quic_zijuhu@quicinc.com>
 <1712939188-25529-5-git-send-email-quic_zijuhu@quicinc.com>
 <678721b5-4636-4268-836e-98c7a8ce36ba@penguintechs.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <678721b5-4636-4268-836e-98c7a8ce36ba@penguintechs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WUQZpS-_qXXENfkVd4pfBixBR62GPUUU
X-Proofpoint-GUID: WUQZpS-_qXXENfkVd4pfBixBR62GPUUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_18,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404130019

On 4/13/2024 4:10 AM, Wren Turkal wrote:
> On 4/12/24 9:26 AM, Zijun Hu wrote:
>> Tool btattach currently only supports QCA default soc type
>> QCA_ROME, this change adds support for all other QCA soc types
>> by adding a option to specify soc type.
>> ---
>>   tools/btattach.c   | 29 ++++++++++++++++++++++++-----
>>   tools/btattach.rst |  2 ++
>>   tools/hciattach.h  |  2 ++
>>   3 files changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/btattach.c b/tools/btattach.c
>> index 4ce1be78d69c..024b0c7a289c 100644
>> --- a/tools/btattach.c
>> +++ b/tools/btattach.c
>> @@ -97,7 +97,8 @@ static void local_version_callback(const void *data, uint8_t size,
>>   }
>>     static int attach_proto(const char *path, unsigned int proto,
>> -            unsigned int speed, bool flowctl, unsigned int flags)
>> +            unsigned int speed, bool flowctl, unsigned int flags,
>> +            unsigned long soc_type)
>>   {
>>       int fd, dev_id;
>>   @@ -111,6 +112,16 @@ static int attach_proto(const char *path, unsigned int proto,
>>           return -1;
>>       }
>>   +    if ((proto == HCI_UART_QCA) && (soc_type > 0)) {
>> +        if (ioctl(fd, HCIUARTSETPROTODATA, soc_type) < 0) {
>> +            fprintf(stderr,
>> +                "Failed to set soc_type(%lu) for protocol qca\n",
>> +                soc_type);
>> +            close(fd);
>> +            return -1;
>> +        }
>> +    }
>> +
>>       if (ioctl(fd, HCIUARTSETPROTO, proto) < 0) {
>>           perror("Failed to set protocol");
>>           close(fd);
>> @@ -181,6 +192,7 @@ static void usage(void)
>>           "\t-A, --amp <device>     Attach AMP controller\n"
>>           "\t-P, --protocol <proto> Specify protocol type\n"
>>           "\t-S, --speed <baudrate> Specify which baudrate to use\n"
>> +        "\t-T, --type <soc_type>  Specify soc_type for protocol qca\n"
>>           "\t-N, --noflowctl        Disable flow control\n"
>>           "\t-h, --help             Show help options\n");
>>   }
>> @@ -190,6 +202,7 @@ static const struct option main_options[] = {
>>       { "amp",      required_argument, NULL, 'A' },
>>       { "protocol", required_argument, NULL, 'P' },
>>       { "speed",    required_argument, NULL, 'S' },
>> +    { "type",     required_argument, NULL, 'T' },
> 
> I am guessing this means that there is no way to determine the soc from the kernel without the assist of the IOCTL? I also see this is a required parm. Is this not something that can use something like a devicetree for discovery so that the type of soc can be a property of the system instead of being manually specified?
> 
yes for tool btattch scenario. tool btattch is mainly used before the final board configuration phase(change DT|APCI to enabel BT), so it can't get such soc type info from board configuration.
for tool btattach, it doesn't need to touch any system configuration and is mainly used for variant evaluation tests before the final product implementation phase

let me take below process to explain its usage scenario.
Customer often buys a BT module from a vendor for BT evaluation, the BT module have BT chip embedded and are externally powered, the module also has a BT UART converted mini usb port,
they connects the BT module to generic ubntu PC by a USB cable, then they run tool btattach at the machine to enable BT and perform variants BT tests, when the evaluation results is expected,
they maybe buy the embedded chip and integrated into there target product's PCB, then change and compile DT to enable BT formally.

thanks 
>>       { "noflowctl",no_argument,       NULL, 'N' },
>>       { "version",  no_argument,       NULL, 'v' },
>>       { "help",     no_argument,       NULL, 'h' },
>> @@ -221,12 +234,13 @@ int main(int argc, char *argv[])
>>       bool flowctl = true, raw_device = false;
>>       int exit_status, count = 0, proto_id = HCI_UART_H4;
>>       unsigned int speed = B115200;
>> +    unsigned long soc_type = 0;
>>         for (;;) {
>>           int opt;
>>   -        opt = getopt_long(argc, argv, "B:A:P:S:NRvh",
>> -                        main_options, NULL);
>> +        opt = getopt_long(argc, argv, "B:A:P:S:T:NRvh",
>> +                  main_options, NULL);
>>           if (opt < 0)
>>               break;
>>   @@ -237,6 +251,9 @@ int main(int argc, char *argv[])
>>           case 'A':
>>               amp_path = optarg;
>>               break;
>> +        case 'T':
>> +            soc_type = strtoul(optarg, NULL, 0);
>> +            break;
>>           case 'P':
>>               proto = optarg;
>>               break;
>> @@ -298,7 +315,8 @@ int main(int argc, char *argv[])
>>           if (raw_device)
>>               flags = (1 << HCI_UART_RAW_DEVICE);
>>   -        fd = attach_proto(bredr_path, proto_id, speed, flowctl, flags);
>> +        fd = attach_proto(bredr_path, proto_id, speed, flowctl, flags,
>> +                  soc_type);
>>           if (fd >= 0) {
>>               mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
>>               count++;
>> @@ -317,7 +335,8 @@ int main(int argc, char *argv[])
>>           if (raw_device)
>>               flags = (1 << HCI_UART_RAW_DEVICE);
>>   -        fd = attach_proto(amp_path, proto_id, speed, flowctl, flags);
>> +        fd = attach_proto(amp_path, proto_id, speed, flowctl, flags,
>> +                  soc_type);
>>           if (fd >= 0) {
>>               mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
>>               count++;
>> diff --git a/tools/btattach.rst b/tools/btattach.rst
>> index 787d5c49e3bb..4aad3b915641 100644
>> --- a/tools/btattach.rst
>> +++ b/tools/btattach.rst
>> @@ -62,6 +62,8 @@ OPTIONS
>>     -S baudrate, --speed baudrate       Specify wich baudrate to use
>>   +-T soc_type, --type soc_type        Specify soc_type for protocol qca
>> +
>>   -N, --noflowctl            Disable flow control
>>     -v, --version              Show version
>> diff --git a/tools/hciattach.h b/tools/hciattach.h
>> index dfa4c1e7abe7..998a2a9a8460 100644
>> --- a/tools/hciattach.h
>> +++ b/tools/hciattach.h
>> @@ -19,6 +19,8 @@
>>   #define HCIUARTGETDEVICE    _IOR('U', 202, int)
>>   #define HCIUARTSETFLAGS        _IOW('U', 203, int)
>>   #define HCIUARTGETFLAGS        _IOR('U', 204, int)
>> +#define HCIUARTSETPROTODATA    _IOW('U', 205, unsigned long)
>> +
>>     #define HCI_UART_H4    0
>>   #define HCI_UART_BCSP    1
> 

