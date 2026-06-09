Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6841931B
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023124; cv=none; b=d+sERfoQIFxhSq5cc6f+ebGZwEJD5yulSTeoXWbu5P8TG2xFJ+TGA8rBjwlc0TI+hZhtbKpep5bpIhl9Wr8IspJ0ao6hBlTPx7evjEExInXXJxlL0tIkTLAYV12NGchfiFK85UrvX+hAo6vSCGjTznV5Y8QFyCwFMPEr+H0+JwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023124; c=relaxed/simple;
	bh=vIVjRBnvXbnYDZnkLmlulowK8xGPMGwduf3lvi0rGM0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YFTfi7TNUnYLfn7mVfGV9joWwX4FVAWy3ZQsYe2+U3Q89yrkjOg0iyKgKi1ztD9cX38cTV1/zTH3h4DCqizFbOqBQq6XjMRZu2gvl9cGIBr8k/Dc634v+Z1ClW+0FS9U53vn/7LN/jj7CtPxYFfZoTZEaS8Hx4Q/obKZT15tKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cPPChL7Q; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cPPChL7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781023122;
	bh=RjZdXrfA/48aCFIOOvZP5ca/w5FSBYw0ZcqbFkzidCo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cPPChL7QWp1yu8mpeDoL4NAL5fFLiLkcE9WIQ/4f71AVrph9F6KlqiFBZQ3+owuKF
	 JS7FdtyYIvi+LCSgbWwtFcdJ8Ib7uO71092HPzwfp6z2F8GknMr9AFVVTmEYg1PoCQ
	 TCozwv5TeA21zE19m8QZ1PdQBmcjmRMV7t54Fq+E=
Received: from github.com (hubbernetes-node-0ad1104.ac4-iad.github.net [10.55.99.44])
	by smtp.github.com (Postfix) with ESMTPA id 7CCCA3210E2
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 09:38:42 -0700 (PDT)
Date: Tue, 09 Jun 2026 09:38:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108111/ad880b-000000@github.com>
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

  Branch: refs/heads/1108111
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
