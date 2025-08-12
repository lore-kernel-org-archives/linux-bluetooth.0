Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8552A2DCF44
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011633; cv=none; b=LCXC9twWL/PBpgq/du4mkGMJLdHWtbuWt3T2QlWr+EiYL0Z1OffUc7gtbIsCEQPsx5Tr5eMrj8Nf3Lu7HOIhtcR5V7dApr/695AxCoV2TMx2Yhh6Y0PtTDF/AXRXcI9ZukbeRa8DQv8N45pSyGwz+9zK19yrnSHfjpLtCeJS0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011633; c=relaxed/simple;
	bh=Ih/CFAHFWmsLNLtDUodlCK4iA206j3ybScmltG+ndV4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NiB7b7IoYeTl724rL7+xMKvUokwhLrj4a4JnSLG5+KQAxAZvQXEzVfYyzYGKFM5w5CcNveIVaiDVQyoqO7ADREl7CLzCbdQ2O078CHP541tlaBySHyr/zFdRH3IrzK6Q7TzLU+Pu7s2szfIBKv8CwsXQqc49jHT/PpHtnJilZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=N4+IeH4A; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="N4+IeH4A"
Received: from github.com (hubbernetes-node-4211027.ac4-iad.github.net [10.52.157.25])
	by smtp.github.com (Postfix) with ESMTPA id 737F36404B3
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755011631;
	bh=Llm6C2hoS4LFfBb7lsF6uhIkT+QFeQgsYM1PvotWQfA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N4+IeH4Aok+xlPvHHxUbGvb/vG1PO8kLbr34akpCBtqaMFJ/91XO2zJ4NHyokVKVf
	 VEB1BGqTJNWhyU7W2AHYJD42EfoCU1iP96pwKpcElDTnNvbQ7ZAPbugfbDePyaxtf9
	 Ittz7dHi6GkZ+elYptQnr+bHSLBLNIdwOilqg93A=
Date: Tue, 12 Aug 2025 08:13:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989741/ca79b1-000000@github.com>
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

  Branch: refs/heads/989741
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
