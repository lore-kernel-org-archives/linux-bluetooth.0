Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Balazs Fulop <admin@guardware.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-KFT/R6Lro4hyvdD5WRGJ"
Message-Id: <1104016872.835.1.camel@bigwig>
Mime-Version: 1.0
Subject: [Bluez-devel] PIN requester
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 26 Dec 2004 00:21:12 +0100


--=-KFT/R6Lro4hyvdD5WRGJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Dear BlueZ Developers! 

My name is Fulop Balazs. I study at the Budapest University of
Technology and Economics. 

As a Christmas present, I got a Bluetooth USB adapter yesterday. I
wanted to see it in action immediately so I booted up my Linux box
(running 2.4.28) and started to look for the necessary tools. 

After some workaround I had a feeling that I was close to the solution
but something was wrong. I loaded the necessary modules, and I started
the required daemons. When I started gnokii, it connected to my mobile
phone, and I was asked to enter a PIN code on the phone. It did not
matter what I gave it, it did not work. The computer did not ask me to
give a code. 

I knew I needed to specify the PIN, but I did not know how, because I
did not get any error messages about this. After a while I realised that
/usr/bin/bluepin is invoked in the situation. It is a Python script and
it imports the pygtk module which was not available on my machine. After
installing the python-gtk package on my Debian Woody, nothing changed. 

I am not familiar with Python but I think it needs a Gtk 2.0 module
which is not available as a package for Debian Woody 3.0 r1. Because of
this I wrote a Perl-tk script to do the job and now it just works fine. 

If you are interested in my solution, take a look at the attachment. It
is not a big deal, but I am quite proud of it. Moreover, if you would
like to include it in bluez-utils go right ahead. It is released under
GPL ;-) 

I am not on the list, so please reply to admin@guardware.com. Sorry for
the long letter, and Merry Christmas to Everyone. 

Hail, 
Fulop Balazs 



--=-KFT/R6Lro4hyvdD5WRGJ
Content-Disposition: attachment; filename=pincode
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-perl; name=pincode; charset=ISO-8859-2

#!/usr/bin/perl -w

# PIN code requester
# Satisfies BlueZ requirements
# Written by Fulop Balazs <fb554@hszk.bme.hu>, 2004

use strict;
use Tk;


my $mainwin =3D new MainWindow ( -title =3D> "Enter PIN", -borderwidth =3D>=
 20 );

my $frame =3D $mainwin -> Frame ( -borderwidth =3D> 5 );

$frame -> Label ( -text =3D> "PIN:" ) -> pack ( -side =3D> "left" );

my $pin =3D $frame -> Entry (
    -justify =3D> "center",
    -validate =3D> "key",
    -validatecommand =3D> \&check
) -> pack ( -side =3D> "right" );
$pin -> bind ( "<Return>" =3D> \&ok );
$pin -> bind ( "<Escape>" =3D> \&cancel );
$pin -> focus;

$frame -> pack ( -side =3D> "top" );

$mainwin -> Button ( -text =3D> "Ok", -command =3D> \&ok ) ->
    pack ( -side =3D> "left" );
$mainwin -> Button ( -text =3D> "Cancel", -command =3D> \&cancel ) ->
    pack ( -side =3D> "right" );

MainLoop;


sub check {
    return 1 if ($_[1] =3D~ /[0-9]/);
    return 0;
}

sub ok {
    my $code =3D $pin -> get;
    cancel () if ("" eq $code);
    print "PIN:" . $code . "\n";
    exit;
}

sub cancel {
    print "ERR\n";
    exit;
}

--=-KFT/R6Lro4hyvdD5WRGJ--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
