Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027C423A6C
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777669662; cv=none; b=anLzfmPCs3kN/UgvJTtE/5A7DeloJxYViUJd5Qfus0W0Zm3iPcS5DAoulIe3GVGtkxm/ZSG4cvCIwRSK3vkeKkoE/rCjoqpF5KdMonlbN8tCnbipR+O73KBCrAe4gx28a3qRXIUOuR91+AH1uhhhcjfSbMAWHurhZrE1AzR28ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777669662; c=relaxed/simple;
	bh=CmJq/dMk+TDQsdyfEMYc3fnu7/vw3Is2gGZLvOCkx7o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=m4a55yKTbZc0WJd+mySj+ZczxEEGBYJKtHZBySKtUatqIW8vpApB0CkMuLcstJ8eqEYvc6TK5NuZjATANgAVh98xm+ss5Gk6owEJBTQbV3eS6etRN3XE2vTKC7ImmP6h5AeYlu5H7JaZaHklNJlzp0NDRIQ3dPt0HgsFkL9+pdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mo1W41Kf; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mo1W41Kf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777669659;
	bh=4Ny9mpVZ/S4ZupyW+7r4L3H+xMFG9+wsNF9vHE40HiQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mo1W41KfW/4/5p7lGWmLV1C5EElcTHLjt6scNdn+pjeqd6tXI4seYnvz7cP3x18uh
	 hMbyggSMN9AMc/+hmQGPiQpqLopS3WSUcV6Um8hQXGyQooAIDUInaOZOWhJ1sAiLCy
	 d7Nrmg84D1ka1akrf1TSnfbw3HTpj9jdUX6z/lyA=
Received: from github.com (hubbernetes-node-e3ddc92.va3-iad.github.net [10.48.156.55])
	by smtp.github.com (Postfix) with ESMTPA id D7472281046
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 14:07:39 -0700 (PDT)
Date: Fri, 01 May 2026 14:07:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076045/1e294a-000000@github.com>
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

  Branch: refs/heads/1076045
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
