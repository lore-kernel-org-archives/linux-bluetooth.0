Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026215E5DC
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784168; cv=none; b=fwFTMcpBqqSuVMFtp+x/Og1EQf7BuScpCFBKlYyGTWzWOo8zhXt9Kju0wgACA6ZQc5EFC+ZPo+0umB4DQO3a/pmI6gJO8I1YrALU/7t0jTnDSUpuqSFBLMGZAhdjlb+gguVR7dwjuXaQkHIYBQO2v4T843TetAXqbGiuZj9xuQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784168; c=relaxed/simple;
	bh=XeeZn2HrwI8gOFisKoKZ+xguw509MZHyuIe20nCkfpI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Gfqul+VKWd0V5IksE5uErswj43uWH8Xfi+wi+6SiM5StCxvcA/cDgImlXG2X5ccakqlC8R6NUX5Qjs3j9mvHRzGC4iToiiusHUC1PSpllROcalDf+ZJt6jJdLdEIFK+qayfA5pWVF8kgI9zFxvuSnxaOZWyPavrOICtKcoxyYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K6i7at8Q; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K6i7at8Q"
Received: from github.com (hubbernetes-node-22889b5.ac4-iad.github.net [10.52.135.25])
	by smtp.github.com (Postfix) with ESMTPA id DB37F701263
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 06:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755784165;
	bh=orerpFLYP8RQ+XNQ6VOpCQG14kPZMTwH8AE4nfDQ1C0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K6i7at8QLqbh/4R/TA47YlPy+jw83f+txorvUGD1lLYFMwu2rPUGOzZuadwnUdvGN
	 2xIMLRX2vj+gcV/HO9y89DqLV86+QqImQxX5ND8DvzrmQhniiwbzKaFEn/AU8+uv+X
	 NAs6IB8azTyeqKnqHn/gaJSu93OwW1WFsRVdPjgY=
Date: Thu, 21 Aug 2025 06:49:25 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ed2da1-5f38ea@github.com>
Subject: [bluez/bluez] 5f38ea: adapter: Fix setting index in
 MGMT_OP_SET_EXP_FEAT...
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
  Commit: 5f38ea159ea8d1ef2967ef1e545a3a0bd5ac92b3
      https://github.com/bluez/bluez/commit/5f38ea159ea8d1ef2967ef1e545a3a0bd5ac92b3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix setting index in MGMT_OP_SET_EXP_FEATURE with debug_uuid

Experimental debug feature requires use of MGMT_INDEX_NONE since it is
not an adapter specific feature.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
