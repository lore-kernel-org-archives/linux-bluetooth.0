Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040925213557.18900.qmail@web53207.mail.yahoo.com>
From: Massimiliano Cuccia <massimiliano_cuccia@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1093528293.2581.25.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] obexFTP ... does it works?
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
Date: Sat, 25 Sep 2004 14:35:57 -0700 (PDT)

I installed linux suse 9.1 and some rpm from suse and
now I have a bt support.

I read in the suse help center a command line that can
send files to my cell phones (Nokia 6600)
here it is:
obexftp -b xx:xx:xx:xx:xx:xx -B 10 -p pippo.jpg

(xx:xx:xx:xx:xx:xx is the addr I read using hcitool
scan)
(I don't know what is the -B 10 option)

I already installed obexftp 1.0.1 but it doesn't works
... 
it says failed
anyone can help me to understand why?
others operation works correctly, so I can send a file
(note or image) to my linux (using opd) from my phone.

The same operation works if i use the KDEBluetooth
framework ... but I need a command line tool

In the application BjOD (Bluetooth joke of the day)
the authors are using ussp-push to achieve the same
result, but it does not works too

does anyone knows a way to send a file to a phone
using command line?
thanks

-----
linux suse 9.1 (kernel 2.6)
bluez-libs 2.5
bluez-pan 1.1
bluez-sdp 1.5
bluez-bluefw 1.1
bluez-utils 2.4
openobex 1.0.1
obexftp-0.10.4rc3-28.i586.rpm


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
