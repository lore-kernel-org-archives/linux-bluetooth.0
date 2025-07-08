Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6723D2AD
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011981; cv=none; b=TeRvw5vRBhybwcUR/Wb+SCp9ynPZmv2avIRs1nk9gf/s2gMrOzCsK+xflvDFlQzeCvfylebRC1akiAI8VhSI9npT6asGWeld+aYWg9Y5TTwmkS0CrEsMs/Lwm/tL4hMkb0HzgeGi/gda1nUhzbpYWgWhfNOlo3+Enl97VIMetFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011981; c=relaxed/simple;
	bh=RoxfUU9UDxCitotc6KARmqtxmViLWFKsCcPDtH6sC38=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lHTrb+hIbryxZNdpYmALFEpXamz3xeE/obEhzHBCjNtNpjhuCYaHJyIjQrUpcaIpMV97dgPqUl4L1K1omKfkBgoJ0m4o1wkissikDERdVpAr0dPHHAADdBHlhdWKrIkhkMmbPiuZ3T3hx2OmRRZsy+7xksSN6maTM7nLj5Bk9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=il1Jggeu; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="il1Jggeu"
Received: from github.com (hubbernetes-node-69fa3f5.ac4-iad.github.net [10.52.182.32])
	by smtp.github.com (Postfix) with ESMTPA id 232FF7003C4
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752011977;
	bh=8xjW3cikaYm+tsLbKfrY/JZl7z4bXK6FDLj3zY6WdiA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=il1JggeuDU8Qd8Fj5kvMnNNy652lT2+/HyKKsRTp3dse698BPJ9XW5u5thsMiowN8
	 z8VJmRa/ptZOxTSg0MfhSMRK0g6UBK9V6ysGENxYjhtFb+hX3idbwQg0g9UOT9B7WE
	 ipGKDxN90cXMWxqKTyTMzjYSMQRNBWRTcX8hflfA=
Date: Tue, 08 Jul 2025 14:59:37 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969627/88da25-000000@github.com>
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

  Branch: refs/heads/969627
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
