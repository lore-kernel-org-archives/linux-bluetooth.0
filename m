Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69DC432E60
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445981; cv=none; b=YEOE/JdzqEuegXr6gBtNslowRA0ats9Djmtlo06WUNX6uGQLxRV3rIWFG0WEzd2PvH+J5kFTgYhBU/uuWZizxCh9yldeKO7QSzmqIE7DcwkWIV3GM3cpkDRpyzF5HUxMqKC05Q+/pzhN6KqoFEqkHdz3TEtR/DE/jw4o+YB7aUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445981; c=relaxed/simple;
	bh=Wc/L1rcCPuO2hZ6WlKjHGrGjzyyrJehQInhXOKby2dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=miC7NsbX+aO+B5Tug4NIuzCHC4vMSfAV1KX/HrJJyRhtf4wZJcj1x8e1SX2/3DZSUjtICbMZjz4gYPgdS61M/6xllqXNgjqPGBVXCUWAKZx/IJb1AYkPskGa7oK7raWiRBBNxkDc1djodAmJYgYJFqkG5ZA1J83qTK5QTuimDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EDjjV8Xf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I3DDksFY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EDjjV8Xf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I3DDksFY"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BAMOOK027816
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 10:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qZ1aqfiqbRJvbP/KfVnH1D5+qDlEv3lhxnG9TbFMG/A=; b=EDjjV8Xf46u06atd
	d09KThvZAvppN9wb1ud1og2tYtx2xnY+la28kMQ3vmsSOai8yvYVIKOziBWLuLRr
	0PjfTFkCPQgl+aPgnJXI+Vx/ju5RKitGYGxHFVvqAfa0TqE+nx+49DRN3m6Qg3nQ
	FYAHx6dEwpIeWSiNK5eLWWYw5hjijhyfPiWPmrgindb69NTLD/ieND3w5JoSeSM8
	GGvuqwWdYp0bCewGlbG8sU+DN5t6C4K5ZtnNunldRm334rGV6T9CKBrRPGBNvO2o
	qov0AdyWKxSLz+t6AgyWyI3Bp9o83XteIJPy8jBAPkN+dEUg7ZVJ6hZ/BKaYTuhE
	NJIf2g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjsktu3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 10:59:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8486c3411c8so4060009b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 03:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786445978; x=1787050778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qZ1aqfiqbRJvbP/KfVnH1D5+qDlEv3lhxnG9TbFMG/A=;
        b=I3DDksFYQIg0kwWD0H1pnwVvg9FuG1P64JnLZO0UNYmnq/DB2TIOjv1CvdBaBR1JSO
         UzjBe91OSehqcdeXbDP6wpVG2zb1ubO9bh+/fYJA1QUJas1dS1L5iPmES9+Ze7ZEs2NM
         6OPRg4WupWaF3YoikzA8tXPAfeuXFLTlY6iHUZ8n1kpo1x+8Z82MJX5qdxuGuJakjbl6
         OrKGLs39OLosFbGgpaHcyF+R4pWHYTougBLzv0TwFC+GXPoJc2RopW23OaAqKZxLy1p7
         hZWJ/ihjU7fH4U0LKcbRnCNI5WI6mybfKQuA+BhkQpyc9Z4fQMozrz+EvZoW4jW4UIkz
         PCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786445978; x=1787050778;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZ1aqfiqbRJvbP/KfVnH1D5+qDlEv3lhxnG9TbFMG/A=;
        b=RAiIYuI+dYb6NTmmKt100Ilf5uBVehtXWhgYL8j0oh5r4y+GgYElVwCqXS1OcQTPQj
         +pAmyJDo+BEoif1Fu6q6SHq3CyER4jyWei1K8TjCtlmvQvUN+f/jKyf5UhmtrrIXWZLl
         MgZc0E9O17seg5JUKnskkjUT8LkqUUkIz7eyd6dS6d2+8/Py6sVOavhc2IjW6IEUwjRC
         119DWYrF4mCQptQATUuLIU4bDI0pVOR/9C6G7CESsSxlC3mb88pqcLrQvbqf4D5SUAOn
         OziEs90+vxF0SdTQRENkPKgxLEPPyzdCMHXhzyuwt8KWJn+lz2az3ckuhj/JCjr9Wg1p
         sn9w==
X-Forwarded-Encrypted: i=1; AHgh+RqrYc8AAModiJ49Lxbf15hqJsA5Sq+Lvv+vBh31R4EiLiHZBBhycRLddEduwOOdb0/dh8DNnwG9a2VjW+YXkZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKeGJK+785Vu/cIE3yd00+Lhp6gHecvDR4R0JeeXLniHBUsUl
	5Em3+volRseSYHyz57bqHHS3n3pMnjJ+rTE9+atFVfNoU0i7QDCKyPqUSbSNyqkIxfIFwXGHfTg
	/ADEvJl27mlQjPPQ3QOFb1Tjmsqzlu75jDy62r5EwT2gSw/cnsnuq0IKrZGA3pdcfpK4R7rk=
X-Gm-Gg: AR+sD10+u/+cQeQmlHrRMzAd1TzqvP6CTd2M+WxW6Bg5nvAbUYYtgtqDx5m/bVooOWn
	bqoCH19ast9CrAgoSgtY9Epq0S1e2lCJ/0GL9mgbq+fcjjDONz4FtZoC5wmifYSON5k5pVXD7ix
	QbYw5Vx6HRzInuadn6IYLS3+5V1uLcwMORUbYlmcyKgL0DXCHXjpjamC1emk1O/wSQIS0BjJwK7
	gL8UJCKFs9WiL4/gQ9w1juMw2Jiurui09DOmlMmdAXLOrUzsgf9oYR40J1Dy2CC6GGABPbiCK9e
	9pOPzwUh/LLk5hCUdmuLg/7npTMLzbHeF5ZnUu0Q97ABgMT6OkTUDEFfiF0jc9An08gSgzRh9DX
	iRLcI+lIFTi2Vc6nsLEdvFikqOl4=
X-Received: by 2002:a05:6a00:1910:b0:842:7296:dba with SMTP id d2e1a72fcca58-84fa8670a54mr2141480b3a.7.1786445978143;
        Tue, 11 Aug 2026 03:59:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:1910:b0:842:7296:dba with SMTP id d2e1a72fcca58-84fa8670a54mr2141431b3a.7.1786445977389;
        Tue, 11 Aug 2026 03:59:37 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa91b5ba1sm553303b3a.20.2026.08.11.03.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 03:59:36 -0700 (PDT)
Message-ID: <f3c1f58d-66ab-41f3-9f25-682196ecb230@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 18:59:32 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: mgmt: always reply when a queued mgmt
 command is cancelled
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        chejiang@qti.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260731042920.2431343-1-shuai.zhang@oss.qualcomm.com>
 <CABBYNZJuenvKSvHuf6DCkt9hpdhuECm3gf5hiV+FyS2E9AM7nQ@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZJuenvKSvHuf6DCkt9hpdhuECm3gf5hiV+FyS2E9AM7nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MSBTYWx0ZWRfXzaZuHpnQhNAO
 kdHYqX3AK0dRIPqYiaYHuTrr7vU3vtmqgviWAeT15Ef68gFMVYsWk/BoAwOc8aqYOVDXjJCcFYp
 Q/+CeyDog+Hcf35g8nXva/T0HysNFkA=
X-Proofpoint-GUID: mC0feKFyEA5t-GgiMD_Oy-qa20S7_aT4
X-Proofpoint-ORIG-GUID: mC0feKFyEA5t-GgiMD_Oy-qa20S7_aT4
X-Authority-Analysis: v=2.4 cv=cfDiaHDM c=1 sm=1 tr=0 ts=6a7b009b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=racmn3MOU509EMJz4VAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MSBTYWx0ZWRfX2dyFJeNK1kFH
 A4RXZPA7CHbAeEFaPm9O0oyWx9cB8f7Eakw1aZlNMw5vQC6bt8MtmxjoLclvTlWMexpCesLsOx6
 cCAyVXho+KAyuLrpuF+KCAJik3fSyZjndGtPxEsxmh2F3hLuXeDMsHiOfWw0tPHyIj9nl5Qz910
 8hj85OdKfbq6H1qDtHIkACwKmT1PmkF+amEK9UgP5KuYmR/QTlcXS9J0G/E1/efI3CyFPI/rh/R
 zIYAKiYn/iuUY1kdSd3E9l6DUBYtor3ENeIdwxsEVX1TASy//4qLHwSB0UfEioLkCTv+HnyhjX1
 siQdnhP82bjKm1EH2X2Aaxi0NREwIJgtyCGuFnS+NQURe2jE+0D4rahakEWXcpP2k9Hrb2bklC9
 EdDu0ZlfwaYNBNeZqyj5l49JsZLEgHkynNx2/iMY+GtLJ7JLNuEyQkxIoPh2v63BwNWEaFoVEt7
 jXpOX7ThAzbHKzEO0iQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110091

Hi Luiz

Sorry for the delayed response. I was OOO last week.

On 7/31/2026 11:25 PM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Fri, Jul 31, 2026 at 12:29 AM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
>> On boot, the kernel's HCI_AUTO_OFF timer powers a newly probed
>> controller back off after 2 seconds if nothing has taken ownership of
>> it yet. bluetooth.service is expected to take ownership within that
>> window by powering the adapter on, but on slower boots bluetoothd can
>> start late enough that the two race: HCI_AUTO_OFF fires and the
>> controller is torn down and re-initialised while bluetoothd is still
>> in the middle of its own adapter setup sequence.
>>
>> When that teardown happens, any mgmt command bluetoothd had already
>> queued for that adapter is cancelled - but userspace is never told.
>> bluez's mgmt command queue is strictly serialised, so a command that
>> never receives a reply blocks every command queued after it on that
>> adapter indefinitely. In practice this means bluetoothd gets stuck
>> before it can register the adapter, and reports no controller being
>> available at all, even though the controller itself is healthy and
>> fully usable moments later.
>>
>> Fix this by treating a cancelled command like any other failure
>> instead of silently dropping it: always send a reply back to
>> userspace, using the existing "cancelled" status value. This mirrors
>> how other mgmt commands already behave when they fail for other
>> reasons, and lets bluetoothd's normal error handling take over
>> (log the failure and continue) instead of hanging forever.
>>
>> Verified on a QCS6490 rb3gen2 board where this HCI_AUTO_OFF vs.
>> bluetooth.service race was reproduced: before this change, hitting
>> the race left the adapter permanently unavailable to bluetoothd until
>> the service was restarted; after this change, hitting the same race
>> no longer affects adapter registration and the controller comes up
>> normally.
>>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>>   net/bluetooth/mgmt.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 167d75e34..9031b5d5d 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -301,6 +301,8 @@ static u8 mgmt_errno_status(int err)
>>                  return MGMT_STATUS_ALREADY_CONNECTED;
>>          case -ENOTCONN:
>>                  return MGMT_STATUS_DISCONNECTED;
>> +       case -ECANCELED:
>> +               return MGMT_STATUS_CANCELLED;
>>          }
>>
>>          return MGMT_STATUS_FAILED;
>> @@ -1338,7 +1340,7 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
>>          struct mgmt_mode *cp;
>>
>>          /* Make sure cmd still outstanding. */
>> -       if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
>> +       if (!mgmt_pending_valid(hdev, cmd))
>>                  return;
> On set_powered_sync:
>
>      mutex_lock(&hdev->mgmt_pending_lock);
>
>      /* Make sure cmd still outstanding. */
>      if (!__mgmt_pending_listed(hdev, cmd)) {
>          mutex_unlock(&hdev->mgmt_pending_lock);
>          return -ECANCELED;
>      }
>
> Which is why we consider -ECANCELED as a NOP, also if you dig deeper
> you will see that hci_power_off -> hci_dev_do_close ->
> hci_dev_close_sync -> if (!auto_off) __mgmt_power_off ->
> mgmt_pending_foreach(0, hdev, true, cmd_complete_rsp, &match);
>
> So the reason this is not working as intended is because we are not
> clearing HCI_AUTO_OFF once we receive Set Powered command only once we
> run hci_power_on_sync which create a race where the likes of
> bluetoothd will be trying to power the adapter but power_off work is
> still pending, so we should probably clear HCI_AUTO_OFF whenever
> setting HCI_MGMT as at that point we know there is a user already
> there is no point in powering it off.

Agreed on mgmt_set_powered_complete, will drop that hunk in v2.

On mgmt_remove_adv_monitor_complete: the __mgmt_power_off() path you
describe only runs when auto_off=0, i.e. when bluetoothd explicitly
closes the adapter during normal operation.

In the race we are fixing, bluetoothd starts late and the HCI_AUTO_OFF
timer expires before it finishes adapter initialisation, so auto_off=1.
In that case __mgmt_power_off() is never called and there is no other
path that replies to the cancelled commands. hci_cmd_sync_clear()
cancels them with -ECANCELED, and the complete callback is the only
place left to send a reply. Silently returning there is what causes
bluetoothd's serialised mgmt queue to stall indefinitely.


>
>>          cp = cmd->param;
>> @@ -5651,9 +5653,6 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
>>          struct mgmt_pending_cmd *cmd = data;
>>          struct mgmt_cp_remove_adv_monitor *cp;
>>
>> -       if (status == -ECANCELED)
>> -               return;
>> -
>>          hci_dev_lock(hdev);
>>
>>          cp = cmd->param;
>> --
>> 2.34.1
>>

Thanks,

Shuai

>
