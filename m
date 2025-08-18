Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893C52185AA;
	Mon, 18 Aug 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543642; cv=none; b=OUB33Ij4jq1Ger3GxEZ+tNMWG7902H2gQ/oPWK+HYNLbPZOuofpV0/FO7lI4D2aKO717HfgF4sXmqdPo8RhDUQXabEMFHzR72tRDl1kOrcIqYR/mGpckhG5jHbmvMX9dlbnLUjQTqGfTEveT9SdgF3RwFs0aWP3Qor0n3Sa+SBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543642; c=relaxed/simple;
	bh=HdJcHnLZFmRshdBvw9A1Sm5Blla51kUxPAONpUMZzsA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QEDQGlQW9bWPk+hkVx7z502cEzfgsNUjrQUj6W1fywFy/Dxxzb+7mjB+hb8/UubUErIJ60xJsoDS7MRziDRPEgOg4DdRizpXEsWWOSVSRFlixFEf+WKR4LIfZnw7HZBWQl3bZhb1Mk0n0SmrfaeSjY6odyYQswhgBqqFSZ2/r1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=INA5xe86; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="INA5xe86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755543609; x=1756148409; i=markus.elfring@web.de;
	bh=HdJcHnLZFmRshdBvw9A1Sm5Blla51kUxPAONpUMZzsA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=INA5xe86DUOrXz4NjX8CJge9aBEuPueyt3OBFKaKVDexvucmOqVvdmOHZTKIiLxg
	 +KZUclzXcjWr6OwozC8JrWhgO22ZtmJpTdubYNBXOLEnZ7HkW/52/5MjjUDz6JRF8
	 9feGhTl5T4Hkh673ZhwYBz6Rel9N+rNjDfwxD3j3CLEajG2hoFfQDZKMR+Yo4fAa/
	 wUXyWyxznAet4/ZhlstMOc/z7Xf3W8ix52OGcEVtcfZKa+OW75uYBnhxjI6gOtwi4
	 7yQQ4rO+7cdJFU+rZJk81IezqGtCEtLetHb9X0BH44ilsgZ8y7RZJh6Nn8bA0YTqL
	 3q/QkfhvQpOt1R3OFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.231]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDQj-1uFIty3Fl1-00p4EA; Mon, 18
 Aug 2025 21:00:09 +0200
Message-ID: <f7fe2444-ba6a-4816-9bd1-0ce233749f6a@web.de>
Date: Mon, 18 Aug 2025 21:00:08 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>, linux-bluetooth@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Luiz Von Dentz
 <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20250818123638.635566-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Remove redundant 0 value
 initialization
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250818123638.635566-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tMXeLL7+fmHQF3IL2o4X1n9FbU+TeBxKApVjgnAGRwCZVDf5wxX
 7oIQOvnghacSFstehLrXgBeeJgSfUUms5kPQBp5x6iLs8YiTWVEteXC+bEnz2VDa0WYJVry
 9N1PaSZVag1fDT/IdwjwOdJtWqofuGxEwLpsq9fINrgr/ZEsrLAguJLgIW+tgzeKijC08bB
 r1NwhU0b/a4MfDWrHw6uA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HDEfvGXJ+kA=;gaY/YitoH8Mpyq5/3iZmF0LU3n7
 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

> The hci_uart struct is already zeroed by kzalloc(). It's redundant to
> initialize hu->padding to 0.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc2#n94

Regards,
Markus
