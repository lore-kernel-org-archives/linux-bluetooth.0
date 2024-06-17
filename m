Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CDF191461
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623994; cv=none; b=ro/deRnapP2g/yoOkzvfjLjKIAeLEzu92YmRtxZ8egpZ7ADxdgZ+W+l4J8DMF67L0KWM1UJwvgqRwMJM+tS+Ds6lsWjDsQjFyGnXoupx7P6eEaoInPAh8OLDTcgt80jln5Z+z0qlJtft+H/ay9BKqrplJaJqAcqrP9zt71Wtoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623994; c=relaxed/simple;
	bh=zBP6dqNNfz12pS0Ue76Q5ZDXvyehS0DhtzQ6Yft3sLA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FtYkxexJaz94xubsHkqbma8fJRSOcXxfb+1i7N8v18WjlmmY67Y/nggUoq7511Hi9/5KqBpgKAa5Z/z+egqazhSbfCP3TixniiKGdlWovS9RQNyGFfNwCemkZCjmt8BPrMtfpRprnmoenX7bb+UaepOzM60e0oPmS9qA8Kt6iFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFEbxo3s; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFEbxo3s"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d227b1f4f0so2322865b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718623991; x=1719228791; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OPUNcyytnHGkwvCuzvOW8AWdrSFrNGblfrgBgtNjSCE=;
        b=IFEbxo3saVdlJ2aXhR/9dpnsncDeeMqpBLtLd0OHPFyluPTBBES/2xm+eWiD2Jiin0
         gNSffm2Iy/r8nvhyS9x0o1Y+oUe8wbfZEXrLgbXLdQrwdOGyrQLe5iRYFH9Qk/eBscHA
         bi85DbwIQhtxSntYk8RDmlHGt1BlW6kYf9RJgAgvewo0h98bZMd9q8WxL4WjHEsXMRhn
         IR20Ia7TQdr5x4NBYju2CQm4e7flNO+SySJ4848HEuS9wVCAcqkwjdQJZWKRKcWbitVN
         TXBKKhsfYaQEE6y8pPH2UTW90tu48zJbLD8DiN+oct2l4X1Z1kLzTjAmddFVFKAuTMQb
         lxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718623991; x=1719228791;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPUNcyytnHGkwvCuzvOW8AWdrSFrNGblfrgBgtNjSCE=;
        b=dLQqL2ORed+ug8BuQXPdubNUGHD1RxyUvmQvbONEqYUYNon72yUICpsHPeNnyG69F8
         ynsihftTWTLMGVAVTNNZavlcLEsbRhcaJeotDVtx/p6NhDsmTVn+TI26CHGXWYW4bn9X
         RCW+jEQlqUmME8cBxfmSBcFioICLLk6PWrd1GVdKha9P+DivXP8zgTthEgRWkHyRm8eR
         iQYJoVBaPUdedJeYfVXkx5UToX6icGPINJ71U5rwvOoefONvvg4fvCntntDaeNQbia3r
         3L0k4sHnChRNV+tl3ZbXQ/sbgTJUnrms54T1ZUQPQmm3fhAGClpXnAkkGw3RUISGjY8q
         thAA==
X-Gm-Message-State: AOJu0YxZRGsVqKI3wOtdR07bqVmlEu8nx4/weqH1tc80vX/qWuwMmSdy
	4yyBjBkNf689C1939UErxXE1iWbcxLL/4/VmtGNly+hFkX+8WjidGLwyqg==
X-Google-Smtp-Source: AGHT+IFJjxHY1eAyiKo8Tq0Ev8zxIP0WD13nrw0HZ4mTjxWm1S/Dq4rgFgXS1TPIt3e+9EfUGFUSiA==
X-Received: by 2002:a05:6358:718d:b0:18d:6fba:d2f8 with SMTP id e5c5f4694b2df-19fa9de7051mr1211893055d.13.1718623991359;
        Mon, 17 Jun 2024 04:33:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.28.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedcf3567csm6457556a12.16.2024.06.17.04.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:33:11 -0700 (PDT)
Message-ID: <66701ef7.630a0220.180c0.0fc9@mx.google.com>
Date: Mon, 17 Jun 2024 04:33:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3918175018730488083=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: btrtl: Set MSFT_EXT_ADDRESS_FILTER quirk for RTL8852B
In-Reply-To: <20240617105020.3246015-1-hildawu@realtek.com>
References: <20240617105020.3246015-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3918175018730488083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862570

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.71 seconds
CheckAllWarning               PASS      33.77 seconds
CheckSparse                   PASS      38.63 seconds
CheckSmatch                   PASS      102.31 seconds
BuildKernel32                 PASS      30.54 seconds
TestRunnerSetup               PASS      524.16 seconds
TestRunner_l2cap-tester       PASS      18.87 seconds
TestRunner_iso-tester         FAIL      32.99 seconds
TestRunner_bnep-tester        PASS      5.05 seconds
TestRunner_mgmt-tester        PASS      112.10 seconds
TestRunner_rfcomm-tester      PASS      7.41 seconds
TestRunner_sco-tester         PASS      17.08 seconds
TestRunner_ioctl-tester       PASS      7.94 seconds
TestRunner_mesh-tester        PASS      6.27 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PASS      30.26 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.169 seconds


---
Regards,
Linux Bluetooth


--===============3918175018730488083==--
