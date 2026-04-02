Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B58289367
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145440; cv=none; b=R/vB0cqEMgJPgI5SzwyhB9c+Fxfom287Jt62VErrmJhxksgNlrgy6CbX5qW3XyMEhUZeZm7NBBWZIlk5vqTlsx8sbnNUa+lApRwOZdMWxiPGvC+xDDD2NSD8UsUDIhnNXy93JNMKRQxlRo33VCWEDmn8UvMuhHo8XXfx/PFgtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145440; c=relaxed/simple;
	bh=hQlsB3ItkvVV6pDToZl8Z0movyz+XH9MVGDx/CsVpSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6BEbpI9rOgR8a9JyBF6tweNrkW2dgm3m1/vutFBIghhZe7jVGRj7TTzDyAMwV939VI8hnfPC355dtJl/egOSGMQP/VTHN/Q0ikm4qesOmmlZM0y8A7aTadE4OuDKsV/Sgxgoe/BkP59g9X6RBoH0S14dvOkhWzsxg8c2ExaSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=do8Zjw9m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ifLzdu4d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="do8Zjw9m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ifLzdu4d"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BlNb52338020
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Apr 2026 15:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OLag89s31xrKUg06GsxWii8mYBGY+1VMicVa+WUGeHI=; b=do8Zjw9m/tIesbWK
	ftfMtS8gkUrF1frAtKKeJqFWJC7hIOKLtpFMLzTtJs4KLi5rKYicAGVhg/w5bUh7
	ISlUOeL//fJ+mozr4mWZBqPY5kc/6reqn6BprjfE0kNhSaZEsyWxVIXeznL7Zlw2
	l6MAcwiaqHKJL48Oagm+Co6S94MZ1fFTuhfpprTZ70ssVnIdnFbR8xYBRpvbTYlW
	EL4oFHs9wYvHzyM7mw6kbbF2H1dndykIn0+//HLep+SW4HvGgw2KKIsfBJk87tEp
	6SFUC+YUQv/fKhmOfQe8irIf/+abptiqawfFejcCKVjpw9MiRFWT6S+7YrRIq2tZ
	D1A1MQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9qw0917e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 15:57:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b0cf396c45so11109575ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775145437; x=1775750237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OLag89s31xrKUg06GsxWii8mYBGY+1VMicVa+WUGeHI=;
        b=ifLzdu4djrjscTpFwdAl9wrUqU9zTaVVir+vzOqpgyDRMNfXIOjCymVnfv/326TbfI
         +j5ead3VPJBN+isrgIY6XNtbi3uBbEvUBJgt5BxHH4/8KDTjZytaWb2cJXEATEybB5u9
         kajpV+W2UJXVfnCL4Fn/X47ILp8H13Va3iKCHlqURS1RXmaZT7+371hgbXlVAlm/CbDL
         hx/jyUynQB7zlQ1QBA3HlVhIe+7JvPIxgL36pRHvMp0Lp0KmwZuGSsv5ug98m1sCePK2
         8q0DnyN6VnmtvuC/UipplU9JgaKugqbeO6bW4f76AYzq/0v6aqt9aK9zo1zmtC/yA7L5
         lR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145437; x=1775750237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLag89s31xrKUg06GsxWii8mYBGY+1VMicVa+WUGeHI=;
        b=A02eKcs4n0pkoMdlytwrkNTbokD8gNzUB7ehSAkfNoc9BTjfEgfoFtezKrIxtNFJGq
         RxHE1Ln7nchloowpKCu2v4CoLz4B/pnx0tSEb4cw0jqGNQnaLA5tlhbJ1AQaAm+7jl2F
         MrtcyI1ZHg8PccjF7t5TR5ysnaNyMkN7b0hjt77ta9eHbS6ZZBsk9T4VcUNnbcidMyme
         RqWCMfzfjIetFG4pwy+PIXL6w6ia03sk2i+3S2hUoX3NqKrPtz6LTMi9dCPj11a1lA8j
         GwWoym2DiXUGd6kp1MlIdu6JYVxEvPErsrqQ4tD4euwvzvefnwRM8QaQyBcAVjDH3eMx
         MCCw==
X-Gm-Message-State: AOJu0YzATNirEl50xoxeeLBam14K11FqP7dQS8mi7Ev/h0IE4x0wyIDv
	393ahpWX9KtY9vAlvKuM5BHAc3UDAmcCj3V3DF2JMXP3Yyh+NNnFxFwBSbkvcO295x9Oy1rK8iz
	T3tcy/hES4gwbeWOjmG32kPiZrEJl7i1cVwd7ZUKsNaWp1SMexg1JJaELYvopfSbmzE6KJCKeWV
	GlPws=
X-Gm-Gg: AeBDietrwor+BeHfF13zhasPZagZ5TqdhzIvvSp4ntYUhnxpB/G6QJ1odUqEEA6LEgR
	CcYmeFNs6rtDt7bDX7yuJ83ySxRF/xr5Z6jmL48htEopA7Cw5xazTpLMWYXrFGAfV7E+zs0hoPP
	EOpokYJR4ugBrvdIcnhUK+yZ6OX6dI6nyEo3IttAPYlniM1u8uFvOsI4+u1qowqBXNo5v2Wfrc5
	lfjhdyCVvNdbtjA4nuqreCHKYDXtdyF5bQHpq3yroWH+HOlwySTlvvZHTJGIA0j3t00i0NI4Y2g
	3AAixHSG55c0QLjjxlAKMxaCIEQzEkX0KBEqoY7kB7NUahtfMgc4uv/bCnJiODkV0o3sjOLCNPI
	iE89tlxtAGaP2j2+D4fWbuaLZerQNBX5znmYX9w==
X-Received: by 2002:a17:902:ebc6:b0:2b0:c106:a42b with SMTP id d9443c01a7336-2b269abe15dmr89772235ad.12.1775145436809;
        Thu, 02 Apr 2026 08:57:16 -0700 (PDT)
X-Received: by 2002:a17:902:ebc6:b0:2b0:c106:a42b with SMTP id d9443c01a7336-2b269abe15dmr89771925ad.12.1775145436314;
        Thu, 02 Apr 2026 08:57:16 -0700 (PDT)
Received: from [10.216.42.173] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d646sm33893675ad.5.2026.04.02.08.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 08:57:16 -0700 (PDT)
Message-ID: <4f45f85b-2bdc-44e4-83fa-fc6052bf1a28@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 21:26:59 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v1 1/3] shared: rap: Introduce Channel Sounding HCI
 raw interface support
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com,
        prathibha.madugonde@oss.qualcomm.com
References: <20260402103900.310778-1-naga.akella@oss.qualcomm.com>
 <20260402103900.310778-2-naga.akella@oss.qualcomm.com>
 <CABBYNZJUp4gQBX7UZ1qJHZa8SW+Yrr47e35oE1qnZajv26HPwg@mail.gmail.com>
Content-Language: en-US
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
In-Reply-To: <CABBYNZJUp4gQBX7UZ1qJHZa8SW+Yrr47e35oE1qnZajv26HPwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE0MyBTYWx0ZWRfX6cY78lqQ7shB
 jRhu0GMcyuxqdvm8eClSc7GESfgcssporrmgvIoC0z5R7CCXkH4+f//FjEz08d9sc+PKkrf/Uue
 SeCCm1idq2U07FeKKwrSOJ/FdMxjgHDfE+1aMcDBzugpHVo8rT6H16edSIvIwxljdmv0n5g/6Lm
 KqTjvLydfBBn8EcVqGI/Tp+jC0CWXiytDeiNR0Lb2FR5wRgeZw3wQrMFSBAzXTtYvS5lAxyncOb
 E46yjiFoljAZyJxKH9rB2PI72O8tmq9C61YiblNcQR9lfs6BRoso3fVwoBAaYoaqRqPBljlI43S
 Za8g5Vj4IxVzPEDlOr59pBqyLeIQQwEvVkbAxLm7iISRru8UVc8U+0jIXh/7B5r7dxVus0CJg+z
 EF4ltw8I6jvnai+4BszqBWgopTb4t75VoymjsxaLxw88MhQGIFGEwJu6oDrneMWPCPjtMLsFKJM
 u43SoyufQ3ao3fiF2rw==
X-Authority-Analysis: v=2.4 cv=PNICOPqC c=1 sm=1 tr=0 ts=69ce91dd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=BxuWDuRrwfIE-EZ8VfcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: DyuvICriA8GTz0nAOqT1DlZfromeJ4ld
X-Proofpoint-ORIG-GUID: DyuvICriA8GTz0nAOqT1DlZfromeJ4ld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020143

Hi Luiz,

Thank you for providing the comments.

On 4/2/2026 8:58 PM, Luiz Augusto von Dentz wrote:
> Hi Naga,
> 
> On Thu, Apr 2, 2026 at 6:39 AM Naga Bhavani Akella
> <naga.akella@oss.qualcomm.com> wrote:
>>
>> Implement stub callbacks for Channel Sounding HCI events and add the
>> required protocol definitions for CS configuration, procedure control,
>> and subevent result parsing
>>
>> Add data structures to support Channel Sounding Processing
>> ---
>>  src/shared/rap.c |  46 +++++++++++++
>>  src/shared/rap.h | 168 +++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 214 insertions(+)
>>
>> diff --git a/src/shared/rap.c b/src/shared/rap.c
>> index 39ef3f278..a0ca6ca71 100644
>> --- a/src/shared/rap.c
>> +++ b/src/shared/rap.c
>> @@ -504,6 +504,52 @@ bool bt_rap_unregister(unsigned int id)
>>         return true;
>>  }
>>
>> +void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
>> +                                               const void *param,
>> +                                               void *user_data)
>> +{
>> +       struct bt_rap *rap = user_data;
>> +
>> +       DBG(rap, "Received CS subevent CONT: len=%d", length);
>> +}
>> +
>> +void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
>> +                                       const void *param,
>> +                                       void *user_data)
>> +{
>> +       struct bt_rap *rap = user_data;
>> +
>> +       DBG(rap, "Received CS subevent: len=%d", length);
>> +}
>> +
>> +void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
>> +                                               const void *param,
>> +                                               void *user_data)
>> +{
>> +       struct bt_rap *rap = user_data;
>> +
>> +       DBG(rap, "Received CS procedure enable complete subevent: len=%d",
>> +           length);
>> +}
>> +
>> +void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
>> +                                                const void *param,
>> +                                                void *user_data)
>> +{
>> +       struct bt_rap *rap = user_data;
>> +
>> +       DBG(rap, "Received CS security enable subevent: len=%d", length);
>> +}
>> +
>> +void bt_rap_hci_cs_config_complete_callback(uint16_t length,
>> +                                       const void *param,
>> +                                       void *user_data)
>> +{
>> +       struct bt_rap *rap = user_data;
>> +
>> +       DBG(rap, "Received CS config complete subevent: len=%d", length);
>> +}
>> +
>>  struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
>>  {
>>         struct bt_rap *rap;
>> diff --git a/src/shared/rap.h b/src/shared/rap.h
>> index a1d1ff2ae..5bd45a65d 100644
>> --- a/src/shared/rap.h
>> +++ b/src/shared/rap.h
>> @@ -9,9 +9,154 @@
>>  #include <inttypes.h>
>>
>>  #include "src/shared/io.h"
>> +#include "lib/bluetooth/mgmt.h"
> 
> Do we still need the mgmt.h?
yes, we need mgmt.h since definition of __packed is present in mgmt.h
> 
>> +#include "src/shared/hci.h"
>>
>>  struct bt_rap;
>>
>> +/* Channel Sounding Events */
>> +struct bt_rap_hci_cs_options {
>> +       uint8_t role;
>> +       uint8_t cs_sync_ant_sel;
>> +       int8_t max_tx_power;
>> +       int rtt_type;
>> +};
>> +
>> +#define CS_MODE_ZERO                           0x00
>> +#define CS_MODE_ONE                            0x01
>> +#define CS_MODE_TWO                            0x02
>> +#define CS_MODE_THREE                          0x03
>> +
>> +#define CS_REFLECTOR                   0x01
>> +#define CS_INITIATOR                   0x00
>> +
>> +#define CS_MAX_ANT_PATHS                       0x05
>> +#define CS_MAX_STEPS                   0xA0
>> +#define CS_MAX_STEP_DATA_LEN           0xFF
>> +
>> +struct rap_ev_cs_config_cmplt {
>> +       uint8_t status;
>> +       uint16_t conn_hdl;
>> +       uint8_t config_id;
>> +       uint8_t action;
>> +       uint8_t main_mode_type;
>> +       uint8_t sub_mode_type;
>> +       uint8_t min_main_mode_steps;
>> +       uint8_t max_main_mode_steps;
>> +       uint8_t main_mode_rep;
>> +       uint8_t mode_0_steps;
>> +       uint8_t role;
>> +       uint8_t rtt_type;
>> +       uint8_t cs_sync_phy;
>> +       uint8_t channel_map[10];
>> +       uint8_t channel_map_rep;
>> +       uint8_t channel_sel_type;
>> +       uint8_t ch3c_shape;
>> +       uint8_t ch3c_jump;
>> +       uint8_t reserved;
>> +       uint8_t t_ip1_time;
>> +       uint8_t t_ip2_time;
>> +       uint8_t t_fcs_time;
>> +       uint8_t t_pm_time;
>> +} __packed;
>> +
>> +struct rap_ev_cs_sec_enable_cmplt {
>> +       uint8_t status;
>> +       uint16_t conn_hdl;
>> +} __packed;
>> +
>> +struct rap_ev_cs_proc_enable_cmplt {
>> +       uint8_t status;
>> +       uint16_t conn_hdl;
>> +       uint8_t config_id;
>> +       uint8_t state;
>> +       uint8_t tone_ant_config_sel;
>> +       int8_t sel_tx_pwr;
>> +       uint8_t sub_evt_len[3];
>> +       uint8_t sub_evts_per_evt;
>> +       uint16_t sub_evt_intrvl;
>> +       uint16_t evt_intrvl;
>> +       uint16_t proc_intrvl;
>> +       uint16_t proc_counter;
>> +       uint16_t max_proc_len;
>> +} __packed;
>> +
>> +#define CS_MAX_STEPS                   0xA0
>> +
>> +struct pct_iq_sample {
>> +       int16_t i_sample;
>> +       int16_t q_sample;
>> +} __packed;
>> +
>> +struct cs_mode_zero_data {
>> +       uint8_t packet_quality;
>> +       uint8_t packet_rssi_dbm;
>> +       uint8_t packet_ant;
>> +       uint32_t init_measured_freq_offset;
>> +} __packed;
>> +
>> +struct cs_mode_one_data {
>> +       uint8_t packet_quality;
>> +       uint8_t packet_rssi_dbm;
>> +       uint8_t packet_ant;
>> +       uint8_t packet_nadm;
>> +       int16_t toa_tod_init;
>> +       int16_t tod_toa_refl;
>> +       struct pct_iq_sample packet_pct1;
>> +       struct pct_iq_sample packet_pct2;
>> +} __packed;
>> +
>> +struct cs_mode_two_data {
>> +       uint8_t ant_perm_index;
>> +       struct pct_iq_sample tone_pct[4];
>> +       uint8_t tone_quality_indicator[4];
>> +} __packed;
>> +
>> +struct cs_mode_three_data {
>> +       struct cs_mode_one_data mode_one_data;
>> +       struct cs_mode_two_data mode_two_data;
>> +} __packed;
>> +
>> +union cs_mode_data {
>> +       struct cs_mode_zero_data mode_zero_data;
>> +       struct cs_mode_one_data mode_one_data;
>> +       struct cs_mode_two_data mode_two_data;
>> +       struct cs_mode_three_data mode_three_data;
>> +};
>> +
>> +struct cs_step_data {
>> +       uint8_t step_mode;
>> +       uint8_t step_chnl;
>> +       uint8_t step_data_length;
>> +       union cs_mode_data step_mode_data;
>> +} __packed;
>> +
>> +struct rap_ev_cs_subevent_result {
>> +       uint16_t conn_hdl;
>> +       uint8_t config_id;
>> +       uint16_t start_acl_conn_evt_counter;
>> +       uint16_t proc_counter;
>> +       uint16_t freq_comp;
>> +       uint8_t ref_pwr_lvl;
>> +       uint8_t proc_done_status;
>> +       uint8_t subevt_done_status;
>> +       uint8_t abort_reason;
>> +       uint8_t num_ant_paths;
>> +       uint8_t num_steps_reported;
>> +       struct cs_step_data step_data[];
>> +} __packed;
>> +
>> +struct rap_ev_cs_subevent_result_cont {
>> +       uint16_t conn_hdl;
>> +       uint8_t config_id;
>> +       uint8_t proc_done_status;
>> +       uint8_t subevt_done_status;
>> +       uint8_t abort_reason;
>> +       uint8_t num_ant_paths;
>> +       uint8_t num_steps_reported;
>> +       struct cs_step_data step_data[];
>> +} __packed;
>> +
>>  typedef void (*bt_rap_debug_func_t)(const char *str, void *user_data);
>>  typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void *user_data);
>>  typedef void (*bt_rap_destroy_func_t)(void *user_data);
>> @@ -43,3 +188,26 @@ bool bt_rap_ready_unregister(struct bt_rap *rap, unsigned int id);
>>  bool bt_rap_unregister(unsigned int id);
>>
>>  struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb);
>> +
>> +/* HCI Raw Channel Approach */
>> +void bt_rap_hci_cs_config_complete_callback(uint16_t length,
>> +                                            const void *param,
>> +                                            void *user_data);
>> +void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
>> +                                                const void *param,
>> +                                                void *user_data);
>> +void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
>> +                                                     const void *param,
>> +                                                     void *user_data);
>> +void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
>> +                                            const void *param,
>> +                                            void *user_data);
>> +void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
>> +                                                 const void *param,
>> +                                                 void *user_data);
>> +
>> +void bt_rap_hci_set_le_bcs_options(uint8_t role, uint8_t cs_sync_ant_sel,
>> +                                  int8_t max_tx_power);
>> +
>> +bool bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci);
>> +void bt_rap_hci_sm_cleanup(void);
>> --
>>
> 
> 
Thanks,
Bhavani

