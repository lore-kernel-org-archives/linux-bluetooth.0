Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D808BE8
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Nov 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771631; cv=none; b=tERMEcDjd4t6utyqbXjHU1TdgKdzp0M14YMUw6lr/DX9Ex5DDqsi9otPTdvPL1H7Mgq9/Fu54ZcG7O6YJk8hg52wDdrQMneGun41X+czsi/u3QK9J+VAYtbgAJI7wOicoIT2sDPKJJrnP1fWgp0pI61rzqYGOO3a8EI4PC9rUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771631; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=jdOLXbSQAAohUNsdRM17K7l0ClA6UvKmPAdQEKMuSOEcOzEwXAFOiD6lT2Fzg5Va3FNJSGVmjLhRulx3hJSR894j1lS7n1QFWyBDJCzN5GzJ0vWD2e7h6dOTmm/Pe1RNwEzfH7BxWLS2Ps1FYbnNRnGxTdCCH1ziwm7mg+dHAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6H5r982; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6H5r982"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-211985ed4c3so2866675ad.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 Nov 2024 07:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771624; x=1732376424; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=a6H5r982JeS1cnKzgDhgoIIer4+NQGa98sxHjjUenfgEsQzzAOza9oBDQxZYWDlW9Z
         VgyDHH54XQI3P9IH4A9iDSDE5OZbBJzcxRM2XZWjmkWlw2ISVk0MCDDekm4znJDCKW/v
         d0FsWWNUeN+1/Bi2f6R2rR/+bpM9CtOFl8KWl0WIkARfXhaAWdzfeGx3T/goCWOozmVP
         v2ENBlGRDqVFDHuT79igDFPdbHmHlgWQWMjdLyn0Ic9THxD+zyJ+1EYvtWeAH3MoLJDX
         0VMNkw9r2reS/CCM+9cwr91F4Akvt7onfVGOitMzDSXPgXXAUxEfj+P5s3BCcuhsgwi3
         KcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771624; x=1732376424;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=EHGHy/l6+bZ9S4RQ3IFcmKkAQNV20ssanMa0WT5cER2XEYlDgyLM0wzqzPdrtJ/TQl
         0NnWAr0+a4OhAcpWR3wDbkOJ4sc9WnU3Uq67UqNFJFy1BGd/Dgi9aoel4YNfF+XbNwxH
         2c8dMJ4w0L2xuNBwtzLq5tFew+oHsfceYY7bE1QxsErScNu7XduW+RbWNA8Cdyqrnuro
         1e+G34NY1Rk73YWWf/VjFGsodijwbALzZH6mgiNF1kzs2MJgc4a1nVaqox7wzLucnhuj
         S/lIcjPuLkv5H9hxt0sA7ArnNRhX32GwgDKrnC8OKPLWxhn1QMGc5h+mdVfdmyZxMKD/
         /yGA==
X-Gm-Message-State: AOJu0YwNk75h9i9sj6ph3NwP5iLWMe9v61S3yOiohy/AuhjkqeadLYUs
	nSeeX9oCn/BYCt29loLCkgTAQ5D4Bco8FPK2JNWJZjvFlbAEZPcoKMORkgzF
X-Google-Smtp-Source: AGHT+IGEb9QzZvcwe9bHwIiTjeVNjgNII6p7jt8FBY3V+EZAvmZlFpSQSxUTC1xes7yymf+wEbN+WA==
X-Received: by 2002:a17:903:2b06:b0:20c:92ce:35b3 with SMTP id d9443c01a7336-211d0d635demr38370065ad.2.1731771624066;
        Sat, 16 Nov 2024 07:40:24 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f4690bsm29150535ad.194.2024.11.16.07.40.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:23 -0800 (PST)
From: "Van. HR" <maniaakannxbxn@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <12a80f411b2bfc4419d4dd9bcdba016c61b1eedd8654c30e939171fc6dcb9a0b@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:20 -0500
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.

