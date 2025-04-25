Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3418DB02
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611043; cv=none; b=Ah0G4YYEL0O8tAGJOE1wqUIg5J5g8BnT884qtFcqVKgN4UYsXHwk2eArDoEIdfUNf1GeBtOfBhvfhXmQDfHN+bxiJOvTARCk01D4zmBsJgKC58mmtp5o2C+wo7ou83lod/6jPbe0/AuHksd7ynaVO78oQ0VyIwDfhmicuC0RTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611043; c=relaxed/simple;
	bh=2KfdPVv5TWgsDqnTUzUDj+KFtYbWXq5J2l1OobeQ/z4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cgpdc7sZrLqaGTbFXvKw3UeTV1GMhFT+mQoi5oMSKz7CJ94zdot85qnmpjOEndWF/NTvMnOcEtnTYMCyijikSLOPA7ivyqudXnZWA+qW+bZ/HcB7mGCQqlvGNINYsBmfRDt0fdlPrbk03WxJZFebohsozWqGII1bSFK0gY2woYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OoFul9vm; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OoFul9vm"
Received: from github.com (hubbernetes-node-1a06fa6.va3-iad.github.net [10.48.149.36])
	by smtp.github.com (Postfix) with ESMTPA id 7E7C2E0437
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 12:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745611041;
	bh=QSgjU39MSmlXachJHeOc9lLXLeHqfP9VmldlS2I/f6Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OoFul9vmp5zyqe/OBJcGLJ34nCPHpeWZOhbOCE02qoCBOWxj/K65WK6ycMSKShPgQ
	 ZQ9LzOm2R8CKKOwaYCC5yq5zCi2+aqNMR7oKzC9Zeu/BwsFd8T22QooCiYvWka5WbN
	 fVm7bDAIzon8mN13XHXKsRIQL+qEG966nv8K2dmo=
Date: Fri, 25 Apr 2025 12:57:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957129/b8068a-000000@github.com>
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

  Branch: refs/heads/957129
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
