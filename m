Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 8 Dec 2006 09:24:17 -0200
From: Cris <ml133@netpole.com.br>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20061208092417.89b3eeaf.ml133@netpole.com.br>
In-Reply-To: <1165573006.5529.13.camel@aeonflux.holtmann.net>
References: <20061206111617.d8f16a0c.ml133@netpole.com.br>
	<1165412385.2756.52.camel@localhost>
	<20061206131754.39cddee0.ml133@netpole.com.br>
	<1165418898.2756.84.camel@localhost>
	<20061206164914.6718738c.ml133@netpole.com.br>
	<1165573006.5529.13.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] suggestion for device control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Fri, 08 Dec 2006 11:16:45 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> > > >   socket (AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> > 	ioctl (sd, HCISETRAW, 1);
> > 
> this should work. However I never tried to emulate everything by myself
> and maybe at some point we broke the raw mode. Check with a 2.6.19
> kernel and post the "hcidump -X -V" from your tests. Include any code
> that is needed to reproduce what you see.

I'm working right now at another end; when I return to this spot,
I'll test it again and come back here if the problem persists. The
kernel used was 2.6.17 (debian-testing).

Thanks,

-- 
Cris.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
