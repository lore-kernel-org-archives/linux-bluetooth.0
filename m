Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3638171A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168258; cv=none; b=besmqknbh6rtOCC5vUgQiLfSpafNd02gIvdfG6mlAHvEVW/f4YIAl0eZUWYeHx/JwKHv58Ca/BZvIdBF1SuXw9ZlsP/plk2M2OYbtg8opjeuVNQMcQHibP6sTVhVCMtHKX6FuPY8T4GJnI99qdBTYFw5jCNsY/nKGwuuEGaw5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168258; c=relaxed/simple;
	bh=n89j/OKqcf+CaMhMsVe/dalynfHUUlGBQyqHeg9M0zc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VLfDnWVUFJSEhWtiYRXws4+wvUd29s3s7uAf/zKTwDcFc/f8qvlREaMvshlgpTlCsOh/7oWxFBN/UeFTrjHvbMo8jnmV2qoT48J+Ge5M+3EXgO0O2X4NIkF03PXfKD9MA9UVH+GjqP0bVr1rdYObqoT7z/vlcxpmW0xo65YXtTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EHGPEm8y; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EHGPEm8y"
Received: from github.com (hubbernetes-node-9edabb7.va3-iad.github.net [10.48.219.77])
	by smtp.github.com (Postfix) with ESMTPA id 39E8EE0211
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 03:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769168252;
	bh=LXQLOrFOlaanzVki0UeMcoAmVae1qVPT/q2+uGHcWuY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EHGPEm8yphRT3rUT/Ot5Nkh8b+0KzMu6+36dYLRCFLpT6EbbFmQZaSpgjCuPvRosT
	 xgvElyzbj9unVQYTV7q0cRaUqnKcZN6GX43qVP86WKkMiHYXR6uH2jjDurB151EoCk
	 FRm4zDKGLsrQu/AzfR9DOPkp0RxF8QxH/yWarnWI=
Date: Fri, 23 Jan 2026 03:37:32 -0800
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046230/000000-1a4f0e@github.com>
Subject: [bluez/bluez] 1a4f0e: unit: Add test cases for Ranging Profile (RAP)
 Thi...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1046230
  Home:   https://github.com/bluez/bluez
  Commit: 1a4f0e135db03a201625541a8bc31a21392b706b
      https://github.com/bluez/bluez/commit/1a4f0e135db03a201625541a8bc31a21392b706b
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-23 (Fri, 23 Jan 2026)

  Changed paths:
    M Makefile.am
    A unit/test-rap.c

  Log Message:
  -----------
  unit: Add test cases for Ranging Profile (RAP) This adds unit test cases for the Ranging Profile (RAP) implementation, specifically testing the Ranging Service (RAS) server functionality.

The test suite includes:
- RAS/SR/SGGIT/SER/BV-01-C: Service discovery test
- RAS/SR/SGGIT/CHA/BV-01-C: Characteristic GGIT -RAS Features
- RAS/SR/SGGIT/CHA/BV-02-C: Characteristic GGIT -Real-time Ranging Data
- RAS/SR/SGGIT/CHA/BV-03-C: Characteristic GGIT -On-demand Ranging Data
- RAS/SR/SGGIT/CHA/BV-04-C: Characteristic GGIT -RAS Control Point

These tests verify GATT server behavior for the Ranging Service,
including service discovery, characteristic discovery.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
