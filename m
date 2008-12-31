Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100812311255p2d10b74crc31ff3211ca1939d@mail.gmail.com>
Date: Wed, 31 Dec 2008 17:55:24 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200812311803.45279.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812311803.45279.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I wonder why don't we use liboil
(http://liboil.freedesktop.org/wiki/). Since we can't keep
implementing, or don't want to, optimization code for each instruction
extension around. Liboil detects which implementation is faster at
runtime and there are many other codec implementations that depend on
it, it actually makes a lot of sense to gstream and PulseAudio which
already uses liboil. I know that means adding another dependency to
BlueZ, or perhaps it is time to make libsbc a real library?


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
