Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] D-Link DBT-120
From: Gene Imes <ebi7@ozob.net>
To: list-bluez <bluez-users@lists.sourceforge.net>
In-Reply-To: <1078322721.2787.86.camel@pegasus>
References: <1078322158.11523.83.camel@go2>
	 <1078322721.2787.86.camel@pegasus>
Content-Type: text/plain
Message-Id: <1078339075.8547.2.camel@go2>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 03 Mar 2004 12:37:56 -0600

Disregard my previous post. 2.6.4-rc1-mm2 has fixed this problem.

Thanks,


On Wed, 2004-03-03 at 08:05, Marcel Holtmann wrote:
> Hi Gene,
> 
> > I have this dongle and after upgrading kernel 2.6.4-rc1-mm1 when I
> > remove the dongle my laptop freezes.
> > 
> > This dongle has worked well before.
> > 
> > I can supply more information if necessary.
> 
> the DBT-120 exists as Broadcom and as CSR version. What version do you
> have (hciconfig -a)? Is BT_HCIUSB_SCO enabled in your kernel config? If
> yes, disable it. What USB host controller driver do you use?
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
