Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA3123B60A
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504892; cv=none; b=hozlhJFyYuU1seFW5BWECPNoRsNgC/Inb6VI6BaFU7/SfeaDti5oitFxtRW8n8f1PoNwPDsngCJb4vEXKlo6hRT+FsijfioJfKvINubERoS8y26O/10Uv1yW0RJV57Z6Syn7XuCLDZghIFhEz7bvraXlj+84xMebsCaOehnOZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504892; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=auFG5b/UybCq6hKgIkZyx1fe+JdrQGHCHudxmPc8bqngkO34sb645QaSDV9a+PFI2MADK0yQMU4vaONIIaPx98KfCCUGBPsm5HblmAh/2X5BVQoXa5LsKQHH8YszRwq5fIqKEXaXBEZJ6LV+XcgF7+7c/ktsqUlMH5PVI4/WsPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=cito@online.de header.b=WN1haNfI; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=cito@online.de header.b="WN1haNfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1756504882; x=1757109682; i=cito@online.de;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WN1haNfIjxBNNP8eYznj9ehGLUsj6k3k9i/afNtkozClz76lvaXSO3Dozq55nHpb
	 klzPQddJmO8Rdk95pzk+kPsbXR/K9gXowwfcjuCrfT9+43fv9Ot+Rj+Ch8SxhrPIQ
	 nRxcSH/f7xtGx+1pEh8LDtDtdwDolPwkIqApRryd3QG86DbtEPAYwB4DbXlzp28yH
	 ouQSC0h2Eg/4cNIMIpCeIRlYKnMh9ZSWcuxuZVF4LEd21/nmICTZsvIUjba2n6r97
	 rSia1xX7hxe2h6HUiZavvXEIrvbMsxGekjRuSMLUt3XxG33c2axOOSq6o9DQeIxsH
	 L+6zNikIMVZb1m42/Q==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from [192.168.1.10] ([176.199.209.231]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Ma1oK-1uxfbZ3w2e-00PA7N for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug
 2025 00:01:21 +0200
Message-ID: <2eae071a-7cf8-4961-a17c-e094a0868494@online.de>
Date: Sat, 30 Aug 2025 00:01:21 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
From: Christoph Zwerschke <cito@online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1Ggym75rN90y+NmcRupK3EV/q67NspWsx8fJUHdnafDrqrh/yJH
 aIhcGr3l9VVgJQbtkYXmboK1ldsyQfUblZhdV4OrTR6VJhudR4KLaYK6eOaeNSN0P77+Ie/
 LaE7M8IGLr9WsYmS/C+N/IU8BHJCS96C2/+NNIZZ6DOi+orqRKWS5E+cbnJ29o1X3YAr2nf
 nDKwz/YYocjQnrC46VdiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wHOvErHSZNY=;7dU1CRCLuZ0hgs1Qk7k8wbi4QEl
 ADwvN/MUyh6CoAiAwCPPuUDhR5lupzI7JPzQP9uwsFUPZbcVejEoCKrYo9rGToEXlm5UtgzBt
 l9oJJuQyh5S1fkpikIU50LQCHWbboCru3onWlhHvtF/LEIg3G5G/nKgRWGXgiEX9w4j4D0kWm
 flv2hN7gQ7DYIvEnPlMjkw5O7IgJ+jzKlISgMxYuYXs49vUN17pulqyHi6E3vXuXp2Pg7g8zD
 ukxVAQ2WWXlUoVKXvpHVg3BPqweq/Hp03KrH94zPXfSAeetib7m1pwIHgzyRUL8RRE4MypJgo
 nPE1g7Bhu5UPoM6I0+zAYlycaPsa+0HTYVpt6/PEsTbc1/9m53ObdnXm/0pKhu/mer6DRf4O2
 yA7NMcAa02R5ExhYrG6GE5A/BIo4m2MarKPhbR8p5pdrSJ4/zQt2/2QKTWUhIgFwAyL4kyyAb
 odkQKsu6hff56CCpoOqKPK2l8raxeH9cQkWYpt/XXGRumLVQ6wIZ0xz5LzojM0whx95XdD1Vw
 pqomcfQI0sfCZ70GyMFcqWprwFiCS8Ej7t4n146TEwT1B10PgeKYtbQGCIpsfbPaaPOTeU7By
 wQtZ9wqlKJDrawVUrJx9BUEVCM0Z6Jx4OvkAEyLUw9AuN5PB+pGqdLAKTLZCKMl6rP/m4TWhB
 XElV/pcWzOEYdYgmC86yviqUen5L7ZCdT2Svk5xJJF6MFnpE0mH/4jCJGUr25iUPo7tfzlA9I
 WMeG5h9mxpR9YpiSd/aJn+IQ9weXAkDQpx42PohH0mVoFvbHtAyUEbtkgPgtDNeKc9ExIYhqC
 i8meN4bsI7kLc74GAlON/0uQjeIBfKHBUu1+/XDc6DkFHod1lBJP2b4u7ahCWnbjG9YvMxYTz
 VdMIBwGMKkUl32lsDSaZx+izZOoOOh1V5lal9xl/CN7Xj50x98C4FgL09OnZsXrBQEt+WCBu5
 umFXP011/SuSI3vTJmDo8i6q7GuWqd+Z+vuc8RXS+roq2IBKWCXDWBvAJkmgFZhdBV/vfcVmS
 usCzvD4I8eCBofpJiwHLvru7TSiA7J+xTsdxT0ai3BM9BILHgYD6A3Q87Ia9AddjnBICP+wSi
 bP6wWmovt+as4GFR6soMorYO35SjUpPEgNqPogU5pClYI/t04aD8qCTrp7FEe9zrP3Z0rDqAY
 PTYk5WrikkZNXKwHMSJvd3kHWGpD8Ag6oMYfYBqWjBRLcIak4amjpAS9ef908TK/s54KxR+ay
 t8muTOUHjCDdRHXJj4LSN3C7g8oEzyBx9nY8W6olcMviJi+ShRP4OKuYaQSdwwiqnYdX5sBWI
 oZkWsk5OQKlOH24QprxqT3oA1ZasieNwX+DEggllCkgpitOGGMP7WYSzuhKkyKOHCYIoMpAKN
 WJfK0Ch7o1c/AJ0kcfAs+PyayuYmBIGk3TX29hnFG6VGyyZ+6uo0B5vq8cUWf+RbfAr873Wj0
 umQ9tGqD3iZeJYWyYkwGVqvIU0zTVpNXEuHs0cugZpRUEUeaUl5lPmt2/MJrFroFkP/751RC5
 KTYldHNt08V97VwPMs9+5/YnS098/ZRPNN0x/hG6g++EmCdH5QQM60gWfRoJYw0iXCAs3DXc8
 lSS2kXVTfkwFb9cdtJjxWcuVlid4Iagg0DuVJl7un6nbsHgLQlXnYc4/rgB0cL8LCj6tU1EZv
 P/gWVz0emAKm9iSCQKN9cWqecA7WzZy05E21C29eOnUKXz/IaVeaSfxWFwPFKgstk=

