Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B714231C9F;
	Wed,  9 Jul 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048289; cv=none; b=d0Lpnn1roPr8vA4oWS3D8wAzl32u9lQua28AdAnP3UVYwhxnTTzeglXKCO2Ea7qcG/qwCT8GB3rCJwY7kQKLYd18zjMC51vqUenOMmnvRC8LUWT/136Xt7iwBlcqXow4XYlojvlGuZ7jnqP+RKNgEMSeZCMX5I1QWRuw5n+lJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048289; c=relaxed/simple;
	bh=/vN4f6GloB2HKqs9li9tfVZYL82dtQ+vnhzZDOE8C7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlzmimi2+g89TvykC/axmcgnVYFZjmY7kJg7i3HTkky0n9I4CNCWc9JHFDwJlwXlJmT83e2RrGo+hJ9pzhqjTaypTdtCNdbVcvr3quwvUPVCDLQYYUv8NsYkJo5i95BTw2sK3H+96djOU8gL0ucyyh29f9xNrnxe+79raewNQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNZxqAQ8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNZxqAQ8"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32f3ef6178bso10925791fa.1;
        Wed, 09 Jul 2025 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752048285; x=1752653085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/vN4f6GloB2HKqs9li9tfVZYL82dtQ+vnhzZDOE8C7c=;
        b=hNZxqAQ8Ac5eWIauecBd0lZJ6PbagYN8Z1/UjzfGjlPKqdbx4fr0YCP333oqImiaw6
         8GH2RR9cl0B83ys6F8kcbSYs51QCzH4VFMMiKOBER5+RryvDnEEsjFX6PFFDgVQFUPyr
         3uI/CBG1qJSqZLp+H6wd62nFgmGP4+tTbpKWAcZzXQx9MJs7KjkF35Jgiidh9MWC7TPt
         9X/Ra3NvYCklJ0ynPCClmtHQbubVGTAy3H91ry8OFVlUmAkxEUcuFsAFe6bzSbhs6867
         rnSEdYy8J8KBxoC9e4ENpTCLxKx9Uap+cpMaEV+IWzC+nf2adDVBueVzXlBXA5xpVa1l
         I/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048285; x=1752653085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vN4f6GloB2HKqs9li9tfVZYL82dtQ+vnhzZDOE8C7c=;
        b=iU9KlkPAiAD90RuCjASH3zdOsmwV8atXBUaMaw8z/Rv3F16mPDcvJi3XPGYx5k5f7A
         yWH+I09OjsKPWLpmOHFXHz5PoqhSYB3cPjFb+EjKh3YPKQrcUYRK4lIwrxgA9tsPoj3F
         4ESzyDTVPvdJT0ifvze1Q+QJrVMsR44YalNqbK6vwKUtl6MWYL3A5KMA4aiCvsb0rl4S
         KHSl+K42wr+5cu1iLGYorYl2WoimtmPsHfKP4rVIrNI2NgAjy1aF+Ta9kg5oE0vIcBQN
         2A+RE5tAGrxBwxsVevDI9MwfGv8VY4qUhQjGCTAr9ciybnJeBuuCjkWtP8mU3Ykmi01A
         1UuA==
X-Forwarded-Encrypted: i=1; AJvYcCVWcVKJM8MeyhYm/7v8h6tPcirroGVron+1iWjB896vKiw6BvUXT1kqlijHUV6P7xDwDczkQWopKwF4hy35nTI=@vger.kernel.org, AJvYcCW5EU6SuTfoQ5IJKDvANKHSkJQS89qQXHhv9EtsxqnVU/RrngJ+DMzUTjZ+J2yOCNsgNi+xNl5HqjOn6gVl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3BIQBpN/BLfu8LOtawOU1DlcL4QSDYYGnBIEoTrdCrGfKajNr
	DCFdnOgC/DJtWP9sQVZHmVCvFMMM+d8HGw4rUiykH0gdkOHhaDprdQn6PgYQ7sywgeykixZ+mCM
	7cx5fdsb0QidhIyFjmyEiAHnwNf5fdcqrBAyKZ6pZ+Q==
X-Gm-Gg: ASbGncswPSxbr+vjwxuzZpoouQS6U+LUs5uzi6DnPQB/iByoxvK4Zt9gP0N8WFrgBK6
	wmaPhOc/o12MvJGTJK6Zu5Ja0e6vNwiD+5PcIQGn8sfVZl/qDi4/5EzE/TXwPXd8iegmqJRojBY
	64r4sDs/RzcjY4biC84OWwL0FfmE87TY1xGItrkHgeBrzFbtBvwf638KGdsUxrkGPAntwo41L2f
	dYV
X-Google-Smtp-Source: AGHT+IH96QsTL3RrgUgPJVlkDGHpCJxIIYfO75lVlWUgFwfF6IIJV3+4SisXlJWruFit22AOqIfUjKdaZW6v1qQVjRg=
X-Received: by 2002:a05:651c:220d:b0:32a:714c:12d1 with SMTP id
 38308e7fff4ca-32f484b6366mr4164781fa.1.1752048285386; Wed, 09 Jul 2025
 01:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708141617.3691-2-alex.gasbarroni@gmail.com> <CABBYNZJ9jLwiieHC=ohp+EjtoO7_4Umd2giRKNe1y0u-qpP1ww@mail.gmail.com>
In-Reply-To: <CABBYNZJ9jLwiieHC=ohp+EjtoO7_4Umd2giRKNe1y0u-qpP1ww@mail.gmail.com>
From: Alessandro Gasbarroni <alex.gasbarroni@gmail.com>
Date: Wed, 9 Jul 2025 10:04:09 +0200
X-Gm-Features: Ac12FXw_h22SikHgQhsvyr9LCUfkngysfL28LGgr9rvqB3agCBrD0b5mwRreAmg
Message-ID: <CAHsjepRDUN6Ry-M-_7MRwgKF_xAB_U8k9e4=p+u7NFFd_5VV3w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: fix connectable extended advertising
 when using static random address
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

> Hmm, we should probably be using hci_copy_identity_address instead
> here, or have you tried and it didn't work?

I wasn't aware of that function. You are absolutely right, that works
and behaves exactly how I would expect. I'll send a v2.
