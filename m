Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 30 Aug 2006 23:44:05 -0700
From: David Armour <d.f.armour@shaw.ca>
In-reply-to: <mailman.44465.1156973920.29847.bluez-users@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Message-id: <44F68535.3060409@shaw.ca>
MIME-version: 1.0
References: <mailman.44465.1156973920.29847.bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bash: syntax error near unexpected token
	`newline', (Paulo Wollny)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hello Paolo,

thank you for your reply.

>> ## running: >>sudo hidd --connect <00:03:89:53:EC:7F>
>> ## bash: syntax error near unexpected token `newline'        ## gah!
>>
>> can someone where to look to address this error? thanks in advance.
>>

> Strip < and > from the command... it shoud be:  sudo hidd --connect
> 00:03:89:53:EC:7F

that makes so much more sense, now that you point it out. mille grazie!




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
