Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100901021140w7211d8e5r8e59316592951497@mail.gmail.com>
Date: Fri, 2 Jan 2009 16:40:48 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200901021833.13342.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812311803.45279.siarhei.siamashka@nokia.com>
	 <2d5a2c100812311255p2d10b74crc31ff3211ca1939d@mail.gmail.com>
	 <200901021833.13342.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

On Fri, Jan 2, 2009 at 1:33 PM, Siarhei Siamashka
<siarhei.siamashka@nokia.com> wrote:
> On Wednesday 31 December 2008 22:55:24 ext Luiz Augusto von Dentz wrote:
>> I wonder why don't we use liboil
>> (http://liboil.freedesktop.org/wiki/).
>
> Can you clarify your proposal a bit? Which functions/implementations from
> liboil do you suggest for use in bluez sbc?

Liboil stands to optimized inner loops, that exactly what we need,
transforming the whole code will, already is, depend on each simd
extention to be implemented. What we basically do is multiply and
accumulate arrays, what could be done with:
http://liboil.freedesktop.org/documentation/liboil-liboilfuncs-math.html#oil-multsum-f32


> Or do you suggest to submit the sbc analysis filter function to liboil, add it
> as sbc dependency and hope that somebody would translate the code to the
> instruction sets of other architectures? Will it turn out to be beneficial?
> IMHO It may easily become just an unnecessary burden and wasted effort too.

What about if there is any other codec that might benefit from the
code we are producing, Im not talking about the whole sbc analysis
filter but the inner loops.

Also read careful what liboil does, there is a whole instruction set
detection/benchmark system very similar to what you have proposed for
choosing implementation in runtime.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
