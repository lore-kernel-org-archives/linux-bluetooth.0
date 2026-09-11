Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0D497B73
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163014; cv=none; b=UAJYeuFFV1xb2vI03gsf1sEv4WuqmLIwcm8+R5kJE+6aQfYDhsBJbWWpkX0JbO/3qQBJBbLv65rz7s5jDDd8eDHOoyeSaqhIEWa5EZUvq6F5rtumb4e0hAZrnA/HBmlfuO7GHATLm1NXr/RLaBr3uplov/LL9qmNQ+iUAvsxKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163014; c=relaxed/simple;
	bh=HnYF3kdsdJoF/NKfFMUgMgcun79Fvgj6q0c7SOGKS3g=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=CgElWJaKUi5i1wm/xkJl49paMr9kfXLMoW0Wy9cFIW7IdssrUWdwvtZ4ijuKNhO/zz6XnchxglxyilcQflkbGoMfS9YtU76IBeJzM2a0aIKlZfAzmyRDRnjIzrummEkYenC9rWTGOrOJmmxq4U9sc6F6kK0VD3Vym403ryIBxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com; spf=pass smtp.mailfrom=grantmoyer.com; dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b=d2WgC7JZ; arc=none smtp.client-ip=145.131.90.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="d2WgC7JZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
	s=2020-07; t=1789162404;
	bh=ZOB2qVMa15IrHZXqIjZ8RmAYle/r60vPoZXtUtzI4cM=;
	h=From:To:Subject:Date:Message-ID:Mime-Version:
	 Content-Transfer-Encoding:From:Subject:To:Date:Sender:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition:Mime-Version:
	 Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
	b=d2WgC7JZkpBmQTXSgU5jEjlAFceOXSe7Cep/He7w3HRAHsM7BEUvd8FqL5l1T7NZ3
	 0AHLuWRB2jeAV3IWKmZlsNuCKDHB3dHH7tBIYB8BDMZ1//XZGDMjnz4XbupUGWdn0z
	 Y8piyZevWgiZVLn1oeJbpyb4W8PsI7EtfTPqJiIKAYm3oPXKDGmWS1F4l+sHs34pZc
	 AsrkRG+gf1rJoHnLde97NnZ/8poqTSYXC/yin+U53Ptve8P70jsH9XjDQ+i07zo/U/
	 HxZ+tF1ybib2FZOUvatdvtsPHagr6DFqnskzNc4m7z89o00T+YApTikr/iQd8FjYT2
	 deasY4W/59V+Q==
From: Grant Moyer <dev@grantmoyer.com>
To: linux-bluetooth@vger.kernel.org
Cc: Grant Moyer <dev@grantmoyer.com>
Subject: [PATCH BlueZ 0/1] Enable D-Bus activation of bluetooth.service
Date: Fri, 11 Sep 2026 17:32:52 -0400
Message-ID: <20260911213253.766659-1-dev@grantmoyer.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

D-Bus can automatically launch programs on demand when a message is sent to their bus name. Bluez provides src/org.bluez.service for this purpose, but it writes "dbus-org.bluez.service" for the Systemd service name, while the Systemd service is actually named bluetooth.service (generated from src/bluetooth.service.in). The Systemd service defines an alias named dbus-org.bluez.service, but Systemd aliases only come into effect once a unit is enabled.

Effectively, this means that instead of launching bluetoothd on demand whenever it's requested, D-Bus activation is only used if the service is enabled but happens to not be running, such as the first time it's enabled or if it crashes.

Grant Moyer (1):
  org.bluez.service: enable D-Bus activation of bluetooth.service

 src/org.bluez.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 61a2b3d93897b04fb921a4fb229c0831d13807a8
-- 
2.55.0

