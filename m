Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530CB64A
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015359; cv=none; b=cah8sZmEmB4qPQTdm4Ahv7sF+AMYKHzaH7VzguAClzc5axq2izRuLckvrs+FaZBkGW8PpJYF2efglH33m0fOfZskcAR2Txl4+UWOH5Bg8nBLLEkMTU/kSfOSl/tiRjFaQF/5GORqemr9+18DggRU3wR+q2gFWYKJngngu7RR1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015359; c=relaxed/simple;
	bh=I1+bJdQpgcBXXGzr/UUBAYKK7RwGckn2smDa1H6vsBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq1aVdFKQ41lsny0/etFs1vs04dyr8fUDk2YVW52sT8ybP/yJfRXA1iWDmF0O+nR9i+r6TWChJkch+GS7Xlyy6kuRyGFcMbOlqX05tLh/QgFvJcnQJvU3r9Y6U6unarOyAntxqq5nPxYJEP3ReGaHTtZFa8Nv8LUZ9e8DJrAD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6cdAFTn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6cdAFTn"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3003c82c95cso40031931fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 14:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738015356; x=1738620156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1+bJdQpgcBXXGzr/UUBAYKK7RwGckn2smDa1H6vsBc=;
        b=c6cdAFTn75wsa90tzFQ5PeIgLsmmZPAxFIwnI3yeci/qmfhZxs+9Li7UkrjoA5gyLJ
         0Oo1HKFKlaELJearj7FVNZG/uX8hyaPqfAHkX5rF9DyT+xHSY7PDHkDtEhwXKBuYFN0N
         Ck02qNgAllN5AMLcoDfzLpnMF8ofUrMttCVYyFvVeT8nd482jgck9B3eLzYKRBnbpR1t
         Zutsv37fVQKdNK/MmDjnTo1z6XdCImdYk/vTA46Ld8AWhKdg/uK7xJTvCmPD1CR7AEIm
         PGo2Pr8OlcC6ti+2wtZdoXAn78AG05j/XFW725I7GbNckZiDYJsdWFuoM0H8YkqxDtY0
         e4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738015356; x=1738620156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1+bJdQpgcBXXGzr/UUBAYKK7RwGckn2smDa1H6vsBc=;
        b=f+qRn3nHuxDg6hsqSxb/uqVV/jHnnrpT6k0p9tkQ5uSFKjss9MjP8PHj/cUabtBM2+
         IvEvFw1gGC+Icwkc6sK+gcyCto/68Lw0zBbz492dfNVjJKVb0skboprSDyW0VqvdWHYv
         LTNiB7lK0pZHXpOytHDMBNVYQg8+Jmhg/Ogz9eR3Uh2crr52HQBcIT5Bks6S8hGNf7mH
         TDo8QtKyrpEYgzyMIoVeoSMtZ42UdwNVdBewmzClfXEbsNHtGYZwDsoZ2E6O4gMKQc8J
         Xdw017bWcyruEing4et51GlGgBIqjj285ICq/Peinz1X7MxFsfmI143wZo/4P3UXeBQ/
         uVgg==
X-Forwarded-Encrypted: i=1; AJvYcCWVv9GzSmTaQVGzY598XTf5cM5q8LxN6wmF77gef25OmuY6F08cmtBl/OD/RC6m/p2c5Mr4DSOkI8VYB4ugNWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztbe8mM9iT/OISDB+1uFp0myp8suWn3jXhJDqMc1OmO+YOShIU
	4fq+GLRPsAV4+bJbL8bHViZQR0DD8hOWfwXc6J2mUnPHH1OrXBJRoyxYyYNvTxf0zf+GX3H7PyT
	1dJFpKu4GP382t4mramDISQc835Q=
X-Gm-Gg: ASbGncuH3ZkiDJjaSK55Huf8SD6SV2A4WE0v0FvswptuuqESC8A3vc1k8tbOZA4nN1M
	bEFAkKYpIbkLY/EBwrQcOgYyPFQVA4FgzCEhgJEfhZbTcgere1x7Fhh+iAN1i
X-Google-Smtp-Source: AGHT+IGPMdyNONVdIOs6t7JkKq1bRbkxrOejk2Gl7fEPuX9mhXM3AA90XcoxiFcl6uWr5M8fjHfNm7d2G9wTdtt+1O4=
X-Received: by 2002:a2e:a498:0:b0:305:f546:374c with SMTP id
 38308e7fff4ca-3072cb1eec7mr130824811fa.33.1738015355918; Mon, 27 Jan 2025
 14:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z5aMrXwnmEXxKWkC@vmi2410184.contaboserver.net>
 <452f118f-2a0d-4b54-9285-063ccbe6e5ab@web.de> <Z5f7BcSERmImx0_H@vmi2410184.contaboserver.net>
 <CABBYNZKxhq33FXEb_8LMLV4whhX0jc100tUPYCAs9t1q9_5MBA@mail.gmail.com> <Z5gAJboUiYtDWdSr@vmi2410184.contaboserver.net>
In-Reply-To: <Z5gAJboUiYtDWdSr@vmi2410184.contaboserver.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Jan 2025 17:02:22 -0500
X-Gm-Features: AWEUYZmVMx58gOGRrPhKWC5ETcLbOm9qn2valFz_jR5ACM_O93K6deGk_2G9Jqg
Message-ID: <CABBYNZJKjVC0sb1pBY6bBxjYTiVn6b84kTEB0bHRtG3bZPMhWg@mail.gmail.com>
Subject: Re: Bluetooth: Remove unnecessary braces around single line statement
To: Jeremy Dean <deaner92@yahoo.com>
Cc: markus.elfring@web.de, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

On Mon, Jan 27, 2025 at 4:52=E2=80=AFPM Jeremy Dean <deaner92@yahoo.com> wr=
ote:
>
> On Mon, Jan 27, 2025 at 04:38:22PM -0500, Luiz Augusto von Dentz wrote:
> Luiz,
>
> > I normally don't require Fixes tag for coding style adjustments
> > submitted to bluetooth-next, these are not typically backported since
> > there is no change on the logic or final binary.
>
> And so the only thing you need is the subject/title rewritten?

Are referring to:

https://patchwork.kernel.org/project/bluetooth/patch/20250125165804.11486-1=
-deaner92@yahoo.com/?

Id just include the output of checkpatch and perhaps reword it to
something like:

Bluetooth: Fix code style warning

Subject should be short so it fits on 80 columns, the description can
have output of things like checkpatch, compiler warnings, etc, but
otherwise also limit to 80 columns or rather 72 since git log does add
its own indentation.


> Regards, Jeremy



--=20
Luiz Augusto von Dentz
