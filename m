Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA352749F8
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353224; cv=none; b=rJS5Nda9HLGepKuNR+rWiaPA+Z+KgoGSQnAPcaeYK3p4So6s4KZESzN9n91hp9BIP9rZoC06EBqsn0WCoepPVF7fpRL85cjUS1ZOj+McEoV48OK9x6463xQ/vSpaNTzpgXdKm1eWW+HebjmIws7PqQgGYaWE/ggmaNINzvtQBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353224; c=relaxed/simple;
	bh=Z7UrO6vWEDLGYCX2384uD++NVBVFT09KcJj2eyssIKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WROSKqGbYg9ctypTclDpGeEiZUHpluM25wjy5FD4NzjnUzZ5w3tuazGOSsUf/ORR5vzw7jAniVd6+Q6zYkWj7XrF3k+xN05mH9I/KQi09JkiVzAgYpApE7YLZTeSQpbr3rQzM+sepcyWF2BZfBKRjmisuNpQ17pGs+7HeBFSlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Ggp9FsvM reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=bT0vfv51; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Ggp9FsvM";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="bT0vfv51"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1748354121; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=9+M7m1zJZWFqVyDFUv3yEFksI/XlWiyTLC29zv3xs5g=; b=Ggp9FsvM8uxhMiOuVU5cwFhaJW
	Y5VvaiiTAMtX0mkVB0GQ22fzjn7GKU4HTa29Q5U+WLN9xGI5TQa6zwO/kipCu4AhC19BVAUOocL+2
	R6AzrrDAbIHqafAp8zFa8u58G5SYEfgpj+X1yptJcmvanlOpFZ9qCTQGWl9oEe6BQhwBDMmhhN2Vd
	x6oCoV91ubnfM8jHKJKGnCgyzOWwolUfcDlOdtkXwxKVcgMm5z7jWhw5XhNjw1dAhhsV000DV8N/+
	2VpLamliIHy/bCoQ8j0Gh0Frgzg5i+/2pTKC9evspsOOgL+pPjRLhsUID36rl1Byl3VIoNS5xNy7r
	gAIJHsxQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1748353221; h=from : subject
 : to : message-id : date;
 bh=9+M7m1zJZWFqVyDFUv3yEFksI/XlWiyTLC29zv3xs5g=;
 b=bT0vfv51b4waNUcj+ZXev9BeJPysYfE4lqFzXERbDJjzaWtP9WLqupJajoUWfeWzH36J0
 7SjDDORwbfNuKN9CMvqsp2HD7CRmiUwanmMA6XSAA8Sij6hZdwzyVCcre6W9BKkfl2BMdp4
 qihV41gjV3iLMhNnLgvJ3pzgdU98GAk0tGu8AW3NHPuhJ4EaYy7G8Bx4+Z23J7rqa/hogpY
 OS6c7wSAilY6k0jpraN6ODQAFf3qIFacStJXtpkkS0F1kBQnm8xu9ekxsfK5JJwSKyLHokQ
 wGJdIEYgJnS8j8sxBN2kbb3HoQhdH+HLXExBGEMG6VSkx9pxeqxf5yqwlqeg==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uJuXL-TRk0yM-R7; Tue, 27 May 2025 13:40:11 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uJuXL-FnQW0hPvkhx-mSDm; Tue, 27 May 2025 13:40:11 +0000
Date: Tue, 27 May 2025 15:31:55 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] policy: Fix reset Control/Target/HS retry counters
Message-ID: <aDW-y1WUsWBpcvJ5@pilgrim>
References: <20250526194328.15875-1-repk@triplefau.lt>
 <CABBYNZLzaOJAQROkLCMWv1_OF6JOFcDN2+Aa=f_Rt9ZS7GJCQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLzaOJAQROkLCMWv1_OF6JOFcDN2+Aa=f_Rt9ZS7GJCQg@mail.gmail.com>
X-Smtpcorp-Track: wfOjA50cu57H.PXb_Di3SjFMe.yoX47QRl0lI
Feedback-ID: 510616m:510616apGKSTK:510616sEGeOYresg
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Tue, May 27, 2025 at 09:00:51AM -0400, Luiz Augusto von Dentz wrote:
> Hi Remi,
> 
> On Mon, May 26, 2025 at 3:52 PM Remi Pommarel <repk@triplefau.lt> wrote:
> >
> > Control and Target retries counter were reset when service state
> > goes from CONNECTED to DISCONNECTED, but usually an extra DISCONNECTING
> > state is reach before going to DISCONNECTED. This causes retry counter
> > to not being reset in this case, leading to service not being able to
> > initialize on next connection. HS retry counter was only reset when
> > limit is reached.
> >
> > Reset the counter as soon as CONNECTED state is reached to avoid that.
> 
> Looks correct, but shouldn't we update for other services as well? Not
> just HS and CT and TG.

Thats right, looks like I missed sink and source retry counters.

Thanks

-- 
Remi
