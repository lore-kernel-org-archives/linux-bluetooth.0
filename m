Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876A357D14
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624015; cv=none; b=atdgI2ga3kBH6u2mJvcWmoql/WLz1uMOwf9gkykWiMWK8LDSYWL/KGkBqacsOnHyH1CWVt+OdOjf2fD8PgaFLRIC+CXZaYwG/IW+BS4mTXMP03B2984s0iK8vjBQNeIWhIk+Z2K2NqLRgIPiYfx3RVS+0FWJZ8axZ0I8aA9aIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624015; c=relaxed/simple;
	bh=tFo3aMYEz8i4EPm0cbUSiE5ApYj5zen3kyMGKiYs6Ho=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z270pBo1bklZ2kQV7ijmfgY0jg4Ul4wVDXQWPmPCEAkrIPjZk+RsAlDePeUdb2DwgNFTG1rplyps8NAN2pl7lOQYrT6fGZh6xCxHywzZT15Rfc3Ql7p1BDIkuIplpvWSZaP2M8uhgvGQQa0Aiei/deY9wy/mvm+eG4DxgXN+NKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=FxufzLw5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dy6NtX51; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="FxufzLw5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dy6NtX51"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D6A217A0152;
	Tue, 16 Jun 2026 11:33:32 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Tue, 16 Jun 2026 11:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781624012;
	 x=1781710412; bh=EUIfwaM5EOvkLK2al6yTPCH3UY1NAHsA3lvsBvzxdkk=; b=
	FxufzLw58rCI6eLKypARDzjD/F2/+ESiVcmS/q6xFjAf2ffEac4bbEOo1fXJKieE
	/opJSO1Bsyt5qWlyKHmxYbO5BmmStKnQpcsBlMRgx/ft5jHPkBrJgU7oLmRY+TG5
	VLnhx9uiVSd022ErDgY3BP8+RIPsswVAv3G9ePhCmWFD5scvEazVFQR2EzJqh1ax
	H21cOD44MjEHsVnRA+6loiVMSdyYfXfwT5u2cPYRXEVb35BWqHMgGtCqN+SiVbJP
	29BXel9exC6dBX/Yg3CzuGgtpKVbP5VDZ520eazFsGbZtCM/8dCoAVBZPlIMq7O+
	m8OvPjY49417kqbWOPr8Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781624012; x=
	1781710412; bh=EUIfwaM5EOvkLK2al6yTPCH3UY1NAHsA3lvsBvzxdkk=; b=D
	y6NtX51lVUBqMylIHA3++z1ppMktRFtYKOLSwSjnvDApc2Fb6U3FX5AkkF1nydlZ
	PTDM7TBa7hEcGXDn95E2/PrF/R+HmKkWcrN83YX4GovT7auCBO6YhrEcXLNIqex9
	v/sUSpAvVKTsCeMLRxGjsQimL2w+Z5Z2Rs0VjK5oZNEwRXqyhfbQnPlqs6qVxqNY
	Gy6GNi0SNoEkYIUTNA0rGGbVGg9V0iRsd97vdYOI27BKC/IvVLyQj8baWE7KOyyx
	aiOyzkYsFcoFx4ULcTvKyU6yuTpZgXKGQ0LnHkQJ9wUKJJCN/LRpNjBI3xML2uyf
	rW0QF0SH+le8erP4JTlMQ==
X-ME-Sender: <xms:zGwxalJ-Gvkg1chO86WsAxnoCfAClrL58C2BNDD5jB7KtDflhmZxjQ>
    <xme:zGwxar9I7EjukZEMCK4c2taiJbY8ScAOc2wWPB80cCj_N2zKu9q54zBKy0fc4p_1a
    EwUPPosKQ-JFpFTPKAqPW8ri9uu9p2JbzQbP4UiHf010XziG1c>
X-ME-Proxy-Cause: dmFkZTGAqtEr0BFkEVtApyUD4bvLd3UlpoUHWYiJs2EyC0CZDiUEh+KIGqneUjGzItI/8x
    7rvhsqDBHqcp533DiTAfn6UCXX/JJaNTENmBsiLeu+AT3zqDPj1a2HKmdXFyA60vHNFLha
    mGb1HKUyiF0iIwXL+qE5kVdVOtLx9b5j1jiWc5DjXXe9wnl59jbjGzsn4eDF+9rWhsxYpj
    YDsOvlQ4TswpweQX59Ir4FAhJBnc2c1dB+pMYUnDRoUNcf5nl0/NdnjfSsac7n9/D5y+f1
    uSmEuNjVvh2T7U8HGdqshfa99mav9edI03w2MWo9jvUDaz6ZYj7lMPHga9Ob5nlasTyvT7
    ctu9TsrSGuCEEa+Ua5hbPn6QsVBHNCKy7R3nl0/aoE2a6DEfOJMjghAgOmqnkuJfyINso6
    0AP8HlHrRflVVw9zbNZyVDMeO991c2z1aw1Od722Fv1KfHLyu8Cj/HALH+ExcQayybqElI
    yMu3TWfTOvVkifnx4hsVWIlYGztoxrpf4bqLJCiPjSrMAdapgIpbsHBO5XSpyMuWv0cBPG
    tyaqjibKSKhEj0+/6y0Du1Kr4vNHItyfzJM3SGnYri7q/tCMs0y8YJ9SGGpYv9qPUNXRhG
    p92UbAGLbOjnx0lkdLobWfyyhEeBAtCnjD5+HWp9kTbeLWP7yyeDkq3Oajzg
X-ME-Proxy: <xmx:zGwxav0dKW3hPR87cl-LmEn11_KK8gIlYFEycrDbOs_OsFvDulUAYw>
    <xmx:zGwxasBbiZ4ABrRiF4ZWk5psYKHZBAyuHkX8EWdUnkNRs2ONAtmv5A>
    <xmx:zGwxancOsefpoWjK3DQkHRt2kjFOG2L_YH2X7K_2KBvL_cmsl-RPzA>
    <xmx:zGwxahj-rd7sSYO58fKQDGQslx_R5QBEX6WqAbde9B6vmLdmwqp_6Q>
    <xmx:zGwxasvNjUCzkUAOZnmYzU8jDQMYan8wRKTrjJYOFJfEoh8RrZuBQKgu>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7ADF4216008A; Tue, 16 Jun 2026 11:33:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVuXUGZoqudo
Date: Tue, 16 Jun 2026 11:33:12 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <59789bed-23a9-4f2a-805c-de521a906a4f@app.fastmail.com>
In-Reply-To: <6a3030a7.f732ad81.18cf48.63cc@mx.google.com>
References: <20260615153527.1583705-1-oss@fourdim.xyz>
 <6a3030a7.f732ad81.18cf48.63cc@mx.google.com>
Subject: Re: [v6,1/2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Luiz,

On Mon, Jun 15, 2026, at 1:04 PM, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111791
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.82 seconds
> VerifyFixes                   PASS      0.09 seconds
> VerifySignedoff               PASS      0.09 seconds
> GitLint                       PASS      0.47 seconds
> SubjectPrefix                 PASS      0.16 seconds
> BuildKernel                   PASS      26.58 seconds
> CheckAllWarning               PASS      28.89 seconds
> CheckSparse                   PASS      27.60 seconds
> BuildKernel32                 PASS      25.49 seconds
> TestRunnerSetup               PASS      571.42 seconds
> TestRunner_l2cap-tester       PASS      58.94 seconds
> TestRunner_iso-tester         PASS      96.66 seconds
> TestRunner_bnep-tester        PASS      30.75 seconds
> TestRunner_mgmt-tester        FAIL      207.20 seconds
> TestRunner_rfcomm-tester      PASS      30.92 seconds
> TestRunner_sco-tester         PASS      31.50 seconds
> TestRunner_ioctl-tester       PASS      26.69 seconds
> TestRunner_mesh-tester        FAIL      25.83 seconds
> TestRunner_smp-tester         PASS      22.80 seconds
> TestRunner_userchan-tester    PASS      19.22 seconds
> TestRunner_6lowpan-tester     FAIL      45.81 seconds
> IncrementalBuild              PASS      43.45 seconds
>
> Details
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.234 seconds

The mgmt.c is not modified in this patch.

> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    2.808 seconds
> Mesh - Send cancel - 2                               Timed out    1.989 seconds

Also, the mesh path does not allocate hci_conn nor related to the code path changed.

> ##############################
> Test: TestRunner_6lowpan-tester - FAIL
> Desc: Run 6lowpan-tester with test-runner
> Output:
> Total: 8, Passed: 3 (37.5%), Failed: 5, Not Run: 0
>
> Failed Test Cases
> Client Connect - Disconnect                          Timed out    5.480 seconds
> Client Recv Dgram - Success                          Timed out    4.991 seconds
> Client Recv Raw - Success                            Timed out    4.993 seconds
> Client Recv IPHC Dgram - Success                     Timed out    4.999 seconds
> Client Recv IPHC Raw - Success                       Timed out    4.993 seconds
>
>

Fixed by the recent commit d35e2950daaf8cd362beb4ecd42af2b0d9459136.

> https://github.com/bluez/bluetooth-next/pull/318
>
> ---
> Regards,
> Linux Bluetooth

Could you please review on this patch?

And also this patch I sent on Monday.
https://lore.kernel.org/linux-bluetooth/20260612143449.3045055-1-oss@fourdim.xyz/T/#t

Thanks.

Best,
Siwei
