Return-Path: <cyrus@holtmann.org>
Message-ID: <4A55A39F.50307@powercraft.nl>
Date: Thu, 09 Jul 2009 10:00:31 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Iain Hibbert <plunky@rya-online.net>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: Feature request: boolean properties to auto reconnect list of
  MAC's at daemon start up
References: <4A4F39E8.4020908@powercraft.nl>  <20090704135747.05efc95c@stoetzler> <2d5a2c100907040637s73791batd85327f31cb4f1ee@mail.gmail.com> <1246716212.336777.600.nullmailer@galant.ukfsn.org>
In-Reply-To: <1246716212.336777.600.nullmailer@galant.ukfsn.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Iain Hibbert schreef:
> On Sat, 4 Jul 2009, Luiz Augusto von Dentz wrote:
> 
>>> IIUC that's just how bluetooth input devices work: they do connect to
>>> the host - not the other way round. So it is really a problem that
>>> cannot be solved on bluez' side.
>> Yep, most hid devices will just refuse the connection if the 'virtual
>> cable plug' was already stabilised, in general this is also a bad idea
>> for any connection attempt during the startup as we have no guarantee
>> that the connection will complete.
> 
> see HIDNormallyConnectable attribute in the HID spec (7.11.13)
> 
> I certainly find with my Apple bluetooth keyboard and mouse that the host
> OS (not using BlueZ btw) can connect to them at boot without my
> intervention.
> 
> iain

Thanks you for providing this information it helps to see that apple
does provide this behavior for usability to its users. Would a developer
be willing to investigate this feature and place this on his/her to do list?

Thanks in advance,

Jelle
