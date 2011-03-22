Return-Path: <cyrus@holtmann.org>
Subject: Re: BlueZ health device interface, problems with link security level?
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <AANLkTimxiLzu=3Cx_LqmVo3+HCcBJ_JzWuYLXJ_kKhEz@mail.gmail.com>
Date: Tue, 22 Mar 2011 13:47:39 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FA8D22F4-FDEA-4E7A-82AB-E684953D90C0@signove.com>
References: <AANLkTi=Kohr02dZOFS4HJknp=keMTCN47jYFOdJBN7Ze@mail.gmail.com> <AANLkTimxiLzu=3Cx_LqmVo3+HCcBJ_JzWuYLXJ_kKhEz@mail.gmail.com>
To: Bill Turner <wjturner@vm-go.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 22 Mar 2011, at 13:37 , Bill Turner wrote:

> I've run into a problem trying to use the BlueZ health device plugin
> (BlueZ 4.89), related to the Bluetooth link security level requested
> and the device capabilities.  I'm connecting to an Omron BP792IT blood
> pressure monitor and have it correctly paired with my system.
> 
> The problem I have is when the MCAP instance is created
> (mcap_create_instance, in health/hdp.c), it uses BT_IO_SEC_HIGH, which
> sets the link authentication requirement to 5 (MITM protection
> required, general bonding).  Since the BP monitor doesn't have any
> user input capabilities (IO capabilities returns 3, NoInputNoOutput),
> the request to change the link authentication level fails, and the
> connection is refused.
> 
> I've gotten the device to correctly connect and exchange data if I
> modify the call to mcap_create_instance to use BT_IO_SEC_MEDIUM
> instead, so the MITM protection isn't required.  I'm not sure if I'm
> doing something else wrong and BT_IO_SEC_HIGH should work, or if there
> is indeed a problem in the BlueZ code (and if so what the correct
> solution is).
> 
> Does anyone else have the unmodified BlueZ code working correctly with
> health devices?

Another known workaround is to disable SSP mode with hciconfig
(hciconfig hciX sspmode 0).

There has been discussion whether BlueZ HDP is correct or not in this
respect. The HDP specification says that devices SHOULD require authenticated
and encrypted connections (which maps to SEC_HIGH) while some devices are
known not to use authentication (SEC_MEDIUM). But the word in spec is 'SHOULD',
not 'SHALL'.