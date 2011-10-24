Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH bluez] add get_le/get_be helpers
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Mon, 24 Oct 2011 13:50:16 +0200
In-Reply-To: <CAE6HaMkxvTPa1eTj1Og7Lvqn=PvieuKJyzugPouwiUTOsnnW_g@mail.gmail.com>
References: <1319448004-8513-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <CAE6HaMkxvTPa1eTj1Og7Lvqn=PvieuKJyzugPouwiUTOsnnW_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319457038.15441.230.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> Sorry if this comes too late, but here's an idea:
> 
> How about changing the name of the functions to something a little
> more high level, for example: in attrib/att.h we have
> att_{get,put}_u16() that uses the byte order defined in the ATT spec
> (little endian).
> 
> So my suggestion is to have bt_{get,put}_u*() and sdp_{get,put}_u*
> functions (perhaps also no_{get,put}_u* for cases when we use the host
> byte order). The bt_ functions will be used for everything that uses
> the Bluetooth byte order and the sdp_ ones for SDP, which is the only
> case of Big Endian defined by Bluetooth, correct me if I am wrong.

lets not try to be too smart. We want the code clearly identify what
endian is expected. Same as the kernel handles this.

Regards

Marcel


