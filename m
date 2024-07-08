Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEBF5674E
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476849; cv=none; b=kcLU/2g9nmynBcduFv1Z8T/2F3rAbqtH9o66JI20kaI/0fjSEwyzhPKBycScVI3RKNjGxS1AH9miKYTnvY2vvrGTdHU48xTZaHPYMs/6b4/3SEVJD4IxEMB7OsilNW1LcfjUekElyWj1zQyOvbBJSiLequ6Aw4KlkA5SUckJ2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476849; c=relaxed/simple;
	bh=q5evto3+wqnzOd7hBRPhxc81qvP1ooiaZGyLBzJG6oI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uiOCaAA5S3feQ+CqXYXA5Myf5TrtrDow/DfeEfotPmzrIaop2cVuiWOLxLsX/WXVoWjWtJWObibMz+AM/oAcINMMmopwhDMxFSVjkc2MpTAeP1Q6tvzaEQUIVg9NaJ7fAXgUfOVoWpBB+sjprjZMFbJmrfBqlZoOCAnmwc0bAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O1hg+OHd; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O1hg+OHd"
Received: from github.com (hubbernetes-node-a4e3790.ash1-iad.github.net [10.56.225.19])
	by smtp.github.com (Postfix) with ESMTPA id 2AD44601327
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1720476847;
	bh=8A6Vw7iqsXUDRHO5nRh60OqUiduI4qnyXfpj3ow0ajI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O1hg+OHdyFvG0ZEsSfYbLBfB+6h1gsNWrzn3Ua1+R4E3kkhMV8FmeNU6nmphxFeHp
	 iQUChwWy0YNYI64O12uWjLLgn4iOiLNNNqiBSANnHvTP1sYeod+vpfLhQYOePT3z9m
	 MCks4C9C3UyVdbhahRwk2uSNqdgtRhDhkVPiPYBA=
Date: Mon, 08 Jul 2024 15:14:07 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.77/000000-c49698@github.com>
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

  Branch: refs/tags/5.77
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
