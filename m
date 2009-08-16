Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090816173529.GA9132@jh-x301>
References: <1250390653-476-1-git-send-email-jprvita@gmail.com>
	 <20090816143858.GA4896@jh-x301>
	 <2d5a2c100908160938w55475cabm7a23c34258f7de9e@mail.gmail.com>
	 <20090816173529.GA9132@jh-x301>
Date: Sun, 16 Aug 2009 14:51:53 -0300
Message-ID: <2d5a2c100908161051n6604ce96wbb9acee6356df3f@mail.gmail.com>
Subject: Re: [PATCH] Add support for the source interface to audio IPC.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2009/8/16 Johan Hedberg <johan.hedberg@nokia.com>:
> Hi Luiz,
>
> On Sun, Aug 16, 2009, Luiz Augusto von Dentz wrote:
>> > On Sat, Aug 15, 2009, Joуo Paulo Rechi Vita wrote:
>> >> а а а if (!interface) {
>> >> - а а а а а а if (dev->sink && avdtp_is_connected(&dev->src, &dev->dst))
>> >> + а а а а а а if (dev->source && avdtp_is_connected(&dev->src, &dev->dst))
>> >> + а а а а а а а а а а return TYPE_SOURCE;
>> >> + а а а а а а else if (dev->sink && avdtp_is_connected(&dev->src, &dev->dst))
>> >> а а а а а а а а а а а return TYPE_SINK;
>> >
>> > I think the dev->source check should be in an "else if" clause while the
>> > dev->sink check should be first. I.e. if a device happens to support both
>> > roles of A2DP we default to dev->sink.
>>
>> Good catches, perhaps we should consider doing avdtp_is_connected
>> check before checking for sink/source pointers. What do you think?
>
> What exactly do you mean? Could you perhaps give an example code snippet
> of how you'd like the code to look like?
>
> Johan
>

Something like this:

if (avdtp_is_connected(...)) {
  if (dev->sink) return TYPE_SINK;
  else if (dev->source) return TYPE_SOURCE;
  else...
}


-- 
Luiz Augusto von Dentz
Engenheiro de Computaчуo
