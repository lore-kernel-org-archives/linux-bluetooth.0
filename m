Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 14 Dec 2006 20:43:10 +0800
From: amateur <ztl.post@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061214124309.GA3123@163.com>
References: <20061213175757.GA9370@163.com>
	<20061213182927.15667.qmail@web8508.mail.in.yahoo.com>
MIME-Version: 1.0
In-Reply-To: <20061213182927.15667.qmail@web8508.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Help ,  Bluetooth dongle not scannig cell
Reply-To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Wed, Dec 13, 2006 at 06:29:27PM +0000, amol kulkarni wrote:
> yup. Its bluetooth option is set on.
> Its getting scannned by other mobile phone, which I
> kept near to PC. My PC is not getting detected by
> either mobile phones.
What's the version of your kernel? Some 2.4 kernels have a bug to give
you nothing for hcitool scan.
> 
> 
> --- amateur <ztl.post@gmail.com> wrote:
> 
> > On Wed, Dec 13, 2006 at 02:34:15PM +0000, amol
> > kulkarni wrote:
> > > 
> > > Hi
> > > 
> > > I am trying to connect from PC(Mandrake
> > Linux-10.0)
> > > using the USB dongle.(USBBTC1A  USB : Class 1 USB
> > > Bluetooth adapter, Billionton) to Nokia 6600.
> > > 
> > > when I tries to scan , it gives following output.
> > > Its not showing the nokia phone.
> > > 
> > > [root@localhost a]# hcitool scan
> > > Scanning ...
> > > [root@localhost a]# hcitool scan
> > > Scanning ...
> > > [root@localhost a]#
> > > 
> > Have you setup your phone to be discoverable ?
> > 
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get
> > the chance to share your
> > opinions on IT & business topics through brief
> > surveys - and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> >
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> > 
> 
> 
> 
> 		
> __________________________________________________________
> Yahoo! India Answers: Share what you know. Learn something new
> http://in.answers.yahoo.com/
-------------------------

-- 
There was a phone call for you.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
