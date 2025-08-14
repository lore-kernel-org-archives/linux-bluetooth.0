Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347423ABBB
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197980; cv=none; b=sfnWib+FdpKT7tyZwU2VV0W3XzSBiE8Q0q13xdD2OodEZ1TG3pv7vHlfc27pf68hGTKnJlyqk+2HIZP+mcMRzxHfqBcfBXxgPkKJOV3rX8NFN9D4UjBg8JVJdEtzU/9kLqXg3F20U9rovTPeRLpxHfeEkWfTOe+cayp9nFvqOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197980; c=relaxed/simple;
	bh=4lA9+iAgDoM8KqtYLYy5TItYuIwsdqTfMvYYAefteh4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=t3PtVDAqOYvH+af8tLusc+7HE4bLJeWmdE+za8KzT2yyLg4sWwFZ48UGrzb6+mzaurOUPcNOLAmxoxqrGdDRElV+bJQROQV9paoIFfY2T0X5581U+8vReYiFX332pSSWu6wk+az6NT+AM7+OK0ke57P82ujx45DGl2Nv7dOsiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B+xrmuFf; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B+xrmuFf"
Received: from github.com (hubbernetes-node-c4f0d23.ash1-iad.github.net [10.56.167.35])
	by smtp.github.com (Postfix) with ESMTPA id 68D9E1411B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755197978;
	bh=TiLIV9zHZr42zTrXs699f5r7TB4Bdqsx2Xoq7qTr8B8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B+xrmuFfhGI1dFEufyr8aYhHyQevL2e1upiUvf3yhtmrIcAf+Wzpw06ETaz5Rz0Sz
	 lplxW8mpuRgN2TMQ0FDW/vPH0hvRn3E8fBOtFFg4CCuknzLKj4Y5w35skKs3Jd48SM
	 Qzqhz1eJuA5klCykHBSgSdtKJxtNMBhRyCaq7us4=
Date: Thu, 14 Aug 2025 11:59:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982635/2b4a73-000000@github.com>
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

  Branch: refs/heads/982635
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
