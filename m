Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD12D4803
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140720; cv=none; b=LSU8at4n4EL/ialzcUOoOZFsE3q7s0Pk2JWz4huPHM5raw28BaJ1yENWM5eH+RSQ7iw/YLINJ3eEZHBpXQhxacr9Ren/FF50az6hklUQjmhv9xfRynDORq64GVoCAACz0u7VvrrESR759IMU8a69Lr+PeZlz2fpAVCtYOI2CA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140720; c=relaxed/simple;
	bh=j7THtA5uYS1R2xiYLDcdfGtb3YU04qAJRpssW9yhI/M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pIroDg/ZaViGOpy58lEvm1gi8Gb8OhCA6rCaoGZuFa0dRnN6ENoF1UuyA6FpUm/XlLAlTVlgrfFSS3WuoHfnUcVnBy6E10sNnjZMushYimojvIx4I8OCwq3zAVTTXYN5I5iM3w29sgxBaKdTq4H6LGxtn/UgdZg+VwVrgXNtQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=j51/JnVK; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="j51/JnVK"
Received: from github.com (hubbernetes-node-2784c81.va3-iad.github.net [10.48.173.31])
	by smtp.github.com (Postfix) with ESMTPA id 724474E0C70
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 09:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763140718;
	bh=TrIYfQFPLEJIWK3jx9+o/uUBH72gVXh7zQoDEKsfFGA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j51/JnVKI1Nxdk5Jr9wJpdviXS4WjIo2qZrRolZawBbARpWS2Iti00a6N5Ixd978R
	 R8DtJnMxshNrJRGKDmPyTWVqHJT1yDz50AYZtWfJAMKhy8w5NPUymBtq4AFappo68x
	 Dgq6CqVIUxlmpj/3fhK7quu2UlZk7un97IdOWNCo=
Date: Fri, 14 Nov 2025 09:18:38 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1022135/cc4d4b-000000@github.com>
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

  Branch: refs/heads/1022135
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
