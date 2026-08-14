Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51334489864;
	Fri, 14 Aug 2026 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733234; cv=pass; b=op4SMko+p8uzdfbjz0WFVBxME7ENV4Ctt6ztc654ZjAFeIIXcdYNZmIOIXDg1jAR4o3o7kTKxddqLmXKBosS++gTaReQpj2DIu3V4e8vhNdLCrQFKJUNwxoKt6VtcK9MSlV1HJ39at6rViNHaiHn6dmGNEWVvEY5ytSjvWQTuBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733234; c=relaxed/simple;
	bh=pwAVMpiMcgXZUrLUkOosowSMaezFOZgthT7tsnnGhE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uU9TVmyppAjHS9wYSwzHi6myHPeHkeo/cXPHGgwLo2ADzSTlJQavOXa6lTUzKRczV7+jSuR58WsCkDUOQLBvTDU5PFh81Cj8rFJrxEHunFqFqFqSulJCzInX7laSPeL2erl3FzrOHndkTo++YPUGWkgPD0cg3nlNQdjD0AM3Ijs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=hTcxUG5x; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="hTcxUG5x"
ARC-Seal: i=1; a=rsa-sha256; t=1786733226; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YVNPDkK4EfheaofaGRBIi2AHiNV29PLqlEODLG5sV7EUiFTr0X/FubvajpAGPJrPTUhoZeazp+9XHxQ6G5uklP5fDLReet/XzFEBtLfUnkNm4+HkAB/M3EqMe46hVcTWQJMVw1MXCT5OOyVAPU/3Yur5x5J9/fc+JuDng0NCs58=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786733226; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pwAVMpiMcgXZUrLUkOosowSMaezFOZgthT7tsnnGhE0=; 
	b=FFhWlrTRecQrkkUXzPiB3rETqMZwDjd4YNbBhO6zzakK9VDay4uW/9a8F4wBNyd8T8B3EQUs0+iz9Cbsv54dsUIFfOqSKSUv4pbaNv3oZYkBljnbItwklsh6QUj1tPo8MxFMkF23ZjZ+Lfd9oLOSaSSsxUi6+MhWguQ8jb0hsFc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786733226;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pwAVMpiMcgXZUrLUkOosowSMaezFOZgthT7tsnnGhE0=;
	b=hTcxUG5xwBA3Zw3p0ig9ldOmeixk7heo2O2Ddx2gICZpCmIeKghteWiehTbukRbN
	J/u/r0vbFh1LC8+IW+69Q6XN6U26DduBs+TR/IYFlClhxqyZ9o46jtN+UHzZscYD7LJ
	mKWRBxoBe10IEpy26c8n/jvhu2wsaPG6nDcM9d3Q=
Received: by mx.zoho.eu with SMTPS id 1786733224646323.8521073732908;
	Fri, 14 Aug 2026 20:47:04 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	raghuram.hegde@intel.com,
	kiraank@gmail.com,
	kiran.k@intel.com,
	ravishankar.srivatsa@intel.com,
	amit.k.bag@intel.com
Subject: Re: [PATCH v2 3/3] Bluetooth: btintel: propagate version TLV parsing errors
Date: Fri, 14 Aug 2026 18:46:47 +0000
Message-ID: <20260814184653.943386-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814171503.42684-4-acharyalaxman8848@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This looks good to me. Propagating the parser error here keeps the
version TLV handling consistent with the other setup path and avoids
continuing with partially initialized version data.

Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
