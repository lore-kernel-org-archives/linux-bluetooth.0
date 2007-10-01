Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <004601c8043a$73fcc9e0$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com>
	<8de6c3e20708231340j439ca230i487e816693149441@mail.gmail.com>
	<1187964393.5121.10.camel@matthias.BEYONDSOFT.local>
	<Pine.LNX.4.63.0708241410030.12067@redbean.intranet.gw-instruments.de>
	<20071001154023.53e57c49@localhost.localdomain>
	<002c01c80435$14e15a70$0200a8c0@jester>
	<1191248069.6484.107.camel@aeonflux.holtmann.net>
Date: Mon, 1 Oct 2007 16:50:47 +0200
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Patch mh3
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,

Thanks a lot, indeed it's really simple :)
Is there a way to have all of these changes applied to my current kernel 
version, or should I simply wait for a next kernel release ?

Best regards,
Oli
----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Olivier Le Pogam" <olepogam@free.fr>; "BlueZ development" 
<bluez-devel@lists.sourceforge.net>
Sent: Monday, October 01, 2007 4:14 PM
Subject: Re: [Bluez-devel] Patch mh3


> Hi Olivier,
>
>> I have a 2.6.22.12 kernel (ubuntu gutsy gibbon) and when I want to apply 
>> the
>> mh3 kernel patch (dry run for now) it seems there are some modifications
>> which have already been applied (partially ?) in hci_core.h, rfcomm.h, 
>> sco.h
>
> the patch name is patch-2.6.22-mh3. This means it applies to 2.6.22 and
> might not apply to 2.6.22.12. Otherwise it would have been named
> patch-2.6.22.12-mh3. It is as simple as that.
>
> Regards
>
> Marcel
>
>
>
>
>
> -- 
> No virus found in this incoming message.
> Checked by AVG Free Edition.
> Version: 7.5.488 / Virus Database: 269.13.35/1040 - Release Date: 
> 30/09/2007 21:01
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
