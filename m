Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158822EB5B8
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094906; cv=none; b=adV90w0+ZI+DalOy0t0pq79DWtBova0On8UaYwT3IQPU7Bv2mQEvoWnXlf6/lLOQoZ3mm37Rcs9TGze9vKODoRF7ve4/P+sC7Tfdjpsct9YydHyVGZM4zO80+IGHyl/Oc1inKIO32OV8NLqD0aKZvJICYuQLpCN8eUlXwJGbwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094906; c=relaxed/simple;
	bh=vRDq6iBSfEHkFnreBdA9UWJ91O/ukG1+t2ejt2eDy8U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pyvQHQZ0H2u7O8ipmCm1MRho6P1p4gocof5qsoo9+pfbAo1ITBDrqcijeCirBPkh7/ppSnoZ1sD9jO1GxMxYK9tZY+ojWM3iXWG8mbSTzKYsntxGcxHaQ2OXvWZpukcVvFhu1xfoST3Kb+Uvfe6TjPCoqskluxWjUep+e8c10ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZvzvRubT; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZvzvRubT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783094904;
	bh=2Mpiq2vFEAmk2glOdiFBOfEZeT4ep1OgUSMHttD2Qtk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZvzvRubT7+Q5R4SoNVHTSLLJxrWI9XR2Vnfj8MDNetyQiiJHmQMfcGvA9fcGOWUML
	 twR+wgo/jLdnB//UdyqxIj1a09ZEsGmqBhLOO2D5b0r0zoHTnF+epX2uea+GrUtkLW
	 Ht1021Grj6Q5lOK/1ia3gWvQRHcp8lmI3qi/+zgc=
Received: from github.com (hubbernetes-node-dacbfc6.va3-iad.github.net [10.51.91.30])
	by smtp.github.com (Postfix) with ESMTPA id 4DD61789A41
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 09:08:24 -0700 (PDT)
Date: Fri, 03 Jul 2026 09:08:24 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.87/000000-47b317@github.com>
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

  Branch: refs/tags/5.87
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
