Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <275070-2200410219819354@M2W046.mail2web.com>
Reply-To: bluez@spamzed.com
From: "postmaster@spamzed.com" <postmaster@spamzed.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] inquiry_info device class to string
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 19 Oct 2004 04:19:35 -0400


Hi there

Im sort of new to bluetooth and bt development but its going ok so far=2E =
Im
writing a little tool which displays all current devices in range=2E Since=
 my
code uses ripped parts from hcitool scan i can succesfully enumerate the
device address and name, my question is , how do I parse  the device_class=

item from the inquiry_info structure ? Say device ID is 001, i want to
convert it to an human readable string like 001 =3D=3D Phone, 002 =3D=3D A=
udio
etc=2E=2E=2E where can i find an translation list for this ? after a heavy=
 google
battle i found a PalmOS site which mentions the bluetooth specs, but the
prop is , i can find only parts of it and my 'bluetooth unreveiled' book i=
s
currently beeing shipped to me (i hope its mentioned there)=2E I hope im n=
ot
forced to use a sdptool query since some 'light' devices dont have it
onboard, like headsets etc

thanks for the help !

Ed=2E

--------------------------------------------------------------------
mail2web - Check your email from the web at
http://mail2web=2Ecom/ =2E




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
