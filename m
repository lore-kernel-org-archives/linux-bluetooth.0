Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455B1164.5050607@kernelconcepts.de>
Date: Wed, 15 Nov 2006 14:08:52 +0100
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <4410090A.3070706@kernelconcepts.de>	
	<1141912311.4605.9.camel@aeonflux.holtmann.net>	
	<44104DD5.80109@kernelconcepts.de>	
	<1141923373.4605.39.camel@aeonflux.holtmann.net>	
	<loom.20060412T215427-611@post.gmane.org>	
	<444CAE4F.70404@kernelconcepts.de>
	<1145876694.21987.28.camel@localhost>
	<4451F478.3070204@kernelconcepts.de>
In-Reply-To: <4451F478.3070204@kernelconcepts.de>
Content-Type: multipart/mixed; boundary="------------020606070300070300050103"
Subject: Re: [Bluez-devel] New HCI-USB device, no MAC?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020606070300070300050103
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello all!
Maybe some of you still remember this thread...

The issue was that some Bluetooth dongles do not contain a valid
Bluetooth MAC address. Well, this is against the spec and so the dongles
are bad but sometimes users cannot avoid to get such. So I still see the
need that we do as good as we can to help those users and get those bad
dongles working.

Long story short, Marcel's bdaddr application contained in the latest
release of bluez-utils works, at least for the two dongles I have with
ISS chipsets. So the BDADDR can be set now.

I wanted an automatic solution so that when I plug the dongle in it is
automatically assigned "an" address. So first I created an udev rule
that calls an application when the specific USB device with the
vendorid:deviceid I know to be bad is inserted - in my case 1131:1001
(plaease let me know more!).

Then I created a small shell script which sets a "more correct" address
than the default 11:11:11:11:11:11. I assume in this script that an
ethernet device is present in the system as eth0 and use its MAC for the
Bluetooth dongle too.

I did this for two reasons:
1. On the same machine I always want to have the same BDADDR, so random
was no choice.
2. The ethernet addresses also have to follow the same rules as
Bluetooth MAC addresses, i.e. they have to be unique. So the probability
of a collision is very low.

I have attached a tarball of my udev rule and script to this post which
works quite nicely for me. If anyone else finds it useful I would be
happy to receive comments ;)

And finally I would like to ask, how can we try to get this into
distributions? Shall I change anything in the scripts? Can we get it
into some bluez package?

Thanks!

Cheers
  nils


-- 
kernel concepts GbR      Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
--

--------------020606070300070300050103
Content-Type: application/x-gzip;
 name="hcibdaddrhack.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hcibdaddrhack.tar.gz"

H4sIAPYNW0UAA+1VbW/bNhD21+hXXJUM+zDHkuzY6V5czE7cNVgTF7GzIdiGlJJoiwhFqnyJ
YQz77ztKfumKrvnQrtsAPjBgkXe8e+54vKMmi2xOHyJlOdWdPHr69bHVaWqKjHXqvdZHI0YM
Tk7qf8S7/0lvMGglcb8bD/qDfq/XipP+6emgBfHHu34cVhuiAFpKSvMhvcfk/1McwrxgGvC3
kApKplNakAcmlnAzG8OYW2ow8AJyKZZYDLAqWOZWIKQB1KTBIRCoFIVMigVbWkVzGJ+Pzs+v
28DZPQVTOB2AC2HoUhGD8tlaG1rCTHJrmBRwJlXVgR9vj8fzJI7f8jrKSWWowvMvKLooibAL
khl0ojQYtQYjQSMJ0LJEBlQYDUTkQBwhdAyTyavr6SVYbQnna7RTSJ676JywodnZZYAsCRPa
vOVfVzQDtnDa623QhGuJhrStKr5Gb0DyXFGtaw6rwvGkXNNOcIhaPyMr9Fy705lilYHIahVx
iduRTpmIUkO0ZkuR5s4QMAFS5VS50BpBnWFBVztHKDGOMj5bllHHnwIKDKwYukoxcnJPBTpG
KnIBxBpZEsMckXVDq/sUg5tmRqboqIuvsw1XjGt4TqhyW98JXHUWzer7e6oE5Xi/Ga0M9gj6
LAhmN+PZ7Ww+uXwyDLFf3DVcwjaMzuYX0yvcRba4/GE6n9YadUe5qzvKHRV5iCZuZ89nv7P8
J1xK9cdwGCZJL8EzW8ErJXObmVqCbQIlvwYH1zdXXw3DR5L4xT3afzkaT16+3/e//er+O/hg
Hj+RD9fkT/v9v+v/3eQk3vf/wYnr/71u4vv/58Dhk8jduy6CwI+Cf24U4CDgvA2lRJuYvy8N
qsCK1mmrmVNjK5ACu/kFygppee46OdFgBXtj3RdaqSS+zpTTOrK9Vj1dCIaNPgV9cMMDd5qW
XEdjDMkKmu9mEj5yW7pzxDhV1WgJoG4hqNmdFbWlEk8zUbMJUSUOoY4b+WtWutDDVColVyEw
zPrOyDYbeGyfx8vR2U7g6qypCdLc7qeaTpP5izt3ocPXGUYY6bWOMo5BR0grchFEGwqvg/H5
+zXTLePoKNlr76k69tbdgoQFNpDMVR1e4Yoh9810XhDLzaa0mnQZN6W3tcXMfti7asIyKF1W
ahPhUso83DkLsPJ+gaMNWRgOAYflN3/9hfDbty6dIjg4BJoVEsKGIg6/uO1KzNTlLuFom58Q
nkFkysr1fRdjhwcHmxF6zOAogWP8MHv94ABtNa/bSXO5QmeaU1pBp/+O0FbBgvlJ6+Hh4eHh
4eHh4eHh4eHh4eHh4eHh4eHh4eHxGfEnW5GstAAoAAA=
--------------020606070300070300050103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020606070300070300050103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020606070300070300050103--
