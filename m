Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9350A8F
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554603; cv=none; b=B+xXY53dDWR4bedjOtqbUHMqheCyOz1I5+Pjekl6IEnmNQ+pL18SQ9ZGquZ9u/99A4pcsnp4grEGRgfkBPCq1XzAJIYhhfTQfsipMBv0CIhVpZCMW8iq/4E04S+T3hOV5KZZI76SVlDsMow35F/FQGV8l72GXAEHgcqBNzPX+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554603; c=relaxed/simple;
	bh=r2FjTv6MUPVAC1p5pT7yAYsAPNyoTkuHXMFNeEckzrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mL+vnOK2tSo0bFHjeYeGa7L5x/J1DLf1b8VmVwCA+i+BHl4Kigl/xpRaPPY4VaBsj2o0ccJ5mc5yZvvXbtX7FM2JljZeC4hBnEdC8oFiH0HYVAFTz1AL05KhIBX8/xFgRVb8iqrtA+6FUe11MebGXQthphOcH8UuVT3alRle6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mVg9AS9Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mVg9AS9Y"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RJt1BP029826;
	Fri, 28 Jun 2024 06:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y+JWoV9HOEKK/m4fZumhU62OrDGEW2iahe+uWDk/AFQ=; b=mVg9AS9Yk973COe2
	2VsMRHqSXu0EGWuEO3MZ037rk5gzhavpen+EiNXBicAKQF3cHKCtDzDyea6Bah1m
	KYJh6yVLdu4YCJNwBgIUail8DikD/e3maDXnop/FTnzjKsAYwSog4ejzpnM1vkzS
	Negqjv5X4I9dI525CCx2UA9elHFaVqFAIkUtVgRdYcIkwKQIM8sjl84iAMoLcUPc
	ZtrZu78jIUtuhAj2iYFsckfVUMlfAVlvrUiy+t0C5FpnTQ9TBNd8/o9hY3oAgu8y
	WpebceUcpbcGd50wbEOgeZ+5B57p/GA4tX8JjuVBBCuKggPKrCoth5yV38JlrD4E
	P6oDEA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400c46eb32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:03:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45S63DmP005573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:03:13 GMT
Received: from [10.216.42.157] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 23:03:11 -0700
Message-ID: <dcc28f25-d2ea-4480-a62e-da6b35b0efa8@quicinc.com>
Date: Fri, 28 Jun 2024 11:32:43 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] [PTS] Included peripheral mode for fixing of few PTS
 Test Cases
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>
References: <20240620112209.12287-1-quic_prathm@quicinc.com>
 <CABBYNZJxmK99e5uV8xHKsdijbeMXHQsTE+b1JjxZu5r43cfDmA@mail.gmail.com>
From: Prathibha Madugonde <quic_prathm@quicinc.com>
In-Reply-To: <CABBYNZJxmK99e5uV8xHKsdijbeMXHQsTE+b1JjxZu5r43cfDmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2oFo15CvjPs74kIrzBy1JrkCzsUjHL8r
X-Proofpoint-GUID: 2oFo15CvjPs74kIrzBy1JrkCzsUjHL8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_02,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406280042



On 6/20/2024 7:30 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Thu, Jun 20, 2024 at 7:23 AM <quic_prathm@quicinc.com> wrote:
>>
>> From: Prathibha Madugonde <quic_prathm@quicinc.com>
>>
>> Fix for below Test Cases:
>> GAP/SEC/SEM/BV-56-C
>> GAP/SEC/SEM/BV-57-C
>> GAP/SEC/SEM/BV-58-C
>> GAP/SEC/SEM/BV-59-C
>> GAP/SEC/SEM/BV-60-C
>> GAP/SEC/SEM/BV-61-C
>>
>> For all above test cases, PTS tool is adding Battery Level Characteristics in the GAP service. And PTS is expecting to write value to Battery Level Characteristics.
>> When IUT and PTS are connected from bluetoothctl tool, GAP service and its characterisitics are not showing in the bluetoothctl terminal.
> 
> Ok, this is sort of weird if that is intentional to expose Battery
> Level Characteristic on GAP service, so there is no Battery Service?
> Not sure why it would be using Battery Level either, or is this
> something you can influence with some (PIXIT?) configuration? If the
> idea is just to have the peripheral acting as a GATT client any
> attribute would do it so the choice here seems really odd, what I'd
> expect is that one could configure the attribute/handle that it wants
> to send the GATT operations.
> 

Thanks for your input, after changing the PIXIT Configuration above 
mentioned test cases were able to PASS.

--
Prathibha Madugonde

>> Therefore need to use other existing tools, here we used btgatt-client tool.
>> For GAP/SEC/SEM/BV-56-C , GAP/SEC/SEM/BV-57-C, GAP/SEC/SEM/BV-58-C test cases the IUT should be in peripheral mode(advertise and accept connection) and GATT client role as per GAP.TS.p44.
>> Added peripheral mode in the btgatt-client tool for PASSING those test cases.
>>
>> Signed-off-by: Prathibha Madugonde <quic_prathm@quicinc.com>
>> ---
>>   tools/btgatt-client.c | 97 ++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 91 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
>> index b47914da3..2b732e454 100644
>> --- a/tools/btgatt-client.c
>> +++ b/tools/btgatt-client.c
>> @@ -36,6 +36,8 @@
>>   #include "src/shared/gatt-helpers.h"
>>
>>   #define ATT_CID 4
>> +#define CENTRAL_MODE   1
>> +#define PERIPHERAL_MODE   2
>>
>>   #define PRLOG(...) \
>>          printf(__VA_ARGS__); print_prompt();
>> @@ -1633,6 +1635,68 @@ static void signal_cb(int signum, void *user_data)
>>          }
>>   }
>>
>> +static int l2cap_le_att_listen_and_accept(bdaddr_t *src, int sec,
>> +                                                       uint8_t src_type)
>> +{
>> +       int sk, nsk;
>> +       struct sockaddr_l2 srcaddr, addr;
>> +       socklen_t optlen;
>> +       struct bt_security btsec;
>> +       char ba[18];
>> +
>> +       sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
>> +       if (sk < 0) {
>> +               perror("Failed to create L2CAP socket");
>> +               return -1;
>> +       }
>> +
>> +       /* Set up source address */
>> +       memset(&srcaddr, 0, sizeof(srcaddr));
>> +       srcaddr.l2_family = AF_BLUETOOTH;
>> +       srcaddr.l2_cid = htobs(ATT_CID);
>> +       srcaddr.l2_bdaddr_type = src_type;
>> +       bacpy(&srcaddr.l2_bdaddr, src);
>> +
>> +       if (bind(sk, (struct sockaddr *) &srcaddr, sizeof(srcaddr)) < 0) {
>> +               perror("Failed to bind L2CAP socket");
>> +               goto fail;
>> +       }
>> +
>> +       /* Set the security level */
>> +       memset(&btsec, 0, sizeof(btsec));
>> +       btsec.level = sec;
>> +       if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &btsec,
>> +                                                       sizeof(btsec)) != 0) {
>> +               fprintf(stderr, "Failed to set L2CAP security level\n");
>> +               goto fail;
>> +       }
>> +
>> +       if (listen(sk, 10) < 0) {
>> +               perror("Listening on socket failed");
>> +               goto fail;
>> +       }
>> +
>> +       printf("Started listening on ATT channel. Waiting for connections\n");
>> +
>> +       memset(&addr, 0, sizeof(addr));
>> +       optlen = sizeof(addr);
>> +       nsk = accept(sk, (struct sockaddr *) &addr, &optlen);
>> +       if (nsk < 0) {
>> +               perror("Accept failed");
>> +               goto fail;
>> +       }
>> +
>> +       ba2str(&addr.l2_bdaddr, ba);
>> +       printf("Connect from %s\n", ba);
>> +       close(sk);
>> +
>> +       return nsk;
>> +
>> +fail:
>> +       close(sk);
>> +       return -1;
>> +}
>> +
>>   static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
>>                                                                          int sec)
>>   {
>> @@ -1709,6 +1773,7 @@ static void usage(void)
>>          printf("Options:\n"
>>                  "\t-i, --index <id>\t\tSpecify adapter index, e.g. hci0\n"
>>                  "\t-d, --dest <addr>\t\tSpecify the destination address\n"
>> +               "\t-p, --peripheral mode\t\t\tStar Listening on Att Channel\n"
>>                  "\t-t, --type [random|public] \tSpecify the LE address type\n"
>>                  "\t-m, --mtu <mtu> \t\tThe ATT MTU to use\n"
>>                  "\t-s, --security-level <sec> \tSet security level (low|medium|"
>> @@ -1720,6 +1785,7 @@ static void usage(void)
>>   static struct option main_options[] = {
>>          { "index",              1, 0, 'i' },
>>          { "dest",               1, 0, 'd' },
>> +       { "peripheral",         1, 0, 'p' },
>>          { "type",               1, 0, 't' },
>>          { "mtu",                1, 0, 'm' },
>>          { "security-level",     1, 0, 's' },
>> @@ -1738,9 +1804,10 @@ int main(int argc, char *argv[])
>>          bdaddr_t src_addr, dst_addr;
>>          int dev_id = -1;
>>          int fd;
>> +       int peri_cent = CENTRAL_MODE;
>>          struct client *cli;
>>
>> -       while ((opt = getopt_long(argc, argv, "+hvs:m:t:d:i:",
>> +       while ((opt = getopt_long(argc, argv, "+hvs:m:t:d:p:i:",
>>                                                  main_options, NULL)) != -1) {
>>                  switch (opt) {
>>                  case 'h':
>> @@ -1809,6 +1876,17 @@ int main(int argc, char *argv[])
>>                          }
>>
>>                          break;
>> +               case 'p':
>> +                       if (strcmp(optarg, "peripheral") == 0)
>> +                                peri_cent = PERIPHERAL_MODE;
>> +                       else if (strcmp(optarg, "central") == 0)
>> +                               peri_cent = CENTRAL_MODE;
>> +                       else {
>> +                               fprintf(stderr,
>> +                                       "Allowed Modes: peripheral, central\n");
>> +                               return EXIT_FAILURE;
>> +                       }
>> +            break;
>>                  default:
>>                          fprintf(stderr, "Invalid option: %c\n", opt);
>>                          return EXIT_FAILURE;
>> @@ -1836,14 +1914,21 @@ int main(int argc, char *argv[])
>>                  return EXIT_FAILURE;
>>          }
>>
>> -       if (!dst_addr_given) {
>> -               fprintf(stderr, "Destination address required!\n");
>> -               return EXIT_FAILURE;
>> -       }
>> +    if(peri_cent == CENTRAL_MODE)
>> +    {
>> +        if (!dst_addr_given) {
>> +            fprintf(stderr, "Destination address required!\n");
>> +            return EXIT_FAILURE;
>> +        }
>> +
>> +    }
>>
>>          mainloop_init();
>>
>> -       fd = l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);
>> +    if(peri_cent == CENTRAL_MODE)
>> +        fd = l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);
>> +    else
>> +        fd = l2cap_le_att_listen_and_accept(&src_addr, sec, BDADDR_LE_PUBLIC);
>>          if (fd < 0)
>>                  return EXIT_FAILURE;
>>
>> --
>> 2.17.1
>>
>>
> 
> 
