Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0F1AAE0D
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977894; cv=none; b=OeDvHzjTJkOxNkgw3eov1Jdr0AyAQvwS776PHTu8cnWJWVGMHaN9OoT3q5fUqV8yA/HgYR8uWOjuPxkOSav491ogpy1W1PFhdZlUtZvQob/QS3OJf5ir+jSlpr3tE/TNZG66b9dh1s75wLyX5j2l34MmQYfLxu4A/Cw2AcgsV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977894; c=relaxed/simple;
	bh=UHzkMw++es1QxCZMuuw8zPYXNCq0nqCjj4ZS1Y6p4M0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JMhu7YbBvuQkCCrTvZtAK10rMutxj5gPjPLY8HMO0KPRXGHBDMsPMqBEEQP9rN/D9VtNajHtHfo1b6QsBMa6GiMtmuZ5zG6FYKEvtaKoFKfROsX1acIinVBdfNoS1HWXYwOKErE1+mZCEswIG2EKKUdz7uye3XO+fjDghDtcTH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DM82MLkx; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DM82MLkx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Ul6j9mwcGcmNiWWQEg6Xzwswk/dC/2XvRqxnfzRIk5E=; b=DM82MLkxQwfZOMJM
	Hoib8rwk0cUURL66wO08A1BAJFNAV9faYQcgdO5hvp3h7pb+SpPlfSaYMxgbgkFl8fes9uKhnZSha
	c0Kj+9WZ7pVMtu34GSeTSmPiZD4ETfk7yT38mNpDgVQ19nx7340zQjOUURbFlxC+AmkH4scyrSpKf
	Ph6LTzJuHDk+EraBxZqt+DIDHFitxR7E3u5JiRaP/iCRQ0XsjeX8REFgaU6/vmuvPm0eaCt/R3Az/
	VdqN4hQTLOR++1K1pGVtoAWFTbI2Cq0tjrMLb+pI56j8Fjl0lZ/r7Tq78Y8ZAdJOQno/oSF9Bo90n
	O+EDCFGXvNkInFq0XQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1swPz1-008iEk-0a;
	Thu, 03 Oct 2024 17:51:23 +0000
Date: Thu, 3 Oct 2024 17:51:23 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
	luiz.von.dentz@intel.com
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Subject: of btintel_regmap_init
Message-ID: <Zv7Zm2sq3Jr7yzW0@gallifrey>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:48:59 up 148 days,  5:03,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,
  A script of mine noticed that btintel_regmap_init doesn't appear
to be called anywhere; it was added way back by:

commit d06f107bcd828a6c3ecd4a7d449d5d0c0dba0326
Author: Loic Poulain <loic.poulain@intel.com>
Date:   Thu Oct 1 18:16:21 2015 +0200

Bluetooth: btintel: Add iBT register access over HCI support

and I don't think it's ever been called since.

Is this just dead code (which I'd be happy to prepare a patch to remove)
or should this be called from somewhere?

Dave
P.S. I'm doing general deadcoding here, and don't know much about BT
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
