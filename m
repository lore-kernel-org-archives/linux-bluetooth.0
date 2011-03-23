Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7970713F1B9E4F489FABBDEAE1C93BC001241842F415@EMEXM3131.dir.svc.accenture.com>
References: <AANLkTi=Kohr02dZOFS4HJknp=keMTCN47jYFOdJBN7Ze@mail.gmail.com>
	<AANLkTimxiLzu=3Cx_LqmVo3+HCcBJ_JzWuYLXJ_kKhEz@mail.gmail.com>
	<FA8D22F4-FDEA-4E7A-82AB-E684953D90C0@signove.com>
	<AANLkTikTJsY3-WY12hD0yTbU3u7ovW3C1CHic2WReoZq@mail.gmail.com>
	<7970713F1B9E4F489FABBDEAE1C93BC001241842F415@EMEXM3131.dir.svc.accenture.com>
Date: Wed, 23 Mar 2011 10:17:30 +0100
Message-ID: <AANLkTin2vUmA5Y0Vx_JuoBJ9XviTqgDQsGzde=g+0PP=@mail.gmail.com>
Subject: Re: BlueZ health device interface, problems with link security level?
From: Santiago Carot <sancane@gmail.com>
To: james.steele@accenture.com
Cc: epx@signove.com, wjturner@vm-go.com,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Elvis, James

2011/3/22 <james.steele@accenture.com>
>
> Hi,
>
> >> I've gotten the device to correctly connect and exchange data if I
> >> modify the call to mcap_create_instance to use BT_IO_SEC_MEDIUM
> >> instead, so the MITM protection isn't required.  I'm not sure if I'm
> >> doing something else wrong and BT_IO_SEC_HIGH should work, or if there
> >> is indeed a problem in the BlueZ code (and if so what the correct
> >> solution is).
> >>
> >> Does anyone else have the unmodified BlueZ code working correctly with
> >> health devices?
>
> > Another known workaround is to disable SSP mode with hciconfig
> > (hciconfig hciX sspmode 0).
>
> > There has been discussion whether BlueZ HDP is correct or not in this
> > respect. The HDP specification says that devices SHOULD require authenticated
> > and encrypted connections (which maps to SEC_HIGH) while some devices are
> > known not to use authentication (SEC_MEDIUM). But the word in spec is 'SHOULD',
> > not 'SHALL'.
>
> An "authenticated" connection has a slightly ambiguous meaning in
> Bluetooth since 2.1+EDR, since you can have an authenticated link that
> does not have any MITM protection.
>
> I think the correct behavior is that HDP should be using "Level 2"
> (from GAP in the Core specification), where HDP wants the strongest
> level of security it can achieve with a device, but it does not want to
> exclude devices that do not have the capability to support input/output.
>
> There does seem to be a slight discrepancy between SEC_MEDIUM in BlueZ
> and Security Level 2 in GAP.  I believe that the intention of Level 2
> is to propose that MITM protection is needed - however it will happily
> accept security where no MITM protection has been achieved (this being
> the difference between Level 2 and Level 3).  BlueZ however does not
> seem to propose MITM protection for SEC_MEDIUM - which would be important
> for HDP (at least in the BlueZ <-> BlueZ case).
>

I remember that issue with we were developing HDP and MCAP. We set
SEC_HIGH in HDP to get encrypted channels and to pass Bluetooth PTS.
The problem doing that is related with devices that don't support MITM
protection (In fact if they don't have any
user input capabilities). This may be a good opportunity to go back
about this issue. What do you think?

In any case, such as Elvis has said, you can disable sspmode to get
HDP working without modify BlueZ code.

Regards
Santiago
