Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 16 Mar 2007 10:52:49 -0400
Message-ID: <2EB6297382462046A9427D7324788A4801B964B3@MCLNEXVS06.resource.ds.bah.com>
In-Reply-To: <1171375953.23580.24.camel@violet>
References: <2EB6297382462046A9427D7324788A4801A3898D@MCLNEXVS06.resource.ds.bah.com><1171308791.11774.6.camel@violet><2EB6297382462046A9427D7324788A4801A38CD0@MCLNEXVS06.resource.ds.bah.com><1171375493.23580.22.camel@violet><2EB6297382462046A9427D7324788A4801A38CDA@MCLNEXVS06.resource.ds.bah.com>
	<1171375953.23580.24.camel@violet>
From: "Williams, Richard" <williams_richard_b@bah.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Oops with multiple hcitool commands
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel,

Just a quick update on this problem. The 2.6.20 kernel finally became
available from Fedora Core. I installed it this morning, and as you
predicted, the problem has been fixed.

And again, thank you for your support.

Best Regards,

Rich Williams



-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Tuesday, February 13, 2007 9:13 AM
To: BlueZ development
Subject: Re: [Bluez-devel] Oops with multiple hcitool commands

Hi Richard,

> Thank you for the quick response. I'll try that kernel when I get a 
> chance. Right now I'm up to my neck with development issues on my
"real"
> project - you know, the project that pays my salary -)

the Fedora Core 6 should re-sync to 2.6.20 this week if you are lucky.

Regards

Marcel



-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Tuesday, February 13, 2007 9:05 AM
To: BlueZ development
Subject: Re: [Bluez-devel] Oops with multiple hcitool commands

Hi Richard,

> When the oops occurs, I lose the keyboard on my PC and I can only 
> reboot with the mouse.
> 
> So, the best I can do is to tail -f /var/log/messages in another 
> terminal window, and then copy the oops output to send to you. Is 
> there another way ??
> 
> So I did
> hcitool -i hci0 info xx:xx:xx:xx:xx:xx in one window, hcitool -i hci1 
> info xx:xx:xx:xx:xx:xx in a second window,
> 
> Note that the remote BD address is the same, but two USB dongles are 
> installed.
> 
> Here is the output from /var/log/messages. I hope this is sufficient 
> for what you need.

my guess is that it might be fixed with 2.6.20 kernel. Please try that
kernel.

Regards

Marcel





------------------------------------------------------------------------
-
Using Tomcat but need to do more? Need to support web services,
security?
Get stuff done quickly with pre-integrated technology to make your job
easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache
Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
