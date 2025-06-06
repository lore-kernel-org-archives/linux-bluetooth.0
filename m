Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D449728A1C5
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229116; cv=pass; b=Bu3SCcmjwdAhUbMG7ZcUcciaV+Lbbf0uEesZ/Cm3hUmxXKSNUT6G+2LxUykzXW4UjYinPh6obUWP0oPBB1lTTk7tBt8FRv3anIGVfcUBF+AmVdOTmo+UVuaozMMJAmaRz6CuloiRhanvPSBbx/e/3IC87v9IdyFVPD5W7GeQXGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229116; c=relaxed/simple;
	bh=2VNVZ2Cy8FA09AKu7mM/bjfqMZcXbynOLaqRdYNbYz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkvmpDYoRrE/fhREH3v3oaqHjVH2Ihuw+AaKea9R6JOmrlJUbWTxXLJWWkrj88buI5ejBr859nBcPAFFWMNY4VhY7rlOp37qEpWJSDi0u86yPtMyFEppkZ7s2IsAFtf5FkTbfAqtHtSSLpW6z7w/2wMkSH6RLksBQ3F38/oYxp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=NfI8Pheg; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="NfI8Pheg"
ARC-Seal: i=1; a=rsa-sha256; t=1749229099; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dc0gl3pBTYy+ERKDqjxepGfXhyB/KAi4jxSEo4B10N0gGURg4CXWJuCvlC91gKcgCepWgIJKGOoEwqCmHqSOwDKQiZT0tAA+K+l4XDlkr+rpc3DnjvEFduRXR45hpaJ+HjTASc2R2WYHKZl8DxW1lkDy/jGivKjbtSUJ0zHK3l0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749229099; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OksVMcScG6B6icR+jYB0kVDNKG8YF00gX9IG+lT2wWY=; 
	b=Kjwzv3/1jOLrEj+FAtymdvuCU45/VJjaZiOD4XyXDcUfrkmY3cIqU4f8hhFXr1m1k6YNjEbOy4e/fn1y77pgJvCyo2xfgwDpnFYRWG77wwjMb4ArXXVgngtMv+gaTXXDQvAoVktU7Wum3lqp7PyilepbyJqjeMF3ZBz7k/FVTLk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749229099;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OksVMcScG6B6icR+jYB0kVDNKG8YF00gX9IG+lT2wWY=;
	b=NfI8PhegXv36p8wSgOksS1IAs4GziIYG1ZSyVhtgr8kuUBPVKERMdR/MIf5Wh3gz
	MVUc2hanNcXavS6RbvBby91H8KODf25YQZLIzIGk1xU/OOjzUAXK+ZKktwsO47A453D
	FwkN8kmj/hRap2WEnDfFETvA04JXvdgphD70Q8Qk=
Received: by mx.zohomail.com with SMTPS id 1749229097849236.62750923477233;
	Fri, 6 Jun 2025 09:58:17 -0700 (PDT)
Message-ID: <3aeca122-2119-460a-9e4b-64fc6628a35a@collabora.com>
Date: Fri, 6 Jun 2025 18:58:15 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 0/3] pbap: use the public DBus connection
To: Andrew Sayers <kernel.org@pileofstuff.org>,
 linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, pav@iki.fi
References: <20250603151651.1080923-1-kernel.org@pileofstuff.org>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <20250603151651.1080923-1-kernel.org@pileofstuff.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Andrew,

On 03/06/2025 17:13, Andrew Sayers wrote:
> DBus requests are received by the public DBus connection, because it
> registers the relevant bus name.  My previous patches told PBAP to
> listen on a private connection, but DBus doesn't let connections share
> bus names, so it needs to listen on the public connection instead.
>
> This adds a little more complexity to the logind callbacks, to avoid
> unregistering profiles during shutdown.  It also removes an API I
> previously added, which is no longer used and would only encourage the
> next person to make the same mistake.
>
> Reported-by: Frédéric Danis <frederic.danis@collabora.com>
> Closes: https://lore.kernel.org/linux-bluetooth/333ad76e-0aba-4f93-b141-8e69fb47535f@collabora.com/
> Suggested-by: Pauli Virtanen <pav@iki.fi>
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>
> Andrew Sayers (3):
>        obexd: Pass at_(un)register value to logind callbacks
>        pbap: use the public DBus connection
>        Revert "obexd: Support creating private system/session bus connections"
>
>   obexd/client/pbap.c       | 28 ++++++++++++++++++++++++----
>   obexd/plugins/bluetooth.c |  6 ++++--
>   obexd/src/logind.c        | 14 +++++++-------
>   obexd/src/logind.h        |  8 ++++----
>   obexd/src/main.c          |  8 --------
>   obexd/src/obexd.h         |  2 --
>   6 files changed, 39 insertions(+), 27 deletions(-)
>

Except 2 simple build errors, this allows me to connect the pbap profile.
Thanks

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

