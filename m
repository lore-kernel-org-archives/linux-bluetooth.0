Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BC243969
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372181; cv=none; b=Vfx5YN4HW7hURj+BcUq2lxfE2mi0bP1I5sxQo5mJKZDwICRI37W7aJAJRKUcdS/mqAKXDuc/R8U94tY6Q0Ou02zVwpkeSR7fY49SJxfK/oBmR6504D4FXzsCSq4c2A/EKSiQJ6b4J0lAIH0XtPFxsfq3mIz5YEUa0S9IUbpd3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372181; c=relaxed/simple;
	bh=t1afs/nKffjvDeeLlBpZcZJMr0ypk787O8hVC18JQbo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WxASvBhwXIHxfP8FqfFZqoDRDHd9dNCDwn/xmbZ79mlts2EObj4CF4avqVFoXWt5QMQhOdrR1gA8E2Z2RwppBMtLNISdUsk3ezbROrJH3l7SqQ8ESHkyPhjSi0hpKkFG6CJkZ7jmdi3nZMpGI7x8xNKb5rZWSFKuYhizjduK8Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DrlMOFnc; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DrlMOFnc"
Received: from github.com (hubbernetes-node-d8a745d.ash1-iad.github.net [10.56.212.104])
	by smtp.github.com (Postfix) with ESMTPA id 8D54314096E
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760372179;
	bh=jzJEmB03o8N2IZULZ4fHzPyyDtxGPg+/UDq+gob7Bc0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DrlMOFnc3wpeEHtyf5katXc3iTLC4ab3qFaTGBp034veNuoaFD/09MtC8PALiqNLn
	 H3nxcuq7z39VsEpbpycY85JEplBdYX+JSRf5DwqUjKDJIhUrNbr7P8KOKeRBINCmny
	 L3anI65JK3jcFHnzrcFvyX9TXFd8oD3RoU1dOP+A=
Date: Mon, 13 Oct 2025 09:16:19 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009862/ed829b-000000@github.com>
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

  Branch: refs/heads/1009862
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
