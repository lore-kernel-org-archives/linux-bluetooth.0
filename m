Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601FE4BD0EE
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446451; cv=pass; b=fTO6tOZZA+mQ+vI0cXbiWr4HtcYE/3c7/UT2M/JzykaMY16v8EmJmXJNVsnYAVLjW6QQySSYUBZAisuSpqixNyb+x2LZ3SeIxj0C9OPo4ev6uydIf9YVwFb7vbUgHUGVkZP+FzbpwBchy00lUmsnNo5kfNpVhKdbMVH8yW+GIHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446451; c=relaxed/simple;
	bh=DMcoFPAWdEiA47YKBPP9R2w1Up2IfyxuLdA+slJYpIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHlXp1wRIrAyxby86R0CVvp5USmgc1ZjdrkOFjgM5sWoxLZBeEDEnvHUe/RndUlNfWQg/+4RSf+Djixa7bWXR6d0vvO8WXe9CZ7D1pC6SlorPT+TUwDkC2na4HfQMQj5YyWNVtGGd2DM4afsd65X9umRoXCmuFItnLmDSVvwkvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvz++bd8; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvz++bd8"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-86b03b75fecso37661887b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 07:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446443; cv=none;
        d=google.com; s=arc-20260327;
        b=agGQfY+/K2T71EuEU/HTuJFSn0N94bmpa+g4vsRKTjhmSOJi1UJTt8Szf2x2mvpnVR
         C1z10PkRwGARgKgwqvPD8+koeR9K3q/sBnT8PaNaWCQlm04CPOyhFkfhAOJZ+UOl4CUi
         Y7hMz07Eb5psS4/edfTIPEwufPeXWXbBjkn8xRsvaI+aZWzFiV1vmvh4QV4FJo7YqWVt
         7nYuSGB+qd0OhsmSx7X9AhXyB85hRvHqE/OHUIvofIZW75kB2tC5eqOBMkDeCSp7Cexs
         TgVMlaLMSfBUakTnRF6h3WJdbI/aDgo2ygheYEz8oXI1lKsTpR7MALK6CeuaBGvlByxk
         poYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DMcoFPAWdEiA47YKBPP9R2w1Up2IfyxuLdA+slJYpIs=;
        fh=gXL6+ZkU3qp2DomgCo4h7NrdT0+YI4jD5mY8nRrun/w=;
        b=OxiqzBD1MvBXW+dWjqkOl8npcMRiK12DB5hl993EStr0WvdIm7M8QIJMwn+GbCrrig
         5BJ2ca+sjs9r8ejXgJjsrz3i0QCxNvlPROO278gsbcGQGg10cac/BNWVlSulyaxXbJwz
         x70ohRKCPUCcmu9dG6qO6d/e/EZ9sBlSciDou5fyOHnwIlcyO2cuv6jMACDk+oMHi7v8
         Ieco5PeyLSyGNus+VQkRKG84ZFh9SpcdVk75U5RMGdROdALUBs+tj8imVid088vvtUdK
         AcrnfxtM/Z6twpuwuVhEklCv86wMi+jZl1HH0fFgEjJNr89r+AB1Q6RbZI7zHHii3Iwt
         mShQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446443; x=1789051243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DMcoFPAWdEiA47YKBPP9R2w1Up2IfyxuLdA+slJYpIs=;
        b=Hvz++bd8+eYQunNClH2gjduGXicxU7Dxf9RUQf91Lt7mmlCNFJBKNsC5TXFqAX2ksE
         KwP1DHKm0mpdNGAGNJgcDLmvLxrAf8KvNg2+oUqTjO7nSEKVjyJReCI4gAaHwfbYUSAw
         IHvyXLBr7UhhT2Q/4PCFEwo61s+0zXpm/p/2pUaMJq0IPc4UM7MZwd3YSqeS2IvhN2GF
         Cr9xZTW2ewL2WfKNfI85Oi/A3HRcMpQWKz9ST2POrBj7DvX+fQSd9K0WzFyGfhd85tt+
         eFZnM6vvgMEv1YHJAgHzmOML+iF1b+rgvY6mA3M0wUoEkS1iHy02lpQbNvuYBxYhiDRP
         X5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446443; x=1789051243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DMcoFPAWdEiA47YKBPP9R2w1Up2IfyxuLdA+slJYpIs=;
        b=C+EEfapag+Gd22w1qH/P1XWSkmku7qqvPaVUWMvfpwGO5l9AfhAceyKbfxwprsGOs2
         sgmuVzaCdae8ypY71f4lQ3KAOGFIvnQS2LQaRAYvuxzdD1foFlJInja9GF/BV1zYQEgM
         g7ivAb/BalTh/l44Vh539fbR33rDkFeVU9Co71hDlEsubcLkJqNQJye5Gh9iW6n0BUWn
         5FUEBhQG1cxdga+jY1cC4G04W2gBTWUJni05mXHMMhArR+PRz0P3ZhCh20ppmybQjaX0
         wpD2sHOfo/6A7/cFLwMy2AXnZAHl01aQUnRp6OSDY1/tdkztsacJvj/tXElaRYzBcW8Y
         n9bA==
X-Forwarded-Encrypted: i=1; AKwUvBxtMy2rSPOPSF5Wr7AX1HJPZsX5iUSx+GmjEXl03L6LVe6Ep2YYrv7e5cQn46ihbwPg10Jbidz05sr2ZgE9XKE=@vger.kernel.org
X-Gm-Message-State: AFuF++kprRtZjeZB5ZuiUI+iTy6M2Ejr5VhrBYmIw8dOuNuKoxpE6P1a
	AL60g9TOVB8B5jDK/ARNFxL6HtBnMk0h+1w9PFP+hC5yxX3lj69GYBRRLyCp+hmmtqZpdxqyT9r
	Q0djtHIGVwvwyFP/fAi+98wFktI5o4Eg=
X-Gm-Gg: AYBFou0ZZZNioHqOUlSkUclKmJRpvusurRAlJVmE0rjJ1s1RSWhzcOm/qBRcQOcz1og
	whJkXLd5Lu5uox4kjivcqrL3yQF0L2SybvAKJ5+x0g9+EmLyybdC3xp0G0WLQff/ZBZAKN+xZrk
	IgaoRkuFqKSTfUHzk7JMwCMKU8sDWEtI3lMsOs0cCTcib1ROxNpeWqbFzNkK17uFffB7qaMBJ9G
	apnrerxR90zXBUjt7PbrMhM9Oj2ZL+fM7KesKBpa/lrAjwMp1E6uuIaZeaJbs4BFGwHymJZACp6
	NkPk6XfLoMv4PiEgHir6Mpmksy1vANhCi/Pagh5IiixXJSrmv9rXS5VnPyRsKiQV99NKziPuuKn
	bsz/Ka3Gwg0BFiQ5JNJA+wzUq6C632Y8=
X-Received: by 2002:a05:690c:e211:10b0:80c:5ce9:8f1a with SMTP id
 00721157ae682-86c54b242fbmr50652107b3.34.1788446442940; Thu, 03 Sep 2026
 07:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5be7vkmpzmizgmvqxyefubgi3epnlo2uf7mabcgsapvia4ckpm@ixwfppk5z5e5> <A4C1EAB3A67613DC+20260903132714.2538118-1-raoxu@uniontech.com>
In-Reply-To: <A4C1EAB3A67613DC+20260903132714.2538118-1-raoxu@uniontech.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Sep 2026 10:40:31 -0400
X-Gm-Features: AcwNN1W2_JiObyW5To0IffDILn7tLdHOJXWxugOC4ExywC4Uofa9xPpYfNG3_Bo
Message-ID: <CABBYNZL2QcodKofLFbHbDJZBcjA+mRDSYi2QFZ_XvyphJYg_yg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btqcomsmd: destroy RPMsg endpoints before
 freeing hci_dev
To: raoxu <raoxu@uniontech.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, brgl@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xu,

On Thu, Sep 3, 2026 at 9:27=E2=80=AFAM raoxu <raoxu@uniontech.com> wrote:
>
> Hi Luiz, Marcel,
>
> A gentle ping on this fix.
>
> It has already received:
>
> Reviewed-by: Dmitry Baryshkov
> Acked-by: Bartosz Golaszewski
>
> and the Bluetooth CI passed. The original teardown ordering is still
> present in the current Bluetooth tree.
>
> Please let me know if any further changes or testing are needed.

Please resend.

--=20
Luiz Augusto von Dentz
