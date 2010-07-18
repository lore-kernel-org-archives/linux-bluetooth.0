Return-Path: <cyrus@holtmann.org>
Date: Sun, 18 Jul 2010 22:04:29 +0200
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: linux-bluetooth@vger.kernel.org
Subject: obexd TARGET_SIZE question
Message-ID: <20100718200429.GB17706@joshua.mesa.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset*=utf-8''%E2%80%9Cus-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

I'm trying to understand a part of the obexd code, to see if somehow a
IrMC server can be implemented. Pierre Ossman already started a bit on this.

I am a bit confused about the obex_mime_type driver structure.
The find_driver() function does a memcmp0(target, driver->target, TARGET_SIZE),
but it seems not all drivers have target of size TARGET_SIZE.

The syncevolution plugin has a target of size 11 (whereas TARGET_SIZE=16).
So the find_driver() probably fails the memcmp0 for this driver as
the extra 5 bytes to compare my be undefined...
A IrMC Sync target will have a target_size of 9.

I also noticed the obex_service_driver, which is handled in a similar
way as the rbex_mime_type_driver. Forrest added a target_size element
in for this struct (commit b38537e5f12decc4b2444112f4363ff1aa5326c6):

	Forrest Zhao [Mon, 16 Nov 2009 07:17:47 +0000]
	Introduce target_size to struct obex_service_driver{}
	Because the OBEX target header length for each OBEX service layer
	may not be the same.

Shouldn't the same happen for the obex_mime_type_driver() ?

(actually Pierre Ossman did this in his local obexd tree to test IrMC
 which also has a different target size, I copied these changes in 
 a clone of obexd 0.29)


-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
