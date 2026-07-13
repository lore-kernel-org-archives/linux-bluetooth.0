Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267234D916
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973577; cv=none; b=thUDTR1//+ILWFDvVz5zhFJAA2rkYJ9dnF9/bpv82fWWVwvg1Kn66JdODvO4nYLVuyG1gUkasl3NOUuvyP4C3yD6fugCvqhhazn1VX9n1l+7ayVuMu6mON/VyOeLULtrv3iXuwWGuHBl4tYkRy8sWZn9tr1M2OhuCAZQGiWeBmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973577; c=relaxed/simple;
	bh=ttWUkOxOy/dNlrNbHY4YnHRO1V3RNb3wgXvMvZ9sirQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PSsOGMjRKoGh4fve0uUGtS3LAxhFgBn/qq06Au54zbCtwQjRKM871ztLj8eKQeVbb8pGtGmIyPLjUfPJtbpSLXAaSlcgzSW35Z7B79sbTDabV2OyztfHtfP65JTcPahjYVLVfV13xEczaicgjXu1EmS/n/KOUp7XXllHOCUAqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Sx01pv1F; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Sx01pv1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783973575;
	bh=lde23SasCZAX3SFqHN2RzgH7Ap3+pmwZ+axWDD4Z1gQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Sx01pv1FgQNwH8xQp6Hyp1zy9/9MN2YS34rS4GCtSVpMveU+u3c2NGKnL7EOyER57
	 eSajm07N8S+gvxlxy70aJVRBEUwrNXUqPu4u3Ho8otJklZR7W5SfDdX3jzVjZFfWL7
	 UfrnEn9SqXetCaB0ypZqy7pxQM1WxJq8VFeZfgUg=
Received: from github.com (hubbernetes-node-63e25fe.ac4-iad.github.net [10.52.85.58])
	by smtp.github.com (Postfix) with ESMTPA id 4FA2B740C44
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 13:12:55 -0700 (PDT)
Date: Mon, 13 Jul 2026 13:12:55 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125561/343365-000000@github.com>
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

  Branch: refs/heads/1125561
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
