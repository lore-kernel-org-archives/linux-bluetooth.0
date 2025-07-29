Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0A46447
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815857; cv=none; b=T0oFpoHHmWPI1iv8hozxfW6xewZtjfW03Wa8iPkXYZrcqWnXjS6HcBhtgQTVTu8RIildqqWLNtM6f+RKAnJfbm5eFN/1hiOUDxzfFMUvZXZOnQoXd5zUYeLaAi5vWpQwbFWGm3Nz6B5hHu1LR1htBiyYPI17EyYjWLwQX2PTgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815857; c=relaxed/simple;
	bh=77vX4O+O9PlQzZxu5jJA3BSwuqpD83C1ID1RfLlBpTU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bJJztoaHgS2428JKhcZNvC3F8sXMtWU4fO/bTXJ9+4JMXIItN9o/E9cgQCXx9nzLyLOyvoD+HdDuHVm3v1Q+yd+53YMPXPt6TmczE/7qVGbJ8KTY0sIdlP7Ly0ecdS7sipiaZIBbCKtJnMeQzKwNk3YktcTIPYecQ7ud5hNWxAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ftOTYByc; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ftOTYByc"
Received: from github.com (hubbernetes-node-9d050e4.ash1-iad.github.net [10.56.143.35])
	by smtp.github.com (Postfix) with ESMTPA id 23536140115
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753815852;
	bh=Nk16PHRnX9MwdqUoDhERaubJxMY6uSRoPKx0pp+LDpo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ftOTYBycabBOLdkkiVeW6kRh5CRNNBHKXtDPiUWUqpSb8eEFjMIX91Qxe9R0zvThU
	 7nYXAIBn4S25P5hPeOqjFTwg90eNJAzZuBBBJNdG5ifZOAycF8NBUPQEoz0nxh8QzS
	 WECCleIadzxnaIZT26zEJZm3hkkamZTTjojegZDk=
Date: Tue, 29 Jul 2025 12:04:12 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981617/140d3a-000000@github.com>
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

  Branch: refs/heads/981617
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
