Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101006095919.GA3066@jh-x301>
References: <AANLkTikqpge1KU4w4aQhtxz21097iQjWTKekdgg_+JeX@mail.gmail.com>
	<20101006095919.GA3066@jh-x301>
Date: Wed, 6 Oct 2010 13:53:11 +0200
Message-ID: <AANLkTim1Aa3t5OtPP6CUCGP4WWEPf36M6BsKuL5e6Qwr@mail.gmail.com>
Subject: Re: SCO Socket input.
From: Pepe Aracil <pepe.aracil.gomez@gmail.com>
To: Pepe Aracil <pepe.aracil.gomez@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

I test DisablePlugins=audio with the same result :(.

SCO input connection only works in this order:
  1 - application turns UP hci0 interface.
  1 - application opens SCO socket for listen.
  2 - application launch bluetoothd.
  3 - application open rfcomm to AG profile on mobile phone.
       (I can't open rfcomm connection without bluetoothd because pin
and key exchange issues)
If my application opens SCO socket for listen after the launch of
bluetoothd, SCO socket never gets an incoming connection.

Thanks.


2010/10/6 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi,
>
> On Wed, Oct 06, 2010, Pepe Aracil wrote:
>> I have compiled bluez without audio support to avoid SCO socket be
>> blocked by bluetoothd. Without positive results.
>>
>> ¿Some idea?
>
> Just to be sure you could add DisablePlugins=audio to
> /etc/bluetooth/main.conf.
>
> Johan
>
