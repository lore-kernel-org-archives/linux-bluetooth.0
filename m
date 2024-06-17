Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015B013DDD4
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633640; cv=none; b=pMfP9Xf6s+7M86fd1Jb4vn0yIHrwI/Ro3TAv+bCgC+xQNNIVsvYFeXp2lhx7XaRXgXeGw8XdHHAsmbRHX1NOf8WcfyGsD2kfDVwQRjGtoq2pgQbaJlyTymv92EStqG+/B5AvYaGirjAVpZuKJlVv0HLLNgW7tBcqy8NBrFsxy2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633640; c=relaxed/simple;
	bh=v2YXdGr85z2uIo/MsvNLSgA8hzP6OH8Ge5tDIM0bD2g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VXol5hf7zXytHZoMGl7GbJTf9g5oOUjUTDh7LoXklcjeXXGlQwqcW9oS3zMKBjlGY+1Xg1cmRObQhyh7OTmJ5tB+IwKfkdElry7KDjX0GMdN4reIWUuZrXl9zz3Hz4gfRDVQFoPlib/DEQYgV4HM1LLKTmVuWcl4qBK8HFWxx1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Kt2hdMsy; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Kt2hdMsy"
Received: from github.com (hubbernetes-node-5da50dd.ac4-iad.github.net [10.52.154.32])
	by smtp.github.com (Postfix) with ESMTPA id 2A5FE701220
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1718633638;
	bh=PNVeexk7JBAANUoKJMex8uRhHoNFaI4kgzPJhoSabT0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Kt2hdMsy0TnAjqUm2xaLcErNDDKaKTdq8G+uh0C+gAxuTJXutfTXMr1XFosU7P3zS
	 O4xOLAlvF4BbLNzqN80jYARG/5/HRQtJ3zl2zig87OlVW9/9oNLoseb1quhRSQ99Lu
	 RbobioFYWBZ5iS7CjigaSfJF30Jrz6UR+Xxc+x/g=
Date: Mon, 17 Jun 2024 07:13:58 -0700
From: vlad-pruteanu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/48b7f7-7ff745@github.com>
Subject: [bluez/bluez] 9e496c: shared/util: Update SDO defined UUIDs
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
  Commit: 9e496c216f463b8a14d35e2715d796dc84bb339a
      https://github.com/bluez/bluez/commit/9e496c216f463b8a14d35e2715d796dc84bb339a
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2024-06-17 (Mon, 17 Jun 2024)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Update SDO defined UUIDs

The list of SDO defined UUIDs taken from section 3.10 of:
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Assigned_Numbers/out/en/Assigned_Numbers.pdf


  Commit: 7ff745c2bd0c2656a7022ee11c67c6d8dc8494a6
      https://github.com/bluez/bluez/commit/7ff745c2bd0c2656a7022ee11c67c6d8dc8494a6
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-06-17 (Mon, 17 Jun 2024)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  src/adapter: Check if device is connected before clean up

Broadcast sources are currently deleted on the clean up triggered
by turning scan off. Thix fix prevents the removal of sources to
which we are synced by also checking if the device that will be
removed is connected (sources to which we are synced are already
marked as connected).


Compare: https://github.com/bluez/bluez/compare/48b7f7e5fe53...7ff745c2bd0c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
