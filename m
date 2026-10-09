Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BAF42E007
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535552; cv=pass; b=E2XQx5kKMJ7qJU+En3GfAgNcslbnFO4FDJeFQz8u4W/hHto0VGk9IUwAOwnXnvQzT1xtpjHxv8aMxLVWF7vmCmtRniWv9f9zQ5vE9F21pGIrKYdBv+3Cv4RCHwkSTDfNW47stX34xKsRtAtjuJDrFcMaTuWcsxGGCWT19QaeQjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535552; c=relaxed/simple;
	bh=NbtvmE45fNdzFHdnx3CqOpgyvtn71ZKrG0SDNEyLQf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nd3KacQvAAuY2im0JhY9BxqHe0Edmo5Scy8mAFW2RYJO1Wmj3fWImY1vhPJEwZejZoDlxufOoSbq4XMNACP4geA40ZWsbnr/0ofKp/sXKC1SUJx5XNEsTGN75GqAe2lMlgesk4/ZcnqcM4N7gBbVDU8uVgbpQQvy56Npr9gOcq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pGnVK2hR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EDDndClq; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pGnVK2hR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EDDndClq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KGcF1625931
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 08:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mIwJkmMSPXHrjJ/ItlmG+QW/0YVzbozcugh8nakxltg=; b=pGnVK2hRqKsoCpev
	LuLB6rb2LDEN5nx7wn24fAv/4T+S2VGH8MV5yTSHTs7IEEFB4UfCWAX/+awqiZRH
	RoYs32g9gRXmG8t34EW5srqkMaCcb8HUyCP96RNtp4BbyrMJQaljEpQ5D9FXfADS
	89ufzQoeU/Su//gv/2O9toT9YoWDvUskv2+wCQzN3lO5j/MG3jlCnM86nV9WHPr0
	CeIGDI0xkVVoKaJV9g5RpGFW5DCvX5W4KM5PzI70GOs8xtE60Q7CuM9J7pwlFkxv
	RdqxI1QewAlVCQDsdLw9E1S8UMW4hH4wk7JW+i6LYCfixjRkGNY3ga64NdiVUovC
	66TkIA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fyj2q17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 08:45:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e60bb65626so17658715ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 01:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791535548; cv=none;
        d=google.com; s=arc-20260327;
        b=jyJb3a88nVDwXvWXYr5cLoKvMsDCJAGQ5YvCriHQfklGwC7RcHTnjuyv2nzW7TtuBZ
         gcHypAWALVDaCM5gRf5rWnS2rhKHqaRh2Hw9vEuHHhJIBHzwsG00yfKIs62j4Tq+uy1P
         m/4vv1Gzrn62tAAoArH2GxPwEQ6xdij9e4RMuWw9ZPQLnm0kStqV/ryM7Kbeg4jrqB8b
         gtZFzOxRJ9kxVmC2lshl/jV2uwp4uTCeui54dlMYCJIuOwuhSIEgXOSf5/n5UhiOm3zy
         sADqbIXUrGwK5QcS26vJWOD+n/Wh3pyho+5zAw3u8agaaBnYL7GeabKE1hsCnWXD3mZ+
         uCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mIwJkmMSPXHrjJ/ItlmG+QW/0YVzbozcugh8nakxltg=;
        fh=5oxE9S7TJt+S/D/z7q5/+I81moeEXV442ZjExfEZejQ=;
        b=P1qB3J+F8ky3vWetD6ALBNWfetsgWrVHtovy2hASQmdge2c7XWeo5+J3tEnWMGK2VR
         Qvkq42d/IQJgKybeIyryqUKhIj4gTCOI0IXuVlX1667sOKg+mFbMdhJmnZtLC21xWoRx
         16VT/Lu2LHxK1orcysqQkPtr5+dlqB6G0k/UUpu5Swlhy6dr8swyZoAO/jfyF4y/MBNq
         WV7CsEMPRBVVQ4tZ9FHxe43F81JcSSo4hdNA/HyN/2dIHyXxI4Euq9f0OPZWlnIsGPlC
         DQSEgTMgFTDd6sjOxbX8Pa9jMINU5Aw6+ytq2oDSmymA3aGoSdnnllvOj1tu0t7xD+R7
         Wprw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791535548; x=1792140348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mIwJkmMSPXHrjJ/ItlmG+QW/0YVzbozcugh8nakxltg=;
        b=EDDndClqPOO3WQFdlLd9gczzAJ8cAvMOk+rKnNqut6FPNjPcuz7CHf5bKbCMFg//+Q
         bKoPTjszGiCZyz8r8DkYRZuJG34K5/xE2qj6AdrC/RRGVef+M1VVU80Uv5ahoQ0s49/Q
         PwYZimGjNx9dFkiF0WYobhIvYXIGfWT7BV6Pn6lKuWWezX4Sai8n1ZZrf80YtkGmfpk1
         izQmoWHJzuf/ii7cHSfmkKpuOyHgCd5GkratAUDj6U9GRd26Sr2i/SArmOALQdf5jbwC
         eLJVl88VsjXzFpu14PYCZut9ctICk3Gz1iCbHrBnIcN7fmK4kv/xpS63lJahW1HkNFe7
         2NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791535548; x=1792140348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mIwJkmMSPXHrjJ/ItlmG+QW/0YVzbozcugh8nakxltg=;
        b=IYgbB2BkFYw+aiNaWOTitwNNPjgiG3W/DSrr0howCnj6XyHbhRyo+QbI7HlvxsKMcF
         NtQ6yCn5qIf45ZKUl7A6fHCWznEh9MPbVRyvMH7gKmqJLasslz38mqKmCOqWK1g3NNGp
         yefDXI454h0t0ZsV+7ctB2G7xBhk2C1Q0LsUuk6cWgft+tptJf6nSK7webRdjbJxwaRI
         i7GYb402+ph1nNFRBGS5gDAilB5ENCnrGX8VUz2DwkJsmduZ0Nu9ejVmLS1edDN9pcp8
         d+9h2OJv2aWeZW0JeGhlKY81Sjl2HxPPDvqiSV+j6C/UTRo67hfMsiqG6+w+MMl9NosG
         MoEg==
X-Gm-Message-State: AFq9FYKK9l1Ry8C63A2U6cVjrD54qis7l4Wv8Z2UFjxxj0wdgdMQYD6/
	qJ4iqXE7W2ROUgBdYvGBuB1i9MyqcsNxx4B2E+OZsFw+CKHvMXez0km3q2tU64SyHfUHclctRk9
	bQPdfLnKecUJbXl86G1TqPh9iKduEeCIDKV+Pa8Hvg8JxgyU11480JMy3xQvVv0V/xSt8vl1loz
	WIGeW0OlWEaZo2KcIUzxwT9zdgBv8hSiyQkTxsg7hgPLXk/g==
X-Gm-Gg: AYBFou2XlQRIfGCl0vPd2omBr0xJmhPjqHPXHjHf/Xbaqt/vXOj4iLNQ3CL1ThjBTZO
	OxWIxjku4GT1TmqaYtGUXVkPT70qxqaCrHHg3i2eTEGN8mwFue4iOxrqCcdp8kEhfxGux7uLYll
	DohArqJ2+iMabfSfynitX2BfbX2+WQO2i2kG3p3lJxvUx4P1I+/NPLSTdbDg==
X-Received: by 2002:a17:902:e844:b0:2df:375f:b7ee with SMTP id d9443c01a7336-2e842cd2136mr7389655ad.18.1791535548448;
        Fri, 09 Oct 2026 01:45:48 -0700 (PDT)
X-Received: by 2002:a17:902:e844:b0:2df:375f:b7ee with SMTP id
 d9443c01a7336-2e842cd2136mr7389535ad.18.1791535547914; Fri, 09 Oct 2026
 01:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001131900.707485-1-cheng.jiang@oss.qualcomm.com>
 <20261001131900.707485-3-cheng.jiang@oss.qualcomm.com> <CABBYNZKVF4iCVzxQ_TC9FHeTOrFYLzZht3tyihfOnfKT=-93Ag@mail.gmail.com>
In-Reply-To: <CABBYNZKVF4iCVzxQ_TC9FHeTOrFYLzZht3tyihfOnfKT=-93Ag@mail.gmail.com>
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 16:45:35 +0800
X-Gm-Features: AclHuK9d4xDs0dTFDtZIWbmMnf-OEd-0oNWSQunHWRoYD8fytN933iY27nnN9bY
Message-ID: <CAOK0kb9C5i9pmKgpVv80eDDa0NkPcu8SX5Hr_qttV+dLznWPaA@mail.gmail.com>
Subject: Re: [PATCH 02/11] shared/gatt-db: Add gatt_db_attribute_indicate()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com,
        wei.deng@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BfpNQbt2 c=1 sm=1 tr=0 ts=6ac8a9bd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=nseXzIg3E5IJX6Mo-ykA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: vM7foa9I6L6dvyJpOelypSs3pZFGL5_k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX2hpJ9J16fWbK
 aqbOZK8l4c9Au8X9JfjPMl6Xda0l+MAYr2bAIEdfG2ArMcfPjbLXDhnL2ArUQOwWgfOPpXzOSSg
 JQOJdiDRvUe/fNn04W80R+6TGw1NP53NZPNCJI3CfGHTv9S+R3epOjTCw+yBz9u7nIBE/oM5Pys
 /W1fpwQX3dfmNeW7K+Y/hFI6qyAvUIywpefk4HVPrt9N9xW8YSXLP66sn83+nBBVS+aFXECU/xP
 xl+lvKaqwdmbzTd0gkEI46huV//VGSpNaZM8jEsHLD6VTLfUbtK9KNNaeKpNwRNApHY57txvzgH
 kmqlOAe4UT5GPRy9vmByIUlkBmVr/G17gx4gtYYnqMHkO+XhcoDzu9vkS0rkLLJMGp34MHFHA3J
 jYAHvNwjGclaVqqkx0VvTd0uQbXXYPy4r1uBuG1lb1J5fNcRrvyQpGXPxWVowPeYf7LPY+Vv4sz
 0zstQ4FHLzIvGFr28Ug==
X-Proofpoint-GUID: vM7foa9I6L6dvyJpOelypSs3pZFGL5_k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX+6rxcQht22ax
 z2SJXFTG9YhqgMzSe8VfktvSrWlObZ8h6bUgut6wAjPdBoMnQ38vV2PIbCkjg96YGb6VNiwqJrT
 D5FQQVO2laqx235Wc3d3QcC/Zs1d51w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090034

Hi Luiz,

On 10/1/2026 11:48 PM, Luiz Augusto von Dentz wrote:
> Hi,
>
> On Thu, Oct 1, 2026 at 9:48=E2=80=AFAM Cheng Jiang <cheng.jiang@oss.qualc=
omm.com> wrote:
>>
>> The notify callback leaves the choice between a notification and an
>> indication entirely to the CCC value written by the client, preferring
>> notifications whenever the client enabled them. Some services need the
>> indication transport for a given characteristic regardless: the Ranging
>> Service must indicate Ranging Data Ready and Ranging Data Overwritten
>> even when the client subscribed to both transports (RAS 3.4.2, 3.5.2).
>>
>> Add gatt_db_attribute_indicate() alongside gatt_db_attribute_notify() an=
d
>> let the callback query which of the two it was invoked from through
>> gatt_db_attribute_indicate_only(). Both entry points share a helper, so
>> the CCC lookup stays in one place, and neither gatt_db_notify_t nor the
>> existing gatt_db_attribute_notify() callers change.
>>
>> gatt-database honors the request by skipping the notification branch and
>> sending an indication instead, provided the client enabled indications.
>>
>> Assisted-by: Claude:claude-opus-4.8
>> ---
>>  src/gatt-database.c  |  7 ++++++-
>>  src/shared/gatt-db.c | 35 +++++++++++++++++++++++++++++++++--
>>  src/shared/gatt-db.h | 17 +++++++++++++++++
>>  unit/test-rap.c      | 13 +++++++++----
>>  4 files changed, 65 insertions(+), 7 deletions(-)
>>
>> diff --git a/src/gatt-database.c b/src/gatt-database.c
>> index 18b7aa667..800f76032 100644
>> --- a/src/gatt-database.c
>> +++ b/src/gatt-database.c
>> @@ -168,6 +168,7 @@ struct notify {
>>         uint16_t len;
>>         bt_gatt_server_conf_func_t conf;
>>         void *user_data;
>> +       bool indicate_only;
>>  };
>>
>>  #define CLI_FEAT_SIZE 1
>> @@ -1446,7 +1447,7 @@ static void send_notification_to_device(void *data=
, void *user_data)
>>          * TODO: If the device is not connected but bonded, send the
>>          * notification/indication when it becomes connected.
>>          */
>> -       if (ccc->value & 0x0001) {
>> +       if (!notify->indicate_only && (ccc->value & 0x0001)) {
>>                 DBG("GATT server sending notification");
>>                 bt_gatt_server_send_notification(server,
>>                                         notify->handle, notify->value,
>> @@ -1455,6 +1456,9 @@ static void send_notification_to_device(void *data=
, void *user_data)
>>                 return;
>>         }
>>
>> +       if (!(ccc->value & 0x0002))
>> +               return;
>> +
>>         DBG("GATT server sending indication");
>>         bt_gatt_server_send_indication(server, notify->handle, notify->v=
alue,
>>                                                 notify->len, notify->con=
f,
>> @@ -1486,6 +1490,7 @@ static void gatt_notify_cb(struct gatt_db_attribut=
e *attrib,
>>         notify.ccc_handle =3D gatt_db_attribute_get_handle(ccc);
>>         notify.value =3D (void *) value;
>>         notify.len =3D len;
>> +       notify.indicate_only =3D gatt_db_attribute_indicate_only(attrib)=
;
>>
>>         if (attrib =3D=3D database->svc_chngd)
>>                 notify.conf =3D service_changed_conf;
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index 751d4c3da..1f6e9ae14 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -123,6 +123,11 @@ struct gatt_db_attribute {
>>
>>         unsigned int next_notify_id;
>>         struct queue *notify_list;
>> +
>> +       /* Set only while notify_func is being called on behalf of
>> +        * gatt_db_attribute_indicate().
>> +        */
>> +       bool indicate_only;
>>  };
>>
>>  struct gatt_db_service {
>> @@ -2440,9 +2445,9 @@ gatt_db_attribute_get_ccc(struct gatt_db_attribute=
 *attrib)
>>         return ccc;
>>  }
>>
>> -bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
>> +static bool attribute_notify(struct gatt_db_attribute *attrib,
>>                                         const uint8_t *value, size_t len=
,
>> -                                       struct bt_att *att)
>> +                                       struct bt_att *att, bool indicat=
e_only)
>>  {
>>         struct gatt_db_attribute *ccc;
>>         struct gatt_db *db;
>> @@ -2468,11 +2473,37 @@ bool gatt_db_attribute_notify(struct gatt_db_att=
ribute *attrib,
>>         else
>>                 notify_user_data =3D ccc->user_data;
>>
>> +       attrib->indicate_only =3D indicate_only;
>> +
>>         attrib->notify_func(attrib, ccc, value, len, att, notify_user_da=
ta);
>>
>> +       attrib->indicate_only =3D false;
>> +
>>         return true;
>>  }
>>
>> +bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
>> +                                       const uint8_t *value, size_t len=
,
>> +                                       struct bt_att *att)
>> +{
>> +       return attribute_notify(attrib, value, len, att, false);
>> +}
>> +
>> +bool gatt_db_attribute_indicate(struct gatt_db_attribute *attrib,
>> +                                       const uint8_t *value, size_t len=
,
>> +                                       struct bt_att *att)
>> +{
>> +       return attribute_notify(attrib, value, len, att, true);
>> +}
>> +
>> +bool gatt_db_attribute_indicate_only(const struct gatt_db_attribute *at=
trib)
>> +{
>> +       if (!attrib)
>> +               return false;
>> +
>> +       return attrib->indicate_only;
>> +}
>> +
>>  bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib)
>>  {
>>         if (!attrib)
>> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
>> index da0600c01..63d7f3464 100644
>> --- a/src/shared/gatt-db.h
>> +++ b/src/shared/gatt-db.h
>> @@ -300,6 +300,23 @@ bool gatt_db_attribute_notify(struct gatt_db_attrib=
ute *attrib,
>>                                         const uint8_t *value, size_t len=
,
>>                                         struct bt_att *att);
>>
>> +/* Same as gatt_db_attribute_notify() but requests an indication even w=
hen the
>> + * client has also enabled notifications. Some profiles mandate the ind=
ication
>> + * transport for specific characteristics (e.g. the RAS Ranging Data Re=
ady and
>> + * Ranging Data Overwritten characteristics), which gatt_db_attribute_n=
otify()
>> + * cannot express since it prefers notifications whenever the client en=
abled
>> + * them.
>> + */
>> +bool gatt_db_attribute_indicate(struct gatt_db_attribute *attrib,
>> +                                       const uint8_t *value, size_t len=
,
>> +                                       struct bt_att *att);
>> +
>> +/* Valid only while a gatt_db_notify_t callback is running: tells wheth=
er it was
>> + * triggered by gatt_db_attribute_indicate() rather than
>> + * gatt_db_attribute_notify().
>> + */
>> +bool gatt_db_attribute_indicate_only(const struct gatt_db_attribute *at=
trib);
>> +
>>  bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib);
>>
>>  void *gatt_db_attribute_get_user_data(struct gatt_db_attribute *attrib)=
;
>> diff --git a/unit/test-rap.c b/unit/test-rap.c
>> index d7da2ff45..5c6033a4e 100644
>> --- a/unit/test-rap.c
>> +++ b/unit/test-rap.c
>> @@ -167,10 +167,15 @@ static void gatt_notify_cb(struct gatt_db_attribut=
e *attrib,
>>
>>         printf("%s: notify.value:%d notify->len:%d\n", __func__,
>>                 (int)*(notify.value), notify.len);
>> -       if (!bt_gatt_server_send_notification(data->server,
>> -                       notify.handle, notify.value,
>> -                       notify.len, false))
>> -               printf("%s: Failed to send notification\n", __func__);
>> +       if (gatt_db_attribute_indicate_only(attrib)) {
>> +               if (!bt_gatt_server_send_indication(data->server, notify=
.handle,
>> +                               notify.value, notify.len, NULL, NULL, NU=
LL) &&
>> +                               tester_use_debug())
>> +                       tester_debug("Failed to send indication");
>> +       } else if (!bt_gatt_server_send_notification(data->server,
>> +                       notify.handle, notify.value, notify.len, false) =
&&
>> +                       tester_use_debug())
>> +               tester_debug("Failed to send notification");
>>  }
>
> Don't mix changes from src/shared and unit/, send them in separate
> patches, now about the gatt_db_attribute_indicate_only, introducing an
> API just for unit testing sounds suboptional and I wonder if it could
> be avoided some way.
Sure, I will update in v2 to address the two issues. Thank you for the
comment.
>>  static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
>> --
>> 2.43.0
>>
>>
>
>
