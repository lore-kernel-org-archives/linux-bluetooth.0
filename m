Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24294328B68
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539265; cv=none; b=g94zOIA38WwEgDaSiONrDmQqTUodl8nnmfFi3rFwVwxnYyDYMa8yiEEdOfzg4OW0U7cy0A85xg2zJpnAS4PRfK7dVI9dlGeCkt8Y6fSi0R1Tqk8VPHGw/d2x4K9YnsibbD7l9G00Jy+RfWmZdTHZ5GRnSWqzEh733FQ9H2UXfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539265; c=relaxed/simple;
	bh=NBoIwm3ziyY1SGzO+cQ3CSb+IkJSMhNc4irP4lZIc6A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PgQmw1ySY3SQEjLO/vH51hPXTL3x7kKfFiqSaxzkPe5J6bqoPHBO1EcIRoC4cmcCGiUcvJ0+ZdTH+J8DGe//LAL6cFZHtUdWfxFYSzW14CPrj5tXlYefE/dNmlHdEYYSxffAGU9llpGTRCb8I6V/8/N5y8/Oy9jowsg8TIrKKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NjB34Q1p; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NjB34Q1p"
Received: from github.com (hubbernetes-node-2b4eaac.ash1-iad.github.net [10.56.128.74])
	by smtp.github.com (Postfix) with ESMTPA id DF0F9141357
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769539261;
	bh=abR3VqF9Jz+aIumcb2Kc39J0j0mgr/hiXidZS+BBsCk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NjB34Q1ppaWkogdjagEaZvNFI6y849C29OoCzDjUunjq4kCSwolAEsuvKDXDWEMKV
	 vH3+axGRsRgMo+VtnoDDOv8TcKIPYvCw5t3UkQl1oqA4ZzOnFRnDJ6crdL5KYJO6Ct
	 0CAp5N9gyUFluxyeK1hnCCJrvaOWRHdFgDF1pCXY=
Date: Tue, 27 Jan 2026 10:41:01 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047696/27bdfa-000000@github.com>
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

  Branch: refs/heads/1047696
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
