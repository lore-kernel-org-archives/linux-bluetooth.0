Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D142212FB9
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089191; cv=none; b=HfYJyqx9AqVdNWHprO2pErM51OEv7Rwl781QBco2nd2CvIZyyw7bwpXFlEu6dJNkwJ5E4BGeoYcbLUPgDFac6ClIgIA7Vtr1VmTUnQv7R1xtcU+xNi9z9x6F190bcKXrHX0UtZUsPdQPFAc+NNZ29nS215KdIaOBEKXeP60AsrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089191; c=relaxed/simple;
	bh=5/jndNa70R97d2EVKOwj2KCZSIMeV+FGO+ZSiUnulKo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Tcy8afr0Pdo8qt0Jl/oyeuoeDFjg3Ctbc/YpcucHprJ7JK1XaHGcgbQhxDeeOzwYVtoKUJKKf4l8hA3ofd7SbqDzauU7uHiIsbbp++7irOVUT6t4wXnqmEwQStCzx+TaVL4JI0dNzvHxynHKLg2k46IZEHt5F8IiDaFKIYNy8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XeGuTYcR; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XeGuTYcR"
Received: from github.com (hubbernetes-node-2202043.ac4-iad.github.net [10.52.125.49])
	by smtp.github.com (Postfix) with ESMTPA id 3E1AC64092B
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 08:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764089189;
	bh=zYvC9ci72q3KaNeqDzb57ZLVqyBKHiogPqbZ3vjdqik=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XeGuTYcRBQwONQ4JJ6VbiK9C07X2vpQ2Fdyx4XBpm4yplqY6IM9EvFlH8nJglctFx
	 mkFFxSzrGokTs3ohHeL1GwPvrAzoOjzP7kxjpNELqSbJotO/vW7NNCXC4fl8gECU8a
	 aQpBpSKZML43OY7BgxM+v9Ezm5BIMfyd9nj4q4AE=
Date: Tue, 25 Nov 2025 08:46:29 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026619/0ca638-000000@github.com>
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

  Branch: refs/heads/1026619
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
