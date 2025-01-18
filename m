Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451B1B7F4
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jan 2025 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737229057; cv=none; b=Gqhmbi/rcL1ElHlknN8dUTRq9/givpK2zk9zVvbGj1gQvthhKwn6ARHnwhFaqPX++blfcFbXX0HCEM1KbHv5vwH10mPhwqlxh797oF5kinUaBm9KWKBAn1JiRADnQlxe1PReO5QvxRySQbO9jcfNpTez7QzCGw6aKgqZLZa3qbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737229057; c=relaxed/simple;
	bh=xO+ZsGmWPGSUQWcyUCNoHEaxCKv5cxhrU9dmBboHbZE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CfWfBBNuWlWO4rMNO22gx339QOaz2JHZczyRiBVPBJiIOdsmzlJgzhL+iW94GZWnzK0En99MhipglcX264218vD71NajKUnHzqe8OpdhZCdSq6jvkAykrHVl27REKhrAYKFOQLa8CrZdRlkzKc26LalGxnSiZ3v+tOgFYJtLuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB+kxlZp; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB+kxlZp"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7bcf33f698dso283188085a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jan 2025 11:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737229054; x=1737833854; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xO+ZsGmWPGSUQWcyUCNoHEaxCKv5cxhrU9dmBboHbZE=;
        b=EB+kxlZpINhad6zdzZLCbVh3t02xgSlyz1kwJAy85dGl31hg2CnlBDeGMtj0xjIcog
         z/YBZ0VamTTReIsR6rx/UlPoR29gof9OVI5tVdXxtnSo3JNfMNrPlE7+vZOn1CyV4HWu
         LPLhFMBwlcWwMBz6qgOAsyuUTkujpXh2erenqYmcGm9lSiGEbDRzaJNHhyhrydWxI/yG
         kY2eclSWZ34JIByhUVn3SGRmIIPnK2WHn4RZscDZQHUG5C5UvuB9LzB6PkFpJhe7S0ec
         eoATysF8lJZUi6vL8iOfYWNWZSPFtCfjRDG1m1zaOIYyPUF7DYQX7zTzcYIdotzVTa28
         CWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737229054; x=1737833854;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xO+ZsGmWPGSUQWcyUCNoHEaxCKv5cxhrU9dmBboHbZE=;
        b=h+2OjD0fh8zZQONn+lAqnjqc43jzU7XpbeEihPQ+xiI97Zph+C4De+Xrw1r34iA22r
         01cOBBPfPvGAWNM2SI9eL/ky3HXr1KtW/YtiXpiX9K8OW/aulE2gAhs80dTAnz+U8dKs
         KcpBtKh47SGSPkmW1yUxOErexWCoxlypWbUFYZEltYy4SvazC+SNZbMHql/DXUWkN8FK
         NIJYUm7mJNAMnMzkIzW5TheEKuJyej6JH3pU9HPTg7OMjPsSdWbT1dgffH4EuL4RQ3BR
         IUFt0zWfbQC4Cr+YBrQPwb4YrqeJuN0HUOg+fMc+KxmC9uKJZ9naAFqb535NaCkavDsV
         SpYw==
X-Gm-Message-State: AOJu0YwgxZGebdbnRsAHcrKOiDFT3Q1RN+OpE7fY7Muv9eEEHLAIKq6j
	q/vfGb2A17Ey8w9aW+T50NsaxBmT3dL0bJvgCkgzK08RyDsV1ySLpZHftg==
X-Gm-Gg: ASbGnctw3x+tHTsy2+VXDdzh+K45njAlYBwfGy3p4L47kLNVa6Zuma/EOEcXvaS6CPi
	X4sFr3phQUes9x4f0oszfHGzvThgyjEICjWLORlkYOa1OVEzriXYxTlzocmG4btPGaSvgzOfshA
	QzV1doU82Qv7vBapDr3QWdunT5JkQv7Z7qUuEHuTZOmWYnCB1oktetpopAfHSfcaMj6jjRfj9rK
	Yw0cVzlZZ25/VoqdCgSoOdixhba4eVnzfghds1uoThk7hxppJP4YJqeErA0hGVqJ5haMsz/w18=
X-Google-Smtp-Source: AGHT+IGJzy3F2725daU+PJswVYx2anbPL7EzVJFFG3SkQC0vv8cOYUT/e6Ws6AT6vCtpqeQgLmFDpw==
X-Received: by 2002:a05:620a:2496:b0:7bc:dc89:3703 with SMTP id af79cd13be357-7be6323b5b3mr1254635685a.14.1737229054386;
        Sat, 18 Jan 2025 11:37:34 -0800 (PST)
Received: from [172.17.0.2] ([20.55.86.195])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be61487e00sm253855785a.61.2025.01.18.11.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 11:37:33 -0800 (PST)
Message-ID: <678c02fd.050a0220.128ee2.b59c@mx.google.com>
Date: Sat, 18 Jan 2025 11:37:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1225669378033771709=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kovalev@altlinux.org
Subject: RE: [6.1] Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync
In-Reply-To: <20250118191205.7175-1-kovalev@altlinux.org>
References: <20250118191205.7175-1-kovalev@altlinux.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1225669378033771709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:390
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1225669378033771709==--
