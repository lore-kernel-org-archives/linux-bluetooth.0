Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B9B3B8D50
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490371; cv=none; b=oAd53wQ8OgpRcanwOxSmaz107h1KOiL5DaoEzoAjNgUh7DUS2yD0eE41BIsP3VYzucwWahNUlQMG2QVlY//Fxahot9bbTsHOdcyt4BvgKA4/VRRA3JTZG5Vh1n59ex5SojD7vlRScyeiIv0GWZHXet6pKIbN6VHHGQjRPhbRQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490371; c=relaxed/simple;
	bh=Ln+AWCppdQzjqk2SGTiLTurDNLipGzjEVNh2P21j3tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGY45ko/j4APLIs3LJDERMDoRBX/bM6sjCP/q0IJmtMaYPXu9bWvV8rtsuGjSENzIYIxtgoRAnz/YGkyrLq5vOzZl4Amp9NzfOBbsnnVcpQnWuCN0/7lRUNSeqnT/324O0FSSRMgT8IXPVuGAsRu76r2xolldPv8WBkSCU0aLlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVyYHudR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CRolegn6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVyYHudR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CRolegn6"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842SM81447415
	for <linux-bluetooth@vger.kernel.org>; Wed, 8 Jul 2026 05:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uqSny8F8Ghd4R0ySyoayfvtgxKEKbyO13k2QK0qpJlM=; b=jVyYHudRqBZxWwbA
	KgFgSLtJtkoZ4ycMl1ULtv5tpJgcrUWlV0Zb/z/ki3WfIxKQDXreP+NjozaM0/UL
	Yytud2R/ZWD6oQMOSHnlo4XIv2SgK65yaTH8PeISi+L831yo9AK1OGnEx6wyzdm9
	GrUgy9pti+gBvLRVKep5bqGQdU01X42rQ8aub7U1PvV1cIeyYQR51cnAmIwZFZnJ
	CexjXFLrR+XhSY8sRoA7S2KMUSnBl+ZfS3P7Fd6mxRCL7f6Plv2OOvVYS/gnr7Gu
	XFzYxNC2UH7pi9qfSthRqaa9eqswRp+A8sNRDVJ1VM6JZsTOV2rNMrdDzF5FuaoT
	oMbUlw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f97u11wfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 05:59:29 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8478423e020so634422b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 22:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783490368; x=1784095168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uqSny8F8Ghd4R0ySyoayfvtgxKEKbyO13k2QK0qpJlM=;
        b=CRolegn6Xa0n1IUJac3SIEGt2ObUDkuD0zfcpPo1flfdBaoHWhkJe2GZwEXb9Wlpcp
         pT+cy6WyH5zubh8oOa7fRl8BcAPrquecJi4fQJfy/b1QcISAty5sQ57m6cKKWEGr1O+q
         F1LxMjQbPLxIhBs0PsiqUkToLTfgyToTwUCV+MM4TckR9F4sJF1WswS49Z6FSvpEGiJv
         Nw12KykB6rpjo4bR/GDXoE03O8cpiRXZiYfVAMgNLWof57aF43cInVtASF2AOKXNKp8z
         BMhTaXVsrralCkn/txSzs3zo4m0sK2yg1JDbFHQc4p/gbRzZsdXhIZwA2VBLrkHZI2I0
         te8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783490368; x=1784095168;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uqSny8F8Ghd4R0ySyoayfvtgxKEKbyO13k2QK0qpJlM=;
        b=RGcJOST8IvGpW5CjGafA4QqzZUpDTcaxmiqxqG8ceEkALu6HePffwNjsUiV9Pkq+bh
         N+p1zERE6ZbG4Vg6BiOxRDT+eP/DQE6Qn1Po/z6aqnj0w1Q1Mpbog7kYIJ5kddaK9NCH
         jnFRbqAC8z3a2RuYz+VsxYJtoFpLSnoIAJ5QGdWHMr1zaaO+ozUeQn5cm8mDlPGq5Wda
         hRd3y6aKQ0Frx/joIDxtd9azUU/wQeXSHI1WRHQyuRejtQLqD2GpJydHVS/FBQnj/OgM
         e3XHNPuyaRaj9l2QXPS0/gRRwdT/M7A918Z+Mbi/W6XlEIeJLIEK290ZYpATcILcNKZG
         F3xQ==
X-Forwarded-Encrypted: i=1; AHgh+RphZsuoOPo9gakta9eHa1tGlWbU/WeKN2bQLO1sfNXZd+BHGGTJ+zWuI7Wh9IeF0serkisEdESZuvR0HN2dqWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQyOrtFZziQdiUTA9Hf1H5bqJnjF3+BwTMiUQgiKTgYOYa4Da
	CS1IXol87qdpjwPxyz5KrcnB4sRv9Ey/ke0M9aYItHzoJmZYF4Cok9tBafi/2x1OWCgXQwm9A4J
	3uP+TmmY0S8v1E3bK1rodUWbaUVmUHKB32FU3UVK7Ea8vDI1VfPJttA/j8O5t35qz9B1exjY=
X-Gm-Gg: AfdE7clR+hoAr2F9R6BXlm7lJwYVL1+VY2srEyfqb6NbLUyrmnIH0ebPgvozrVUG2un
	yL5iTcIkPDnyR7dnKZI2NKNvfZmH/7MVjdHObvVAJ9Ksg/JfOkgH8u2HPtP55efFCferrK6mLxG
	MrJ2yEJSSKC3Cp0hG6eqpVRCn/DiXeB9Lvvmxbi+tlMdHvxj9Lz7fmytHukXDXBrzJRTA/KnuqH
	QGomG0FpMjVf5LPxG8lS1q5YoXZBCb95C15UihrjxKVNcUp6x+tizZ1cPsfsSgvv4hCjhLD/JCg
	9UfTfCAchNXfhrx/oztyodQis8whB+Cu7vLT+gqIOHt5vXMeLu8+UbjZNS2YmSnyWrR73zA9TqA
	Od5xZ4N143856IO31r6NAVHKZSkKjvW1olfoqs6C7
X-Received: by 2002:a05:6a00:2e08:b0:842:68d3:e29d with SMTP id d2e1a72fcca58-84842fd41cemr1147444b3a.36.1783490368390;
        Tue, 07 Jul 2026 22:59:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e08:b0:842:68d3:e29d with SMTP id d2e1a72fcca58-84842fd41cemr1147406b3a.36.1783490367737;
        Tue, 07 Jul 2026 22:59:27 -0700 (PDT)
Received: from [10.253.37.137] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afeb060bsm1882589a12.14.2026.07.07.22.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 22:59:26 -0700 (PDT)
Message-ID: <6067fddc-d3f3-471f-a82f-025f7ebb2159@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 13:59:21 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix discovery state race against
 cmd_sync worker
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
References: <20260707093426.372897-1-xiuzhuo.shang@oss.qualcomm.com>
 <CABBYNZ+X-+ZJYz-V-_QSP5kCJpJJaBiyO=wMHD+Ut+b=639t2Q@mail.gmail.com>
 <CABBYNZLXZaY7KiUneNMg7PrsTJjPF99hPY3sq5a2pL0RC9Z4tg@mail.gmail.com>
Content-Language: en-US
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <CABBYNZLXZaY7KiUneNMg7PrsTJjPF99hPY3sq5a2pL0RC9Z4tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1p836oVVj2vnjzPkYUMw8q_opd_G-Te2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NSBTYWx0ZWRfX0wnox4UjtdZW
 2hHfPv1w3qPD2IHamEyrKY+iMWtfr636A1R2nMQJo4FfkASKQ+PFrRO4g44ik5kIMBzDKy32y8a
 4C7FAQejZftjTmCJwsoEFlpKsjC/lB8=
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=6a4de741 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=cC5VhTdkmkCdcEF56qsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 1p836oVVj2vnjzPkYUMw8q_opd_G-Te2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NSBTYWx0ZWRfX7Qmwn8sWNGeB
 PnS5gzm5/vOVMCCzq46zmrJVXW+NMx4+WLtAg/SbBHGtqrAm7tSqNzENiA6nzhlFc3nsADVpKhi
 WDvvvCLfno+6zYPnloF2iY+DMrVPZLxe16yG5BcFKjKIxfeexXpETaZii9C7XWxAK1KTaYOwBsC
 ztQg0VuuPmmIfxr9ESUqz6b6IO7w2XxZJ+otpbR6cNAIa4pcyPWBJQ/hHuwaWzfpmrzu4O7mJgz
 9R9xa8SJeNXe91UyYJmbwL/YhYRm/no5fI7mpnqKgBdnBeuwem4bzkvpV264P/weUKxIKE456u/
 OFf7YNinDY8W9Pexc0dhTdFZo1Hwg09esGng83PwYns/nDESwKPnPpJQIhVq1+ATWCO9mEj0LTH
 lsPnpDLvFVjBU3imhhtbnMoCowsK4UsSlcIXR7FwTgsulFPg+HzCPpF5EmJMaPw4smrIooHshJY
 7WrQFzphzfSDfjGnE6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080055



On 7/7/2026 11:17 PM, Luiz Augusto von Dentz wrote:
> Hi Xiuzhuo,
> 
> On Tue, Jul 7, 2026 at 10:09 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Xiuzhuo,
>>
>> On Tue, Jul 7, 2026 at 5:34 AM Xiuzhuo Shang
>> <xiuzhuo.shang@oss.qualcomm.com> wrote:
>>>
>>> start_discovery_internal(), start_service_discovery() and stop_discovery()
>>> queue a cmd_sync work item and only then move the discovery state machine
>>> into its transient value (DISCOVERY_STARTING / DISCOVERY_STOPPING):
>>>   err = hci_cmd_sync_queue(hdev, ..._sync, cmd, ..._complete);
>>>   if (err < 0) { ... }
>>>   hci_discovery_set_state(hdev, DISCOVERY_STARTING /* or STOPPING */);
>>> The matching completion callbacks run on hdev->req_workqueue serialised
>>> by hci_req_sync_lock, which is independent of hdev->lock. So once the
>>> work has been queued, the worker can be scheduled, run the sync function
>>> and invoke the completion before the caller has executed the trailing
>>> hci_discovery_set_state(). The completion's success path writes the
>>> terminal state (DISCOVERY_STOPPED for stop, DISCOVERY_FINDING for start);
>>> the caller then overwrites it with the transient value, and the state
>>> machine is wedged: every subsequent Start (Service) Discovery is
>>> rejected by the DISCOVERY_STOPPED gate with MGMT_STATUS_BUSY (0x0a),
>>> with no HCI traffic generated, until bluetoothd or the adapter is
>>> restarted.
>>> Fix it in three parts:
>>>   1. In all three call sites move hci_discovery_set_state(STARTING /
>>>      STOPPING) to before hci_cmd_sync_queue(). The transient state is
>>>      therefore always published before any worker can run the
>>>      completion. On queue-submit failure, roll back to
>>>      DISCOVERY_STOPPED.
>>>   2. In start_discovery_complete() and stop_discovery_complete(), wrap
>>>      the terminal hci_discovery_set_state() call with
>>>      hci_dev_lock() / hci_dev_unlock(). These callbacks run without
>>>      hdev->lock; serialising the state write matches the pattern used
>>>      by mgmt_set_powered_complete() and removes any residual ordering
>>>      hazard against a concurrent mgmt path holding hdev->lock.
>>>   3. Generalise the "ignore -ECANCELED" early return in both completion
>>>      callbacks to "on any err < 0, also reset the transient state to
>>>      STOPPED". With (1) in place the state observed at completion time
>>>      is always known.
>>>      For the stop path this also fixes a pre-existing wedge: when any
>>>      sub-command issued from hci_stop_discovery_sync() returns an
>>>      error, stop_discovery_complete() is invoked with err < 0. The
>>>      existing "if (!err) set_state(STOPPED)" tail then skips the reset
>>>      and the state machine sits in DISCOVERY_STOPPING forever.
>>
>> Needs the Fixes tag since we might want to backport.
Acknowledged. The bug was introduced by:                                    
                                                                              
  Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY")
                                                                              
  Will add in v2.
>>
>>> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
>>> ---
>>>  net/bluetooth/mgmt.c | 86 +++++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 74 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>>> index 733a4b70e10c..25ad9c10740d 100644
>>> --- a/net/bluetooth/mgmt.c
>>> +++ b/net/bluetooth/mgmt.c
>>> @@ -5975,15 +5975,38 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
>>>
>>>         bt_dev_dbg(hdev, "err %d", err);
>>>
>>> -       if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
>>> +       if (err < 0) {
> 
> Sashiko flags the above check as an issue because it tests only for
> negative errors, not HCI (positive) errors:
> 
> https://sashiko.dev/#/patchset/20260707093426.372897-1-xiuzhuo.shang%40oss.qualcomm.com

  The check should be if (err) rather than if (err < 0). The existing tail already uses:                    
                                                                                                            
  hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED : DISCOVERY_FINDING);                               
                                                                                                            
  which catches both negative errno values and positive HCI status codes. The if (err < 0) guard in the new 
  block is inconsistent and would miss positive HCI errors, leaving the state wedged in STARTING. Will fix  
  in v2. 
> 
>>> +               /* The queued start-discovery work failed before the normal
>>> +                * completion path could advance the state machine. The
>>> +                * caller already moved the state to DISCOVERY_STARTING
>>> +                * (under hdev->lock, before queueing). Reset it here so the
>>> +                * gate in start_discovery_internal()/start_service_discovery()
>>> +                * does not wedge in STARTING and reject every future Start
>>> +                * (Service) Discovery with MGMT_STATUS_BUSY.
>>> +                */
>>> +               hci_dev_lock(hdev);
>>> +               if (hdev->discovery.state == DISCOVERY_STARTING)
>>> +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>> +               hci_dev_unlock(hdev);
>>> +
>>> +               if (err == -ECANCELED)
>>> +                       return;
>>> +       }
>>> +
>>> +       if (!mgmt_pending_valid(hdev, cmd))
>>>                 return;
>>>
>>>         mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
>>>                           cmd->param, 1);
>>>         mgmt_pending_free(cmd);
>>>
>>> -       hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED:
>>> +       /* Serialise discovery.state writes against any concurrent mgmt path
>>> +        * holding hdev->lock; this callback runs on req_workqueue without it.
>>> +        */
>>> +       hci_dev_lock(hdev);
>>> +       hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED :
>>>                                 DISCOVERY_FINDING);
>>> +       hci_dev_unlock(hdev);
>>>  }
>>>
>>>  static int start_discovery_sync(struct hci_dev *hdev, void *data)
>>> @@ -6051,15 +6074,23 @@ static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
>>>                 goto failed;
>>>         }
>>>
>>> +       /* Publish the transient state BEFORE queueing the work. The
>>> +        * completion callback runs on hdev->req_workqueue serialised by
>>> +        * hci_req_sync_lock, which is independent of hdev->lock; setting
>>> +        * the state after the queue allowed the worker to win the race
>>> +        * and have its terminal STOPPED/FINDING write overwritten by this
>>> +        * trailing STARTING write, wedging discovery in STARTING.
>>> +        */
>>> +       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
>>
>> Hmm, do we really need to do this if hdev lock is taken at
>> start_discovery_sync? Because that should then synchronize the
>> callback won't be able to change the state before it is set to
>> DISCOVERY_STARTING.
  Yes, the move is necessary. The old discov_update worker was safe for a     
  different reason: it never wrote the transient states (STARTING/STOPPING) — 
  those were always written by the caller before queue_work(), and the caller 
  wrote nothing after. The worker only wrote the terminal states              
  (FINDING/STOPPED) after completing the HCI work. There was no conflict      
  because only one side wrote each state.                                     
                                                                              
  With hci_cmd_sync_queue(), the completion callback now writes the terminal  
  state, but the caller still writes STARTING/STOPPING after the queue call.  
  Two threads write discovery.state in an uncoordinated way.                  
                                                                              
  The reason hdev->lock does not prevent the race is that the completion
  callback runs under hci_req_sync_lock, not hdev->lock. Looking at
  hci_cmd_sync_work() in hci_sync.c:    
 
  hci_req_sync_lock(hdev);
  err = entry->func(hdev, entry->data);       /* start_discovery_sync */
  if (entry->destroy)                   
      entry->destroy(hdev, entry->data, err); /* start_discovery_complete */
  hci_req_sync_unlock(hdev);

  hci_dev_lock is mutex_lock(&hdev->lock) and hci_req_sync_lock is
  mutex_lock(&hdev->req_sync_lock) — two independent mutexes. The caller holds
   hdev->lock when it calls hci_cmd_sync_queue(), but the worker only needs
  hci_req_sync_lock to run, so it can proceed and complete concurrently:

  Caller (holds hdev->lock)            Worker (holds hci_req_sync_lock)

  hci_cmd_sync_queue() ──────────────► enqueued, returns immediately
    [still holds hdev->lock]           start_discovery_sync()
                                       start_discovery_complete()
                                         set_state(FINDING)  ← ① written first
                                       hci_req_sync_unlock()

  set_state(STARTING)  ← ② overwrites FINDING → WEDGE
  hci_dev_unlock()

  We have a debug-instrumented kernel log from a QCS8300 device that captures
  the race directly:  
                  
  [T8668] stop-discovery complete: err=0  state=2  <- FINDING; caller has not
  yet written STOPPING                  
  [T8668] set_state(STOPPED)                       <- worker writes terminal
  state                                 
  [T2216] set_state(STOPPING)                      <- caller overwrites
  STOPPED                               
  [T2216] REJECT BUSY: state=4                     <- every subsequent
  StartDiscovery refused                

  state=2 (FINDING) at the completion callback entry proves the caller had not
   yet executed the trailing set_state(STOPPING). Moving set_state to before
  hci_cmd_sync_queue() — while hdev->lock is still held — ensures the
  transient state is always visible before the worker can call the completion.

  Will send v2 with the above corrections.

>>
>>>         err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
>>>                                  start_discovery_complete);
>>>         if (err < 0) {
>>> +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>>                 mgmt_pending_remove(cmd);
>>>                 goto failed;
>>>         }
>>>
>>> -       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
>>> -
>>>  failed:
>>>         hci_dev_unlock(hdev);
>>>         return err;
>>> @@ -6178,15 +6209,19 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
>>>                 }
>>>         }
>>>
>>> +       /* Publish the transient state BEFORE queueing; see the comment in
>>> +        * start_discovery_internal() for the race details.
>>> +        */
>>> +       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
>>
>> Ditto.
>>
>>>         err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
>>>                                  start_discovery_complete);
>>>         if (err < 0) {
>>> +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>>                 mgmt_pending_remove(cmd);
>>>                 goto failed;
>>>         }
>>>
>>> -       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
>>> -
>>>  failed:
>>>         hci_dev_unlock(hdev);
>>>         return err;
>>> @@ -6196,17 +6231,40 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
>>>  {
>>>         struct mgmt_pending_cmd *cmd = data;
>>>
>>> -       if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
>>> -               return;
>>> -
>>>         bt_dev_dbg(hdev, "err %d", err);
>>>
>>> +       if (err < 0) {
>>> +               /* The queued stop-discovery work failed before the normal
>>> +                * completion path could advance the state machine. The
>>> +                * caller already moved the state to DISCOVERY_STOPPING
>>> +                * (under hdev->lock, before queueing). Reset it here so
>>> +                * the gate does not wedge in STOPPING.
>>> +                */
>>> +               hci_dev_lock(hdev);
>>> +               if (hdev->discovery.state == DISCOVERY_STOPPING)
>>> +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>> +               hci_dev_unlock(hdev);
>>> +
>>> +               if (err == -ECANCELED)
>>> +                       return;
>>> +       }
>>> +
>>> +       if (!mgmt_pending_valid(hdev, cmd))
>>> +               return;
>>> +
>>>         mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
>>>                           cmd->param, 1);
>>>         mgmt_pending_free(cmd);
>>>
>>> -       if (!err)
>>> +       if (!err) {
>>> +               /* Serialise discovery.state writes against any concurrent
>>> +                * mgmt path holding hdev->lock; this callback runs on
>>> +                * req_workqueue without it.
>>> +                */
>>> +               hci_dev_lock(hdev);
>>>                 hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>> +               hci_dev_unlock(hdev);
>>> +       }
>>>  }
>>>
>>>  static int stop_discovery_sync(struct hci_dev *hdev, void *data)
>>> @@ -6248,15 +6306,19 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
>>>                 goto unlock;
>>>         }
>>>
>>> +       /* Publish the transient state BEFORE queueing; see the comment in
>>> +        * start_discovery_internal() for the race details.
>>> +        */
>>> +       hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
>>
>> Ditto.
>>
>>>         err = hci_cmd_sync_queue(hdev, stop_discovery_sync, cmd,
>>>                                  stop_discovery_complete);
>>>         if (err < 0) {
>>> +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>>                 mgmt_pending_remove(cmd);
>>>                 goto unlock;
>>>         }
>>>
>>> -       hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
>>> -
>>>  unlock:
>>>         hci_dev_unlock(hdev);
>>>         return err;
>>> --
>>> 2.43.0
>>>
>>
>>
>> --
>> Luiz Augusto von Dentz
> 
> 
> 

