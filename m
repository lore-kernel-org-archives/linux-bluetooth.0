Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Oct 2010 11:59:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pepe Aracil <pepe.aracil.gomez@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: SCO Socket input.
Message-ID: <20101006095919.GA3066@jh-x301>
References: <AANLkTikqpge1KU4w4aQhtxz21097iQjWTKekdgg_+JeX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikqpge1KU4w4aQhtxz21097iQjWTKekdgg_+JeX@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 06, 2010, Pepe Aracil wrote:
> I have compiled bluez without audio support to avoid SCO socket be
> blocked by bluetoothd. Without positive results.
> 
> ¿Some idea?

Just to be sure you could add DisablePlugins=audio to
/etc/bluetooth/main.conf.

Johan
