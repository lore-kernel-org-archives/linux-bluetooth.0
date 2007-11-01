Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <47293C50.90803@gmail.com>
Date: Thu, 01 Nov 2007 08:09:12 +0530
From: Mohan Sundaram <mohan.tux@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <slrnficmht.ogv.matt@coleridge.tplus1.com>
	<1193847937.32459.50.camel@violet>
In-Reply-To: <1193847937.32459.50.camel@violet>
Subject: Re: [Bluez-users] I need help pulling photos off my
	phone	with	bluetooth
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

Marcel Holtmann wrote:
> Hi Matthew,
> 
>> I have a Samsung A707 phone with AT&T.  They call this the SYNC phone.
>> Anyway, I can export photos off the phone when I boot into Windows, but
>> all attempts to do this with my Ubuntu linux box have failed.
> 
> you might wanna include the output of hcidump -X -V when trying this.
> However I am pretty sure that you have no passkey agent running or a
> screwed up system. I would advise that you have a clean install or
> better switch to something like Ubuntu Gutsy were all the needed tools
> can be installed easily.
> 
> Regards
> 
> Marcel
I use Gutsy with a Moto phone. I'm able to do obex xfrs to and from the 
phone by running a obex server on the system. I had a problem pairing 
with passkey agent etc. I used a dbus-send command as given in the bluez 
security page and some fast typing of passkey to register the first 
time. Since then I've been able to use it with kmobiletools.

Mohan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
