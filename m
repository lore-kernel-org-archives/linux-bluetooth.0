Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A3126BF1
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759434280; cv=none; b=vCtOOxgIFPmthELE0l21JKWRfwsIU1Wokf1SVKnfzyBpDG58RrXrVsiTHnvCrk7IsIjX7eclgwWVxnI99VZnyKG1pf1A5QfiZmZB9NC0S0jf7Ix+Vm/LUNWLEjHx/LSceKPXqormut2E1N8xLWoEax4AFBA0utm6L23XzFEhWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759434280; c=relaxed/simple;
	bh=/lbS1KxSdsa8tuEkjlHFUQEbmtB64apnJnVxCO5RYAI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WYO48Zq8uEZYtAVoVx2RxYawvIhxFbzZq7/AFj+Nf4/1VMR9Bo8eSeL9tIKRVr8FpaDzTQF3mBMgJd6r5ay2Fh6vo36jK5N1rMw31F+tINwdfjY+4GfoCwBu3mdmVOUAcWWt7cKZEseUK2pcn//s2Pncg/08IL4Mumu1BO0+nz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JuoAMvPK; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JuoAMvPK"
Received: from github.com (hubbernetes-node-a9ec292.ash1-iad.github.net [10.56.173.19])
	by smtp.github.com (Postfix) with ESMTPA id C1CE51403E2
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759434277;
	bh=tZCEY5Dq9wF2l6C5+dKAQCRSDrYw0kzNfiJ9fgAyYDM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JuoAMvPKJmRW1REAFffVDv7dPNm7sjIIwh3cH+ClKEdlU8aPT28XSF5Gvd5Svx/7H
	 XEkem/CXcl36i33K4D7GK1CJy8gqKz/MAFK1batsI/DqR7MSUEK4YG/tJUr/aWvQxK
	 UpMz2jFhC9nF03Jnt10QMQWF34kEf0mR4aMcDyPw=
Date: Thu, 02 Oct 2025 12:44:37 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1007714/0166cf-000000@github.com>
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

  Branch: refs/heads/1007714
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
