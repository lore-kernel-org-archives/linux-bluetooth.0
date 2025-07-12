Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F7A1AD3E5
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jul 2025 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752312694; cv=none; b=XzgMrQngogeOuP+WQFq+DUwZNlGyMw53FVD31yL5hfTm7EIYmb3Y/9ZGQ1DWO8x2YH1XMtUgq7YDy3NCb5Jd8dSpm6sV6ex5Uv7kDpOSwCSjlYxMGZQN256T23NmaKxMox+XCVK9Hn1grzHcnPQ5C8Qn59oUaRpRhSHnRHm7MqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752312694; c=relaxed/simple;
	bh=Uy9eVdklasCiH+ZPBNhqWJa2fsaRAjSg2TJZbrrKuv0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=P3dcEi2yHPW4LKVCNjE6sRrjxPV5zkJSGWm09fFhlQBFnVfDb90VNpx+EJwV3oc0zR5QBnlRwudM34RnsayoJIm0vW604JGdWfFr97Wv+rowW940aKjXw1MAGz3hTsaJ+kkog2pCn3OiUN9cBs50e4Kzu0aToqJ4fu9vCE+Rx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RmTp6YF1; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RmTp6YF1"
Received: from github.com (hubbernetes-node-ba1df07.ac4-iad.github.net [10.52.180.41])
	by smtp.github.com (Postfix) with ESMTPA id 521F26406DE
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jul 2025 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752312692;
	bh=LqZPFkUYnfWBBf9UxSGfR1EA3vfdgMovRxGIQAL5V9g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RmTp6YF1O3HRypWIL4YEsezXsQL7ib6ktgQNY1u/9hkvpAc4jTczylkS3u4aR0piF
	 aniNT7fWx3+6gAV+KRT68jnebJJsrf9atecmWTBEKrTM6CqKD1W8lYF1QZBHCOhZLM
	 XvTNuS4Vwm55hedUS1bJ1nRGJSYyyV4E1IhsNrls=
Date: Sat, 12 Jul 2025 02:31:32 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981701/000000-ccf6ee@github.com>
Subject: [bluez/bluez] ccf6ee: src/adapter: Fix RemoveDevice timeout when
 device ...
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

  Branch: refs/heads/981701
  Home:   https://github.com/bluez/bluez
  Commit: ccf6eed3547b64924826c36e9af4e91acaa61b7b
      https://github.com/bluez/bluez/commit/ccf6eed3547b64924826c36e9af4e91acaa61b7b
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-07-12 (Sat, 12 Jul 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  src/adapter: Fix RemoveDevice timeout when device already disconnected

When attempting to use RemoveDevice to delete a BIS source device that
was synchronized by the BIS sink scan delegator, the kernel marks the
device as disconnected due to PA sync termination. However, BlueZ is not
notified of this disconnection and still proceeds to send MGMT Disconnect
command. The kernel responds with MGMT_STATUS_DISCONNECTED, which BlueZ
does not currently handle as a successful case. As a result, the RemoveDevice
call never completes and no D-Bus reply is returned.

Fixes: https://github.com/bluez/bluez/issues/1421

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
