Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101020144004.GA14607@jh-x301>
References: <AANLkTikmAHP8JiBw=cYqHCbiLot6rLjjboc7wnySmEmj@mail.gmail.com>
	<20101020144004.GA14607@jh-x301>
Date: Wed, 20 Oct 2010 17:17:31 +0200
Message-ID: <AANLkTi=QGnn5bhWSvBvaAE-k0NiRcKoybQM+pjGtn9ua@mail.gmail.com>
Subject: Re: Activating a serial connection with qdbus
From: Igor pesando <ipesando@gmail.com>
To: Igor pesando <ipesando@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,
thank for the quick and precise answer for what qdbus concerns.

On Wed, Oct 20, 2010 at 4:40 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:

>
>> If so I do not understand why it is not possible to set the Powered
>> property using hciconfig since if the device property Powered is false
>> it is not possible to initialize HCI device.
>
> I'm not quite following your question. You can use "test-adapter powered
> yes/no" and even "hciconfig hci0 up/down" should also work.
>

You are right.
The issue I have is therefore associated with blueman:
when you switch off the adapter with blueman and then kill blueman-applet
hciconfig hci0 up does not work and returns an error (Can't init
device hci1: Unknown error 132 (132) )
and sometimes
dbus-send and test-adapter do the same (
dbus.exceptions.DBusException: org.bluez.Error.Failed: Unknown error
132)
while blueman-applet can solve the problem if restarted.

Igor


-- 
-----------------------------------------------------------
fatti non foste a viver come bruti,
ma per seguire virtute e canoscenza.
Dante, Inf. XXVI 119-120

Ye were not made to live like unto brutes,
But for pursuit of virtue and of knowledge.
(Trans. H.W. Longfellow)
