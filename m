Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC501C84CB
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972079; cv=none; b=MikGwRgZOi0pxKEq7uNAAAcO8dWalI9rFW/o1ct2ROY8nXfRoEkcBV7yI0hgrJ3nmQm2mR3v5ars96/ASLpBOb8hUztXI8TO+mli15xMmi2n2MWXW5oDJr0YqXLUPyxv2AfhwIGLLnIT3IApnp8YQoGlpjTZ6dNtgdEMgAAbtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972079; c=relaxed/simple;
	bh=gJ4G10heSLPVDCocrDvUTIDBBva0qm5I2zA7SaLWftk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qYhcyTGnnoujxyEPvOAoQklR9qd7Tt+hfHmAFfp8M/mtmqK8kCgyU4/EnhBDhO++0IxwRwe8EriZjoeDlIjXqBrO2jKCVqVMWQRI6EU5NghqrNJHpW817fyFXcpwpwx0AEc3brz4mOOxEJSLQ7P9fTKfo4xV3ds7tXzyNJZ4axQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BNg2Dcwf; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BNg2Dcwf"
Received: from github.com (hubbernetes-node-e49ff9c.va3-iad.github.net [10.48.130.38])
	by smtp.github.com (Postfix) with ESMTPA id 947FA4E0C2F
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748972077;
	bh=stXZBFYwIYUe+SmnHQ+dghJ1f0Aa1/FD68VpRNZN0zI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BNg2DcwfqANw3rdVhyPn1rOUnZD2fn+NySf0W8iMuIuXVcU/FdmezZLGppNwqyeYk
	 B+NL4Dx17AkVbGJbnn5/lqrr4a6MInMeTbq+bdKunoAoyqzTdXdquE4+i+ccle0vUL
	 RpCYLrFI/h7jcBGXyuW/tSEyyvJoR6jp1sRnA68U=
Date: Tue, 03 Jun 2025 10:34:37 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/967697/d0b56b-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/967697
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
