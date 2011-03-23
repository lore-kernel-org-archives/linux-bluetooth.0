Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Mar 2011 11:26:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot <sancane@gmail.com>
Cc: james.steele@accenture.com, epx@signove.com, wjturner@vm-go.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: BlueZ health device interface, problems with link security
 level?
Message-ID: <20110323092612.GA16903@jh-x301>
References: <AANLkTi=Kohr02dZOFS4HJknp=keMTCN47jYFOdJBN7Ze@mail.gmail.com>
 <AANLkTimxiLzu=3Cx_LqmVo3+HCcBJ_JzWuYLXJ_kKhEz@mail.gmail.com>
 <FA8D22F4-FDEA-4E7A-82AB-E684953D90C0@signove.com>
 <AANLkTikTJsY3-WY12hD0yTbU3u7ovW3C1CHic2WReoZq@mail.gmail.com>
 <7970713F1B9E4F489FABBDEAE1C93BC001241842F415@EMEXM3131.dir.svc.accenture.com>
 <AANLkTin2vUmA5Y0Vx_JuoBJ9XviTqgDQsGzde=g+0PP=@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTin2vUmA5Y0Vx_JuoBJ9XviTqgDQsGzde=g+0PP=@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 23, 2011, Santiago Carot wrote:
> > > There has been discussion whether BlueZ HDP is correct or not in this
> > > respect. The HDP specification says that devices SHOULD require authenticated
> > > and encrypted connections (which maps to SEC_HIGH) while some devices are
> > > known not to use authentication (SEC_MEDIUM). But the word in spec is 'SHOULD',
> > > not 'SHALL'.
> >
> > An "authenticated" connection has a slightly ambiguous meaning in
> > Bluetooth since 2.1+EDR, since you can have an authenticated link that
> > does not have any MITM protection.
> >
> > I think the correct behavior is that HDP should be using "Level 2"
> > (from GAP in the Core specification), where HDP wants the strongest
> > level of security it can achieve with a device, but it does not want to
> > exclude devices that do not have the capability to support input/output.
> >
> > There does seem to be a slight discrepancy between SEC_MEDIUM in BlueZ
> > and Security Level 2 in GAP.  I believe that the intention of Level 2
> > is to propose that MITM protection is needed - however it will happily
> > accept security where no MITM protection has been achieved (this being
> > the difference between Level 2 and Level 3).  BlueZ however does not
> > seem to propose MITM protection for SEC_MEDIUM - which would be important
> > for HDP (at least in the BlueZ <-> BlueZ case).
> 
> I remember that issue with we were developing HDP and MCAP. We set
> SEC_HIGH in HDP to get encrypted channels and to pass Bluetooth PTS.
> The problem doing that is related with devices that don't support MITM
> protection (In fact if they don't have any
> user input capabilities). This may be a good opportunity to go back
> about this issue. What do you think?
> 
> In any case, such as Elvis has said, you can disable sspmode to get
> HDP working without modify BlueZ code.

Either I just don't remember correctly how SEC_MEDIUM is supposed to
work or then there's some confusion here. Medium security will require
encryption. The main difference that high security brings is that
unauthenticated link keys will not be accepted. Furthermore, you should
also be able to get an authenticated link key with medium security as
long as both sides have the IO capabilities for it and at least one side
requires MITM protection (only if *neither* side requires MITM will Just
Works be triggered).

Johan
