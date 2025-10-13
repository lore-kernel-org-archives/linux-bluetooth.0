Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471F11C860E
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382659; cv=none; b=FWEdwQtCqkAFznckOe/qnHbOBH9gwDGbWEiNIg3Mpzt9GCF9MyaTdmbpXO066JgU040mFkhiqRPIBWrGNTsxurCsFpot5kpjSuYFFW83yG81b/y3xDAU//xNI7tor/7Xxn6JgA+gmftU/vbYLt3PT7JApgqMC4R4gPewpvw3dvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382659; c=relaxed/simple;
	bh=RgNlw9BJNRn8jUhg5X9w9sU18Uxfc9TVyhLc4PN0/KI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dtlr1tzCKEKTzkpNcCv5Zy2BmV1EMfHJ89UaM25iKjgtf0S+TTvUvBki4S4TF/ECptuVa5kl2UMsipM8HX+bNHsHSzJTIimKFA6GkNTQ6cwWAYhc8m5e8ILl1h+KAK6dk4oNweH0s4G3OfBYmiYbS1GsGU0+rwI4XWKwzu3mKO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jFL949Xs; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jFL949Xs"
Received: from github.com (hubbernetes-node-7a60172.ac4-iad.github.net [10.52.179.65])
	by smtp.github.com (Postfix) with ESMTPA id 605696403E3
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 12:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760382657;
	bh=AFcKAIku69SUpxcaEcHH/J+KMM3yAFvXw0yYQUdHyRM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jFL949XsBwMQ3QF9J7SitzvkisdHW/x9DRf73Jc+fm4eFZK0ELl0Q9YL8kF+FPU3p
	 Qsh4sajSdHxeQJLwk73h9rMxAURnypbpg6wgMEGD8cd+GQmhlYalc+8FOQdswUQUTF
	 /wbon/RVZIB5imOpZ1zpCJwrqKtwOqTIJsDrHi2Q=
Date: Mon, 13 Oct 2025 12:10:57 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1010888/d4d506-000000@github.com>
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

  Branch: refs/heads/1010888
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
