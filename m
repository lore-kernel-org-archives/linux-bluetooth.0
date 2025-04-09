Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64726E17C
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209848; cv=none; b=JOiyB5r2EuzhotxngpnUcXC0McIAQvHW0nSVh73HfNRJKs13mYCvd2H4TrrrPHI1Il0HDRY178OLyksvqV7W6kWVH3MLhOaxaIlu9yeYcgBMysCAw8qLImWmYiBnRLOTC8wHz2xyOlGOu5as802vW4WffWFqGEcqSDknhKUMnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209848; c=relaxed/simple;
	bh=XneEsockD1qwxMOFJ2e5UpiWpl5up7VQGgDpftb2BLg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iM5ow1G+owQ0gjieq/IxGG/Vh9JB8e6yG4C2JhzuBRgr+V7YEPQAo7+qaT8I4Rdv77cL5q8bPJX9pBgYaJ1ER0l6+2Rt0hZQ3/tGtdZC6DqKJjpgikAnQah/IkxlYNbCGO1brjVQHhL1WnQCWNjXmaHfirk2YMPfnV6HJuZqHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K3tiwhKc; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K3tiwhKc"
Received: from github.com (hubbernetes-node-3951b9b.va3-iad.github.net [10.48.200.17])
	by smtp.github.com (Postfix) with ESMTPA id 158064E129D
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1744209846;
	bh=NmqdXBJ7/+Xhw/3l7qy/x12qlra+8oL0iKHSEXwyFPU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K3tiwhKcDx65P75QYtIPhvIUSHf2eEkxw1GWVx0Xw8LKfwJ/uLaRBffRlOMCAyVUe
	 Ji5AxNK2n/08rO/UDVN9X1c98ZmRG9kOlD+LMyQFpF0I96DfdvV0dED+xuJT7wHemt
	 yAzcZwN1wtdGXJmmzyaQhITza8eAxVbXzEnXgoOg=
Date: Wed, 09 Apr 2025 07:44:06 -0700
From: Yao Wei <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1288fa-0b3d49@github.com>
Subject: [bluez/bluez] 0b3d49: policy: fix HSP/HFP reconnection
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 0b3d49f4e03014a911c421896ae727bba9e09ba1
      https://github.com/bluez/bluez/commit/0b3d49f4e03014a911c421896ae72=
7bba9e09ba1
  Author: Yao Wei (=E9=AD=8F=E9=8A=98=E5=BB=B7) <yao.wei@canonical.com>
  Date:   2025-04-09 (Wed, 09 Apr 2025)

  Changed paths:
    M plugins/policy.c

  Log Message:
  -----------
  policy: fix HSP/HFP reconnection

This patch removes checking whether A2DP service initiates the
connection starting HSP/HFP connection, instead just start timer
when HSP/HFP is not connected, also move order so that setting
HSP/HFP connection timer is not blocked by AVRCP connection.

The previous patch also did not get HSP service if HFP is not
available.  This patch adds it in.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
