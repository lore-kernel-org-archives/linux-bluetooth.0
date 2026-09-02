Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F2440A1D
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344657; cv=none; b=nCJLB+gw9XUeUpOcLOq+2JhbMnMLsH/9AXROYc7f4JQaJ8VhqTxNNUKblWOquWgTyK1Gr7IUiw8jbujhw+xPOhvKBNfD3jITHvgcmviNkiA14lzrRRNYkJ+O3O3Gk18KGfS9n4aXXgxzERQ9O1FSsxNgc3oS9yJ8QwHcz0XfYkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344657; c=relaxed/simple;
	bh=fGwE0+L/r7nVv+aIgD2DhmE3V46r9gTiSlOdE5h3IUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb0nleLNfxFNpzC8cG3RSVbQoOcPUc8Wq+XDXa8hnPGAVx6bBAapPMcSHsKZTlzh+IEyyW26PyntaeHD/aApd3ilvh03xtOiQxAEFdpir7yKdCmBARA4Ntl+zspN4w/34JDeWRp3IWj7BEeYRZW2pcbX/Dd36bX3fccepJOW9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxeIQBj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxeIQBj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427351F000E9;
	Wed,  2 Sep 2026 10:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788344651;
	bh=gs50LArPGNJtsLo9n73doEI4gPIgO1EFMN1dseKbfmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PxeIQBj1Wicv8oTIdxPyDv8jQm7OVZLb1MTKPeM0YQWMyW6Yfo2xPu3Xm7O7fJbAj
	 JBI64RGRzvJKhv+K+aHVMGmrUfcp4nYLRdYmVzLwxMB5UTh5Neys3WoKbrQoyAP32f
	 ru5ec4fVM6TsLmvjEzG30qPAn2svw7aJB1aMXk2HBifrmJTEO+WFRQXH9KKiis/c6/
	 8bkXI8kE+BQcy2nB9g6OaMvf3la4IDWNHlXe1IPC7ihBMT3h4iuUZTlH90n0l85u5p
	 LKcfhkevTvfaro9qc7rtZvZ2O2WkxiKzJ35BLaesz6loazFIclQFhmxHvS+ZIa1yjY
	 q3MSE8odkhKtw==
Date: Wed, 2 Sep 2026 11:24:08 +0100
From: Lee Jones <lee@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [v2,1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries
 on cancel
Message-ID: <20260902102408.GP2943942@google.com>
References: <20260901154427.3991920-1-lee@kernel.org>
 <6a970648.557772ff.f1661.edb2@mx.google.com>
 <CABBYNZK8yPR=abu6xmnfL-XQA+3CRYH22TJZOScG=1MEZpJH4g@mail.gmail.com>
 <CABBYNZJ9PLqVhDKUtGEpsfgK9WOeKynVR6EFmen3s97+J-OWxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJ9PLqVhDKUtGEpsfgK9WOeKynVR6EFmen3s97+J-OWxA@mail.gmail.com>

On Tue, 01 Sep 2026, Luiz Augusto von Dentz wrote:

> Hi Lee,
> 
> On Tue, Sep 1, 2026 at 1:10 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Lee,
> >
> > On Tue, Sep 1, 2026 at 1:07 PM <bluez.test.bot@gmail.com> wrote:
> > >
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1155482
> > >
> > > ---Test result---
> > >
> > > Test Summary:
> > > CheckPatch                    PASS      0.75 seconds
> > > VerifyFixes                   PASS      0.10 seconds
> > > VerifySignedoff               PASS      0.08 seconds
> > > GitLint                       PASS      0.22 seconds
> > > SubjectPrefix                 PASS      0.07 seconds
> > > BuildKernel                   PASS      28.57 seconds
> > > CheckAllWarning               PASS      31.59 seconds
> > > CheckSparse                   PASS      29.62 seconds
> > > BuildKernel32                 PASS      27.44 seconds
> > > CheckKernelLLVM               SKIP      0.00 seconds
> > > TestRunnerSetup               PASS      510.88 seconds
> > > TestRunner_mgmt-tester        FAIL      233.06 seconds
> > > TestRunner_mesh-tester        FAIL      26.88 seconds
> > > IncrementalBuild              PASS      26.40 seconds
> > >
> > > Details
> > > ##############################
> > > Test: CheckKernelLLVM - SKIP
> > > Desc: Build kernel with LLVM + context analysis
> > > Output:
> > > Clang not found
> > > ##############################
> > > Test: TestRunner_mgmt-tester - FAIL
> > > Desc: Run mgmt-tester with test-runner
> > > Output:
> > > Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4
> > >
> > > Failed Test Cases
> > > Read Exp Feature - Success                           Failed       0.262 seconds
> > > ##############################
> > > Test: TestRunner_mesh-tester - FAIL
> > > Desc: Run mesh-tester with test-runner
> > > Output:
> > > Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
> > >
> > > Failed Test Cases
> > > Mesh - Send cancel - 1                               Timed out    2.732 seconds
> > > Mesh - Send cancel - 2                               Timed out    1.986 seconds
> >
> > These are preexisting errorrs but I was hoping your changes would address them.
> 
> Looks like there are more problems:
> 
> https://sashiko.dev/#/patchset/20260901154427.3991920-1-lee%40kernel.org

That's annoying!  I ran Sashiko on this locally before pushing.

Looking now.

-- 
Lee Jones
