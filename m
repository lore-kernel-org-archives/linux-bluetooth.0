Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164F3DB620
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136284; cv=none; b=rueDlUYVDssihGVf0+XZkPh4+id/wySyxrxZm1kKVE7DHQIwuspeE6i8+T8TTi4IFkLUF70+rbY+ciUPDeIAqLCdFv2RieEYAhtAOUDdFyJDpp1f/h6xVsY678OHeAGXNsl+7TFBee0dv2kH/fPvdkZ887H6LqeZNkCxeYV+cA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136284; c=relaxed/simple;
	bh=cQG7yexUIlc/P/Vm7qq0IEXu1A/Mjlf0F1X92+0PAmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoH8w5hd7gNLI+jS4CoeJc4h91h6M02qqGa3axlaw5QLRPBWHmmlLeV5FLk/E6gaZh5Kd0Z6VwD2xHMjHPoxEwOaqKe1LGsnssPHSNL0KwHbIQCRtWD3pdQCMNz7sf2H5o9kD1osK/pMIH1GvvO631GUHzT7QrvbvZBy4mfaLZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8+DrRnG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E5sKMtaO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8+DrRnG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E5sKMtaO"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1fkAe2571876
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k3oM15ZU9/jgvdiJaBQrR+abgAJOvrmHsCDR1Cet4HU=; b=C8+DrRnGVNfA2Ju2
	n3IgSBvmF9jBMd7wjukp+A9w7tj7KoeL8YsaQSWRIRFsjh75PcEnIMnYBHZezmEn
	cLtkJK/DmVPjtJqPLH7MwxCfz6PuZzM+phXu0xPG/Vxd2KRG+ochBjOq+WnstPPs
	fPTP6USBZYjBJJPvDCp04TbRiRiA7jJttMHqskzdPtQxKu2r+Led8doZ+UxDYSxV
	YtqkA+LvQtxNNESuFtL3Om9j7c+DOmfHelzuYVOs1AzxdRP0AgmBI9pm+qbc+SLr
	/kakGjhu1eqt1Jli9bzNL3xJANqr5zPVmu0BVTiN3vuIniHklcVAm6cka418LOZd
	a9jrzA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3sd1w0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:11:19 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e375d9736so3505892b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785136279; x=1785741079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3oM15ZU9/jgvdiJaBQrR+abgAJOvrmHsCDR1Cet4HU=;
        b=E5sKMtaOk/05i3O46Zzej97eG8xZFLQ1/IoDtygxoUrTW4o2gg34yvtyyG+BLlvn5e
         Puf4/MVStSn+kh9kdqxdwtoUmXGODot1qPXUu3N2Et2zYENW3Pa9+dehy827EMHkO9ID
         iYBhTqrsTRqC90f0vwqXkFLdJ1CAWbHNeO2DZ18VUUu/e+eAtJ0g10KNn5f+ya5IEgu3
         DR8xAWMDd2rHyAFqIdvCitndRNtzYElQordmF+2P4wGjTIHCrZ1Wf4yvUw7MaIQl2R6l
         4iOnoMeHDZds1gmJHncMH49Tbxfo1l6V3fBF4gpyAD/QYjmRxppvizciWWRr4fZOq6pz
         zabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136279; x=1785741079;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k3oM15ZU9/jgvdiJaBQrR+abgAJOvrmHsCDR1Cet4HU=;
        b=YCpxCpI01bTRy7Gg9LfA3VShEZtqp2wpkxhxfXHUYHnEqBIM/CIFLNq5XT1HxKiwOV
         P1d3TFD/C94pCoLm0+fuJGff3qRFx195SjCU1S/8OZADGocN6QRMLUpKacqpce0KPkIP
         M2uIzoKYw7Qt2Vn39sC7x2TKsK0TMRCsDv9R4OuDUuo5g1dpVqBKVFpgeTlSFFc3y30y
         FpqGetHNqNe4jq0yjXylxtN+LZqOXFghmxoMoYOKfZ17n83D8SEs+FyoDkT9fBp/FMFG
         w1QiFXg181YkOoqUuv6Gyvvmj2E2h2KRapJjXGSd0eQ3J2V7PJEMDsBFfpsADT7wh7JN
         eTDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbLc+WxASoUf9eBZh1PAXHWEkyxSPmSv8SO4824LiRHngs3MMMg02GvmxPAYsWc4vshyCs9DBNbdLJqQnDrHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Lnhfjv83MCH+81Ho1lEElHhyJFiG+vBJaqS5fTuutquyIE9s
	zfb6MRmD1DJg9gxXYR9eDTZJ23eYehU0sS4fR2OAGMsIxQr34fTre6MHbn2EFXY7Bi5LyuFkwc0
	LPm7cELQ19TMrsJ+1VsiGVWMPvWYrwXfgFEeFTyHAiC97A+SSfuiJi9XrxZpsGy6dFzGBCww=
X-Gm-Gg: AR+sD10+vjWAg/aDfeSwUNNf2dOrSk7jcl73a2DRuMi1dM40etJhcnJ7S24EIEh1Rq1
	rVHHR5IM3vaUY8jHUTy5RhkWloxpTV2U3lRdkgZQt5Qgqzzw9znj2di7lf1dqNhO0kGJ/K0DFLI
	U9I/d94P4Uving5vlKMpKQezgM2RKqbn7vDBZtyawpZXTsL2dlkMzMJeF3IQ6QY+cATsep4+CLX
	XJ/cVD5PC7UbJico1PzjVOZPdFnvpy5fcKGZBgWt/ueYr5Fow/YMByIpTC4Lv2z11Ih7rn9pCt1
	jAANbW/EEG5yipFX8EwctUeO2hLtbq7GKee5C02wJBeqdC92NJQMKpQnMFIOJNoaiYp1Fe1Mwlz
	NelXEp95iT+FQ8HKeOJ0wTkpZwVOhHw==
X-Received: by 2002:a05:6a00:2990:b0:848:590a:4c90 with SMTP id d2e1a72fcca58-84e595b702emr5828433b3a.59.1785136279297;
        Mon, 27 Jul 2026 00:11:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:2990:b0:848:590a:4c90 with SMTP id d2e1a72fcca58-84e595b702emr5828411b3a.59.1785136278810;
        Mon, 27 Jul 2026 00:11:18 -0700 (PDT)
Received: from [10.253.79.132] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533d1386sm2606568b3a.36.2026.07.27.00.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 00:11:18 -0700 (PDT)
Message-ID: <cbd7a34f-613b-4b8b-bc7b-9bc5a7ab391b@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 15:11:12 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: MGMT: Fix discovery state race against
 cmd_sync worker
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com
References: <20260710052009.728899-1-xiuzhuo.shang@oss.qualcomm.com>
Content-Language: en-US
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <20260710052009.728899-1-xiuzhuo.shang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA2OSBTYWx0ZWRfX8+TscViiCwo/
 JgJS4+LyH9a/2QffyY16CRq17TLpW0JE1RxkAzuZAaF8XYDTXb6Rd+WYAUwvlKCwSvDCuUAVtCn
 f5knf2P7Etc9cNHU9m9sqpNjwhlejQLO6u/QqJrS+EzmNoq1fH57Aw20HG/401GypujsZndXs4m
 7I8V0gVap+TOOa+KhvtCOsOsDQUL2r95jFew3HN9sf5kppqC7PHub0ViGXm0V8rRLqNsKlsEEj8
 IwOVVwsiFMGR5BiqSVe1/gCifj4AkFp+J9BF9+4iyy4RzOu7TL20s3PvS7OXyRDtGYubbwPRr8U
 5GxR1ZnVrK8CZ/RIJLc6jo8G0YrVZmqZZoixfAmmr9GHv8GmvlCE7CwXV26r9CKICC8ZpnosiRi
 oUJFfmHR1X3JRB7OTpJ5IYHdkk1I42Uh5xjCnFrtwKQ0cmI83LPl0DOWxm1k1q4ueGCuMTnnwQ+
 DntqkkYA4UxF9kEnj4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA2OSBTYWx0ZWRfXwCWDH/qhpXpD
 sI1+a9RGMRZQCHF4t8ZPTWnJ4YXvfiH2Q5TtGogDgjPtZNphuYf4LUf9gtUR02T1Ir7ZBuwkqZ/
 IJn8PhORfj5BzXsyAKD/V7kS0mMv+3c=
X-Proofpoint-ORIG-GUID: CpdyfDyLDRh1rM-EIqy46BwOT7O3eap6
X-Proofpoint-GUID: CpdyfDyLDRh1rM-EIqy46BwOT7O3eap6
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a670498 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tknXimsZ09G-OvYSg0QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270069



On 7/10/2026 1:19 PM, Xiuzhuo Shang wrote:
> start_discovery_internal(), start_service_discovery() and stop_discovery()
> queue a cmd_sync work item and only then move the discovery state machine
> into its transient value (DISCOVERY_STARTING / DISCOVERY_STOPPING):
> 
>   err = hci_cmd_sync_queue(hdev, ..._sync, cmd, ..._complete);
>   if (err < 0) { ... }
>   hci_discovery_set_state(hdev, DISCOVERY_STARTING /* or STOPPING */);
> 
> The matching completion callbacks run on hdev->req_workqueue serialised
> by hci_req_sync_lock, which is independent of hdev->lock. So once the
> work has been queued, the worker can be scheduled, run the sync function
> and invoke the completion before the caller has executed the trailing
> hci_discovery_set_state(). The completion's success path writes the
> terminal state (DISCOVERY_STOPPED for stop, DISCOVERY_FINDING for start);
> the caller then overwrites it with the transient value, and the state
> machine is wedged: every subsequent Start (Service) Discovery is
> rejected by the DISCOVERY_STOPPED gate with MGMT_STATUS_BUSY (0x0a),
> with no HCI traffic generated, until bluetoothd or the adapter is
> restarted.
> 
> Fix it in two parts:
> 
>   1. In start_discovery_complete() and stop_discovery_complete(), wrap
>      the terminal hci_discovery_set_state() call with
>      hci_dev_lock() / hci_dev_unlock(). These callbacks run without
>      hdev->lock; the caller holds hdev->lock across hci_cmd_sync_queue()
>      and the trailing set_state(STARTING / STOPPING), so the callback's
>      hci_dev_lock() blocks until the caller has published the transient
>      state and released the lock. This serialises the state writes and
>      closes the race window without needing to reorder the set_state
>      call relative to hci_cmd_sync_queue().
> 
>   2. Generalise the "ignore -ECANCELED" early return in both completion
>      callbacks to "on any non-zero err, also reset the transient state
>      to STOPPED".
> 
>      For the stop path this also fixes a pre-existing wedge: when any
>      sub-command issued from hci_stop_discovery_sync() returns an
>      error, stop_discovery_complete() is invoked with err != 0. The
>      existing "if (!err) set_state(STOPPED)" tail then skips the reset
>      and the state machine sits in DISCOVERY_STOPPING forever.
> 
> Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY")
> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> ---
> Changes in v4:
>  - Drop the "move set_state before hci_cmd_sync_queue" change (Part 1
>    in v1-v3): now that the completion callbacks acquire hci_dev_lock,
>    they block until the caller releases hdev->lock — which happens only
>    after set_state(STARTING/STOPPING) has been written. The lock
>    acquisition therefore serialises the state writes without reordering
>    the set_state call.
>  - Update commit message from "Fix it in three parts" to "two parts"
>    and revise Part 1 description to explain the locking argument.
>  - Link to v3:
>    https://lore.kernel.org/all/20260708093822.3495633-1-xiuzhuo.shang@oss.qualcomm.com/
> 
> Changes in v3:
>  - Replace inline patch title with lore.kernel.org URL in v2 link
>    reference to fix GitLint B1 line-length check.
>  - Link to v2:
>    https://lore.kernel.org/all/20260708062009.3047447-1-xiuzhuo.shang@oss.qualcomm.com/
> 
> Changes in v2:
>  - Fix if (err < 0) to if (err) in both start_discovery_complete() and
>    stop_discovery_complete() to also catch positive HCI status codes,
>    flagged by Sashiko.
>  - Add Fixes: tag for commit abfeea476c68 as requested.
>  - Update commit message wording from "err < 0" to "non-zero err" to
>    match the code change.
>  - Link to v1:
>    https://lore.kernel.org/all/20260707093426.372897-1-xiuzhuo.shang@oss.qualcomm.com/
> 
>  net/bluetooth/mgmt.c | 58 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 733a4b70e10c..2295042234f8 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5975,15 +5975,38 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
>  
>  	bt_dev_dbg(hdev, "err %d", err);
>  
> -	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
> +	if (err) {
> +		/* The queued start-discovery work failed before the normal
> +		 * completion path could advance the state machine. The
> +		 * caller already moved the state to DISCOVERY_STARTING
> +		 * (under hdev->lock; the callback's hci_dev_lock() blocked
> +		 * until the caller wrote the transient state and released
> +		 * the lock). Reset it here so the gate in
> +		 * start_discovery_internal()/start_service_discovery()
> +		 * does not wedge in STARTING and reject every future Start
> +		 * (Service) Discovery with MGMT_STATUS_BUSY.
> +		 */
> +		hci_dev_lock(hdev);
> +		if (hdev->discovery.state == DISCOVERY_STARTING)
> +			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +		hci_dev_unlock(hdev);
> +
> +		if (err == -ECANCELED)
> +			return;
> +	}
> +
> +	if (!mgmt_pending_valid(hdev, cmd))
>  		return;
>  
>  	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
>  			  cmd->param, 1);
>  	mgmt_pending_free(cmd);
>  
> -	hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED:
> +	/* Serialise discovery.state writes against any concurrent mgmt path
> +	 * holding hdev->lock; this callback runs on req_workqueue without it.
> +	 */
> +	hci_dev_lock(hdev);
> +	hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED :
>  				DISCOVERY_FINDING);
> +	hci_dev_unlock(hdev);
>  }
>  
>  static int start_discovery_sync(struct hci_dev *hdev, void *data)
> @@ -6196,17 +6219,40 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
>  {
>  	struct mgmt_pending_cmd *cmd = data;
>  
> -	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
> -		return;
> -
>  	bt_dev_dbg(hdev, "err %d", err);
>  
> +	if (err) {
> +		/* The queued stop-discovery work failed before the normal
> +		 * completion path could advance the state machine. The
> +		 * caller already moved the state to DISCOVERY_STOPPING
> +		 * (under hdev->lock; the callback's hci_dev_lock() blocked
> +		 * until the caller wrote the transient state and released
> +		 * the lock). Reset it here so the gate does not wedge in
> +		 * STOPPING.
> +		 */
> +		hci_dev_lock(hdev);
> +		if (hdev->discovery.state == DISCOVERY_STOPPING)
> +			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +		hci_dev_unlock(hdev);
> +
> +		if (err == -ECANCELED)
> +			return;
> +	}
> +
> +	if (!mgmt_pending_valid(hdev, cmd))
> +		return;
> +
>  	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
>  			  cmd->param, 1);
>  	mgmt_pending_free(cmd);
>  
> -	if (!err)
> +	if (!err) {
> +		/* Serialise discovery.state writes against any concurrent
> +		 * mgmt path holding hdev->lock; this callback runs on
> +		 * req_workqueue without it.
> +		 */
> +		hci_dev_lock(hdev);
>  		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +		hci_dev_unlock(hdev);
> +	}
>  }
>  
Hi, Luiz, do you still have suggestions in this change? 
>  static int stop_discovery_sync(struct hci_dev *hdev, void *data)

