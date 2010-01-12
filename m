Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <aa32413d1001111335o50255f67wc4d044f828da50c8@mail.gmail.com>
References: <200911051142.31929.denkenz@gmail.com>
	 <20091105185232.GA27336@jh-x301>
	 <200911051322.18130.denkenz@gmail.com>
	 <aa32413d1001111335o50255f67wc4d044f828da50c8@mail.gmail.com>
Date: Tue, 12 Jan 2010 11:31:51 +0200
Message-ID: <2d5a2c101001120131m18b87878t63e4966f264195da@mail.gmail.com>
Subject: Re: RFC: New Handsfree Client Role API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2010/1/11 João Paulo Rechi Vita <jprvita@gmail.com>:
> On Thu, Nov 5, 2009 at 17:22, Denis Kenzior <denkenz@gmail.com> wrote:
>> Hi Johan,
>>
>>> > Properties  boolean Connected [readonly]
>>> >
>>> >                     Indicates if there is an active connection to the
>>> >                     AG service on the remote device.
>>>
>>> In addition to (or instead of) this property we could also have a string
>>> State property which would also communicate the "connecting" and "playing"
>>> states. This is what we have for some other interfaces and it has proved
>>> to be useful there (not sure if that'll be equally true for this new
>>> interface but it's still worth considering).
>>
>> Sure, updated.
>>
>
> I guess you forgot to update the property name to "State", making it
> consistent with the audio API. BTW, is this the latest version of the
> API spec so far, or there were further discussions on that on IRC?
>
> --
> João Paulo Rechi Vita
> http://jprvita.wordpress.com/
>

What about merging part of this spec with Media spec, that would mean
we not only can register endpoints that implements MediaEndpoint, but
also MediaControlEndpoint or both.

This also means org.bluez.HandsfreeGateway doesn't need to register
its own agents and the transport can be acquired via
MediaControlTransport interface. The only real difference is that the
endpoint registration is per adapter instead of per device as
HandsfreeGateway is, but maybe this is no big deal.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
