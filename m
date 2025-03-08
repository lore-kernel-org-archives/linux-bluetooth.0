Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D3F14AD0D
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Mar 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741462668; cv=none; b=Fwf+2vjVWVx846TMptljvIB01oqn+ijFs5TGj1C2v+ye5e16OAQnorUq6h9GmGdSIWPhsFy6SfPdLuYJgiAfD57qFsIs4vtrdNQeG//DR6EzhK0TDpip6drKPqnI5w06rvAjAzpuxE/NnXLaBJtfrzUM25RShFAcuALn1HnwYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741462668; c=relaxed/simple;
	bh=zXBgGntiCTRp1LOFX2x3yf9NOknVyoV7E/eRgualDJ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FAe+kwPabtbYdVemCrvw5602GnKrutlKoo2nnrBJVNZL2PVxfayVLHlWZut2K4HVu5+XmhhSZwulUWBpiNwQU21dyaj5v9i6zDg6NlqVVQ6z6+xLNwQbbb4EghkeUhnkre1441N0ad8ivTHqF6FvYmy82H1fX/gUKbShT6b2/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp0wj2wJ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp0wj2wJ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f6970326so22489906d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Mar 2025 11:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741462666; x=1742067466; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zXBgGntiCTRp1LOFX2x3yf9NOknVyoV7E/eRgualDJ4=;
        b=Mp0wj2wJGVNI+M8rc2OFMzTt3KHxGl7riWbQ2V04J0XE16T1vDZ9AmmIglrY6GqXTx
         yAcWQ/i82KE4XfV2H6EtjLTJ7u0++HsKxCcVTuBYK0X6n4cmEXD6I/kH2ixemIIv/Plr
         R+FhhGdl/gEwcn/D9Pz7YBPQAKMsepu19E3/qmvJkkM0IQ4PEPr6hIU0+jTSpH7ErfuK
         1xN0bfOU8vY9XW2mYv1IZlBDof93LRiWb2ZL6UCpXdQgu1KPW2fjgxXEMjLr5eRW/OE6
         XWnZQlMABNTKkv3E41qqL1CTUHwR4W6g9jhi2ishsGCebaULFE7mDRTJFD+RJXKn8bwQ
         ckXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741462666; x=1742067466;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXBgGntiCTRp1LOFX2x3yf9NOknVyoV7E/eRgualDJ4=;
        b=NSnMUL5LD5iDIq9uW+aBuPj4gWhKslmTuer4jc77tMQZ4+KI5aixCVhIuDCD6rWkfN
         oH7/u25u9H+Ky67w898FIk1BPLPWJj0LBP1aPeov+CH08FXD9n46Atm+gmDQ4Rpr26P0
         quk4g+c6uGug5fjwLSmXFHB9AD3JGZyMjjOhaJTiXE44oP1PDCvKOqcwcS3AYYaz6oRu
         2oT6nCE/Ii2oWLGpx/H2S6HlmSU/LdmOQKmU/t7Xx0cTiWNKLmR4ZfebPJfEbwSVK/H4
         QiJ5XeblLZ1RRrahFGIt4XlvkPlhZ6lN8hvRWHcmus4sPM59a0C5F4ugErtLYAEkXvst
         hc0w==
X-Gm-Message-State: AOJu0YxQwFtUXmJrFDMG+z6x8rNHoHP2fkICYzMkd0iRoLGpGssM5hpt
	sDuOOXAFjibv2UcDoPePZmjpmd2BuimfvvrleZeevB35retEZIuBT9aWdw==
X-Gm-Gg: ASbGncvRxQvyS0EP008Tow2Q5oKE9gFZVUXv3MwcTudnuvgAeKJ2ybXjXZGv+n2xBJC
	xHHGmavmUJNC8qX6CR8z+k76FXwzc5PvdYbS9to/mJXMTgZ3m2eWEAeG4StYgD3UccLkGJrDpmK
	81g38rBKf4Po9gcW4ecCIUVRL3N1ZVBcHRPQcioixd3U21HdPdNV42D8JG+YmjRljb5cTCbZa1+
	+AOpNWRBP5qWqGzleBtQyuIX42vT1QEFiDQra3hCEsaU9z9vEVQjTAcG46R+7trBa9bck1DCHSI
	APEZlXtKiP2hqy9p3EA9eGcXXbQrYTPPbK8RVjUMpVv6wJbLyOSfvp2SGIJE
X-Google-Smtp-Source: AGHT+IGD6M/9JnJXayiHZJ8FdJOXSPqXVr4b1UCA4+zRM7ATomKVuMxXHcS6yBasM0CXvNbmFs3SfA==
X-Received: by 2002:ad4:5b84:0:b0:6e6:6699:7e58 with SMTP id 6a1803df08f44-6e9005c2158mr111652206d6.1.1741462665603;
        Sat, 08 Mar 2025 11:37:45 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090e75sm33927466d6.36.2025.03.08.11.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 11:37:45 -0800 (PST)
Message-ID: <67cc9c89.d40a0220.5ff20.c9d9@mx.google.com>
Date: Sat, 08 Mar 2025 11:37:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0355090238653320636=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, g@b4.vu
Subject: RE: [1/2] Revert "Bluetooth: btusb: mediatek: reset the controller before downloading the fw"
In-Reply-To: <Z8ybV04CVUfVAykH@m.b4.vu>
References: <Z8ybV04CVUfVAykH@m.b4.vu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0355090238653320636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtk.c:1328
error: drivers/bluetooth/btmtk.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0355090238653320636==--
