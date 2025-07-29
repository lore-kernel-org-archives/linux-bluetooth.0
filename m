Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C240579C0
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796975; cv=none; b=pxEmB295B1xKX6KR9wrGiTGKi8TqSnPQpXArxzmdOq3Pg86upL0RbGoTJldJqMN4yGDMXkI/lqDLELCEaFlADi1Kp2BefdoBY8Og4k9bNQHBPExiKYGhlwhdvLjk2ZorqzQ0C/P2Nh62gllQcSiPJOtgDhGeOzoqxbWbdKUF/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796975; c=relaxed/simple;
	bh=VfKnjou+066uF1ipQsFzTRaGUjEzbSzGV7Vb3Y+JU44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQfcZ+942TjtwQ0Bb7Do3KzI7E4js6mbi4MJifD9GArODhTNDtWW9AkPDSawqiRQoejWXY5u0vuxC1mRUVnj4ciakb6nfw4iEhQmMWsoxUkVDm/0BK2+kXfl0pHDNNF6344Ckqe3fvKOnaQaiIz9jLD5g/+SHmPytzeHnpqiKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jCclWLMv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jCclWLMv"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9fRrZ017653
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 13:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	61kk5jNvxyOz0SbCumRr64fLpCAMGc4bzaNs2SIldko=; b=jCclWLMviM0feQbp
	acEOIJYxvSXPmqSbEO1+zcuhurtEkzfVmDQFQMaw2tRLwelECTUGlYgpUmyczrGB
	UxFL2KaiYFoaoZlfIcDOiZ1FkUkLZ6izeyDG2o8oft2NKGzPw+Sa9Mb/6twEGTpK
	4M2Ip/O3O47gq/o9ZGatSgOa5jPV4I4/s17fTEiwXG0fTGUv51lCpFcwbJzfEskQ
	y0M5+ZhXFvSbZKOWAWKv37cOzHJ0A25+9gWSxaIrA0p5ce03XetpY1LzUyi/g50s
	NHFYWVnahaB8cZa7cu9njRasugeGh+SNb6BdQd2W2l8ZPdO+y3z83VOA/s+zeTki
	jgf/iQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2g74v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 13:49:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e33e133f42so115040185a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 06:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753796971; x=1754401771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61kk5jNvxyOz0SbCumRr64fLpCAMGc4bzaNs2SIldko=;
        b=QK6fkH5rZEbyzz6tgSE2ACQiRpuuwhVjut7x1Cgpux3QoSm45RgQfCZZEAfkAbtyYx
         lGhiedmUuX98VNtgK6BVm6u/GH/A1nqQFfeVP7kZ1HYe8lLtl/J+uUMQFJCF072kMkx4
         oigBiJ6Wr8EhAMhpLv2DOAW5KW7toW4k+cC01U2ah79zzyASW6NdPQd/0kL0KgE6z2d0
         gRsqLmSEBrzouFZsq+kyaNKMvtSMJTInBcUDjzP+9JtJpPDEaHZkhv2C+A6abOuidffc
         GOxkamYFdQksBxFw2F5DsPq7x2qPK/dse0k8BuRXtyKTru0m3ah6h22cObfHQVTBg8jL
         rdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5XMtCb6kqZ3RLeAUpiKZlo1kYhwkyG8YnVBs9Cl1YLgHYcOLBsxdm7I0hvEbQryKnDCQoCq31xdr8sqsipLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXSqkGbSeBSSTTA1uzofRs85/ieMgLQkbLUvDcZRB3E4Fpzzi4
	2Faj7t+wl32ZJ40Pm3VojMrkEbaYp7nbBtPf63yblyGryd4M9BMeX+lyQU02+dhNneFG0zpsz0U
	P3xW/FsrwEjWtPVz4ZHfc4h1yDW0KATvDocsI8X9ARVfLrjUYMm/hM2i1U56YhX0yYERRsf4=
X-Gm-Gg: ASbGncvwVgh4SfjV56CXGW/geBHE1p4USQdxGXDThEtUg6KBznbsMHvhA+8LRqd8Ywz
	hZK/ZtoTmB9WweAk/Y0HtH5rWmE4E9O/2crS2dFiqReLetB34Gpn5tcl0wTLTHaxC8MNgke9jYk
	sZAmQVSLcZ/+tFbsSEulpC6nBb1ikLzhmwl23I7uSNAyHy29A/fptm1SJaoU2OB6KGuJTdpU3g3
	IYXRL+p4k600wkoFIMNeC9WVzpp6GbPgke/2/wKv7xgjBeGTYzTdag54AdM83WoGzbYv6BZ0gPG
	BrXj9TVnAbfsz5TuoHH+XZJZmS/mKWAWyUJijTM6ctXENw6x3YD5rZxUjHQfnSW4x2tKkgMkxIY
	QerYrWXgaTyf4THrTRQ==
X-Received: by 2002:a05:620a:40cb:b0:7e6:3c4f:fff with SMTP id af79cd13be357-7e66d4b1af0mr5516085a.3.1753796970969;
        Tue, 29 Jul 2025 06:49:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/cjxXB3TqSvv6mMYVyunIjlcclP8mBW4l0J7rAIH3yOPfz1ez6vZZCzhqpworKGNcU2JTWA==
X-Received: by 2002:a05:620a:40cb:b0:7e6:3c4f:fff with SMTP id af79cd13be357-7e66d4b1af0mr5514385a.3.1753796970480;
        Tue, 29 Jul 2025 06:49:30 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a63121sm589037166b.67.2025.07.29.06.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 06:49:29 -0700 (PDT)
Message-ID: <489a1c80-e7b6-48ee-bee1-76e32a72a060@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 15:49:28 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: bluetooth: add callback to exe l2cap when
 read_security uncompleted
To: Shuai Zhang <quic_shuaz@quicinc.com>, linux-bluetooth@vger.kernel.org
Cc: quic_bt@quicinc.com, linux-arm-msm@vger.kernel.org
References: <20250627030229.1720287-1-quic_shuaz@quicinc.com>
 <7a823b6d-767b-4777-8db0-761a2d0e09be@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7a823b6d-767b-4777-8db0-761a2d0e09be@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: l_iLT9f8ZjENfV18Fh9G1i2V15zs67CV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwNiBTYWx0ZWRfX912zjiVvZ+gj
 HyBy40XbF/Q77+ptlcoluhs/lboy8kE4iRTvyuBcq1YBcfeBGeoFSDFB7izeUrcgNHt8YUji6RO
 J4p7P2bRWwW6mus5CN+my8e6TbSPlSSIFm1BJQJ51VuvNyNx2Yf5p1XvgUonDcEu4N3+3Bvnqb0
 Pnk+wgn5PPyAN1HlyAKJ+rz7fPyn0PLlRI7hreAwQseFuc9S/RLiYMI/SR4/PbAzD8HP6czcXHR
 PV+lKaw6an30jK49aCKKSkd7vhoodmHd0Y+JImUsSe2PDavj/6o0PNN1rhDFU5R7myWFW7sRFkK
 Eid1rHX3waD3n7QKm1ONiV1rbtm6sPHK2EBeeGBtyKECvRxBZ//Q9i5P11iSAAeYZb+0Z4fiMJK
 uiPnT7xlBnzhUbVFX7dD7WGWnYqCYMYlMtp6CwHhLoTueQ8GvdtE7ID9YTt5PeA3U5RuqsDK
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=6888d16c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Dei6p5SHAAAA:8 a=pGLkceISAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=COk6AnOGAAAA:8 a=aDRfdkeckOnu_uhJLj8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=M-Yerj1wOn-OpK7r_3ei:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: l_iLT9f8ZjENfV18Fh9G1i2V15zs67CV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290106

On 7/7/25 9:21 AM, Shuai Zhang wrote:
> Dear all

(Please don't top-post)

It would probably help if you included the maintainers in the To/Cc
fields, so that your email can actually reach them

When using the b4 tool, you can simply run `b4 prep -c`.

Please resend this patch and add these emails:

Marcel Holtmann <marcel@holtmann.org>
Johan Hedberg <johan.hedberg@gmail.com>
Luiz Augusto von Dentz <luiz.dentz@gmail.com>
"David S. Miller" <davem@davemloft.net>
Eric Dumazet <edumazet@google.com>
Jakub Kicinski <kuba@kernel.org>
Paolo Abeni <pabeni@redhat.com>
Simon Horman <horms@kernel.org>
linux-bluetooth@vger.kernel.org
netdev@vger.kernel.org
linux-kernel@vger.kernel.org

Konrad

> 
> On 2025/6/27 11:02, Shuai Zhang wrote:
>> When the DUT receives a remote L2CAP Connection Request during the Read
>> Encryption Key Size procedure, if it fails to complete reading the
>> Encryption Key Size while processing the request, it will respond with
>> a Connection Response – Refused (security block), resulting in the
>> disconnection of the remote device.
>>
>> Use HCI_CONN_ENC_KEY_READY to determine whether
>> l2cap_connect_request is pending.
>>
>> When l2cap_connect occurs before the read_enc_key_size event, it will
>> be pending because HCI_CONN_ENC_KEY_READY has not yet been set.
>> The connection request will be processed once the read_enc_key_size
>> event completes.
>>
>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>> ---
>>  include/net/bluetooth/hci_core.h |  3 +++
>>  include/net/bluetooth/l2cap.h    | 10 +++++++++-
>>  net/bluetooth/hci_event.c        | 16 ++++++++++++++++
>>  net/bluetooth/l2cap_core.c       | 30 ++++++++++++++++++++++++++++++
>>  4 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index b47c74080..db329abbf 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -767,6 +767,8 @@ struct hci_conn {
>>  
>>  	struct bt_codec codec;
>>  
>> +	struct l2cap_pending_connect *pending_connect;
>> +
>>  	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
>>  	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
>>  	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
>> @@ -970,6 +972,7 @@ enum {
>>  	HCI_CONN_CREATE_PA_SYNC,
>>  	HCI_CONN_PA_SYNC,
>>  	HCI_CONN_PA_SYNC_FAILED,
>> +	HCI_CONN_ENC_KEY_READY,
>>  };
>>  
>>  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 4bb0eaedd..b1ccd56bd 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -679,6 +679,13 @@ struct l2cap_user {
>>  	void (*remove) (struct l2cap_conn *conn, struct l2cap_user *user);
>>  };
>>  
>> +struct l2cap_pending_connect {
>> +	struct l2cap_conn *conn;
>> +	struct l2cap_cmd_hdr cmd;
>> +	u8 data[sizeof(struct l2cap_conn_req)];
>> +	u8 rsp_code;
>> +};
>> +
>>  #define L2CAP_INFO_CL_MTU_REQ_SENT	0x01
>>  #define L2CAP_INFO_FEAT_MASK_REQ_SENT	0x04
>>  #define L2CAP_INFO_FEAT_MASK_REQ_DONE	0x08
>> @@ -976,5 +983,6 @@ void l2cap_conn_put(struct l2cap_conn *conn);
>>  
>>  int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user);
>>  void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user);
>> -
>> +void l2cap_process_pending_connect(struct l2cap_conn *conn,
>> +				   struct l2cap_cmd_hdr *cmd, u8 *data, u8 rsp_code);
>>  #endif /* __L2CAP_H */
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index c4b87bfb4..6c992f83e 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -32,6 +32,7 @@
>>  #include <net/bluetooth/bluetooth.h>
>>  #include <net/bluetooth/hci_core.h>
>>  #include <net/bluetooth/mgmt.h>
>> +#include <net/bluetooth/l2cap.h>
>>  
>>  #include "hci_debugfs.h"
>>  #include "hci_codec.h"
>> @@ -766,10 +767,23 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
>>  		/* Update the key encryption size with the connection one */
>>  		if (key_enc_size && *key_enc_size != conn->enc_key_size)
>>  			*key_enc_size = conn->enc_key_size;
>> +		set_bit(HCI_CONN_ENC_KEY_READY, &conn->flags);
>>  	}
>>  
>>  	hci_encrypt_cfm(conn, status);
>>  
>> +	/*Defer l2cap_connect here if it's triggered before key size is read.*/
>> +	if (conn->pending_connect) {
>> +		struct l2cap_pending_connect *pc = conn->pending_connect;
>> +
>> +		conn->pending_connect = NULL;
>> +
>> +		bt_dev_dbg(hdev, "Defer l2cap_connect");
>> +		l2cap_process_pending_connect(pc->conn, &pc->cmd, pc->data, pc->rsp_code);
>> +
>> +		kfree(pc);
>> +	}
>> +
>>  done:
>>  	hci_dev_unlock(hdev);
>>  
>> @@ -3396,6 +3410,8 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
>>  	if (!conn)
>>  		goto unlock;
>>  
>> +	clear_bit(HCI_CONN_ENC_KEY_READY, &conn->flags);
>> +
>>  	if (ev->status) {
>>  		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
>>  				       conn->dst_type, ev->status);
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 40daa3827..c4cb60e65 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -3982,6 +3982,30 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
>>  	struct l2cap_chan *chan = NULL, *pchan = NULL;
>>  	int result, status = L2CAP_CS_NO_INFO;
>>  
>> +	/* If encryption is requested, but the key size is not ready yet,
>> +	 * we need to wait for the key size to be ready before we can
>> +	 * proceed with the connection. We do this by deferring the
>> +	 * connection request until the key size is ready. This is done
>> +	 * by storing the connection request in the hcon->pending_connect
>> +	 * field. The connection request will be retried when the key size
>> +	 * is ready.
>> +	 */
>> +	if (test_bit(HCI_CONN_ENCRYPT, &conn->hcon->flags) &&
>> +	    !test_bit(HCI_CONN_ENC_KEY_READY, &conn->hcon->flags)) {
>> +		struct l2cap_pending_connect *pc;
>> +
>> +		pc = kzalloc(sizeof(*pc), GFP_KERNEL);
>> +		if (!pc)
>> +			return;
>> +		pc->conn = conn;
>> +		memcpy(&pc->cmd, cmd, sizeof(*cmd));
>> +		memcpy(pc->data, data, sizeof(struct l2cap_conn_req));
>> +		pc->rsp_code = rsp_code;
>> +		BT_DBG("store request and retried when keysize is ready");
>> +		conn->hcon->pending_connect = pc;
>> +		return;
>> +	}
>> +
>>  	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
>>  	__le16 psm = req->psm;
>>  
>> @@ -4105,6 +4129,12 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
>>  	l2cap_chan_put(pchan);
>>  }
>>  
>> +void l2cap_process_pending_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
>> +				   u8 *data, u8 rsp_code)
>> +{
>> +	l2cap_connect(conn, cmd, data, rsp_code);
>> +}
>> +
>>  static int l2cap_connect_req(struct l2cap_conn *conn,
>>  			     struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
>>  {
> 
> Is there any update?
> 
> thanks,
> Shuai
> 
