Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E63976B8
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546916; cv=none; b=p7DYwVchjyyPVwDqN5lZaZ/Mi5WSwHWPe6EwcF5OtqUHU3XEnypYXDF1ZuSBFK/IJbf9vJBgHO1/Ti5vV7o1X53opLQf8XZ/7X0uUT1s9c+RVhR/92qMmZHLxjCJjEMgkodJoZ7OQvF+uT+mP+Njki5EONUrLTOrZsZuFVQOFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546916; c=relaxed/simple;
	bh=sHe1lNhAlMcpLyol52t+666xy/sX7GK5WEIbJSFlqyE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IQghUcogpL/NtxgmYOeU8HtJC1TEYpUcIxF4BWpJmlSOq8y2s4mVSBGABCui8gtMHHei+CaQ9xfxtyd6j+d9cW7xrCpKHGEY99ip+GGyWdK2ZtKPdIxVllVnuGMhL+WbTO5/mZwq1IzEc3XnsXKAE9JdwhZHLuaA/K6hOrjVF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBLjyqND; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBLjyqND"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899a5db525cso9772676d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774546911; x=1775151711; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eJN9UHjJu1zKrDL54JxW3aWpUnAHgPmtq5kVinLJanA=;
        b=bBLjyqNDynRkonXc4+LjT2NhdKCFQIZZ3LNmRcXK1g47tf/SoStJC4Vufual5ilhHY
         FN43FgDk2ahqWCvYYWTzlb3Lf0veVe3N2a3Abq7QYwkpuOjYyhRGMlNLiZpGsSrTJ6d/
         6uRqQvzN1blfULyzzzY0IxjIlfiA+wYq6j3EIlPeEccbr5vkG/4unSTQe217Z+8JCgE4
         ZZEGox9ZL2/FRA7f0MKs9/s3rB16LrQcGPiukSrS9FQNvAgv9Do0s6iE6yC+VZo/0mS9
         puRiiHSnCSCbGSH8+UEthrDNgIKjM8M50Bqq730LRfp7rlpwam5E/DNNb1NB5geekREd
         vCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546911; x=1775151711;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJN9UHjJu1zKrDL54JxW3aWpUnAHgPmtq5kVinLJanA=;
        b=FdWYNjDLbXJGgbOPdhd2Y1ZMgpsa7glGl00QYPpBSJfOvpYfpOkha1xWA4wPTXEF7M
         zVyKVbmcnIVLu+XHeCQBPGHvmzXEFb4dKF2sAEeEnmaCZYqbUZFXZx0RVu+XDnm/zRUb
         O2ui7lmfN9/3TIjMatoNhg2LLEH2wEkVR60f3FOZr+yeOn9CCl9+oxboC6N6aWbNWySZ
         dKBE3+HT/rOfaWZGH5bH8QqWLEV1ALOyR+gXE7xIuTVv8X6dP28tz9AIClPFnxcF9a/0
         tBCUIL1p1arJBdNHtaylSalREIldrNuGzaYyaGoZcROB3+e7J41Cdmx6k8x5WgHObqfU
         ZWQQ==
X-Gm-Message-State: AOJu0YyTkCKFo9jEMxDcKocIlnKN/26pI011GQaddFcWVA3Qx016QjHy
	lPt3e3wDcWibxSyop3ZBm9vC7JRuI33aa+Y96Rmo+6DsH5TQ0roOPTGTQnIeJQ==
X-Gm-Gg: ATEYQzw8UW7TUm71xzIv94ciAOV976g+9MlQgJJlNe9UvtEh2AORtEr9WrKoYSe+9S0
	gPTy5l88TCvcleEb+ThktAcqjT4nNGppETDQitdEwvHLm3FZt+COUoeL1G7y4VjKCxIMNvqZMjn
	W1lGTmm8e3w5jrHconVrR7TdFDAoNqpNeYPRULh6UD+gxyR+j/XbZIUq7ye8lfX2SgMmzRdFelV
	2TpT4gjxhdBKmiH20K5CknTOg8c5RIlvm/FrSj58sq52BolGKGmWBTpgIkIU3WbD5qYzSKyXhel
	9Dx3ebQZfSQwKMlX7s1XdlnD085kWzjbQRr6RcLY8qb5zIHa/3kK1sVoFaihVB5zkvl0cteQ8Yn
	NLfwsh9Wmox47P6wNmdlyrjHcRu4JTtCrG9EJENQyPBy+GmOZcQz2LqQ9fGWXNtY4SbJ/Kf9vdN
	9mvDzrh7f0sMBoQg0My1jRd7e0U57DMg==
X-Received: by 2002:a05:6214:2686:b0:89c:e4c3:dc23 with SMTP id 6a1803df08f44-89ce4c3e7ecmr15687696d6.30.1774546910691;
        Thu, 26 Mar 2026 10:41:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.87.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a6a840sm29356686d6.36.2026.03.26.10.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:41:50 -0700 (PDT)
Message-ID: <69c56fde.d40a0220.14ca62.cdd6@mx.google.com>
Date: Thu, 26 Mar 2026 10:41:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0107221375616717301=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [RESEND,BlueZ] mesh-gatt: Fix JSON files missing from dist
In-Reply-To: <20260326162454.1910916-1-hadess@hadess.net>
References: <20260326162454.1910916-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0107221375616717301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073069

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.01 seconds
BluezMake                     PASS      645.23 seconds
MakeCheck                     PASS      18.98 seconds
MakeDistcheck                 PASS      242.40 seconds
CheckValgrind                 PASS      288.85 seconds
CheckSmatch                   PASS      346.05 seconds
bluezmakeextell               PASS      181.27 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1005.32 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1988/checks

---
Regards,
Linux Bluetooth


--===============0107221375616717301==--
