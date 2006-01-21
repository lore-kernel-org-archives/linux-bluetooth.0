Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Apple mouse gives me various "Can't get
	device information" troubles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <loom.20060121T004726-720@post.gmane.org>
References: <1137635164.7455.63.camel@localhost.localdomain>
	 <1137719835.17336.141.camel@localhost>
	 <loom.20060121T004726-720@post.gmane.org>
Content-Type: text/plain
Message-Id: <1137807615.20856.116.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 21 Jan 2006 02:40:15 +0100

Hi Sunnan,

> > the PIN of the Apple mouse is "0000", but you might have changed it.
> 
> I don't know how or if it can be changed. I've switched my shellscript to echo
> PIN:0000 instead now (and restarted the various bluez userland daemons).
> 
> > Check its manual for a reset switch.
> 
> Apparently, it resets everytime the batteries are replaced.
> Additionally, the red light underneath the mouse blinks in various patterns
> indicating various things; I currently see a creepy, waltz-like "blink blink
> pause, blink blink pause, blink blink pause" that supposedly means:
> "the mouse is looking for a computer to pair with" according to 
> http://docs.info.apple.com/article.html?artnum=86474
> 
> I still get the same "permission denied" (or, once in a while, "host is down")
> message from hidd --connect.
> hcidump still says "Error: Authentication Failure".

if you don't find any hints in the syslog or the log files, I am out of
ideas. We now would need a protocol analyzer to find the problem, but
they are a little bit too expensive.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
