Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239753;
	b=mxdC4I8O8paDd7bO0mV3N/cUsVKa8ToxwCTzp0+mdamerXXCMdEqFFhwmWjHnLoBM404
	 Vmk3bFwb9MKVKsvprOEHg1j6HYJZ+G2y3qqN5l4/wsBARY32BBU3qGmz8FNHsJd6NGoNT
	 Iil39+K2YYhtbCOtPXlf98iBNUtN5OD7VK+pYF6nm3C/f3sxwqw2tIYxJMDf6Mo3ZHnpR
	 30/kObw4MuwwnO2PQozs4hDzVgH37D0boT+W+pRBtTAux2ah3eTgLug+j0uEh88gN7cnr
	 y4nqnWF0WhDTqVGJweacfAEUZTB2j+ovchHaXBvgNxsK6X/CKaQs/lovu9QHLfyybZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=bSZNRMcHJ/DIddsrr71DiNoVDmpOdD7i9tRO6mThzk4=;
	b=cDUSE12t399SM/i8qLbFxLnG8wrwUWL1s6a6JE9cD0LfcZ/kh1TInrFYMDsUGFtA2EIm
	 NXmvvpCxOKyCo5qdxIRuxsFxiNSl7uLksSxOTE18/AznJuEed7WfXaUtDAKE44PtPLxbL
	 ztWLTIRdAiRPjxNSHhWibf7AEfTVmV67ZIwfY+iGkmdt/5ognPRSbnjs8AiPH6FFEvDmG
	 +3kgw73tnXBTRFyrRj5c0eYvq+38+GtL0ADM5cj/bl5VyPdwcYDoIRMvph0Pdb4SbOFXB
	 8dvwE6pB7DwG2b44EbyG51nMnUHyM76KfN4nA+CbwKohoZoYgbwSnL5arkn4akOaoEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nvOrOxSd;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180C606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 02:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7180C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nvOrOxSd
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a315ed211so342095eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 19:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793239752; x=1793844552; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bSZNRMcHJ/DIddsrr71DiNoVDmpOdD7i9tRO6mThzk4=;
        b=nvOrOxSdwDWTmN8gcPI5hFSQSSlpD9lolp8fKjiOTwBSQuJ6pYKkPoKlrpF9Prq4/U
         w7woOCK8M9qLrIiK6h7SylaxrGYfEJ32R2LB/15j6Dh2PzevqEOiTPTDiZsUaJG3f2S8
         xQEK/9+WBvhyZjCXbFqKRkI2TtcAdN7rTwxBE8uD084EZxZeAyKse3nKalMa69TyGNDw
         tN9OrVMFKUTMgroJhv3s5Kzkj+Jm815TvRbzoBF4L+cB2BofkHKOfYlCmPU0oTTqwDS+
         26owEbKukstJw69xDKUNCEIbgfy+yHzQQ/v/AmWV8b2CwpJRICSfQhEiahB8YIJ85kPB
         mOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793239752; x=1793844552;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bSZNRMcHJ/DIddsrr71DiNoVDmpOdD7i9tRO6mThzk4=;
        b=CfHcHUlHevqmt5637DTxca00YW3P3DJtSM6/V8mhGTyZ5HQBiyQYIgFzGz1Vp3J/Ar
         Ncbd3AQHs1AUdKlK0SwcjHtdUx3ODA+HHzZpQGbROaCXzygsQG4q/uebo6wD5aII9M2e
         /L+0N2NYoPqZ2M0xnbQ6eN+6aI5vp89NF2O/Rk8osItF2zeD8OlSeHhPCPiQJ8awFSnv
         d2/CRBZSPfJYcFa54iIiaVC9ultdVdmdb0WEpt5h5j0xwswFa77JwbDIZld3TkpmGUJo
         dMZAgfNebrCOUemXS2BePnOlMnNKs6esWEbUdMb7XkmO/bfJFuCdHn7HYf629dQ5Ft2a
         H1MA==
X-Gm-Message-State: AFq9FYI/Lp+KarUzPmKz3C6zGmqEXd1cdrlNMuOtlI5AQ9cTovs8k8NW
	2hPtnCNeEbhbZHho3B4uSr6yFSO50dVTxRxQKBfQD4DU9rHrc1r091sxQ/9IHg==
X-Gm-Gg: AYBFou2tkhu7yyMQZRmqpuWfao99Til/GnBdaV9fmT8IitO8dZyCajDQFlCAowCGRob
	imMOxGUToFkcZ2x4tyXK1IF8vuDmzmMP5B7VSYBF2v1fhdPTRBqsAT2GLVyOnGfPRcBJStx4utm
	AhIO5T5tZIebe1I5q7e+CrqiuR/IZ1gsFkL2MXdc4tbt3LqzOsdb97uSkY8Q0p9OslZ72T4xU3m
	IqioBfwOS/c17lsj65qjr4D6eS8WihGU/sU+WK+lEqzNwVq6UPptrS5FInvHFl+BmvKtDhYKTdh
	pr7hRq8JMJBQtSs2XB7M/vTw69tCWYZh1CG5IZyLoTGwlERla21UzTg+fDq/n0xbqwy5C3VtoNm
	RW4m5uVC3Oe8DrGzf70DAk/LnYzlYXv1/Kdc/YWD9S554tP8ugjnzhqERrZmh/yd2SbZJ86EL+5
	jhmLbJAVoEGtNgNgjr/61D0cZkqXeL9d/LrW19G8KMjBgpPOPqfzU7ng8kJbwcfMuOZ8hhoCN7+
	pDCyP1EiPEHGXGjCtr2GL+MmTZKrs98vQJ2vKucwKnCE2omiQCACgTWpN9bsvXv
X-Received: by 2002:a05:7301:4715:b0:369:f17d:efb with SMTP id 5a478bee46e88-36a3002dfe5mr1557535eec.10.1793239752187;
        Wed, 28 Oct 2026 19:09:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.140.104])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237be80csm25050301eec.2.2026.10.28.19.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 19:09:11 -0700 (PDT)
Message-ID: <6ae2aac7.99020481.2ef3b0.09d8@mx.google.com>
Date: Wed, 28 Oct 2026 19:09:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1760801817993429536=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@michaelmcallister.org
Subject: RE: Bluetooth: qca: Fix WCN3950 power-off
In-Reply-To: <179322687811.94538.11949086384142524062.wcn3950-poweroff-v1-2@michaelmcallister.org>
References: <179322687811.94538.11949086384142524062.wcn3950-poweroff-v1-2@michaelmcallister.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1760801817993429536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195776/

---Test result---

Test Summary:
CheckPatch                    PASS      3.03 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.93 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      32.82 seconds
CheckAllWarning               PASS      36.55 seconds
CheckSparse                   WARNING   40.78 seconds
BuildKernel32                 PASS      35.33 seconds
CheckKernelLLVM               PASS      36.31 seconds
TestRunnerSetup               PASS      768.31 seconds
IncrementalBuild              PASS      37.75 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/hci_mrvl.c:170:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:203:23: warning: restricted __le16 degrades to integer


https://github.com/bluez/bluetooth-next/pull/1018

---
Regards,
Linux Bluetooth


--===============1760801817993429536==--
