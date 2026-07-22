Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7B31A6834;
	Wed, 22 Jul 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744153; cv=none; b=fBemH8LhpoeO5xWT5ouC2LBY8+a+kda5q1u3dBpD2HXkorCY3JO8xuqwGfZlPiL+FaaxwqEyLI1A5noVjRlEGc9xSHfr7c23H0pDeYWiFlCv1Qohvnzqc4w6Hijj5LkImK5Te3rm2H21VsweYX7ACZdE7fHJ5IdmO5V0erXHMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744153; c=relaxed/simple;
	bh=rlq+5nSngsoF0VGK6MXCm+JpRR9DEES+dz7VNvwnwCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlNLHNRUIv4wzhsn4SZcxARK3y6qXny2LerT44h5i7ae8v3dQgg/7bbke0zVJ2fgrbfOtXpk2nozSbVtmELm177c2vpKlVDoKe5qLF0OJhy6XyAuyYD1jIqnlPwyAbO6q0xhE6lXoiOp7CBg5jrV72LoUpxP6kx2TMSPZEOfqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pcp1jkBR; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pcp1jkBR"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h52Vv0GykzlfwgD;
	Wed, 22 Jul 2026 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784744148; x=1787336149; bh=rlq+5nSngsoF0VGK6MXCm+Jp
	RR9DEES+dz7VNvwnwCU=; b=pcp1jkBRnkEe2hzj6j8Qy1/o5WgJASkqh5gJOk85
	2hq2/fg6qRCQOOiJmNKHk0oog/+Rs9x6ydIazDcPDCQB183awHv3bxjyjLUkkBXR
	jJJLxr+G0UQUruWiXqDZhWeRzfa8QLmBod8I1gYkt/sWzJzT+Uh1v3iHc+G+XLSh
	jsvms36bzPA5QKglupaLJy+k79MNJoqjM674NbVuHASQKU0JrhXjOlUW5ywUvgr0
	2Vl71LSbxjY515Tl+PkQ76CP2Md0GxwLVUcid7wf+DnfPq9AeEfVs3aNJI90owrg
	5CvTbFCbYiRin9+0vrad3CW4uxJhjMQL5tEQM1cjJg9Vlg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3W4BxMPp6wrr; Wed, 22 Jul 2026 18:15:48 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h52Vp35bCzlfwgC;
	Wed, 22 Jul 2026 18:15:45 +0000 (UTC)
Message-ID: <79dd1eee-9e41-4b1f-ba90-d64bacf194cc@acm.org>
Date: Wed, 22 Jul 2026 11:15:44 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Bluetooth: L2CAP: add locking annotations for
 l2cap_chan_lock/unlock
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, elver@google.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <aaf5b46dd2519f7b3c7e74f9b232be2130ca30db.1784018377.git.pav@iki.fi>
 <a0e6db05b52994c3c27d854e2d35ab0256b93769.1784018377.git.pav@iki.fi>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a0e6db05b52994c3c27d854e2d35ab0256b93769.1784018377.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 1:40 AM, Pauli Virtanen wrote:
> Add minimal context analysis annotations to l2cap_chan_lock/unlock() and
> callers required for no warnings.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
