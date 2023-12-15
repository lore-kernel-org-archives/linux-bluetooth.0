Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950793EA68
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X9sHzxrD"
Received: from github.com (hubbernetes-node-ee95298.ash1-iad.github.net [10.56.144.32])
	by smtp.github.com (Postfix) with ESMTPA id 945096009E3
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 08:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1702658360;
	bh=qdUnmhwcFaBKWBF+f+8xlevKGdeq8hZ8AUlngNfGJBA=;
	h=Date:From:To:Subject:From;
	b=X9sHzxrDpbb4KY3C2AztRFyoM/sjPwHWHMh3jJtyzOMODiOOEfjE2zV/PhXahet9z
	 6RK1NO/ggMUeosdMTXeZva66em7ea3kWeC+o8tf2I4e6uH42zQR6YlPmXmR+4yg9u0
	 fCHXReGCayVn46jpmsOxSPaPNYHYTpZP4uVgpu0g=
Date: Fri, 15 Dec 2023 08:39:20 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.71/000000-9f7368@github.com>
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

  Branch: refs/tags/5.71
  Home:   https://github.com/bluez/bluez
