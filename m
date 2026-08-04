Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4074399E2
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869554; cv=none; b=dD9T6b+H4huMGgTym9lSfP2bLop99IUD4ill1CaQZ+Ln6TXDeQXWOQ7P7zVEZd34XjkvqISt6Sdz/Ui80DcakpZEMrkTlt/4hexVNfRazI/AX5/Sxo59I1hJsXcrOw7rdHbf2zs8Xs0j+5xVfWhoSJ3FNMaaSXFTPIU8BV7Qu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869554; c=relaxed/simple;
	bh=CL5wraOiGZ75DrtWKmWArsdhTCThrqQGqF5kax3q5xE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Y3Lohn4GL8wUSSwOu8XdVfDYUc+kLoJIC3creF/EoKj6VGKolnIDhPh1E/+RdOVcbxbluiQwswfmN84XCUUMJh9gRCc8hs7jC5uUj7/d0PQZ/TD5S7tU8zsZe9aMgtZ1qmruvcxk05fuEyr7JpI0Cp5rZy4NW96bd/m/j1uA8Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BDT4tbcE; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BDT4tbcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785869552;
	bh=haAJSZV50Ov4JwTOOUNdI6QkzWACV3hjM2tCYluKEw4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BDT4tbcE4+Hp3112eDOWEOhnSQ15FtVXpkzjGmGkiDVj/WuSInfkwEExFTVyhuMuA
	 iZUuBVrS1aHBfxObF6TokdjdxMQc+qB+Y2km3UUskbJUzKYIZx/Y1kNTCCj5TW9ZpY
	 IsEhXg/K7daGeyXdg+6YfRy90htQwFpmGEbIjV9M=
Received: from github.com (hubbernetes-node-de83416.va3-iad.github.net [10.48.73.99])
	by smtp.github.com (Postfix) with ESMTPA id 5390C8011F8
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 11:52:32 -0700 (PDT)
Date: Tue, 04 Aug 2026 11:52:32 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1137629/032ea0-000000@github.com>
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

  Branch: refs/heads/1137629
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
