Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sf.net
Subject: Re: [Bluez-users] Re: Can't understand
Message-ID: <20040513103228.GA4449@gmx.net>
References: <200405130659.45969.hedin@hiervard.ru> <1084422667.25099.130.camel@pegasus> <200405131627.34993.hedin@hiervard.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405131627.34993.hedin@hiervard.ru>
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
Date: Thu, 13 May 2004 12:32:28 +0200

On  0, ????? <hedin@hiervard.ru> wrote:
> Thursday 13 May 2004 11:31, Marcel Holtmann ?????:
> > > // I guess, this one is dongle.
> > > T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> > > D:  Ver= 1.01 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > > P:  Vendor=0a5c ProdID=2033 Rev= 0.a0
> > > C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=100mA
> > > I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > > E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> > > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> >
> > you guess right and it needs the bcm203x and the hci_usb driver. So when
> > do you start looking at the logfiles to see what is going wrong.
> 
> What should I do after loading modules and connecting the device? hcitool?
> Tell me, which logs to look at and I'll do.

The normal system log, something like /var/log/syslog.
With hciconfig you see the registered hci devices. 

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
