Return-Path: <Lutz.Pressler@SerNet.DE>
Date: Tue, 18 May 2004 12:19:36 +0200 (CEST)
From: Lutz Pressler <Lutz.Pressler@SerNet.DE>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6230: "pairing and conn. rejected for security
 reasons"
In-Reply-To: <1084872149.5833.72.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <E1BQ1hB-0007WA-00@intern.SerNet.DE>
List-ID: <bluez-users.lists.sourceforge.net>

On Tue, 18 May 2004, Marcel Holtmann wrote:

> please install bluez-libs-2.7 and bluez-utils-2.7, because it looks like
> that this phone already contains some Bluetooth 1.2 features and I need
> to know the full 8 bytes of the remote features.
later (work to do here :)) - probably not today.
>
>
> You made a connection from the phone to your PC, right? And it looks
Yes, but I tested both (at least I think so).
> like that you are in security mode 3. From your hcid.conf I saw that you
> haven't activated auth and encrypt so this is not you, but I can't think
tried with and without "auth enable; encrypt enable;" and with
"lm accept;" and "lm accept,master;". No difference.
> of that your phone uses security mode 3. This is not normal.
>
[...]
>
> It disconnects with "Pairing With Unit Key Not Supported" error (0x29)
> and I haven't seen this error before. I am no link manager expert, but I
> really think that one implementation is acting very bad here. And I
> guess it is your Acer dongle with the Zeevo/Telencomm chip, because it
> has caused troubles in the past. Do you own another dongle (preferable
> CSR based) to check this?
At the moment I don't think so. We also have a physically bigger Acer
dongle (that may be "100m" variant?), but that's on the road at the
moment. Should I order some specific model?

Lutz

-- 
  _              |  Lutz Pressler          |  Tel: ++49-551-3700002
 |_     |\ |     |  Service Network GmbH   |  FAX: ++49-551-3700009
 ._|ER  | \|ET   |  Bahnhofsallee 1b       |   mailto:lp@SerNet.DE
Service Network  |  D-37081 Goettingen     |  http://www.SerNet.DE/
