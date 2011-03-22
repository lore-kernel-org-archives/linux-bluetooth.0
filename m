Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=Kohr02dZOFS4HJknp=keMTCN47jYFOdJBN7Ze@mail.gmail.com>
References: <AANLkTi=Kohr02dZOFS4HJknp=keMTCN47jYFOdJBN7Ze@mail.gmail.com>
Date: Tue, 22 Mar 2011 09:37:20 -0700
Message-ID: <AANLkTimxiLzu=3Cx_LqmVo3+HCcBJ_JzWuYLXJ_kKhEz@mail.gmail.com>
Subject: BlueZ health device interface, problems with link security level?
From: Bill Turner <wjturner@vm-go.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've run into a problem trying to use the BlueZ health device plugin
(BlueZ 4.89), related to the Bluetooth link security level requested
and the device capabilities.  I'm connecting to an Omron BP792IT blood
pressure monitor and have it correctly paired with my system.

The problem I have is when the MCAP instance is created
(mcap_create_instance, in health/hdp.c), it uses BT_IO_SEC_HIGH, which
sets the link authentication requirement to 5 (MITM protection
required, general bonding).  Since the BP monitor doesn't have any
user input capabilities (IO capabilities returns 3, NoInputNoOutput),
the request to change the link authentication level fails, and the
connection is refused.

I've gotten the device to correctly connect and exchange data if I
modify the call to mcap_create_instance to use BT_IO_SEC_MEDIUM
instead, so the MITM protection isn't required.  I'm not sure if I'm
doing something else wrong and BT_IO_SEC_HIGH should work, or if there
is indeed a problem in the BlueZ code (and if so what the correct
solution is).

Does anyone else have the unmodified BlueZ code working correctly with
health devices?

--
Bill Turner
Senior Software Engineer
Visionary Mobile Corp.




--
Bill Turner
Senior Software Engineer
Visionary Mobile Corp.
