Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4322.192.168.127.20.1071611970.squirrel@cp257602-a.dbsch1.nb.home.nl>
From: "Richard van Dok" <rdok@home.nl>
To: <bluez-users@lists.sf.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Performance of Bluez
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
Date: Tue, 16 Dec 2003 22:59:30 +0100 (CET)

Hi,

I'm writing this mail because I have a question about the Bluez bluetooth
stack on Linux Redhat 7.3 (on a Clarkconnect box, in fact). I recently
installed the software using the information found here:
http://www.harbaum.org/till/palm/bluetooth/index.html

First: everything works! It's great, I can even use MobileTS on a Sony
Clié with PalmOS to take over the screen of windows systems. This wasn't
possible before, when the bluetooth stack was running on my Xp system.

One question remains: the throughput of the Bluez stack is less than half
the amount I got under Windows. This might be due to an error I constantly
get in /var/log/messages when connected over Bluetooth. It states:
rfcomm_send_data: Flow stopped, to credits (0) on DLCI 4, returning <value>
<value> differs. Often seen values are 0, 328, 984, 656, 1312 and so on.

Is there perhaps a way to change this behavior? Is it bad at all? I had
some difficulty finding the right software, amongst others I didn't have
the bsd_comp module so I had to compile it afterwards. All this went well,
the errors I received before have gone (Can't locate module
ppp-compress-21) but I saw mentioned on another URL that vj_compress was
used to compress the data over ppp. Can this be related to the performance
issue?

Thanks in advance for giving me the opportunity to ask a question on this
subject. Of course i'm glad to help with any additional information.

Regards,

Richard van Dok
Vlijmen
Netherlands.





-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
