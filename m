Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C41CAA3
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426600; cv=none; b=lu5snr+Xgpm0b/g0L8OzSJ6QaptUXbi206v9D92+WBVwNZa5N7me265qj/tjX4peqJqSRLxdmWNf0HinKO3ErDFhkx8e4Prz3J7npzTLupUOwOPwjCuYeKEReZRSafu7cA7fzh0kMQV7NcVXizJGfYO5NHPAhtP65DfaJi/ZA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426600; c=relaxed/simple;
	bh=4esLXVNTthFQuLoh5ogEhkDOA3uIIoeEkBqEladOPe4=;
	h=Received:DKIM-Signature:Date:From:To:Message-ID:Subject:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:
	 X-GitHub-Recipient-Address:X-Auto-Response-Suppress; b=YtMegU3A6TYa6CZZiQlmMKFKmlopE+TeaGlzFLpphr8xcSaTjiDqKKBnYRhkvOSP6SM1AIPqyOjEKairCEchnup334ftbpZi3VwAzRXqjbzrA8jxdtIcTlUFjgHEW3M5XBSU2qyvBRlgE8jhDma4YQ40DIQ3Wic5D/ZrB21JwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iqO4Fz8k; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iqO4Fz8k"
Received: from github.com (hubbernetes-node-413e5a9.va3-iad.github.net [10.48.141.38])
	by smtp.github.com (Postfix) with ESMTPA id 639F4E1082
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 09:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1705426598;
	bh=jPMAby0Tb2mYkUbZXwvkDLMbnJmYwW3NOZX+62/wptc=;
	h=Date:From:To:Subject:From;
	b=iqO4Fz8k6aXg6Z+UKSawGKO0iwGBqMp5q+CyO0lMmXUqtL8UwUtmgUvX+z/7kS1JY
	 0OFIGNf/OeWcA7ppAYJX2cWM3xIt4B6d+1PF6edGTmHDuYVuamm+WkMQI3v/iT82T6
	 4ITH38jdPHC8r92DPAxUFMAGrLsUrTBhh6Klb34s=
Date: Tue, 16 Jan 2024 09:36:38 -0800
From: silviubarbulescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/770ad5-2a3e93@github.com>
Subject: [bluez/bluez] 2a3e93: shared/bap: Fix dereference of null pointer
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
  Commit: 2a3e935f3f652f2b625af72d2c9abda64d742c28
      https://github.com/bluez/bluez/commit/2a3e935f3f652f2b625af72d2c9abda64d742c28
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-01-16 (Tue, 16 Jan 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix dereference of null pointer

Fix ScanBuild error: Dereference of null pointer


