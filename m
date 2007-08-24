Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9FADD91B-899B-45A5-A018-CAA3F97C976D@cadvium.net>
References: <9FADD91B-899B-45A5-A018-CAA3F97C976D@cadvium.net>
Date: Fri, 24 Aug 2007 17:32:45 +0200
Message-Id: <1187969565.15402.188.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] handsfree profile
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Robert,

> So I was planning to implement the profile inside of java, which is  
> why I am working on the Avetana BT stack, but I don't beleive that I  
> can handle any of the SCO communication from java.  Essentially I am  
> planning write the command processor for handling the AT commands in  
> Java (easier to maintain and debug), and then just create a small  
> daemon that handles routing traffic between the SCO channel and the  
> Alsa devices.  Perhaps communicate between the two using D-Bus?

that makes my stomach turn around. You you are of course free to do so,
but doing everything in plain C is much easier.

And I would advise to try an integration with our audio daemon.
Otherwise it would become one of these external things that is hard to
install and maintain.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
