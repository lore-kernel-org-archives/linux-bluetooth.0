Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC593F9C5
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686489; cv=none; b=lxLp/nzdcY5LBHw02poFNJR8g2bN0BZQWTOoWra28z0lWp9hy/raRozWmJPJVJWRXZtAr/PlkjWm2VGMS0QFQjHBlciF5YDZJmDlX4Dd/5/M8GPjkMjRpHNZx+683Ou7MyZuIsrD5GscBcv4/CRma924A95oW9x3ZQjPzZyxC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686489; c=relaxed/simple;
	bh=kx5Ai0ZD1BBuQHCmFZuGYh4wOKs4x6CBr8fdFGTJ6Uk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PatmO2kGlGu/+L03c9nBkGZh/GL/F17vh7UZRAe+E46+5ebZCfc9WjD1kOz5aPhKCKVjMPvFzQKW8RmA7nVx5C1Qrf9a0IooR0wuaYP4F53gA3KYl9I0ZXbMTThDaVlHMG7ugJCe7B80FIRxy6BmbdjHUXYt9VwxB13JhyHJRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lOJ9TN4x; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lOJ9TN4x"
Received: from github.com (hubbernetes-node-10b7308.va3-iad.github.net [10.48.153.30])
	by smtp.github.com (Postfix) with ESMTPA id 502F9E0A6D
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 06:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764686487;
	bh=O3hGOFXSk8I6PjmL4Y4Yv4ECNAJKAbTalH6TDZaTrWA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lOJ9TN4xIgiOePe/uOHJYrXZS790tWJ467ZHC4EltgzKZnwu5lCHMS4rhIM2ndaJv
	 ZZniQgwrAG0+LKTjt3MqKBXRp+hwGsr/ofXnD+dvhe3jT2svbH06uMR7CCySyd8zsT
	 n4EDWyegH9TW3y7dCMYOWTn2hPodx2lMUNDaNhAk=
Date: Tue, 02 Dec 2025 06:41:27 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1028907/76c2fa-000000@github.com>
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

  Branch: refs/heads/1028907
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
