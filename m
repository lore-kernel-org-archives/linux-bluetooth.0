Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC6372EE0
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258389; cv=none; b=cnaPzWfvBaU53eY+HQEGyGa2smJuTqkjJcpSzUxpvLNSDefT4Dagmou907ksPZ6yVWmg00Tpvd/TcpX/Jui5iVllk78bBkhNiJeRSuiChMCmxWRNXCN0cReNMJf9Az+zRIpZE2ptRokZ+yn0tXg1OfZGYDHJIdpyJK/rxxJdhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258389; c=relaxed/simple;
	bh=BQZGGR+Kj9Md3bS6Uq4HRXhbnJ4m++574iu+PGya68I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UepvRd7JMsgzJObeuW5jZfmYNj0BLv2sdh+n9zTkqKJb3MBylk6K3+2w0KG7bAz/fh/7WQg9eLyO/R2oCmDkmH/g01iDBAvi0m4qDhaS6oyy3i2hr2shjNhJAb2V+uYnf/M+dR1mAqdE10pgCSS3qvNQpRoNLOtfKJnVLAJc+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dunzMV3u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UtRH9BRJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dunzMV3u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UtRH9BRJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JMva4o2063911
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 06:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bW7F36999oGFMbvn1eYTcV73jKHwj2KE5q8L3kwSVD4=; b=dunzMV3uXGkn7Q8I
	K1yv966/P0r1yGQzaCI+eju4wxVDl2VU5NcvnPjb3CtDSqtS6g2o3OXGr4HUEnWU
	O0Ml8v000I3Fv50EOnmDjeHT9lCIT3+pbnocaNbmmneGuJXQ+FR02FAB53WV0ORw
	hIBnawbFy11Nw97lqy/qVzLxz2XQMwEDSybh/rY7Zk9g7DF3FHq9Rxl0TjhxOCEf
	hlszaPAZqWm4OsuLfO5sJuID5S1qOAhMqHdcE5jYin67F76vPfQoqv7JpDgRRVWS
	RcQqFhTD0vYGs+OvTW0P49PBmat2c06aHFbT/kxBPRGXbIjAR6Q+OsXyoR3nGi4/
	5hhMdg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t38b6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 06:26:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd00a65673so32818005ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779258386; x=1779863186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bW7F36999oGFMbvn1eYTcV73jKHwj2KE5q8L3kwSVD4=;
        b=UtRH9BRJ3aa8tHrpkttAhcsI0s7fNEPU2OHT8MFtlyASK6/+oqPZQILeqAdVmkq+7c
         Ee0tmOXUwgTaeT/6v5Go5aHdOX09ek4qbabrL7O5UUVBAXqY2aGh5h27PLZPmBTPhQrO
         yxowWVchT36E1kfWaXp8op1uVSaggstXt9KScf6h3d+EIP+xMAckE1N2hLnGb2YU7NcC
         2ZcE+66XbTwktN8MnFjHgWASMqfkS9oF5U4Csr2ciT1Yi145nOjMc289Ze+U04Etyaop
         zPxpjzc4ZmTg4MMcq6MPpsRgrHhdfawkYVnYx37g/WSNsU58VvgVXJ0YqWmbQLPYFp8b
         Z0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779258386; x=1779863186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bW7F36999oGFMbvn1eYTcV73jKHwj2KE5q8L3kwSVD4=;
        b=gA2VontJcG40nWjct3XA16UNHj5+0d4/q2jyeaAe2+9UB3PJr9ct3pfnX2PaAwJO1j
         3NmWe/9b2ZJfH2FHGdTnZJwkvIb1mnt8usRiLxzvnk8I9emzUE3SHSk8QcGoNm33ziFc
         q5jdDNqGFWzZZVYgFpPz6mB2b4W889r3xCw6MkCafD7EfEh2hOnTU11sKqbO6DhQl8Fk
         9usFBecUy7sCG2CDOebtzPCct4WusWc2UccBWp4XJvrbw646kyrJqKr25zhFO08S/zau
         a5rB17enMZuHcnORtwI5nIdMjky0ENmxXV5pLJ1G1sgq7QU4PBiab7dZCXx+lnXSi7CX
         2MBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9suW8Cp73/NgOaLKww1szsGMRx/cPg1ICSXnbLOsPxnAP260961+d0xEn1byqRcoICgzaEj4hNt40ESO47T40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZp8/uCmmpfS6k3WanzEqJVq9Hl+i1oZib5xUglobDU+/v8R1q
	UuSyeLHKsAeBcqFewuOLWD0O5EqCgUt+X5HkuPak0TMiW6xajTAForE/WXuZqODfDeT9FLD2Nke
	T+wwDjF8JiRIdvlEoksPioUf+xsqkL3w2PCKNzh54+aFjlKUmGMjEMWWj7PgfPf+QQHqLKvhRyz
	H/Duw=
X-Gm-Gg: Acq92OHkeuhJTEITx0xsqTbEEAJjatp8tUTc1mCYCXOqxTOh9b82EZuNe2RtoTfCGqS
	3aBAazYYcMO6HZTs3SiIIU97IHtvk2PSpvRSDtHJV0o1n83NnmmsFLWtWxO3fQ7yPQw+6anwRiv
	T/Th4Bnge0DGzdFrYk/3mkcD+xZY5tr65pvqvTBindFN0CbKFFBr3jVEi4jYyEcGe9/jkrgHFyK
	vEZM3d0Z5NgcERrfRIK9pdwWyaWSn2l/sO87kp7QanBQ91y1pDH8V69igLITeLDYxuMMSuFLNKd
	Qa60EYxpF0Ae5p7HAr8NgJtyWVsp/QSnEgW+6l6g9+o3L9gHgP9/Bbx3Jv0k+HA04Ycej0hGf67
	IYxj/AJ+6JeOkqfKOv5eAM0zmeAnQfXx6CfuCjMMHSMrT/WlEvOCqgbc6hYU=
X-Received: by 2002:a17:903:46c4:b0:2ba:6601:8e3d with SMTP id d9443c01a7336-2bd526f69f8mr226306855ad.9.1779258385717;
        Tue, 19 May 2026 23:26:25 -0700 (PDT)
X-Received: by 2002:a17:903:46c4:b0:2ba:6601:8e3d with SMTP id d9443c01a7336-2bd526f69f8mr226306635ad.9.1779258385245;
        Tue, 19 May 2026 23:26:25 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe4973sm210884795ad.41.2026.05.19.23.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 23:26:24 -0700 (PDT)
Message-ID: <cf77b8bb-5427-4d0c-b212-51947704378a@oss.qualcomm.com>
Date: Wed, 20 May 2026 14:26:20 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btusb: Allow firmware re-download when
 version matches
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260429121207.1306526-1-shuai.zhang@oss.qualcomm.com>
 <CABBYNZLP+rBrjhdKJLE7N47Bg-g4-6E3vS3yZXvMKwYQ2rMcUA@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZLP+rBrjhdKJLE7N47Bg-g4-6E3vS3yZXvMKwYQ2rMcUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IAXfD7-CiGZAux_TunxPSWdg273GHubM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2MCBTYWx0ZWRfX5K4z/tZClf6T
 uK9nsDzrXl3CqT5V+Po4dA/iI7pH+2a2ff0PoSBYEMFLCXwUJ7P+jkGtVDkWeix2x5rTIQ20m6T
 B4TbnBToCTsq5pR/eXg98sh+BBGbWY9NzUJ+HkFMXkZI+cp21hyzISoWHkDJ8Hqd/ISZbm8CmAq
 wlQv9mG6InPyjprv/x7whbQiLs7Om/tiV4MoiH5PQE62m7KPxrfJC2Lmem6bSfav1yNqBoE2t+c
 xcBnBA2XxjI9I8XaywPgTtHiycHMy1dYBVZE9yr8/UatZ8lclrxssaONwI2wg5DRypAHzHwh8wd
 2urpevHr/5zsjmdh618mc5cagcY2nAhORrUJa7cYkMnYkYzxpAVeJLdhOhZ9SqekNZ/vdDNFR/m
 UW7Yea1bzDd/JGP1cFJj23KX+7Kd9cKLc0hJmpRNUOxPItFyAlmuhZ1NHx1eH5bx1Zrhdam82CE
 MyBa7Q/iCghy/UQf91w==
X-Proofpoint-ORIG-GUID: IAXfD7-CiGZAux_TunxPSWdg273GHubM
X-Authority-Analysis: v=2.4 cv=C4LZDwP+ c=1 sm=1 tr=0 ts=6a0d5412 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qqokX6KkybRntjKqjosA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200060

Hi Luiz

On 4/29/2026 11:17 PM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Wed, Apr 29, 2026 at 8:12 AM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
>> The Bluetooth host decides whether to download firmware by reading the
>> controller firmware download completion flag and firmware version
>> information.
>>
>> If a USB error occurs during the firmware download process (for example
>> due to a USB disconnect), the download is aborted immediately. An
>> incomplete firmware transfer does not cause the controller to set the
>> download completion flag, but the firmware version information may be
>> updated at an early stage of the download process.
> Hold on, if the download has been aborted then the version should be
> reverted, or rather just update once the firmware loading is complete,
> so this indicates there is a bug somewhere that needs fixing, not
> worked around.
>
>> In this case, after USB reconnection, the host attempts to re-download
>> the firmware because the download completion flag is not set. However,
>> since the controller reports the same firmware version as the target
>> firmware, the download is skipped. This ultimately results in the
>> firmware not being properly updated on the controller.
>>
>> This change removes the restriction that skips firmware download when
>> the versions are equal. It covers scenarios where the USB connection
>> can be disconnected at any time and ensures that firmware download can
>> be retriggered after USB reconnection, allowing the Bluetooth firmware
>> to be correctly and completely updated.
>>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>> Changes v2:
>> - Update code comments and commit message to reflect the correct logic.
>> - Align the commit title with upstream conventions.
>> - Link v1
>>    https://lore.kernel.org/all/20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com/
>> ---
>>   drivers/bluetooth/btusb.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 572091e60..70abbabea 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -3550,7 +3550,13 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>>                      "firmware rome 0x%x build 0x%x",
>>                      rver_rom, rver_patch, ver_rom, ver_patch);
>>
>> -       if (rver_rom != ver_rom || rver_patch <= ver_patch) {
>> +       /* Allow rampatch when the patch version equals the firmware version.
>> +        * A firmware download may be aborted by a transient USB error (e.g.
>> +        * disconnect) after the controller updates version info but before
>> +        * completion.
>> +        * Allowing equal versions enables re-flashing during recovery.
>> +        */
>> +       if (rver_rom != ver_rom || rver_patch < ver_patch) {
> As I said above, this sounds more like a workaround. That said, I
> wonder why it would print an error if the version matches, it sounds
> to be that if the version matches it should just skip and consider it
> has been loaded already in case the actual problem is fixed by setting
> the new version only when loading has been completed.
>
>>                  bt_dev_err(hdev, "rampatch file version did not match with firmware");
>>                  err = -EINVAL;
>>                  goto done;
>> --
>> 2.34.1

Just checking if there are any updates on this


Thanks,

Shuai

>
