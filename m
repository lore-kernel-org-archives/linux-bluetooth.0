Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF83A485CDA
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555496; cv=none; b=JB+BsIiG9807J6xdAgAjejCj/kzOxQkOQLX7p37xdHR01e7Z9tOuaSs5AI9wTTVxUdJ5FLHRNVLglrWzgqwhSY+4HxqkDKCYdMoUp3M8lH0tGUAiqDJJh9xmwxIoUYYzn5157DwCx0tKiZBsFO8oxwtTExAJ+DhqTo37V7xIPv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555496; c=relaxed/simple;
	bh=PCy0QS02ypFeS2adXaujT8gfxsghXA+UJ4z+UnB2Vc0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6IbcHK4XZz+dH4l2ZFt431kPwV0gBiMOO3iUvK1cji0xhLmKXnMWPlpeRUoomJk5NAe1CchOnldwlxakiFkpYfUn3zn7ofDgtWnBYZZ8y2gI/4YwK6jVJmYw7/CFQ/5BPbsq4u8mbkkkyHyVQPjlPSzbBk0Lbby6AQfZYZse/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGZtpU6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGZtpU6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152001F0089A
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789555476;
	bh=UM8JS7rLpoD6uIAoKhYDRs0uZeX47O6kNd/C4i1L3ek=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=fGZtpU6UkrzfPbZ0Vw5LusXtK2h2o6i/JH+XElxvI2aBMInpLfdqKwDIfymUp0oKs
	 iTefFh5V3u37qRlUa5PLb+AEeJpwHgFrjoMcwOtwawPbMn+YrAis83JBZdGS5uQ9HZ
	 +PubiFNv2d+aBdjDCT+QQ2v4zdr1f7WdKqWtui/1vj5m+an3ceFejaRokiL0zpsruO
	 GiSOIgmil1G1oCupFzt+/OcOSklCDUGLDEkyrU4za1A5CjQR66NIf9ggaohisgqBH6
	 rVruLkOrWdaBlMM6aQtOTQkDmGsRFFNDmzMfIOTH42cF20kmPRBBmYDuw3vCKszSHb
	 JdF94U+aia5pQ==
Date: Wed, 16 Sep 2026 11:44:33 +0100
From: Lee Jones <lee@kernel.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [v3,1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries
 on cancel
Message-ID: <20260916104433.GN11487@google.com>
References: <20260915120823.3460208-1-lee@kernel.org>
 <6aa94072.2842b724.2f298f.7f4a@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aa94072.2842b724.2f298f.7f4a@mx.google.com>

On Tue, 15 Sep 2026, bluez.test.bot@gmail.com wrote:

> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1165484/
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PASS      0.77 seconds
> VerifyFixes                   PASS      0.12 seconds
> VerifySignedoff               PASS      0.11 seconds
> GitLint                       FAIL      0.41 seconds
> SubjectPrefix                 PASS      5.05 seconds
> BuildKernel                   PASS      28.89 seconds
> CheckAllWarning               PASS      33.54 seconds
> CheckSparse                   PASS      36.17 seconds
> BuildKernel32                 PASS      29.54 seconds
> CheckKernelLLVM               PASS      34.56 seconds
> TestRunnerSetup               PASS      745.28 seconds
> TestRunner_mgmt-tester        FAIL      9.35 seconds
> TestRunner_mesh-tester        FAIL      8.15 seconds
> IncrementalBuild              PASS      27.99 seconds
> 
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [v3,1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
> 
> 30: B1 Line exceeds max length (105>80): "  - Advance mesh queue on error in mesh_send_start_complete(), skipping -ECANCELED to avoid self-deadlock"

This is just the change log and can be ignored.

> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> No test result found
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> No test result found

So, is this my problem or the harness's?

> https://github.com/bluez/bluetooth-next/pull/772
> 
> ---
> Regards,
> Linux Bluetooth
> 


-- 
Lee Jones
