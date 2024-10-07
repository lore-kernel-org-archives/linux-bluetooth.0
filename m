Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1092015A8
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728260284; cv=none; b=YWJPoAgV7Zi3kECmmf5hawQnGdAT2izNLBjSHnCA5ts0HjDRScEFFH0LRJVSQJZvfbGZfZ1+4vw4u5vK5O1LTd2G7WYeV8b1YILu9//quZuZ8NhYlXEGRu3SsxqRjElWYrS4LRDnxOfrX7p+eqt5P7dce5C0tri82iNMOygEwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728260284; c=relaxed/simple;
	bh=wCSlnJLeG8nmJKOOT4ChdTKwdM1VlargIBSKWlgVLn4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyfyteZbxsERWqcrs4ZOw/9nlCntuxKqk2vLIGDg2B1VA0izKt6XFvb0I2y8xiM1/I0va2MxgsbsNKfOJpP+FWyVnnjHI2S/S4/MV7pQSDGFZ3Tq3Rkd139oZNzcyx0pn2gvYzClef9ATLgagpnkeH76sK3IVdA9gF0z0KXCbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM8HTo0m; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM8HTo0m"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea03ecf191so727907a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Oct 2024 17:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728260282; x=1728865082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mKU61D2ctOhGCvqkG2pDCamTS6SVWO/Y/lsygjmkc2s=;
        b=RM8HTo0mqA2+u1lxgRXGTUcG78fx/gDqfmGJ6B2roKrfJ/H3k1IwvFccn7EPKpmwP0
         xN0FcAGglq0MOu9jIMO40ek1/uIbySgt6gRcHaVspBPdlJ3KpcZUtX5uVmf47a2mMjus
         VXw38JjIQXeZCVlpKRXbow+6/vfb9qnebZHa40jOHoYbgSR0n2u+m1hqFDtWxuJPMQnU
         qjeERBlgwjGEQb4Yn/r3BryimbOO/VZp4l/Kr1L0wKWxzrnwX3Ftk0LbHvrhDU0xYmIP
         vOFm6qgssvRx3ZgyZd6POFxThtSYno76JokAxjdEocOBaSO0gng/oNJzA5dFnfJKDjZP
         KJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728260282; x=1728865082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKU61D2ctOhGCvqkG2pDCamTS6SVWO/Y/lsygjmkc2s=;
        b=uGGsg7uqI2yTPZ/bTImyGqoT9NVTg+SvB5S8wCQlOnzeZYjRUNrsXC+7o3hoqSgDYM
         Ybpfi+XqivwVSzUMerCQc2MTh6iVWhMNwcuPTUkngswHT4k7RBceSOiMG5fs9Gf27x2L
         FXec7/ocn2YsskfXhQsnQgvzAt4aNGW5jiL0FjWUMtnAylS8dpuZquq4wHbpGe3JMjF/
         yf9KNNejV3hoF6s7VvkIVhOv/o15relXPEJNTHQszfQVORW0WNNk+DHBq5b6BZPr+58t
         XsAhZzGdgZ0HVaDou9wRzTcqJ6iQjOYFxulfWS3NETPBg2JYdVfvnU4gGJv2oLX3rn4g
         p4nA==
X-Gm-Message-State: AOJu0Yy1kQQGd+JIoMg3sdJ08PUTXYWMRMB3IPrD5qmrP4vqcINoUf9t
	MceXBr9GqN+9HFJEY4SPOFqAG+7pFOv3sAlFKVI5TP5Xs6eoZ7t3lOmqEg==
X-Google-Smtp-Source: AGHT+IFGM7xIi20bo9jRqs8EjYZEKYvM4+t4v8bcSQRi3C08NE25Qb/q/r8BjGjPI8gUU5RLdUrbyw==
X-Received: by 2002:a05:6a20:c781:b0:1ce:e080:185c with SMTP id adf61e73a8af0-1d6dfafbe29mr13506265637.41.1728260282146;
        Sun, 06 Oct 2024 17:18:02 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d2f3sm3254716b3a.201.2024.10.06.17.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 17:18:01 -0700 (PDT)
Message-ID: <670328b9.050a0220.66bba.9cd8@mx.google.com>
X-Google-Original-Message-ID: <ZwMotqWoskduBelo@JUNHO-NEOSTACK.>
Date: Mon, 7 Oct 2024 09:17:58 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, bggixx@gmail.com
Subject: Re: [PATCH BlueZ 0/4] mesh: Fix segmentation behavior of Lower
 transport layer
References: <66ff99a1.a70a0220.1fac1d.b37c@mx.google.com>
 <CABBYNZ+waey5srQd23fnUGT_65T2TdF7npmXRo8P+rW+m-B7UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+waey5srQd23fnUGT_65T2TdF7npmXRo8P+rW+m-B7UQ@mail.gmail.com>

Hi,

Sorry, resending with a bad cc.

On Fri, Oct 04, 2024 at 11:16:16AM -0400, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Fri, Oct 4, 2024 at 3:30 AM Junho Lee <tot0roprog@gmail.com> wrote:
> >
> > These is implementations of segmentation and reassembly, except for the
> > friend feature for LPN nodes, implemented according to Mesh Protocol 1.1
> > section 3.5.
> >
> > Junho Lee (4):
> >   mesh: Implement lower transport layer for segmentation and reassembly
> >   mesh: Add mesh conf for SAR Transmitter and Receiver
> >   mesh: Fix inserting NULL into bool type arguments to false
> >   mesh: Add features of Segmented Control message
> >
> >  mesh/crypto.c       |  69 ++--
> >  mesh/mesh-main.conf | 107 ++++++
> >  mesh/mesh.c         | 125 ++++++-
> >  mesh/mesh.h         |   2 +
> >  mesh/net.c          | 868 ++++++++++++++++++++++++++++++--------------
> >  mesh/net.h          |  33 +-
> >  6 files changed, 881 insertions(+), 323 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
> 
> Lets see if Brian has some free time to review this set, one thing
> that might help in the future is if we do some unit testing to cover
> the testing spec, it is probably a lot of work but I think we add them
> over time, with that it would be a lot easier to check if something
> breaks.
> 
> -- 
> Luiz Augusto von Dentz

Thanks for your reply. I agree with what you said. If so, what is
something I should or can do? I hope this commit can be approved,
as the existing code is actually causing performance issues.

Regards,
Junho Lee
