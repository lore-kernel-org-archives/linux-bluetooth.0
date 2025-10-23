Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401BB1DF99C
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244735; cv=none; b=mWg0pCANAkMdatVTW7fLgao+x2zkjnvGp9ceB5IV0E+T60ffqIIbzTojDtQpW3YCackdcLfSM3PetYWzzF0RWBe3NOXITs/zGoGNeYTJNihYLjNbjM5Gap55x+YWBJudwfZx2x9Na54NCyRZ0u/+jm052RPQ8LaZKvWyL/FDXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244735; c=relaxed/simple;
	bh=IJz322Dk2EbU9jOBpCOHtD/vjWDkx0Y4Ic75icLEf7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfdsap42gqxKa5Ef7MVdjg0d+FyNSsreZyQ7u0A0npJdXAEjiOnYImSDRDOaQG2kf41gNNzX1Zy3Aq9CfyZ+NhveG5YQNnohL7tiQJGc9KF5zFrSX0bwKW8XI98VRkesT0/tD3tGvB9/PZNQjXxa9x8jFyM5y1lcTWYxPdiSgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=cHT93CGn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="cHT93CGn"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so895640a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1761244733; x=1761849533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJz322Dk2EbU9jOBpCOHtD/vjWDkx0Y4Ic75icLEf7s=;
        b=cHT93CGniYOkAK5Zk/I6FxHqgr8b1cCatB7WB8/ruwecUfO8CMsd4t9mdHxGlM3/oq
         lmsRz9jYCn31HY/qeBqwqf/fF6IHhlJTFmZMwQLuyMHIh58+fEnFIWsIB4U22xMimSyh
         ykEt4IWfXZC93j2NMTsL0abj6FNxw/5EBHw+YzniLdwMUfjAiFy18AfBlrXlat8/SWks
         l3v5foR0x3ekjxeCHGp2XTdGgk2IgWrCtsp7kmx7fDSBC9kqDpTaiALlt+0vbJNliCKm
         U9CjQsYeozGTiUfkwF7Fz49GZM0QHnTPPV1fwL7ZeAMyKM/VP9x+Iw0S+ZW9dZmwW6XQ
         HCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244733; x=1761849533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJz322Dk2EbU9jOBpCOHtD/vjWDkx0Y4Ic75icLEf7s=;
        b=fQ2koour6EyNgpVJuJugkjxjDjaov5b5wUypn8atI33LY8kfDRjx3bIIsNiVu0HPIp
         D6KhZgi6yGPsY2vNTe8bRFGGJphBexnNrJIPrk+Jfo7EYBawkXzpjiI0TXd2KmR7x6YY
         osV3uzt4v4IxyaAe/MtT6g0zmDKsi4s9V1FsvriZ96tx5ih9d1eIpEuR5T8gEeeTvXjm
         CfYw1RXflzW0Q09lf7XDYxP8WI28LXr6rTQxit5cqD9uiQa4ESkkBidgO54pSnKlvXCI
         9irJvIF2fGIjPoQmsNjRg9EWIRdwcVM1HBwedr3EiR6O52ZMepG6IaCxnEsAlitKs/BV
         fd0w==
X-Forwarded-Encrypted: i=1; AJvYcCWi5EsZhJq4BgBDanbFlcA8MsTQg00odZ/ER2mRc6VfdAI1HSGaABH//HeJhfm0jxkaUwe0xfD776mYHGfMObU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo5qSsPulWtRWSX3QKrhGv5GML3SLSoGCp3gMP9d5xbqQ0mInI
	Tl67yiQgfAIHM4oBFMCCdBbWUcocIrhE9aTdBzKiqaFgjD9opFFoWBMGVbuFzBwj2ys=
X-Gm-Gg: ASbGnctNVjgbRh92pJM7w6xVBjSIRZoLL9c793KOUT9ImmkwEinVhMoEMyqnybmKklr
	0Eb9Vq47yhdqgKv0CPqMVgdUtMGjMDrZ5IU5qRQtvAluTlIWGVmHTFF++ND415o1mf8xYqjuTp0
	awjTZFNhxrSBqybUY88yrMYLaE+y5LKTDhCZW4aJ/bk8aknXKopQJRLXPDzZt6hq6z/pG14cK0Z
	woPOq17d2+V1ujhxM9opaCJT+vpKJIMadqZUfS607aTM7+0btvUzabM3RUalo5M83baJdh/7wns
	0u8l45TqEt9gcFgdrDcuWqLn29Srrb5DNLRSuRv4zMY4RtyPyo++wOVZX5PE0du25Sz4SekkgCJ
	BiUSHB/gWGDRQDbM/jhnT8GnGlPA5jXXj5HAOVEO9ascLPZmHeDcxiNb5A9O48gBi/I7ANz07I+
	BqbvrOqaOJqX3a
X-Google-Smtp-Source: AGHT+IHv4EEmGzJ6qdnkG0U4M/t1i0Oxb27fs6YPyYXb02bVmUpsxYKcjyZyI1rde0buij6ZTIgCWA==
X-Received: by 2002:a17:903:1a4c:b0:267:ba92:4d19 with SMTP id d9443c01a7336-290c99a8ed3mr313633845ad.0.1761244733473;
        Thu, 23 Oct 2025 11:38:53 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de105b1sm30862925ad.49.2025.10.23.11.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:38:53 -0700 (PDT)
Date: Thu, 23 Oct 2025 11:38:51 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Francesco Valla <francesco@valla.it>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Erratic behavior in btnxpuart on v6.18-rc2 - and a
 possible solution
Message-ID: <aPp2O-H55h4IJOFU@mozart.vkv.me>
References: <6837167.ZASKD2KPVS@fedora.fritz.box>
 <2569250.XAFRqVoOGU@fedora.fritz.box>
 <aPkCZ8l4-5ffyiAe@mozart.vkv.me>
 <1982590.7Z3S40VBb9@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1982590.7Z3S40VBb9@fedora.fritz.box>

On Wednesday 10/22 at 22:35 +0200, Francesco Valla wrote:
> On Wednesday, 22 October 2025 at 18:12:23 Calvin Owens <calvin@wbinvd.org> wrote:
> > <snip>
>
> I tested this on my i.MX93 FRDM and I confirm it's working. Can't say that I
> like it, but...

Yeah, on second thought I agree, the cross-driver dependency on drvdata
is gross. But I think I found a better way, I'll send a patch in a sec.

Thanks again for looking into this.
