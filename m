Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59304153598
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 03:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746244666; cv=none; b=cFTi9U333LHpHJvQhf/EefLAzy06Mhwu8wrcw6z5ebo2IRZfE4EaMOefSwi8QuW8yeYep/no1qpLzx0B57BpMK58JJOTEOEbLxL2zmvoUuu1m5l7xpnEGNIWGusM3MwqfAzltMKTzZAU3CZNF56eYC2T6iroLuyI6rj+bp+UnbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746244666; c=relaxed/simple;
	bh=MlnjgWSPsjYc1RguVO5qgV2WA5qs0nk0/tk4M1pAu5o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=r2go6K1qKpD4SE4E/orSsUffPwbeuwiMbHYshzG83AuzVcURI6GLo6lwpoR3KpjJk/I46FWFRaaBZGijB0jK1rQmaRltQu+yLaJYBFIahilSdllmHwJgQsb8TWW07lY48h/pg8DvoUBntH2kEJNGrF1lM6sfIwT693QqlxrLYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NHC1fDQl; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NHC1fDQl"
Received: from github.com (hubbernetes-node-e259917.va3-iad.github.net [10.48.154.33])
	by smtp.github.com (Postfix) with ESMTPA id 4A5F84E04B9
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 20:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746244664;
	bh=SV0UuBae+wrY7owH8Ej5JAocHSO1vj3P1c09qrTiOmQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NHC1fDQltBW0rgMpLV8+KdZGgJtlD2y9rITZkPOW40Rg/FL+5K9ZqnJKqBcGLwCpq
	 uSZTdIrezdzUDN99WN1DG6cR+r3IkBjjJ3Kk9L/38mJNlLQC41oOnxqShEUUpSW3nR
	 QR6oEJuVSNbtILmi+63nZxycq77mUe3y0kCSzRn8=
Date: Fri, 02 May 2025 20:57:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/949647/8c0f0a-000000@github.com>
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

  Branch: refs/heads/949647
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
