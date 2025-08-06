Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9B41C63
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450178; cv=none; b=A/GQmgJQvnjlvNvj8Sd2kIyn6vJ8JJOdKxKgxmjD9a8x+ttPSBgJvnm/fWOlLNE+qJq04X92TcaDjcyCt0dGMtEzFuMgM2polS+BkfiiDSjsE76oDzaSza9/zdzoXVyE/PUF8bVNM1qFcHQHqnIusX1Ys2i1gPV4MMR+56OGyZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450178; c=relaxed/simple;
	bh=FBFW9lN0KdMyCluoe90YCv4NSoUV7sEk4JLL4M1cVFk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bcl1Tvwe5GV0N7mqwoquoMdNPc4t+y2IMT+vhawRg6Gqa6QOmpPnj9zvxpnhM3FAD4Wj43uqE0a/4SxQPN1x+ZNFocpxLknNVgWniuoBgE21lJEE/7qFKrpheruc/vftaQfPTRfdVQqeopujMtQuxuChtEQEyuzXkhb8BXEWq2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Va/wE3ZM; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Va/wE3ZM"
Received: from github.com (hubbernetes-node-94ec952.ac4-iad.github.net [10.52.181.56])
	by smtp.github.com (Postfix) with ESMTPA id 7B2FB70050D
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 20:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754450176;
	bh=MbGXXqJfYowmF9Th22OHCzj+C/fbrvV4jXyy9hfhOBE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Va/wE3ZM3gFMzvfVsnT42rgJTsUgPL+FjqzcwXE+ddU3HyW76jMGTBB46j8aZ1la/
	 HpLrlyHYYUTDup3cLnykNqlPeUtuVPXgJxmA8xicQogLLE5T2B3GkDEAfSgOD/F2g4
	 keXXy7LlhUF8p8YkBhnM6hquEaloEFhC9PsXmSF4=
Date: Tue, 05 Aug 2025 20:16:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/988586/e8d54f-000000@github.com>
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

  Branch: refs/heads/988586
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
