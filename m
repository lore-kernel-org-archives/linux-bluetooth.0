Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100630095833.GA2866@jh-x301>
References: <1277860131-3285-1-git-send-email-jprvita@gmail.com>
	<20100630095833.GA2866@jh-x301>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Wed, 30 Jun 2010 10:03:33 -0300
Message-ID: <AANLkTinBR8gOf-jsqxf2gUkAm08gprUe_KsGc4p7rxLU@mail.gmail.com>
Subject: Re: [PATCH] Add udev scripts to gitignore.
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/6/30 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi,
>
> On Tue, Jun 29, 2010, João Paulo Rechi Vita wrote:
>> +scripts/97-bluetooth.rules
>> +scripts/97-bluetooth-hid2hci.rules
>
> How do these files get created? I've never seen them in my bluez tree.
>

You have to enable udevrules during the configure phase. They were
probably leftover because most devs use bootstrap-configure script,
which pass --disable-udevrules to configure.

-- 
João Paulo Rechi Vita
http://jprvita.wordpress.com/
