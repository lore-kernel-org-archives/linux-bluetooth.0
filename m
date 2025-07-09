Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E882EA14D
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069643; cv=none; b=baO24mE1U4m4kUY910CYPFlVCKwal9nWgWoSHASX2eN48b7PLSMM18doSSF4RnJKT5hC/bSohKm6LhHy5cZ4p1GifvwMtA8O7QE3BoqVu8dhAI0h5CZFd7uWsd+yutq+e9N4vTUv1ijXNU8pZl3kfelM1ZX0WgAFf21oLfWzmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069643; c=relaxed/simple;
	bh=VjWw7EKumvWWBdf5TJWJIWA2uUGEwA0TYZ3QltJjDIQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H3yIWB9gUbykrsLptTOMN6W4N7R8GuK2QKnx+VmiilGlKC2q8ojUzoHl32PmRUby49logkYQTx8annvg6kt3KrGdEXf8ScNIhyocD3QMt7d01eh4VjvmUjRUC1rFCWbwd2nKImXqqCdApm6pYv19CdDGsedxPOQ7lV9Au1hYLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=StFjBngo; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="StFjBngo"
Received: from github.com (hubbernetes-node-e8a60f3.ac4-iad.github.net [10.52.158.15])
	by smtp.github.com (Postfix) with ESMTPA id 55BF3700CD7
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752069641;
	bh=QJ0eNK2ibEk/r1rAGJoitTfYK+DlXSJflyg6AfH00U0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=StFjBngosRzMg2lW+eH4qNEtjmc3x4hE2V9xAR/vdXePMUDLUy6iQoj+C5j/ems7j
	 TdxHZYd145LiohOungdIuIZgagrYN0h8mQk2xL4l3dtvpLEmemF6MnmafhkFb9k+76
	 9pwtQfyCwfm/g5yibu/slcLTzhcyC+/+aEalduGo=
Date: Wed, 09 Jul 2025 07:00:41 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980540/b00403-000000@github.com>
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

  Branch: refs/heads/980540
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
