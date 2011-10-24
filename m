Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH bluez] add get_le/get_be helpers
Date: Mon, 24 Oct 2011 12:27:41 +0200
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1319448004-8513-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>  <CAE6HaMkxvTPa1eTj1Og7Lvqn=PvieuKJyzugPouwiUTOsnnW_g@mail.gmail.com>
In-Reply-To: <CAE6HaMkxvTPa1eTj1Og7Lvqn=PvieuKJyzugPouwiUTOsnnW_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201110241227.41140.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

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
> 
> What do you think?

Some profiles e.g. AVRCP and SAP use big endian...  

-- 
BR
Szymon
