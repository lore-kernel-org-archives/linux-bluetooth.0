Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5218BC08
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Sep 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381816; cv=none; b=ZPgVw7z7H7AnyyLq0Kx9Ud+mfn+PI+yjhdH8is/WBLKlzwDeki3mY5nT8Aa53mgMn3ExfHV8WBUyglUcsY+CPvfUG2u4P9IgOzbwiM4AoZVf6m8d6AGHfFMiAxGUfKwdvsREpKKk5qLUkJ4LnQ4zyo+FRM21bPQCOqdgk5Mg1Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381816; c=relaxed/simple;
	bh=LjK03t4rQ6X5dEtMRoWcRFBgvr9UcsAbb7Fffj4BiQw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PIWs8cFN0KTzz/TAEZ2bqnFY8hDPOGueeTdpsERmqxy80rLL1mr3TiCu9Og0uktxV0WD7h8Ze/Reblyvs68cGUGQ9XVKL43DGtmJqOwiTSJTRMHveTcZ8QDTWIBnKU1nqwpC8I8Q0qfd0y8CdIJEUqXtU3kAhqer/71sh1mseU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfxIYkai; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfxIYkai"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3df06040fa6so2867251b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Sep 2024 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725381814; x=1725986614; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aseDci2+SS7XBdpdf68N6EtpuhwWQKmWqWnl69J6fBM=;
        b=IfxIYkai37anz3PCFSeUU2VdDxGW/d7dRYcMgbNQO6o84dEUWnb4mDeB7tzYRwandy
         Z5pzqURtVVZEDylxC9CWHMW6D1jhnNTJvPUsidhdkJCV8lAxfxBoOAU8EfbmWVwtdhYP
         37zZs43H5/W+YlNnnl7wVVeAjfnP/YRevn+irkmCaB8zu+UIRmGVAbWH0tk73By/sk7O
         pfv9ZmFZn+4/5z3mF+EP21tQNwbs+VC28bS+qhrZw9nZ1ZsDpPJInSPOQ4YGzy+tLVXb
         8TYSy1vRLf9oon2EPHF9a0AplK8bmNsnJa8zhog9Lj36J1UtTFNcJEx23BCbOvDeLxY3
         mr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725381814; x=1725986614;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aseDci2+SS7XBdpdf68N6EtpuhwWQKmWqWnl69J6fBM=;
        b=cbKWCNgnRfPOG0uBJoMEuJ2lAhNLkqzt6EmJbsTrKkNHV7di6JoOTQI6GMR5fpbk/d
         PrBJ8xC7K61UsiSKOvTjTe9Q4dEc4dvHa6z7N05Ddhwf4df9Ww8mqAoo/eZPenGZWDhY
         25UXOT6AD9XJarwXKAtOznq+KjRC82/1zEFeUY8pxStgPJxPWjBi8fIUXzHSWTeQt8iI
         LhTB1H9/SlJ0pG8+t+FTGH6Dm/oItjoFLv7Pkfl6V0TTHVyPneUyPX8mu99bJ4KudzfZ
         7NYUssp4fbnLzSZ0bJ4tDK2V28+PYXcD7c4Nd8FO3sI3EwDhCM3bx04N/7jDKKZso+PV
         9XnQ==
X-Gm-Message-State: AOJu0YzbMn1kY4Jbll+89FF9jsTAwEqL2bMKYodG4dsZ/A8yPFIrNciX
	Yb56Q5ffyyBgRpw1z+Ux8Pd7PHqekIcT529Q/eA4B+TleZinUamTtJWb8Q==
X-Google-Smtp-Source: AGHT+IFKcZ/sFV9hCugG1fFioZD4m6Qbh1l6DEsoaH6gbkeSAX6Gs17jQ6jvPhiz+vvbCDFwMYztag==
X-Received: by 2002:a05:6808:1801:b0:3da:b336:b2fc with SMTP id 5614622812f47-3df1b81daa8mr12181900b6e.36.1725381814204;
        Tue, 03 Sep 2024 09:43:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.126.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682cef8dbsm51347481cf.57.2024.09.03.09.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:43:33 -0700 (PDT)
Message-ID: <66d73cb5.c80a0220.41ac2.303e@mx.google.com>
Date: Tue, 03 Sep 2024 09:43:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2372693476873917866=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, agx@sigxcpu.org
Subject: RE: tools/mpris-proxy: Add systemd user unit
In-Reply-To: <3548acb9bee2d1d8e0bd8e650a8557241e9e76ca.1725373981.git.agx@sigxcpu.org>
References: <3548acb9bee2d1d8e0bd8e650a8557241e9e76ca.1725373981.git.agx@sigxcpu.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2372693476873917866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=886341

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.86 seconds
BluezMake                     PASS      1731.77 seconds
MakeCheck                     PASS      13.77 seconds
MakeDistcheck                 PASS      185.79 seconds
CheckValgrind                 PASS      252.14 seconds
CheckSmatch                   PASS      354.89 seconds
bluezmakeextell               PASS      119.61 seconds
IncrementalBuild              PASS      1480.65 seconds
ScanBuild                     PASS      996.74 seconds



---
Regards,
Linux Bluetooth


--===============2372693476873917866==--
