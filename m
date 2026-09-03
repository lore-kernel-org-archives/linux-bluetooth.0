Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DED314B63
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466800; cv=none; b=jPcN0kuVz7gQFa5/b/1D33DLVKW0tGPwJHUzKeknW9z6kLfA0BcmMzY7EqI0fluotA9NP07wFmd7XwVudweLq3XlfxJExmONDeXBPVHSSmOqig9fU3YaMSaa1q3FFMKkMT0A3q3AKvuBO8+wacLIhq3kDN7MBSmzwjpSXfe0Opk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466800; c=relaxed/simple;
	bh=vrgANoOZP4uxpzFUg0+vAi2/oa2qxS2L6S2v3Gz4KuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=g2F0dHPt+uvCqiuy3N+SalxTDLr6TDbRASZmGNkqNqMYhMgemJeCywsVi+2sPEqNiJHcqD2b/3Q6eLuDA/1hO+W7zS8i2D9rEk+sas6txvXU+OY53GRIpXTP2X1Cp0Y4R+VvNrEjzoNazLiQ1Oiflc1qpAOnRGyZHk/ra820lVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.230] (p5dc5557e.dip0.t-ipconnect.de [93.197.85.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 953B84C2C37D7E;
	Thu, 03 Sep 2026 22:19:33 +0200 (CEST)
Message-ID: <c820f791-2edb-49f4-a39e-801965fc86ed@molgen.mpg.de>
Date: Thu, 3 Sep 2026 22:19:31 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] Bluetooth: btintel_pcie: fix stale cache in set_dxstate
 fallback check
To: "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>
References: <20260903153521.130258-2-vladimirkondratyev2@gmail.com>
 <6a99bf19.a40fb949.f1a41.3b57@mx.google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, Sergey Lebedev <lsa.uz@pm.me>
In-Reply-To: <6a99bf19.a40fb949.f1a41.3b57@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 03.09.26 um 20:40 schrieb bluez.test.bot@gmail.com:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157226
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    FAIL      0.97 seconds
> VerifyFixes                   PASS      0.13 seconds
> VerifySignedoff               PASS      0.13 seconds
> GitLint                       FAIL      0.34 seconds
> SubjectPrefix                 PASS      0.13 seconds
> BuildKernel                   PASS      26.99 seconds
> CheckAllWarning               PASS      29.40 seconds
> CheckSparse                   PASS      28.36 seconds
> BuildKernel32                 PASS      25.69 seconds
> CheckKernelLLVM               SKIP      0.00 seconds
> TestRunnerSetup               PASS      474.96 seconds
> IncrementalBuild              PASS      24.73 seconds
> 
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script
> Output:
> [v3] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
> #113:
> operation to abort on Intel Lunar Lake hardware. The system immediately resumes

`scripts/checkpatch.pl` ignores lines that start with the “timestamp”.

```
# Check for line lengths > 75 in commit log, warn once
                 if ($in_commit_log && !$commit_log_long_line &&
                     length($line) > 75 &&
                     !($line =~ /^\s*[a-zA-Z0-9_\/\.]+\s+\|\s+\d+/ ||
                                         # file delta changes
                       $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
                                         # filename then :
                       $line =~ 
/^\s*(?:Fixes:|https?:|$link_tags_search|$signature_tags)/i ||
                                         # A Fixes:, link or signature 
tag line
                       $commit_log_possible_stack_dump)) {
                         WARN("COMMIT_LOG_LONG_LINE",
                              "Prefer a maximum 75 chars per line 
(possible unwrapped commit description?)\n" . $herecurr);
                         $commit_log_long_line = 1;
                 }
```

[…]

> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [v3] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
> 
> 6: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0"
> 7: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 1"
> 8: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 2"
> 9: B1 Line exceeds max length (98>80): "  btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend [btintel_pcie] returns -16"

I believe the configuration in the BlueZ git archive [1] is used. No 
idea, how other commits with pasted lines entered the tree.


Kind regards,

Paul


[1]: https://github.com/bluez/bluez/blob/master/.gitlint
