Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3321EF080
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743516879; cv=none; b=E8eHCvEBYlOV+LvFhln/+AGXQDZNnS82DcBSPelWmoGPky4Ib7OeY4CPLcn+V5M/iWwT4yibh2Kxb8Zqj10mvzruuY/xWxVhWdif0g5MUtUjw/AXTBXyEuQCnDSn4xJIeI2WutPDGaZYIva/zU6CEfCKuDyjofc7YidcB6VVqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743516879; c=relaxed/simple;
	bh=SWXtTEG5cwhI9dppqXIdrt51alpCJys3gotrM6T3gz4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=loSZYGwqRcSGqyFRcUWFbsqaRxl2U/tqauMAuN2s97vbuMVqcrS1SvGH4SznwqYAHTqBuhQ5A3HFxIsxTpP6223F/tCdkRnpUkddIhwEQojn3iYb6ZTflzIZO7fd8Ojq2/TPZtk9IWG8Qy9kRAt15jy18YlZw8eNERlM+z6Ttbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dTN2nTCZ; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dTN2nTCZ"
Received: from github.com (hubbernetes-node-a3b52c7.ash1-iad.github.net [10.56.160.33])
	by smtp.github.com (Postfix) with ESMTPA id 9CE8B6003BA
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1743516877;
	bh=Kqs7LAGNLkxnAz+BSNK+oKbZ8tOihpLbRoW6r6mLPJ8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dTN2nTCZ/Iphm6GxtnrcX3DH5QEzsbFh3CvtQJ5Mkok6jhYoq79mo6yDqd5OpmXek
	 frWDYeOyFEahSNsLawYFCoKuiN7OQhA6lM7TJec3vBTcBv9njbnLE8ebFVtJtn9iB0
	 wqmSo+LeChjHx/1jHGQXGcKTBff+QgiEB5CxXoFY=
Date: Tue, 01 Apr 2025 07:14:37 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/cdd02a-47e5d3@github.com>
Subject: [bluez/bluez] 47e5d3: Release 5.81
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 47e5d3491d373944c82704b48b3005443807fb40
      https://github.com/bluez/bluez/commit/47e5d3491d373944c82704b48b3005443807fb40
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2025-04-01 (Tue, 01 Apr 2025)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.81



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
