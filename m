Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032021A42D
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788697364; cv=none; b=AtjnKTgW31b4t+/CSjApBcWjeXh62p8ALA9/uWT3AuRnvloOX6zzznqrCj2Rxlnh/Dg4N1Y18ANk2YI1t/180jxJTxNHExjuGMI08w/N87kux5Her1il79IT6Up2RyCorG/JHUMr+EcDOpLTZMk004dBS2roYRBK4KSLUvWGBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788697364; c=relaxed/simple;
	bh=o5+6/BHAVR45FBNOI2HxvVAfkCpabFTiLMuCqfNNE7M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=njZvqgQMs4JNN8LW67EDwcx4mfPuJShg87fz1MdYXhHstkziC0arqtHIz2kGH8LXJRM2bNTfxqMA9PWR9GAIgIAfxDRryYDXlC4dBL3v59OcAWX/29NOXegATqKGckWmwwaY8MgGGMeB4yF6bnrhIVsCNFeXthsrxCCwrwk2SC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=G4uqzZW0; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="G4uqzZW0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788697362;
	bh=A40LjkDepVpDIa/6jWIZLPV6jvrjVWQ8egKJAnSjMlc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=G4uqzZW0zn6RgcCIqA29iwfRDy+f9ay9NT6fgXWEWOn8XCDjE0j0ocMy0A+kJ1YgS
	 kjLJtjiwCo1AlDBalR4FGEOAO/B6p2Ff+TEoEzxrJ9B7YiQI3cLmdWCigaaBb6kjXh
	 +hTBFTTiwUAgbx3twKwPJN5l8pLgZjPgXXlrCi6s=
Received: from github.com (hubbernetes-node-d7b0bc6.va3-iad.github.net [10.48.64.53])
	by smtp.github.com (Postfix) with ESMTPA id D4F4F8000FF
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 05:22:42 -0700 (PDT)
Date: Sun, 06 Sep 2026 05:22:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142087/7a64bb-000000@github.com>
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

  Branch: refs/heads/1142087
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
