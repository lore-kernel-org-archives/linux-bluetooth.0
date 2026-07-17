Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6E3EA940
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283300; cv=none; b=Nj5aHKNZSBoH4goUyv1GvJonDlFe32X1LUXnEltvZZfBu7umnlKneaSCksCe8ZCIV/TXPpZzyWPimaGPOnZHpQLxnCB6rqYCCNg9yjHq6ophd3ztOHMlXLWw9+Voci345Kq4vnxSpjAx2WPdFQjaL4fSR7f/H5Q1uvGAXnATXKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283300; c=relaxed/simple;
	bh=VqJMd99t2rFRylQaecENOZ+QfBNiZ/x2FhBiHcLpfvQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EX5YUATmCNdYNoOF/HInPzdJe7Gszcls6Pg/wZLxu0VR+gORp8bmqdA8KFlCCmvN7U5z38GcbEuEvg4ikcOi/BKJaNQrPBg3Osvu61EO7URBF6oiqRCHxb3AwzLhwfetlTTUsELVlWJFEd9nl1r/47fYvNOudnwnSvEM4QnJJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Mfj1tKig; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Mfj1tKig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784283295;
	bh=cGRCE5jFSI/8V/JrgiwrNG/sPp3kOTm9VKkA+/Zx0g8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Mfj1tKigLJYOZTTOf3A5ginnVnVAW3Hq7otuaLwB+YGQ8q8BCSlvON9U0+Fm7NHgD
	 17Bj34n/0R6lL2nQDw70QehapiVC17AyK0XO7h6h/4rIqq975P4Nv8QoIro8ELqhy7
	 NXURnAQszG1uLrwimcnRmtRY1R4sq5MfJ1sF+ly4=
Received: from github.com (hubbernetes-node-e40c59f.ash1-iad.github.net [10.56.147.19])
	by smtp.github.com (Postfix) with ESMTPA id 5F043520614
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 03:14:55 -0700 (PDT)
Date: Fri, 17 Jul 2026 03:14:55 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1129094/b555d9-000000@github.com>
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

  Branch: refs/heads/1129094
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
