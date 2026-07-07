Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C213B42DB
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453848; cv=none; b=aGVSu+cXq6lbFs+3lfXz4ret1Q54wiL1jZ+hwVyrD/5dQdX/5TZjEtpFFyEOS6HL7pZVM/lpVNwVCEtepZrn/j3EUjjW6Rs7n9AJjDiHU8hZZpJIBOdp3XkzXXmlqpiqc+WAF4u0d3a+asQ1trfnTzqvfjly8/3bpwX9mnGIJHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453848; c=relaxed/simple;
	bh=E5CBK6iX6l12NlD5VflHBd3ITC/lhBkuBdypc6ywbBw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=R+/JOZtJwGJCC4K++XUpM66QX+Xi3VChLJZgreJlkVk8nel0rrWNAo9Rt/UgN0ZSUvjkkc+0eNJX9EocXYEDxiA0eBWB7QsW+kCqzwZ/RT/CVSrVpgis4QkV30b0T8S3ffOjKecxnptlKRu/+g7C+NUnhDg+npHk+7mlBToVwQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NHHiRky5; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NHHiRky5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783453846;
	bh=G9kGIhc8zsNC0DHvBCpGFXeSDG5f8ymYDS2Rdb8F/xU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NHHiRky5W72oqCRh52l+1WfvLrsf5VBAV1GmbBUdOBjQ4Bo1uf5nbp/lRLx5KqOkj
	 NJr+7mK6oqiuXxdzzsXue6h4P6FWxWoevnLzUgCef1VsaWWZNFwDXH61/gdI4zi1dw
	 hb7OUzjX3JuafP5chQV1POmw34+r1v7afIyp2Bcc=
Received: from github.com (hubbernetes-node-d2bf83d.va3-iad.github.net [10.48.72.53])
	by smtp.github.com (Postfix) with ESMTPA id 4AA3850D786
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 12:50:46 -0700 (PDT)
Date: Tue, 07 Jul 2026 12:50:46 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5bc6aa-5c1c67@github.com>
Subject: [bluez/bluez] b84aa8: l2test: Fix calling getsockopt(BT_PHY)
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
  Commit: b84aa894921037e1b1de00d282db2ee27a4ce63f
      https://github.com/bluez/bluez/commit/b84aa894921037e1b1de00d282db2ee27a4ce63f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-07 (Tue, 07 Jul 2026)

  Changed paths:
    M tools/l2test.c

  Log Message:
  -----------
  l2test: Fix calling getsockopt(BT_PHY)

getsockopt(BT_PHY) expectes a 32 bits argument not a
sizeof(struct sockaddr_l2).


  Commit: 3f283c8e0ab3bad17ee8c13fa0dcf251a16e4e25
      https://github.com/bluez/bluez/commit/3f283c8e0ab3bad17ee8c13fa0dcf251a16e4e25
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-07-07 (Tue, 07 Jul 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Validate codec configuration parameters

This is required for PTS test ASCS/SR/SPE/BI-07-C


  Commit: 5c1c679ec304b8aadaa287cca59b38589d339e91
      https://github.com/bluez/bluez/commit/5c1c679ec304b8aadaa287cca59b38589d339e91
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-07-07 (Tue, 07 Jul 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Validate unicast QoS configuration

This is required for PTS tests ASCS/SR/SPE/BI-08-C and ASCS/SR/SPE/BI-10-C.


Compare: https://github.com/bluez/bluez/compare/5bc6aa79e537...5c1c679ec304

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
