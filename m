Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34A92
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Nov 2023 02:51:38 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40b34563987so10150925e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Nov 2023 02:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700823097; x=1701427897;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ogd7GN1vg+Upqjip0Rft01VeOWU+5iGppBA5JPoIqZQ=;
        b=UljT8A2vW1JRVPQUxcg/PPuwX7X4jjcj2PvqnN+pof9Jw0joB+YeRgFmJGS1WbACAG
         JjGCGC+lwKMfLmE9rUUhCiRclIcFss+Jq6NN6UF1wZHgPO+XB9oOYjIupPP6OE89osu2
         1L+3Wgr4WYdJbmyTueFOg3JYL0R+Z3dhISkiBuG641OwvtUYmK1Sp3WpPplkxNTAqMIS
         RIKOG4AlsXF0L/LtxbeAL3ZwpMjw/WTaSR7wxXVQnP4Lqwp3MqKpGCe3dLkp/HNdS09P
         JMbi8brf6bzndeHXMw44kQIY7HCxScBAsTPiEkOQyCDHca3CKNFdJ0svjg8dS9yIJDny
         XIhw==
X-Gm-Message-State: AOJu0Yxt4Aczw3LdyH23UZu4cqerVgz5y6Gir8pMP6nKLIg0StDcWng0
	ff4LJPPpzGQqbhNIky+EE5NXMA==
X-Google-Smtp-Source: AGHT+IGHfeZKdJJqlPCm2t3mOYCGRNlNcPvWNipyvQ2dkcF62oHB6lLBq5eJbk6zUcbv5Xbx4Ymk6w==
X-Received: by 2002:a05:600c:6d3:b0:408:37aa:774a with SMTP id b19-20020a05600c06d300b0040837aa774amr5037413wmn.17.1700823096844;
        Fri, 24 Nov 2023 02:51:36 -0800 (PST)
Received: from xiaomi.filo.uk (lewi-26-b2-v4wan-163478-cust641.vm4.cable.virginm.net. [86.21.74.130])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b00405c7591b09sm4700636wmp.35.2023.11.24.02.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:51:36 -0800 (PST)
Message-ID: <5613fd0da2fec32af714529516b7b66f3d3b02ba.camel@tlvince.com>
Subject: Re: MediaTek MT7922 controller crashes after LE Setup Isochronous
 Data Path
From: Tom Vincent <linux@tlvince.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, pav@iki.fi
Date: Fri, 24 Nov 2023 10:51:35 +0000
In-Reply-To: <CABBYNZLohR+5BXJVGQv4CKDZ_77f+epZrRbBvrfgpFpLu2_C7g@mail.gmail.com>
References: <38cb99f2b63dc55763e9e2c8ae4d4cb14afc6770.camel@tlvince.com>
	 <CABBYNZLohR+5BXJVGQv4CKDZ_77f+epZrRbBvrfgpFpLu2_C7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hey Luiz,

I've heard back from the MediaTek maintainers listed in linux-firmware
and they confirmed this adapter doesn't LE Audio yet, but they're
working on it

> While MediaTek has made progress in LE audio on the MT7921/7922
> Windows platform, we have not yet officially declared support for LE
> audio on Linux-based systems with BlueZ.

I'll try a AX210 in the meantime.

Thanks!
