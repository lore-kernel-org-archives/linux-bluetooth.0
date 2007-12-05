Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 5 Dec 2007 18:03:29 +0100
From: Franck F <celos94@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20071205170329.GA8475@d830>
References: <bc2917430712040950x21220f7an64d0d558939d42f7@mail.gmail.com>
	<1196839466.12292.154.camel@violet>
	<bc2917430712050434y7c3eb69bm57fce2702c977f64@mail.gmail.com>
	<1196859942.12292.179.camel@violet>
	<bc2917430712050522y53baf906q1c13111b5125f90d@mail.gmail.com>
	<1196861704.12292.184.camel@violet>
MIME-Version: 1.0
In-Reply-To: <1196861704.12292.184.camel@violet>
Subject: Re: [Bluez-users] Dell D830 laptop BT card doesn't start
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Well, it seems my problem will not be solved soon ...

Anyway, thanks for your help :)

Regards,
Franck F.

Marcel Holtmann wrote:
> Hi Franck,
> 
> >         if I am not mistaken, then this is a CSR based dongle. Would
> >         need to
> >         decode the Rev=43.15 into the build id. However an easier way
> >         is when
> >         you boot into Windows first and then into Linux so the dongle
> >         works and 
> >         then execute bccmd buildname (as root).
> > 
> > Here is the result of bccmd buildname:
> > Build name: cyt_8unified_fl_bt2.0_kymodo_21d_0702212310_encr56
> > 2007-02-21
> 
> this is a special build for Dell as it seems. I have no idea what's so
> special about it. Only Dell or CSR people can answer that.
> 
> Maybe you need to enable the antenna or something. I don't know. There
> could be also some ACPI magic that does this job.
> 
> >         You could sniff the init sequence under Windows. Would help to
> >         find the 
> >         init sequence.
> > 
> > hmm, How can i do that ? and what should i do when i'll find the init
> > sequence ?
> 
> You can use USBsnoopy or run Linux and then Windows in a VMware and use
> usbmon. There is no easy way to explain this task. Find someone who
> donates one of these laptops and I can do it by myself. Otherwise you
> are on your own here.
> 
> Regards
> 
> Marcel
> 
> 
> 
> -------------------------------------------------------------------------
> SF.Net email is sponsored by: The Future of Linux Business White Paper
> from Novell.  From the desktop to the data center, Linux is going
> mainstream.  Let it simplify your IT future.
> http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
