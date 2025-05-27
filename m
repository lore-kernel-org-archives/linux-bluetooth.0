Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85971465A5
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381352; cv=none; b=Z6ibx1kTk4mtlbu83whYJJptCvF/lkbUUD1A4AWzK9pmOAmGrIpbrx5MjY4fvBtmYp4gT+VZTaqtB5x/PIZyOssfRRTfNXiPLOYdsGWjv5w0TEA6/9NqJtiw1FW9tiiKDT0fhBAzuBMU4PNTk6uEzfBYfKVWgqFVpYSKZ3VnpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381352; c=relaxed/simple;
	bh=AZ1EG8HKph8zpnVm4+yWINKYQ8zCxAj3gww5Pq65m9k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DFZjjF1jYVvbnrecNOYHecqAGZQ5MJoh5EjB9/HeK0JLqTbOVOoJhw9iSzelFcsiHrIY2kwNjNdUuVaEPiiJL+kkJizaDA9N/JHvhuj+q/9jQKmXVYaR3ndiZO7BzeJXKXZ1Kk6IQUZ+8sxXYGejD/A9He1g/xEAC83sVbk1ZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NEGmCxt3; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NEGmCxt3"
Received: from github.com (hubbernetes-node-66b26a4.ac4-iad.github.net [10.52.142.27])
	by smtp.github.com (Postfix) with ESMTPA id C06D67000F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748381349;
	bh=tlzfpjZ/1ZCZoe8skZaMogylTMQEiBad4+weHlwjzOM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NEGmCxt3DMXuvFNYt44dBMXX07mnWU+H1wg2L8i1siWqsPcK+m3KF0PxV1UHRiz5m
	 YkJqBDAQJbn9Cb0D7MD9mcrTPXLhY2SUaJkTAASE5jv97ZeQFz0dgcVaubUTX5pe6r
	 6RbhDMgQpz4tCo8ODcbCbUWxuq+GPP8yaHxpy5Js=
Date: Tue, 27 May 2025 14:29:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/966680/99cf7a-000000@github.com>
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

  Branch: refs/heads/966680
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
