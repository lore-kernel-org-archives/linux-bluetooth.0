Return-Path: <cyrus@holtmann.org>
From: Mike Tsai <Mike.Tsai@Atheros.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Mon, 25 Oct 2010 10:11:42 -0700
Subject: RE: [RFC] LE connections and advertising management
Message-ID: <35B17FE5076C7040809188FBE7913F983F844057B9@SC1EXMB-MBCL.global.atheros.com>
References: <AANLkTin8pUACCu4YYuhLpFB7DxCfsYhN3cOpYYaVcTQ6@mail.gmail.com>
In-Reply-To: <AANLkTin8pUACCu4YYuhLpFB7DxCfsYhN3cOpYYaVcTQ6@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Claudio Takahasi
Sent: Monday, October 25, 2010 5:53 AM
To: BlueZ development
Subject: [RFC] LE connections and advertising management

Hi all,

Interleave BR/EDR/LE discovery is implemented, the next step in the
user space is how to manage advertising and LE connections.

Some aspects:
1. Only one LE connection is allowed(per peer), meaning only one
GAttrib instance will be allowed otherwise it will not be possible to
serialize commands/events
2. The remote/Peripheral can support more than one GATT primary service
3. We are planning to use "direct" connections only, meaning that we
will not use whitelist and the application interested must inform the
remote address/object to connect to.
4. Kernel manages the connection establishment, currently there isn't
a  way to change the connection parameters. BMI or ioctls will be
required to change the default parameters and also to trigger SMP
negotiation.


Some ideas:
1. implement a characteristic driver: basically to provide an
abstraction to GATT clients. ex: Proximity, Health, ...
2. We don't need to implement Proximity and other GATT clients as a
plugin at the moment, it can be enabled automatically by
--enable-attrib
3. GATT clients could register a watcher/filter for advertising events
4. GATT clients doesn't need to know ATT, in theory it can handle
characteristics only
5. GATT clients needs to control/request LE connections based on the
advertisement received

An initial draft implementing part of this idea is here:
git://git.infradead.org/users/cktakahasi/bluez.git devel

Comments?

Regards,
Claudio
>>MT comments,

1. Only one LE connection is allowed(per peer), meaning only one
GAttrib instance will be allowed otherwise it will not be possible to
serialize commands/events

>> You mean the master (or client) can only connect to 1 slave (or server) or a slave can only connect to 1 master?

4. GATT clients doesn't need to know ATT, in theory it can handle
characteristics only

>> You mean both characteristic value and characteristic descriptors of characteristic?

Regards,

Mike

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
