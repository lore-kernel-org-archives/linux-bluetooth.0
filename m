Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4503AF64D
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478557; cv=none; b=Ma6b3/FWv2ZaxdOxlfNSy8xh/fkTuVjcBsaxfPmJrV2TQHTNYCWbIKbtfFRI8FC71wTgnWM8vKIm3Qynogeu8u9U8XIWlHD2mu5aqvHbMVGqtTthJYQmtuibjnXHmh5ndILuOXDePoeJ0InRq4k91PpwGG/ZOMehr+d2T9pQFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478557; c=relaxed/simple;
	bh=Afe6eOtB4MECnCOjFwy5/C8coTJqPXlKwhB7tpOcHbk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HWLNOPAZjMPwaXYHPErbNQ1O7bmUjz04faOCWIQ+JmvGch4tAgXm/rYFmOFfqYulczI3aDb3E59X1o17pUjrofc2PQaXVN4tblsfqAOSEpkCaZlVFAA32GahgS6zqIxzNykKPPyushfnNwzFhN368/eeNDMLJYdJFVIspX9eZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=MqRhrEcC; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="MqRhrEcC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791478555;
	bh=RJ+MKShBRc+v0nNPNWCP4CaFUkGckQmS+p8ugH5ECyA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MqRhrEcCIYxQpaGThP0LQwK155cKcR2XVBJuhEpukXmjXvh1yNYOy07f0zI0twODo
	 5vjU0A3IGzb3MMsXrpTxpD8TwEmCSQ0v3RdsrWiPDc6lxb2CT66BxBFRR2zsPjHf6S
	 8tOdeU1v7t829UFRPjvyjDAH+kVd+WP3chHkrLEiYbbmZngcB+KYJHVvZuJigJ1GUD
	 otf048/sm+tbS5y1ZpwlG5VozIvxTbCVqpz/zFn2ih/BBZ6hkims9RqAE6xngROhtZ
	 gpURNCe4edVhlDeLt59nvz1vIeC1PDJM0lxw8dA4KljIqn1Hba95ASv1Fqts/WZA02
	 7tR2uTCIJkVuQ==
Received: from github.com (hubbernetes-node-fc952ef.ash1-iad.github.net [10.56.151.39])
	by smtp.github.com (Postfix) with ESMTPA id 0393D1801AD
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 09:55:55 -0700 (PDT)
Date: Thu, 08 Oct 2026 09:55:55 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181105/1f2db3-000000@github.com>
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

  Branch: refs/heads/1181105
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
