Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bitstuffing in a Rfcomm connection?
From: Agustin Jose Fusaro <afusaro@apexar.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1140643645.4519.42.camel@localhost>
References: <20051202220703.C04EF953BA@sc8-sf-spam1.sourceforge.net>
	 <200512021834.19314.mgorbach@yahoo.com>
	 <1140642881.3319.10.camel@localhost.localdomain>
	 <1140643645.4519.42.camel@localhost>
Content-Type: text/plain
Message-Id: <1140710294.3302.6.camel@localhost.localdomain>
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
Date: Thu, 23 Feb 2006 12:58:14 -0300

Hi Marcel,

Here's the situation. I have an open rfcomm connection which I use
through a file descriptor, fd: fd = open(devname, O_RDWR | O_NOCTTY);

I realized that the 'extra bytes' I was reading (using the read
function) actually are some bytes that I'm periodically writing (using
the write function) to this file descriptor. It's like I have an 'echo'
of the bytes I write... I read all the incoming that AND the bytes I'm
writing  to this fd.

I'm taking a closer look at the documentation for these functions right
now...

Thanks a lot!!!
Agustin Fusaro - Apexar Technologies

On Wed, 2006-02-22 at 22:27 +0100, Marcel Holtmann wrote:
> Hi Agustin,
> 
> > I'm writing an application that communicates using rfcomm connections.
> > This application communicates with mobile devices. In order to debug the
> > application I also wrote a mobile device emulator that runs in a
> > computer.
> > 
> > Here's the problem:
> > When the application connects to the mobile device everything works
> > fine. But when the application connects to the computer emulating a
> > device, I obtain, mingled with the data the following bytes:
> > "00 5E 40". Sometimes these bytes are together. Some other times these
> > bytes are spreaded among the real data bytes. These additional bytes
> > keeps the application from synchronizing with the emulated device.
> > 
> > My question is: when an rfcomm connection is stablished between two
> > computers, is there some bit/byte stuffing involved?
> 
> provide is with a full "hcidump -X -V" for this problem, because I have
> no idea what you are talking about.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
