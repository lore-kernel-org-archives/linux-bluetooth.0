Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7D0175A74
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344024; cv=none; b=Vy3NZKH7U7DlVbDSnwLcwmw5k0jiaXIlLGp+pEBBsGnPlh1ghgYNAv7aZtrwhtJLF6hhVRQ311n7acAlRdw8bX2Lqquyi8szVvf9r4w1Q9daq6OnTp44WTQ7JaJHSg20URzrAFWaCOsG/aLhjuBSlxNERRWlDcKr/b2l6h0h4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344024; c=relaxed/simple;
	bh=ky7XjuPWKqd4WtY1Up8I3dY4JvXb9FIPM2fj2AQ5EFs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J6nmwa5v9GqIXRKanD5Vk1cqd8bOu28xfZUMbtpW/HPP8OG+KEJtkDZOnI07UuRTGZUs/NsUOlqcdGU+ItKxWEuzzs2VZnKH9VOabi7wwGtyWVrru3ha7ZSA5Wn1XUDuWe8jM/qd77VTVpKxxKyW70c9+yMElDtnMIA13yPrVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IRF+DWKx; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IRF+DWKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777344022;
	bh=ZamJH6fY0EjQYsb5BSTxiMhHJ0RfL5Mwnm6m2FLYYN8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IRF+DWKxltbrLd/q1fOL5/kL7XbSrpN71x4pnr4CP7bQnnsZWTXtYf8byBQ5xQTb2
	 0+oHUc8l2HNDRZw3TT4NHECwr9YrN216/mpxI1clJo0UgLTFcJ9HTna+Pr/WClFiix
	 uOcjo1gYMxJ0XPgzDPMm/IbpRvvQASIhWshgGNKk=
Received: from github.com (hubbernetes-node-64e9200.va3-iad.github.net [10.48.179.57])
	by smtp.github.com (Postfix) with ESMTPA id 2E2A11810FC
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 19:40:22 -0700 (PDT)
Date: Mon, 27 Apr 2026 19:40:22 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086507/000000-1c15a4@github.com>
Subject: [bluez/bluez] ace83f: src/shared: Add RAS packet format and
 notification...
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

  Branch: refs/heads/1086507
  Home:   https://github.com/bluez/bluez
  Commit: ace83f49e878d588c268cb525e65156c6dcb80fe
      https://github.com/bluez/bluez/commit/ace83f49e878d588c268cb525e65156c6dcb80fe
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-28 (Tue, 28 Apr 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  src/shared: Add RAS packet format and notification support

Implement complete RAS data pipeline:
 - Handle HCI CS subevent result/continuation events
 - Serialize ranging/subevent headers per spec
 - GATT notifications for real-time ranging data


  Commit: 1c15a4a4463a498473a5ce53e5ac854a5260c8b7
      https://github.com/bluez/bluez/commit/1c15a4a4463a498473a5ce53e5ac854a5260c8b7
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-28 (Tue, 28 Apr 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles/ranging: Read cs_mode_one_data members

Rearrage reading of cs_mode_one_data struct members as per spec.


Compare: https://github.com/bluez/bluez/compare/ace83f49e878%5E...1c15a4a4463a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
