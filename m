Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F929219A67
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452290; cv=none; b=Ju7hh3NWET9Opetax3leDAgwsiwmxRcLdhOsjHPbwj5UkxLUn6whO1xAe3ZPCijrYax83/+F71BdwlzRRYEyXZLXZXmRrlMbUDK8UBOAtKcwChL4Bgxe5Vou6NrzmdRegGwalxl/pb+i1dU6gSPfX/+oHM/5ws9L5mkfLNReGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452290; c=relaxed/simple;
	bh=JVlYEwRwikuzUOgEINGp7li9we21O1TcMlC0U0e11IM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C6KSPN/keIIHHlaXFbDZ3Olp+oW04z7PtttP2RrnAX/COw0Qr/jZOnk881TM5GxaML9f9+O5bY5fDjl90P9LhP7hlyCHldSHtIDIiU6WV/xRYmZlfeAdwHwMz1bQI3nVoQIR8B+iu2S26sIqcpiRQv9vXQvVfDOEf6Cv3R3aAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtgIkwWt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtgIkwWt"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2243803b776so16089865ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743452288; x=1744057088; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JVlYEwRwikuzUOgEINGp7li9we21O1TcMlC0U0e11IM=;
        b=CtgIkwWtX6RiM3VNfB++5xztbUBnfDdaTQE50dluxUvxsdIk5uh4BBxSxdwSDhwnuZ
         DBRGooCPYs+uggYT+lgspqpPanpM6kJYfGIhkYxFXO5cB60in49xdqbJQyGOB4jTVjS4
         lxYsq3xOs58H+B+uKyRgS4Ky7NtHNejuTJTfyrktG8tvimxB7Xhhq6qTU1kkAM+xPpOG
         wb6vmGj0hmqFEjX4yWlNtAaRySQzQ4Sw7AO/ZxUtuavcEs0UdJE8Wn2voBRCmCh2H6eK
         KOUzjRDH5PlVPbnmSmXw/h5V6ChV8AwlJHpMJjSUh1wMt6syHxUCOnSyaboovXwGgLQr
         Zf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743452288; x=1744057088;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVlYEwRwikuzUOgEINGp7li9we21O1TcMlC0U0e11IM=;
        b=sEro+DMixXIAvghHkRYceAZsu1uTsqc4nYpOUL1DcYltRrwOT7i+AogyS8hKV3zFeX
         WdLKcrbT+Dr0t4i9CVlNv33kWNnDGhfdoLICHa2NSKK9q35epGA7JeQY7gXCZrLf25kz
         xkBMJJo5XqjuAAL1GR3t+f1/0pUX80dQ9dh1yYGuaVwML3x9KrmkMJKDj6YsY8LGgvux
         BsHBoOyDzFgd/SlZCDtdrEd6XwYpH63EgnmZXmOTuz4m9w5zYtwS3Nt2g0IQLv0kTa/a
         Vl//prLok0dshhCcaaf6sH1P598aegtwZRewz2k4MHOiFCbMj5r/3ICGfaqsIcpZrSqB
         ey3w==
X-Gm-Message-State: AOJu0YySoNHquc5RmuMz1z/vBCFZuIcK2gnlEhYH4eZCbiDkg/3dAr9k
	M75B5DFgQMaiOYmaxhGZnX7KSMymPTiEEMljak2eLlQgyCsUr2Ijg0YV1Q==
X-Gm-Gg: ASbGncv2vsFPNkXi+OiO6aW4oNb7KgfK9hhyTHzfbHaO+HY5gLW/Ejvfgt/n9KsKulM
	nmN1seAna7wbuUT6lLev40hZPMeumey1JBvErKrxjBziTs4h0eOMx0p4y4TCIR6X3W5a1WfG7xZ
	46qhWYEfLZIztoSmMeGFBMpQ9njQBQikzp+5Hi+CYey4eq3pY15dT7tW7Mu1OSfT1VmJrJJvOT3
	f4YNypO6LRJf9DcfR1eLeZHu8JiAWYnWvkLRD15Ue9vn4YjLAlaXlMKPG/5e23pvU27eLUmr422
	ZWl2n/fZi8dzvprkVSYrlJgZzgx+pNFDUNncOdp9a5H4LCe8Mn88
X-Google-Smtp-Source: AGHT+IGUJDor05Um1vC2mwIPYjncJxW2YYlCdTFw+EIag6NUmgqnyP6NsANvZfV/HzKlsmoLmO8j/w==
X-Received: by 2002:a17:903:2308:b0:223:5ca8:5ecb with SMTP id d9443c01a7336-2292f9f2b5cmr165618435ad.42.1743452288276;
        Mon, 31 Mar 2025 13:18:08 -0700 (PDT)
Received: from [172.17.0.2] ([52.160.161.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710acd6esm7623239b3a.145.2025.03.31.13.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:18:07 -0700 (PDT)
Message-ID: <67eaf87f.050a0220.f9eb8.8282@mx.google.com>
Date: Mon, 31 Mar 2025 13:18:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3410005993155171988=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, metze@samba.org
Subject: RE: net/io_uring: pass a kernel pointer via optlen_t to proto[_ops].getsockopt()
In-Reply-To: <156e83128747b2cf7c755bffa68f2519bd255f78.1743449872.git.metze@samba.org>
References: <156e83128747b2cf7c755bffa68f2519bd255f78.1743449872.git.metze@samba.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3410005993155171988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/inet_connection_sock.h:47
error: include/net/inet_connection_sock.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3410005993155171988==--
