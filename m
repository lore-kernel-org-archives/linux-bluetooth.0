Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B51F1936
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628437; cv=none; b=BMFA3kkj2fkUFSDXJXZuMVmOfVVPtvHHNep9jmj6FYKsMfEpx+QiX5RL//wqkFLsvTfzcQDARnVBv8hfkJ2QMYKbU9M3D4fkGdfNBGkDEdCJaXfJStGv6U7EtkP4/jTXj3EJVEFDR97cewYuX0B2Dm4Y9vYEW9RG+8Z9yjLm+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628437; c=relaxed/simple;
	bh=yMtg/5bd9WuFFPh1QUVVbVzPyQ8PxgEFM//QPDYEqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJVtaQ8XCzJiqpxkXUCieCJH8Cpx17of3y2M0ksy8CVbM5GP/nZXBAhYx4EUEDQ1qj7ytA5l6bxMXd0Zq1DpkxsXZaRZiIcjdVA31Z5AV0laV89dOuyAjWVtnw5VFCZHq4paIqs53iDE11NNdEVM1bqz/L2QtQPopkiPEJNBK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bfa+LuvQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bfa+LuvQ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf3d64849dso27815166b.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Apr 2025 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743628433; x=1744233233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=bfa+LuvQjO3wNd8nBCUqIbk6+pcQsTgzXgHmwBahXEwzn8lBhcyuoqun0TIfkKGiRO
         dciQvgB3992UIyabIgVrBpfSXwB6FpXE92UbVcKum7M9LMN1dgyKKcC/qe0fxhZYYJNK
         h180Glb2pJWuyT5ZRJNzlKyrYuqHFK0giRl7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628433; x=1744233233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=YMgUzY8kA3fQ5Sygvuls8cveMpLuZlHWPMUTaZlZq//wq/xRhf40OXMA73flRCUxjC
         dt6rP5jizAOAJ0ULCbk+tEg/lzXxYuU/f0nzap/NMLPXqToqw9brfVgvTBz2X+WVe68A
         07Ab3GPCMZ8aBfU9ddPjv7tsjIkz/PAGw+j5oDpsXnZKxp0gVRDoli8D859lMaHu7gCw
         SaG1guMVXUGBIsPThjoUPcbuQUyuOmwZ/gfp0pH7rgq+ugH43dLk/+pabxYbdXrFppFX
         CCzm73t1JRCT19WzrwlIqrKD3YaxmOrUHaPNgEEO8gviX4rFE4CalcRb2Td2AmJiwrdT
         3Ygg==
X-Forwarded-Encrypted: i=1; AJvYcCWVdU/xtR8p+MaRAxKNWbN47H8HPq24IpnxKbhKxUsx4phIStNbNVtP+Lk3J7jPdqGbVDwF8nlv05SomkIA9rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7c/m7JCmrMugz+HwKUZyuf1pyoYjQL/MOYWVNjXTJmoaKGbX8
	YkEesFBZumQ2jpd0DnA9aNfKSNjtykXQrmZVSt3mSupHf82UPMvK1TmWxodacvNVAA+sFfQ49vz
	IezgETg==
X-Gm-Gg: ASbGncswujGmlx6Rn3Ef/7YgRbLaEImF8YJz2S2EEVZQ46Z5j4RwWEqawcVQ/2Bghgq
	5v+0TtVfsGpnP+DXEozCe5JxmR0QEK0muU3wYLJMhdn68eP92s3JbL6leg0NgYefFlbJi2l1hhM
	rp6IDNqZwLy4zhJsEqXU78G5HEP+xZW/94MBYJ+JCRrbS1eT/ERuJyOoWdCugh+vISucG6/eK3N
	aFHhp/zdG+esGkG9+xM663fS0fuWFOOQYcTFavftnfOuE/XcjNlFKC3EPCiENQP7+R4LAyNGM07
	shz3SrbprpSt4hw0R1AOU0ApB/DJl24+ywFWFX0hM/s3bEqaSZfH38p13yAqgjO+Loncot3Z77M
	rpkG1/LWQT3fpYjGWIzU=
X-Google-Smtp-Source: AGHT+IFJCtPgmZKwzYwd4MCyA/hEPiTc1HHdIh2u7kMtzuV9TPpV/QoOyyfGIN38m4MmWVShCU4WDw==
X-Received: by 2002:a17:907:d86:b0:ac3:121e:f2cb with SMTP id a640c23a62f3a-ac7bc03af5cmr21371366b.1.1743628433184;
        Wed, 02 Apr 2025 14:13:53 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae6fsm8942230a12.16.2025.04.02.14.13.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:13:52 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac298c8fa50so36295966b.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Apr 2025 14:13:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVygVLUIjf4m/tKZ8xCxixREBYY9VPrKfE7FB9Lx1ddBIH+qtVIFGBJzEAyc3K/uzPKHxHn06oSTZSDeLq8mQM=@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-ac7bc126208mr19593966b.27.1743628091735; Wed, 02 Apr 2025
 14:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-sDc-0qyfPZz9lv@mini-arch> <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org> <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com> <Z-wKI1rQGSgrsjbl@mini-arch> <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch> <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin> <Z-1Hgv4ImjWOW8X2@mini-arch> <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <20250402214638.0b5eed55@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 14:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
X-Gm-Features: AQ5f1JpKVAIlc4pALP5yKNCr8F3ijIqVBIOCCdqoIfNZomenel-ajZbKWJ5EdvE
Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Stefan Metzmacher <metze@samba.org>, 
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The problem is that the generic code has to deal with all the 'wild stuff'.
> It is also common to do non-sequential accesses - so iov_iter doesn't match
> at all.
> There also isn't a requirement for scatter-gather.

Note that the generic code has special cases for the simple stuff,
which is all that the sockopt code would need.

Now, that's _particularly_ true for the "single user address range"
thing, where there's a special ITER_UBUF thing.

We don't actually have a "single kernel range" version of that, but
ITER_KVEC is simple to use, and the sockopt code could say "I only
ever look at the first buffer".

It's ok to just not handle all the cases, and you don't *have* to use
the generic "copy_from_iter()" routines if you don't want to.

In fact, I would expect that something like sockopt generally wouldn't
want to use the normal iter copying routines, since those are
basically all geared towards "copy and update the iter".

           Linus
