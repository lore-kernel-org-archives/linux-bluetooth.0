Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Oct 2010 08:33:48 +0100
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: "shivendra.agrawal@stericsson.com" <ag.shivendra@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: AVRCP 1.4 : Future on Target Role
Message-ID: <20101027073348.GA5236@vigoh>
References: <201010191147.34241.sander@outrightsolutions.nl>
 <AANLkTikgKM1MNpwP2JL1GdERZ60dE6dkFNC=rdyQDhOV@mail.gmail.com>
 <AANLkTi=ThA2ojhj8PBHK_VybmFcHO91K0g=y7nhfTBAO@mail.gmail.com>
 <AANLkTimGO9-_odEX-=8Lttw1D3M=X+DWJH0w45W8nMtT@mail.gmail.com>
 <AANLkTi=g+8UDsSQBnqBWk=Ly=xCmfvwX_ZCMsn_kU9Fb@mail.gmail.com>
 <AANLkTinodSvkAffPKrHT_Yd9nwXwAdQoqacD9vJt-F96@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinodSvkAffPKrHT_Yd9nwXwAdQoqacD9vJt-F96@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shivendra,

* shivendra.agrawal@stericsson.com <ag.shivendra@gmail.com> [2010-10-27 12:27:54 +0530]:

> Hi All,
> 
> ST-Ericsson plans to implement the commands to support target role of
> AVRCP 1.4 Profile, and we would like to contribute it to BlueZ.
> With our initial discussion, I would be aligning with BlueZ
> contributors and would propose for the ideas that has not been
> touched/developed so far, in order to have a design/implementation
> that can be accepted.
> 
> As a very first, and very rough, design proposal for the BlueZ parts:
> - A new SDP record for AVRCP 1.4 would be added to inform CT of the
> version and features supported by target.
> - A new callback to accept browsing channel establishment.
> - Enhancing similar to bt_io_listen for browsing PSM.
> - A new browsing command handler
> - Incremental addition to AVRCP 1.4 commands.
> 
> Any feedback is very much appreciated!

Top posting is not allowed in this mailing list. Thanks. ;)

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
