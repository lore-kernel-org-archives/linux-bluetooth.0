Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: ext Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] sbc: powerpc altivec optimizations for 4 subbands encoding
Date: Mon, 23 Mar 2009 09:20:10 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200903162159.49487.siarhei.siamashka@nokia.com> <1237011433.24751.6.camel@localhost.localdomain> <200903230851.53472.siarhei.siamashka@nokia.com>
In-Reply-To: <200903230851.53472.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903230920.10134.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 23 March 2009 08:51:53 Siamashka Siarhei (Nokia-D/Helsinki) wrote:
[...]
> For it to be ready to be appied, the following still needs to be done in my
> opinion:
> 1. Add '/proc/self/auxv' based altivec instructions support detection at
> runtime, this should work for all linux systems.
> way the same binary will be usable on which are conservative about the
> debian

Sorry for this unfinished gibberish typing that slipped in.
Translating into a "human" language: most distributions like debian use the
lowest common denominator target cpu options for binary packages, runtime
altivec detection will make sbc altivec optimizations work fine there without
any extra hassle :)

-- 
Best regards,
Siarhei Siamashka
