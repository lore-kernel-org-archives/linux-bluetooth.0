Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200911051322.18130.denkenz@gmail.com>
References: <200911051142.31929.denkenz@gmail.com>
	 <20091105185232.GA27336@jh-x301>
	 <200911051322.18130.denkenz@gmail.com>
Date: Mon, 11 Jan 2010 19:35:48 -0200
Message-ID: <aa32413d1001111335o50255f67wc4d044f828da50c8@mail.gmail.com>
Subject: Re: RFC: New Handsfree Client Role API
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Nov 5, 2009 at 17:22, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Johan,
>
>> > Properties  boolean Connected [readonly]
>> >
>> >                     Indicates if there is an active connection to the
>> >                     AG service on the remote device.
>>
>> In addition to (or instead of) this property we could also have a string
>> State property which would also communicate the "connecting" and "playing"
>> states. This is what we have for some other interfaces and it has proved
>> to be useful there (not sure if that'll be equally true for this new
>> interface but it's still worth considering).
>
> Sure, updated.
>

I guess you forgot to update the property name to "State", making it
consistent with the audio API. BTW, is this the latest version of the
API spec so far, or there were further discussions on that on IRC?

-- 
João Paulo Rechi Vita
http://jprvita.wordpress.com/
