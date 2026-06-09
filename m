Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F501370AF1
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023120; cv=none; b=DTmKXKZrkNQ5hWW0ygtAXPi40rw9Upa/xs6l6UCFCT48gf+5k0/o0wyegJ0X455VdLWRbGRr98Ek7qeAXJdq9M+oUbVQKCa7EqGvnClMRZy3VSrCee2LQEEjGUefPVshAaX2pp0o9RkWLA59davn3WtBFO4gKYaBcPpmD/QLFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023120; c=relaxed/simple;
	bh=CKkp1o1xnUU7SJwyerbSB7dFLLXuU9wAQlVr46Ju92A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ptP2YEp40ZwsXp/MvT5LIp0nkf9AyExExfj4FcLh6H3uW8M95fkY5pHemchYuWtanb69mtr+qqgeFP2cy22iSFv3JRSdfIIqUyyZs8LO4r2xAWvL7NWt6uaox0mJ330p9e0Sh5yhW2zn1J5ctr/wueJxyY0gHNAlIrwd287kTT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mj3gK1MQ; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mj3gK1MQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781023118;
	bh=Ocuk2kmIvh5iK9MvySlupi5iHmeWAQ3hCMsTc27WzHk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mj3gK1MQei9wP1NGZy9Rhvcu6gf1k8LQLidE7IhcVEb5rmRqpsZljRyFv4p1yE9Kv
	 3YIZOeQ6d9PpUzL256/+WXaBrlD124h8zynNiFw0FUp0juzlJ4XSpWN2q6wD+2G8jo
	 Rgb+On4Gx25TvK9zLjs8120v6G0e7HpAxDSnPBnc=
Received: from github.com (hubbernetes-node-8fddad6.va3-iad.github.net [10.48.206.55])
	by smtp.github.com (Postfix) with ESMTPA id 76CDC5001E5
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 09:38:38 -0700 (PDT)
Date: Tue, 09 Jun 2026 09:38:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108507/d6cc95-000000@github.com>
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

  Branch: refs/heads/1108507
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
