Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FEE1DA27
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834925; cv=none; b=PK8OtF4wbghffh1JpiNhBVp1bge12NNDVvkBBymi7CotcaYgPmn0k3b6G56VEI0PAS7HfINBVTHfkBH7WSyoRH/swbjIinC0n+TyMfH85zUZF5TqskwOf5d9ZBxdC7iex/UuxgjaoqJBFM2MDWOXZJNd5TXRhBKlEM/gfF3oSYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834925; c=relaxed/simple;
	bh=dKd3yiCikj3pKPaq00hjfeyUgf+F2wxa9dgy7s0oS20=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NhBDmKn4VMQHKIoxPtRTdH5BBIWS8JVHdrjBibkPQV8Ocv3RmXTArwsIsMzq9j8TJwHEFSODldbs1MriOgrKxvNKG3rj43zLQ+JKia6bU7ky3ozlqgZZ1z2ydu28tqd3LUvISQG1seERq28Ng03wK2JABLJVCOlUOkr7paV6bfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lALIp4GE; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lALIp4GE"
Received: from github.com (hubbernetes-node-e5690b9.va3-iad.github.net [10.48.222.46])
	by smtp.github.com (Postfix) with ESMTPA id 9D28FE13A1
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 10:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1709834923;
	bh=3JuEzc6n/F5JY/Vu/kaWuLChQJ6IwiNcWTKzji21pwM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lALIp4GEbjdcojo36zXlzayOtmXzACgP1ty0Wln1mZHwsHPK1FEKFTveWZYr+DNFr
	 RHArK8codH/Xi6xHNubNl3tgdgS4WmB8ZxfSwrBWKEdFo3WIwd8g1haWKIM7D40SV/
	 EePmsndoPDl5KeQtqb1rkMa0gJF8L+U6+IOMsZn4=
Date: Thu, 07 Mar 2024 10:08:43 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.73/000000-2bc3a9@github.com>
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

  Branch: refs/tags/5.73
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
