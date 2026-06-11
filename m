Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305453D25CE
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173993; cv=pass; b=i6GnqYclnFNTnprsDfQBcCjCcEj+8DVYnREcytgm35ClH4BgH11zBuORx2cqbDEdcUHQMMqXuUWm5iDyGZ8zzb1MgFgNxBxrFGj8YiK/s+DsMKdIi/8Y8TnD7i4bzG5hYkEwkD2J3xs4MazwGvOmkek5VMlAbTTyNqGmV/fQgM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173993; c=relaxed/simple;
	bh=USjVFKaTOqKKMsfC4POylKAfJ6Z15YP2VbWw/lmqYa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sm/erMjwxYLzxWNZTosNYI9hA8ywjL5P5R8lHD69QfNwQKluTNaTqnVLNQn5oXAT8Q14Uf3kLw3Q+2yTAuPN8WEiE1EMqtpFKuw6dZSH2bAlg5N1OwwPXtBhCd4S1eiaXwCnvPffozdtpaTLQnT4QBlXeE72yzgpMiAX3ecgPg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+OL+TB3; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+OL+TB3"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1363fe80fe8so11287819c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 03:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781173990; cv=none;
        d=google.com; s=arc-20240605;
        b=jsn8EgBXlDWmy2zhu+K7Clf3kHWygCh/9UeWp3zYN+GweVchEE0d7uG1IfKWqdenZo
         +m+dcx+fMnWlQZtz2E86teAxOJXwLnayfbJfiB1fdFS6R73dsY3uAIxV0ddXee6uZE9c
         c74uVLq1SISmXWFg6o+qITxYIeBbRVrrD4gSb6UnZdlisRiBrUu0hnqRyxsGDZZYK1Rq
         6Q+UiqXArBTbuyQbXnAemx9dg6AYFKASUPkWnETY0Ont5cokNy1pp1f1xOZEeCPW1Z8M
         Lki7sJMN9zBisgHyiL0CHKSmfItNkmEORXu50HrXtUT8B/MtKobG32Ot+hk8EFDKXp78
         MjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=USjVFKaTOqKKMsfC4POylKAfJ6Z15YP2VbWw/lmqYa4=;
        fh=0lXXPMVPzA46oaDzlr7m70zJMIAyNkh5J2ClfAkyYVQ=;
        b=KD4gKg4e3PZfq1CdowOCfHKoIiXjV1CfnCWU61P8QSUEduXzpQyDmVzK8yDhWxHZfk
         sb8+S4x9coLQRp7DXm/c2vaQaCVjqEVq8c/gcp9NWNkD7oVJGP47ar72qk2DAgxjC92v
         iDjF6gZwvs1L3ZXw3qbOW6nMjTychz7d7Ydr4tEZlB0ngj3P5TM6v5ZQactfQ05Hwfb8
         Og4hcmTY7T/97b1NEnDgkQEJDZ1updrXzKGWIKNXwuFWxs3S2/ZXm+rPoNtrl3KZWwE5
         z9YU/9Z7uh/nM8w1iTQSDArJYYgIKLuikVntEWy9Xs0J9FuatSPo2IUjiK0eYCGCA5/4
         0dVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781173990; x=1781778790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=USjVFKaTOqKKMsfC4POylKAfJ6Z15YP2VbWw/lmqYa4=;
        b=Q+OL+TB37aF70BIKvlwIYDdzThXwwG259gKgL0jFQWMW2GI4vjQ6LCaO/SQP43twkt
         HIy5wCGseR0jsiumH5zcREnAMC+9CfIQctwIZgplJy9ALdJrokguuw7ZVXtXpwsz546q
         YAsA5nOxVun/bZpZ2BzWQB+rxotOZ9knUIfiRxAxijYuw5IppZ3Xe6c+Rt/QSgxF1v9x
         +gAASCYqeeLRxbdrRpvZpcZkCTLVdRSeTN25MXuTQmwqMkfQ0B/5hjBmQbk+4om5suMe
         zSd4cMXjAJ0Om2cQcsFB16HiCoj5RlomLACptSWMLazVEPmfik4wDQMe1V+rGt7AmBg2
         6IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173990; x=1781778790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USjVFKaTOqKKMsfC4POylKAfJ6Z15YP2VbWw/lmqYa4=;
        b=c62sRro7xl7RVRmFt6/+gC+fTmqFE0M0W+sLiMtsar9zMNfyEaOj08UHqE7ZK/0Xri
         a4RsdvkVEQ6WnBbM0i75jrJhrLVRyD66bj24IbudQWwpmqteu4W9Aq1nYvh7glBp2twN
         wuLvfMOE92nc5yBd7xAB1zA6pOEgCwAn4NFWSI2Vs7OEMeMchr6rz6w7QgDCCtotDGFh
         /rSBh7Os8TfdPk7z56DVXKt+kHPFDzOeQB59CBr+e7EkMRIGF/jwzwb4Od5W3J1e0D9m
         18TYCPSzzh5PMVs2V5yU3rRVJ0oa7GeIQLU2U0/FYM683UeCuKEtO7w5JRCIq4RJOSAt
         qfhg==
X-Forwarded-Encrypted: i=1; AFNElJ9AbyeZzDYlLDknaTt1GvKWRhAEl+VRXxiFi9E1gmRxq9RXzXPCFIEBZgb/lziaDfK3kvXNkyCSaM0ypEz9aB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9tj8RHvHpAuMOYLoU/5/kT3oU6eMly1lfmkdDgP5UIxDl/Wk
	l6JZb3WeqtttipQdG3YIYXAk1x81Jv9KTymE4jTad+2gL3siFuwMJlZHMOr6A+ycnGMHYQa3NS7
	+wkLOut7xSaF6iAwwxJviI8r53gotWfVLvRwut6SJ
X-Gm-Gg: Acq92OErUb0CqWpt68M4ybw72gg+1cPG4p1r3s/KGTANfQwqwWKpJNK/wJ1Lzh0QdoK
	GFWfPdttlqYBO+SLXgRQbBzgRarBxtw2PlM2o7ybB0TRz+QSZCDmjkhD+ZDa8/0C4y1tEONiXrA
	wt1dTOuRZZQlssg7DJCAfhYL4BM8+5ffMxpyht/W8VYoR1tzXmHx4LVDUEtPoCI7WvyQs0+p9jn
	yW43tPUORsokfl05rW0004lxiuj4WrtDSkqyIGUMiNlS1iu7owztT1D2DoR2VetU6EiV6DdTq87
	TtW5nAD1ZStqkK3cu3iIYDrOyxyflJKQ9h7LowxnyzWncmM=
X-Received: by 2002:a05:701b:4183:10b0:138:177c:b971 with SMTP id
 a92af1059eb24-138423ed863mr961163c88.29.1781173989581; Thu, 11 Jun 2026
 03:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605142351.2306664-1-elver@google.com> <CABBYNZKRHj0z6n9kJhOST53tpnbpS1wikgB-sjanZaYdXxNk+w@mail.gmail.com>
In-Reply-To: <CABBYNZKRHj0z6n9kJhOST53tpnbpS1wikgB-sjanZaYdXxNk+w@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Thu, 11 Jun 2026 12:32:32 +0200
X-Gm-Features: AVVi8CcTZiDNtSS2_ZUuIlLFtCgs20y0-fuTxWai6BS59EzQbJKMWEBzXUIsQuE
Message-ID: <CANpmjNMurZs1bh8_WEA-vbTjCR0UpogCEy_=4brU52OmAmd2JQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix UAF in channel timeout by
 holding conn ref
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org, Siwei Zhang <oss@fourdim.xyz>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 17:48, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
[..]
> While I consider this a much cleaner approach than any the previous,
> perhaps we could go one step further and stop using chan->conn as an
> indiciation that l2cap_chan_del has run/detach l2cap_chan and instead
> perhaps use a flag e.g. FLAG_DEL, that way we can make chan->conn be
> used for reference tracking alone and don't need to introduce yet
> another field for it.

I agree in theory, but this is a larger refactor and needs a careful
audit of every user of conn in conditionals. Haven't had time to look
at that yet.

Thanks,
-- Marco
