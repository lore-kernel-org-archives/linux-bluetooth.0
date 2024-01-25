Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E85820B
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190111; cv=none; b=rVBM+5ecjZB61pytEocvEtkFGhkay+ymw6jg4gUWGb6wlTa5qyBRTZEan8078zOSAOXQijC6huDKPS7vLgg/Q7Pk3PK5UyMx1uDO7YrPQj9tS+41GXvX2LDMXLL/60Ue4uvQhycC8ly/LnUH2ocQdD/KLRXoubCDNCHHoUX4PXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190111; c=relaxed/simple;
	bh=0vVe0xcbdZRs131bwFEm0luQlyHNfD0D0sLBGnZmin0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxrVWviTSnnJrXr463jxsUubVtV+FkNDskZhXvo1uim0VjgWALXqpVwrkCNybJ8182Tk2y6tL54eNCEwa2JdQb3/CzBmCDeDgoui4rvmULYfsMAB1bRlzrAA5gBlTSoJkhGpY0MnKTfHgaP3GEi4n2CQ2zbpv84QHTHbllsqakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz/gk8Ei; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz/gk8Ei"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff7dc53ce0so51020757b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 05:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706190108; x=1706794908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0vVe0xcbdZRs131bwFEm0luQlyHNfD0D0sLBGnZmin0=;
        b=bz/gk8EihEhciD6MpKdKPPUliXO8lp+l0CNBuq527Xjdrx5YH+edEYBozqWZpNZwib
         xGjAeseFSEUi0pr/GZbckfn8LIXIHlQ9vIMwEZewH0LAW60US6mj9GOR1bpyO6Jk3QDL
         nylYM6S8jUl7/4YzOPPPcKKnjm+YazjTiIGdEjkeyvQeLgEZqeQFYhEQFgxrMpU/zenI
         owXnmJSRuSy5yFpyIdDRGvX0WxvRqsxWqCl2Iqn455QVqnOvZh9rd3QSGWbVDfwcpzyp
         vKX41zMy405/OyyHeZyvD21M47eOboYeF5RKUQIQOc1/INJSNuO3PPNLuLVj1V8SzGLI
         5ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706190108; x=1706794908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vVe0xcbdZRs131bwFEm0luQlyHNfD0D0sLBGnZmin0=;
        b=wtS7vz4EXIXeR7n6m6QFl6DxPFoG0fzHCx32XN9tm7td1UIRvRmcbSHd95Hrlnhr3Z
         5wc77+twmY3Hj47JfNmTsCefUxtNSuyMSZkit52HY7mZX3cir/WFt76ck7o2N+hmOMa1
         fNnbwnQxYEe4zL0/wWpq3IRfiFk6dQKdG1gZJ3pD5m5LXG9V/3n3Jl7xEMeADJ5TZM1s
         Z4+OzrulJEr+MaP4DYBE8QS4cJx0w/EqHz+VZl5welDzRvax/dkrSM9EI5EyvjjMs3GT
         nnApIZ/PPvXHXv1TD4a86h5NCF5f3HPz8uONysFduthKHW9gMvn5i/NCdc8bMLBtB+Kk
         Dtqg==
X-Gm-Message-State: AOJu0YyseutIK1CnXVa+DFsHRcaT/uWdHMGg3VgNRDCEVqYULXUOQzZJ
	tcapJmNWopVltQJOUWBw5toJCYDEV1cagJXCbcEWxmI0odls7damVurpNl3esnCeCfsaL0FUnSU
	gTIkjjFsVb9ciCkF6/9NlJxLFkNk=
X-Google-Smtp-Source: AGHT+IF0OJuU7zVPI+AqJB4YEM7fkahIHKkiEVWWvo/rJ/pTlq/1IoAmNegVWVaSxXXy3yHkrQqsu2/gFcLVln3ymNA=
X-Received: by 2002:a25:848d:0:b0:dc2:66f2:d68 with SMTP id
 v13-20020a25848d000000b00dc266f20d68mr580313ybk.31.1706190108608; Thu, 25 Jan
 2024 05:41:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
 <20240124-disto-patches-v1-1-97e0eb5625a3@gmail.com> <94235415-0001-4bba-a27f-519533a4a0ce@endrift.com>
In-Reply-To: <94235415-0001-4bba-a27f-519533a4a0ce@endrift.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 25 Jan 2024 13:41:37 +0000
Message-ID: <CACvgo51n2QZ8JPcLLvXS7VbsiTSJFy+fK47kdGd7kZ9UnOX1ew@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/9] Enable alternate Bluetooth connection modes
To: Vicki Pfau <vi@endrift.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Rachel Blackman <rachel.blackman@synapse.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vicki,

On Thu, 25 Jan 2024 at 03:05, Vicki Pfau <vi@endrift.com> wrote:
>
> Hi Emil,
>
> I didn't write this patch. It was written by Rachel Blackman, and I believe I just rebased it onto our local tree with the expectation that it was just our local tree. It would be better attributed to her, potentially with a Co-Authored-By for me.
>

Sure can do that. I've intentionally tried to preserve authorship,
which seemed to have backfired in this case :-)

-Emil
