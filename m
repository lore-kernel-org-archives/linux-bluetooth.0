Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C42F1FDF
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082187; cv=none; b=F9uC3yrg5zzEYEwVCcoiLkB/n2ypwnv2FKBC94qsvYlL1yRNOhmn9d23j07e+mTYyJa2ihE7xK92Rq7AWj5mqIw2W9Ewf/3kdtYh/sxUmXnsD0vd4etF59S08LhtjL+CwwjZsOt4Y4L8jXW4zAElt09hv06Q1j1mZ2naxZpjX1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082187; c=relaxed/simple;
	bh=vMf16BM3RdxZtj2JzjuoCtaXOzop9MvRqXMsZ/swG+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjzO7edGfpTvLlnuVCoqNq/qqttlYTlXA9KuZkQeVjIXFFnRLKUT2lWwgVNboae7hsh4tH1BLqPI7AszM/+LpuDU55AGjW61h8U2BS7TtshVDO6qoRWy7/nmLRz6H/bGQiIq5S7BOHuFo/HVDR+sSROHBAgcoSbRuEHAQFLeb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXftd21t; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXftd21t"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e809baeef7so709736585a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 03:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755082184; x=1755686984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vMf16BM3RdxZtj2JzjuoCtaXOzop9MvRqXMsZ/swG+4=;
        b=DXftd21tzB8K/2tHUNhC+xwi88TsSkTTitOZJ/ADszxcIoYBUakAepalFxz+SI8TOZ
         SNHgRD4mEPXlMRt7+qAkiF11fkN2PY7ILxS+iV8wj3TpV8jyXJnCR1zmUmCiURS4Uv0U
         kyO9lqanZKjCDHY+XWtBPOsbq8wo3B4I2tP5hV6SE7FAMuZfU0p8Wy41dmyNC8NXas8J
         wtIm06aBP4+lna/P86w2K7DJUTk+qDCjun4bmVA7MGpcDdK2sQHRz/XwXmvFbB5jOjQI
         fBrr2IrdgrVhegWFL5c++Px+aoNGhpegP4HdaQXgO7gETRK1J7D8PDBAz8PJ3oRuyawa
         UXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082184; x=1755686984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMf16BM3RdxZtj2JzjuoCtaXOzop9MvRqXMsZ/swG+4=;
        b=M4GqQi9rj7S0cuVU5yC2QSDpXsrb61Q3ycHfjeC9aGQ2RGrpVmBwbxup2k2Guf8ZdX
         uYtmWMrGsHGwxhsRizRsV7S2qTvwUdVsZSOH1scuXtVWYNBqt81p4c7aDrzv7zELbKdZ
         9mSPbrX29cFeSCCrTZHfn1qg9YoH3y4PQcovj9F3LdY7wLKH1MPBdTlt6DfCvbUoyrCb
         uGQO5axpxkOxJgRdxHfLJqlEOfiFq7NsSX/+bez9pAbvzb5wdifT0yvlyDYe3eYVvmRB
         sw4hUbVb5Arawblww0IymGhLlX/S8HJ5U66k+3IvsrWjtzBH2gfKWl1cvIfEkRruMYmi
         yKgA==
X-Gm-Message-State: AOJu0Yzn/nceTjZg7hGqJN5RFQYhdvujadBw6kj3qO6xS6RddfBvTXN1
	Ny6p4eK6vvSmhj05puiOdCugf2BD4jOZ6H8GAe721FkIZIj0cO6y2+AJkBkTO1jeV0kkc3KxsRf
	QH2zK/5dFAlxMX1CL+C3Bt+1/n6D9yTbhi2QEdrSnbbaNc9pYUfSRi+m8LGD98Q==
X-Gm-Gg: ASbGncsddsTpnyURjucu+C5kRs+gQ1EZaKBsP7gvlDT1NjWrwBQBEQcAaeoHuGRwGS1
	dGV1xL7YoMGQULdlcAETfHoUSPzJLhlepeg8hvEufOEyv17ua8cebqy/bh7WjsTJfBeav/gLHmd
	sxehVXxtv3mmyntX2ryiHz1DdyVpDW0ZPy/5XxeGGSAZxbYyIQzu7xaLG8Lbc/3NRi2/WezNc4R
	qiNMh5X6f2l3bey7Xm0Fqw4F0GNY94C4FAaa0OTkQ==
X-Google-Smtp-Source: AGHT+IEGaNG0b2eD2kmCjXyylfbIMwTtzAYmXbsZhcPj8nNVpX7AtNQSWu8oEToe4HYYCFmbuTk7OSiItxRof682tzo=
X-Received: by 2002:ac8:5aca:0:b0:4af:12b0:57aa with SMTP id
 d75a77b69052e-4b0fc6e7b48mr27154701cf.16.1755082183801; Wed, 13 Aug 2025
 03:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813103459.3690107-1-ochang@google.com> <20250813103459.3690107-2-ochang@google.com>
In-Reply-To: <20250813103459.3690107-2-ochang@google.com>
From: Oliver Chang <ochang@google.com>
Date: Wed, 13 Aug 2025 20:49:32 +1000
X-Gm-Features: Ac12FXwS8FU2nNwDy7LHCtlUSGTsmOXk1ACFdI9tiatF98wStzyZcfAQNGH_bpk
Message-ID: <CAFqAZOL8mkFSyfONx3bzMegD-xQuCisDvPbV=AX0zwndnijB5g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/1] Fix heap-buffer-overflow in sdp_xml.c:compute_seq_size
To: linux-bluetooth@vger.kernel.org
Cc: oss-fuzz-bugs@google.com
Content-Type: text/plain; charset="UTF-8"

To clarify which "previous patch" I was referring to, I'm referring to
the one titled "[PATCH BlueZ 1/1] Fixed heap-buffer-overflow in
`compute_seq_size`"

Kind regards,
Oliver
