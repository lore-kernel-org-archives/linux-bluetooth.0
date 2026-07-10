Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73536683D
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660723; cv=none; b=QyLCIz48NNJGj+OgfpoNf1M6jCBhf8/7azGay/LTtfX6KqPxg/sHJQS8uVLvao1H+wD371ClNp1KymvkfAx/tstPZu5OxAL8vwDBTmjNIIlS0umGRsa+/hhbmmF4v2ectrgnRr40jMo1g/YUHjQY69SluW+9/QI33HUNpJ9U7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660723; c=relaxed/simple;
	bh=CFhYBpFASUi4kJne5tmfoaQfUFFZv0IW+q7BueYXfxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpY+DZa7bO0+6fOWiaFGea0jz9a1SN3BvwHBTzVoZVsF3R604AlWH+vIKERnCgBBV/RIEGqXGxH6cAaWc8QGZD/+caFSH0/uLZ1SjmsngRmbhHtrV8Nc7rmQmE2Cfg2jka/KB6lk476A6mWRDIsYG4EQ1sbeOhwB8EdBo3m//yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lsItxuOl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kOTUKIUO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lsItxuOl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kOTUKIUO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3mhLp3847258
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0qD0u0athdFjd83FLWFwWIF6JDNJtir1aylsMBxMUGw=; b=lsItxuOlinmPrGGo
	e/sAdhde3zp4fkaLf0tqm6rNNNlkbikkCHuo0m8SkmVJzD5P++tySqQXKc5xkIOC
	/ypNuqui5UIqRha32qCs0KDYtd98NdRk3gFEnPSV7/tevVkdPnV5ytLplpIZV8s4
	cneQfmyxxGBMHgW5n52W8xfnKrIfBPaqBbsIdJlMxGklJJfZRIHUFodsNNOlnDwl
	e9qR7ur4E04sdSlLLrHMwZksEZyi044E1BZlMweD6ERwMiNkqgMbyq4WDMotvPXU
	GbprAGEYwZoecXlhRDcMtvy3o0rqw/tnLc3wH1a1DYYmcidXl8gpXAzdcr6urbdC
	WK2BKA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte1eyr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:18:40 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f0c46bfb6dso12367936d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 22:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783660720; x=1784265520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qD0u0athdFjd83FLWFwWIF6JDNJtir1aylsMBxMUGw=;
        b=kOTUKIUOB0ZEergNOSIfgKREbMHdqJkLybSdDyOrTprfeC6OxdOZzcMVpBEdjOXJe3
         i5bKVsBsJ/RPgiKyjzj/x346w0AwvJsJLqFv+qxdOdXiwv1Q9hQwLXVMWwgcT7/bwN+M
         S8FImBE6PSCFN+hQltVE7FyVTrbkpc5wlC726PPtCMLtNvO2qldu3oK2tQSJL9LJlg1S
         SlKunVntC2SNDMHhDc1wtXsAJs0lZlE1HN3WftyQTSrU0WwGGJ+TYt5+JIDU9MWODU/0
         kjyqT6Ck1fkJulwpswEGJPEE6fKFKKIq2AnoM0W+BTYM8kEAGIbKDG7prBl5fevU/YNN
         pe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783660720; x=1784265520;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0qD0u0athdFjd83FLWFwWIF6JDNJtir1aylsMBxMUGw=;
        b=LEeLz5h1Z81hoXOaZV3+9/sJrB7WKQoJi7G0ehSNx5T3l/zExncJ4hWQ5zIoK3J9Kh
         roCm0dHV+0lNbAp99bUQZJvtTXM8UeF7JTN+9SRQ4gcK+gsr/xcEckorYFlpjfjmBsaG
         Bj81/RfnFrxRZMVDtBrVA0jJGPAl3Sj3EW+bhYljO3zyjTOHlIQ7DGz5GuUHYVCPT+mB
         xhccA7KW8QdJXAFQpwlsri4d6n2zxAhK+yihxeLgatLyGniRU8V1yO41zlBNVkwj+juR
         vJgmOPwMP7zTitPWdcH2L7aMLnMPz4QdaGuBX762NGMlWpqr/tbDkoBSyKs4G3y/cllR
         kyzA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8k8fZVa+Zy6IGIq9VmAx1SAeJdzuDmHjfatW/8OYuvCGFKGBPwDcv51gKDBBRMkpj72r/bskTfDbCAthC7Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzisoHJUoaudbWIFbk4BiNFE/O+SyfFTosI4aTCjnxmVnqf8D0s
	uAt2sPhfP1MdwSSNgeBqJe27dwSrKMrZZjAdOOamPKDxPhAcSVvFZeFENL1SJfzpHVV11A/utl/
	4wDzob8kXLUSrgPR+7uDt50P73DAmVBnUdkvkDg+DrtLiPwY0fgcmu6a250lLf/HuVN6Tugg=
X-Gm-Gg: AfdE7cmZDzBLSIEL7KJM4Eg6qqXfmIZJQG2pFwXfIxNyWXEvvwvW4E2b9iwhT5+ixr7
	AQv6f9PZb/k+/KAfx8Bew1x/2+rWtLCsMgsDli6HartvILqSKKZM1Jl8nuZEnJgvfMwkB9cVRr4
	8OmSNntVDmOAdICThZ8TRGLMXVwN/Rt63x7+GsPGNZXJ3Mms1ujnlrPEdQKqcK+Jsdn23/jE1PG
	0akbD54dmJhueZZwcisrDPBik8bCOEvJJrKpRi4hKGLfhvRzCU9yOdWNs1ZrqkSCvJLgx7rw7YB
	QwDsOTjbRIjHBaEatmBXuo7ug2Bh2ouKDuVTU1zUB9zLoj6VixGtDk1iT8KGOeU/kPhjCPsFr0p
	wIKQfswvs6HsIWe1To3FHvGzNhIX4L7bVM37+Jug=
X-Received: by 2002:ad4:594f:0:b0:8f2:c086:2523 with SMTP id 6a1803df08f44-8fec304ad3dmr107914876d6.30.1783660719341;
        Thu, 09 Jul 2026 22:18:39 -0700 (PDT)
X-Received: by 2002:ad4:594f:0:b0:8f2:c086:2523 with SMTP id 6a1803df08f44-8fec304ad3dmr107914626d6.30.1783660718713;
        Thu, 09 Jul 2026 22:18:38 -0700 (PDT)
Received: from [10.239.96.184] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e3083sm33403376d6.6.2026.07.09.22.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 22:18:38 -0700 (PDT)
Message-ID: <c76f6810-d477-40cd-8534-cdff82605d67@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 13:18:28 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: MGMT: Fix discovery state race against
 cmd_sync worker
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com
References: <20260708093822.3495633-1-xiuzhuo.shang@oss.qualcomm.com>
 <CABBYNZJ+Kw0RGE3sW4AWUTzHeAH0Z1UhBQwdkhtpQg5FKOUtCw@mail.gmail.com>
Content-Language: en-US
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <CABBYNZJ+Kw0RGE3sW4AWUTzHeAH0Z1UhBQwdkhtpQg5FKOUtCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7-PryPDpUV0bVYzS7ZAoPt9POpWCYPff
X-Proofpoint-ORIG-GUID: 7-PryPDpUV0bVYzS7ZAoPt9POpWCYPff
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0NyBTYWx0ZWRfXyGfvVEht6o9E
 /LUbudHdxKuYHobwKaa4OsYm6Rn7WBeA+yi9GpGLMrgXNcpuHqVBkhpEgW/vAGZpbDXcqq2anoW
 7U+tKxKX7kms6JmIqfiP0rn4ECjy0DgjFDEzSO8xU42QI5RGt5umRnf21+j6hlTTxC6zy7pMMXF
 zTeObJnS5Rl6aoFO/+lSpA3Xybjlju+slxsQ21qcJGEn2YrG8+SHNr154UZbZ0STzucra5gBSjS
 603ZPKbcFmrZvner+22+VCahf94nWe1tUvo3rPLSQCIM3gQ4lAQmFricfyQqDWV42JGVekT2ycy
 Q54eSI0+Fcql7CP/YJEkBoqHZymQJfTxM2QQVV1S9aefpVBGK/IszPqcKhKpswoT+03LMRlByyH
 yWPApdV2qOKYsct+/NybDFUw46Mvvbzb2GCYVv23v3z2bWH3gFMDZLNucp79iEq47SC9cB+l+0R
 MtGcP0eG1JP6zqYhrZA==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a5080b0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1R3jAp6bkt0XbGehbloA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0NyBTYWx0ZWRfX6peOEnx/2+EU
 VPxKoQ2PQ3eW7DbvQ20gd33vR0s0VwCjKojE1ONmWXThEtkLj4PdWp7e4XAZoeGM40BEbyDnJxW
 H+ErIlDQA7RbQqRJpVj5aCvheodAN7w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100047



On 7/8/2026 9:51 PM, Luiz Augusto von Dentz wrote:
> Hi Xiuzhuo,
> 
> On Wed, Jul 8, 2026 at 5:38 AM Xiuzhuo Shang
> <xiuzhuo.shang@oss.qualcomm.com> wrote:
>>
>> start_discovery_internal(), start_service_discovery() and stop_discovery()
>> queue a cmd_sync work item and only then move the discovery state machine
>> into its transient value (DISCOVERY_STARTING / DISCOVERY_STOPPING):
>>
>>   err = hci_cmd_sync_queue(hdev, ..._sync, cmd, ..._complete);
>>   if (err < 0) { ... }
>>   hci_discovery_set_state(hdev, DISCOVERY_STARTING /* or STOPPING */);
>>
>> The matching completion callbacks run on hdev->req_workqueue serialised
>> by hci_req_sync_lock, which is independent of hdev->lock. So once the
>> work has been queued, the worker can be scheduled, run the sync function
>> and invoke the completion before the caller has executed the trailing
>> hci_discovery_set_state(). The completion's success path writes the
>> terminal state (DISCOVERY_STOPPED for stop, DISCOVERY_FINDING for start);
>> the caller then overwrites it with the transient value, and the state
>> machine is wedged: every subsequent Start (Service) Discovery is
>> rejected by the DISCOVERY_STOPPED gate with MGMT_STATUS_BUSY (0x0a),
>> with no HCI traffic generated, until bluetoothd or the adapter is
>> restarted.
>>
>> Fix it in three parts:
>>
>>   1. In all three call sites move hci_discovery_set_state(STARTING /
>>      STOPPING) to before hci_cmd_sync_queue(). The transient state is
>>      therefore always published before any worker can run the
>>      completion. On queue-submit failure, roll back to
>>      DISCOVERY_STOPPED.
>>
>>   2. In start_discovery_complete() and stop_discovery_complete(), wrap
>>      the terminal hci_discovery_set_state() call with
>>      hci_dev_lock() / hci_dev_unlock(). These callbacks run without
>>      hdev->lock; serialising the state write matches the pattern used
>>      by mgmt_set_powered_complete() and removes any residual ordering
>>      hazard against a concurrent mgmt path holding hdev->lock.
>>
>>   3. Generalise the "ignore -ECANCELED" early return in both completion
>>      callbacks to "on any non-zero err, also reset the transient state
>>      to STOPPED". With (1) in place the state observed at completion
>>      time is always known.
>>
>>      For the stop path this also fixes a pre-existing wedge: when any
>>      sub-command issued from hci_stop_discovery_sync() returns an
>>      error, stop_discovery_complete() is invoked with err != 0. The
>>      existing "if (!err) set_state(STOPPED)" tail then skips the reset
>>      and the state machine sits in DISCOVERY_STOPPING forever.
>>
>> Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY")
>> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
>> ---
>> Changes in v3:
>>  - Replace inline patch title with lore.kernel.org URL in v2 link
>>    reference to fix GitLint B1 line-length check.
>>  - Link to v2:
>>    https://lore.kernel.org/all/20260708062009.3047447-1-xiuzhuo.shang@oss.qualcomm.com/
>>
>> Changes in v2:
>>  - Fix if (err < 0) to if (err) in both start_discovery_complete() and
>>    stop_discovery_complete() to also catch positive HCI status codes,
>>    flagged by Sashiko.
>>  - Add Fixes: tag for commit abfeea476c68 as requested.
>>  - Update commit message wording from "err < 0" to "non-zero err" to
>>    match the code change.
>>  - Link to v1:
>>    https://lore.kernel.org/all/20260707093426.372897-1-xiuzhuo.shang@oss.qualcomm.com/
>>
>>  net/bluetooth/mgmt.c | 86 +++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 74 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 733a4b70e10c..81c09c24a14b 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -5975,15 +5975,38 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
>>
>>         bt_dev_dbg(hdev, "err %d", err);
>>
>> -       if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
>> +       if (err) {
>> +               /* The queued start-discovery work failed before the normal
>> +                * completion path could advance the state machine. The
>> +                * caller already moved the state to DISCOVERY_STARTING
>> +                * (under hdev->lock, before queueing). Reset it here so the
>> +                * gate in start_discovery_internal()/start_service_discovery()
>> +                * does not wedge in STARTING and reject every future Start
>> +                * (Service) Discovery with MGMT_STATUS_BUSY.
>> +                */
>> +               hci_dev_lock(hdev);
>> +               if (hdev->discovery.state == DISCOVERY_STARTING)
>> +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>> +               hci_dev_unlock(hdev);
>> +
>> +               if (err == -ECANCELED)
>> +                       return;
>> +       }
>> +
>> +       if (!mgmt_pending_valid(hdev, cmd))
>>                 return;
>>
>>         mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
>>                           cmd->param, 1);
>>         mgmt_pending_free(cmd);
>>
>> -       hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED:
>> +       /* Serialise discovery.state writes against any concurrent mgmt path
>> +        * holding hdev->lock; this callback runs on req_workqueue without it.
>> +        */
>> +       hci_dev_lock(hdev);
>> +       hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED :
>>                                 DISCOVERY_FINDING);
>> +       hci_dev_unlock(hdev);
>>  }
>>
>>  static int start_discovery_sync(struct hci_dev *hdev, void *data)
>> @@ -6051,15 +6074,23 @@ static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
>>                 goto failed;
>>         }
>>
>> +       /* Publish the transient state BEFORE queueing the work. The
>> +        * completion callback runs on hdev->req_workqueue serialised by
>> +        * hci_req_sync_lock, which is independent of hdev->lock; setting
>> +        * the state after the queue allowed the worker to win the race
>> +        * and have its terminal STOPPED/FINDING write overwritten by this
>> +        * trailing STARTING write, wedging discovery in STARTING.
>> +        */
>> +       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
> 
> I guess I will need to repeat myself, now that the callbacks do
> acquire hdev lock the comments above are invalid, the callback will
> attempt to hdev->lock making it wait the hci_dev_unlock bellow past
> setting DISCOVERY_STARTING, so the change above is no longer needed.
 Hi Luiz,
Thank you for the clarification. You are correct.

With the hci_dev_lock() / hci_dev_unlock() added to the completion callbacks in Part 2, the callbacks are forced to
wait until the caller releases hdev->lock. Since the caller holds hdev->lock across the entire hci_cmd_sync_queue()
call and the trailing hci_discovery_set_state(STARTING / STOPPING), by the time any callback can acquire hci_dev_lock,
the transient state is already published. Part 1 is therefore redundant and has been removed in v4.
Changes in v4:
- Drop the set_state-before-queue reordering (Part 1 in v1–v3)
- Update commit message from "Fix it in three parts" to "two parts" and revise the description to explain the locking

Will send v4.
> 
>>         err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
>>                                  start_discovery_complete);
>>         if (err < 0) {
>> +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>                 mgmt_pending_remove(cmd);
>>                 goto failed;
>>         }
>>
>> -       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
>> -
>>  failed:
>>         hci_dev_unlock(hdev);
>>         return err;
>> @@ -6178,15 +6209,19 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
>>                 }
>>         }
>>
>> +       /* Publish the transient state BEFORE queueing; see the comment in
>> +        * start_discovery_internal() for the race details.
>> +        */
>> +       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
>> +
>>         err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
>>                                  start_discovery_complete);
>>         if (err < 0) {
>> +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>                 mgmt_pending_remove(cmd);
>>                 goto failed;
>>         }
>>
>> -       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
>> -
>>  failed:
>>         hci_dev_unlock(hdev);
>>         return err;
>> @@ -6196,17 +6231,40 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
>>  {
>>         struct mgmt_pending_cmd *cmd = data;
>>
>> -       if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
>> -               return;
>> -
>>         bt_dev_dbg(hdev, "err %d", err);
>>
>> +       if (err) {
>> +               /* The queued stop-discovery work failed before the normal
>> +                * completion path could advance the state machine. The
>> +                * caller already moved the state to DISCOVERY_STOPPING
>> +                * (under hdev->lock, before queueing). Reset it here so
>> +                * the gate does not wedge in STOPPING.
>> +                */
>> +               hci_dev_lock(hdev);
>> +               if (hdev->discovery.state == DISCOVERY_STOPPING)
>> +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>> +               hci_dev_unlock(hdev);
>> +
>> +               if (err == -ECANCELED)
>> +                       return;
>> +       }
>> +
>> +       if (!mgmt_pending_valid(hdev, cmd))
>> +               return;
>> +
>>         mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
>>                           cmd->param, 1);
>>         mgmt_pending_free(cmd);
>>
>> -       if (!err)
>> +       if (!err) {
>> +               /* Serialise discovery.state writes against any concurrent
>> +                * mgmt path holding hdev->lock; this callback runs on
>> +                * req_workqueue without it.
>> +                */
>> +               hci_dev_lock(hdev);
>>                 hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>> +               hci_dev_unlock(hdev);
>> +       }
>>  }
>>
>>  static int stop_discovery_sync(struct hci_dev *hdev, void *data)
>> @@ -6248,15 +6306,19 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
>>                 goto unlock;
>>         }
>>
>> +       /* Publish the transient state BEFORE queueing; see the comment in
>> +        * start_discovery_internal() for the race details.
>> +        */
>> +       hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
>> +
>>         err = hci_cmd_sync_queue(hdev, stop_discovery_sync, cmd,
>>                                  stop_discovery_complete);
>>         if (err < 0) {
>> +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>                 mgmt_pending_remove(cmd);
>>                 goto unlock;
>>         }
>>
>> -       hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
>> -
>>  unlock:
>>         hci_dev_unlock(hdev);
>>         return err;
>> --
>> 2.43.0
>>
> 
> 

