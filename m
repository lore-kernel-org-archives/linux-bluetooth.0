Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 14:00:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Szatkowski <bulislaw@linux.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gobex: Fix setpath to match one from OBEX spec
Message-ID: <20111116120043.GA3873@x220>
References: <1321368294-29379-1-git-send-email-bulislaw@linux.com>
 <CABBYNZLMKiRjuc9de0g_26PW=OAmAgJfOSRaCFMHBSPSHjbnig@mail.gmail.com>
 <CAPGrrxWX2VupSpvh+sz57mdagCXExtkM5r=dHVAz0xQLnqwz6Q@mail.gmail.com>
 <CABBYNZJ+vzT5Sp_pJyHWaO-=5N-wGgFmphSc4aphykaHchBXqQ@mail.gmail.com>
 <CA+i+Aw2UJMhfegpB3Odmzyhv9khYKtt-9tJzX1Y2kXDqsgCCgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+i+Aw2UJMhfegpB3Odmzyhv9khYKtt-9tJzX1Y2kXDqsgCCgQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Slawek,

On Wed, Nov 16, 2011, Slawomir Bochenski wrote:
> The function itself is quite useful for MAP clients. There is this
> fixed part of directories structure in MAP, which is:
> 
> telecom
>  '- msg
>      |- inbox
>      |- outbox
>      |- sent
>      |- deleted
>      '- draft
> 
> There are no messages in msg, thus going from e.g. outbox to sent
> directly seems convenient.
> 
> I do not understand why you are so reluctant to have function for
> setting path in gobex that actually offers what OBEX offers. As I
> mentioned already in discussion about MAP API proposal, this also
> gives additional restrictions on what characters one can use in folder
> name.
> 
> You at least have one example of profile that could have make use of
> it. So it won't be in effect anything that is not used.

I don't as such have anything against the possibility of supporting a
"cd ../foo" operation through the API, but the way that the OBEX spec
implements it feels like a hack that's been put in place as an
afterthought (they thought they'd get away with restricting path changes
to one level at a time and when they realized ../foo might make sense
instead of extending the name header they added this to flags (I don't
know if this is how things actually happened but it's the impression I
get). In OBEX 1.4 the DestName header was defined to tackle this
shortcoming of the Name header, but at that point it was too late to
have SetPath use it due to backwards compatibility reasons.

Anyway, there's no reason to expose this ugliness in our APIs and we can
still support the feature by allowing the application to pass "../foo"
as the path name.

Johan
