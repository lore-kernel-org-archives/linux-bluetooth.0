Return-Path: <x.garreau@prim-time.fr>
Message-ID: <003f01c48755$3dfe6a70$0301a8c0@zazoumobile>
From: "Xavier GARREAU" <x.garreau@prim-time.fr>
To: "Marcel Holtmann" <marcel@holtmann.org>, "Vlad" <vkorolev@nist.gov>
Cc: <bluez-devel@lists.sourceforge.net>
References: <loom.20040820T185934-862@post.gmane.org> <1093073294.3544.12.camel@notepaq>
Subject: Re: [Bluez-devel] Disconnections are not being detected.
Date: Sat, 21 Aug 2004 10:02:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

>> 1093025241.319200 > ACL data: handle 0x0006 flags 0x02 dlen 16
>>     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0000 result 2 status 0
>> 1093025241.320195 < ACL data: handle 0x0006 flags 0x02 dlen 10
>>     L2CAP(s): Command rej: reason 0


> actually that is not quite right. The server (phone) sends back a
> connect response with PSM not supported error status. And we then
> send a command reject for that. This is really stupid. What kernel
> version do you use and what kind of hardware is this? Can you
> reproduce it with the latest 2.4 or 2.6 kernel?

I guess the command reject is due to scid and dcid being both set to 0 by
the remote device. So bluez doesn't know who it's to talking to (as we can
have several cid on one ACL link) ...

I may be wrong but that sounds like an appropriated behaviour to me.

BR,
-- 
Xavier Garreau <xavier@xgarreau.org>
http://www.xgarreau.org
