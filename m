Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6135328B6D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539265; cv=none; b=fRrQGR2cewQISqOlTzJmVbkYzcksZ7ODpVrrITxvIAN5I0p2gVR0AETw97LnxmED2mFU6ey7YcKILhpSNu7OYqKwRP4V2Yyv9Si5oNIbkiHYlr9XkiFdWWa5qT+9Qq3Wr5K72KXbVPv5OUqj5jlHqa4CZSH7Z1B3Zt6d7AY3DJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539265; c=relaxed/simple;
	bh=dcyhqVAi8khmacbJW10GaMkGQI2PRwaGery5R2MwpZ8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rnraC9j725fbDZSz91y85OSP5CqUVHPff7aKnsDFj1g5kp9/iiENwl1MbzFAgqg+vEpB7ScUeD56cQzPj5zWnMpI+DKv0Qhp35mBLBRYMSNa4I7TRbvVyZ2NmeLaKe3cY5CZZRX78WZkX8LikD8cYWzLKQZi++23KX29cEPmJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CJMitvTU; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CJMitvTU"
Received: from github.com (hubbernetes-node-5f624db.ash1-iad.github.net [10.56.209.106])
	by smtp.github.com (Postfix) with ESMTPA id 7BA786000E2
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769539262;
	bh=muH0dna6f6JQtcDHioBSgHvX/OCTTrS9trn/Z1aBAPc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CJMitvTUMye7nRAjAWzwEE896lIKClkithCRweIDytfU3D2HPEw31Z/D0y1cE96IY
	 PFjmB/jC4j1NiulDt/Ih9DgS1RkIyOKcYOE1EwBttj+PCyju2oxQgNHVbRstK0kME1
	 EzgSkpr0NDbov1E3iF3WFgeldK0PxvTInJw0mcT4=
Date: Tue, 27 Jan 2026 10:41:02 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047695/0ba82d-000000@github.com>
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

  Branch: refs/heads/1047695
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
