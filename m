Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3D1B29C2
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873029; cv=none; b=ErFtN+G86uBFgNn0wT26rczpmX4ecNk4/a66UMNFCRFl1nFm3qDma4wW3elDdzP+qeBHI29DFJj4J1L9MrhbG5Gg28c5BFVQvj7xsB8Sw7e+q4rzs6mOnNKfluYQREJrJBvYnexzAgOWM/eYnWFwlsCW93uiYrxONU+BHOKTuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873029; c=relaxed/simple;
	bh=RuF4bepHjVTqmBvHbQ2ic0nX3Z/3ZOcv3L44I/ic8pc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iJ2oWRypPmQTv4PXUy5FKb/JMMe8T2G4akkPJVCBvGuUBtqyaW5ruVIgnnfWB7Pe5Bz/+CZljV1v3NNwz4Fg8foPl6+b8N1lqsOaSo3d7VodlszG4aNXgkgkxsqoLdZs319zC7Tcj4P3UE1sbkpa/CKvbZb7LHQpYV8lMSaWCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I16h6EUZ; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I16h6EUZ"
Received: from github.com (hubbernetes-node-89310bd.ac4-iad.github.net [10.52.164.17])
	by smtp.github.com (Postfix) with ESMTPA id EA4985E09F9
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1725873026;
	bh=gh6Mv3YvFN2nf5RqJ4BEDYXhE2eIuJ6a0/nKyJwPwbQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I16h6EUZX3UeL1AakF7Unyy/pNUWjTsDgqK/lJmZh0IjFgJo0kd+GKYv6041qXb4e
	 nrExKbRTQwoJeXXUtNHewuv8lIEIIZLwFh0BpFFLOeEWXt0NWQm1URTfZ5oxSO2gBs
	 S4PabNb6m2GHZyrqJSI7jUefl9pHeLoe2CFHvOmY=
Date: Mon, 09 Sep 2024 02:10:26 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/394675-e8575b@github.com>
Subject: [bluez/bluez] 60257a: build: Update library version
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 60257ab82801c5df552772061448fdcdecde95ba
      https://github.com/bluez/bluez/commit/60257ab82801c5df552772061448fdcdecde95ba
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Update library version


  Commit: e8575b6196ab8d457342c2d332bd402f2bedd9f7
      https://github.com/bluez/bluez/commit/e8575b6196ab8d457342c2d332bd402f2bedd9f7
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.78


Compare: https://github.com/bluez/bluez/compare/394675782078...e8575b6196ab

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
