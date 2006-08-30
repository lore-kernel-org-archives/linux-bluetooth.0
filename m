Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44F5FC57.2020305@ibdcon.org.br>
Date: Wed, 30 Aug 2006 18:00:07 -0300
From: Paulo Wollny <paulo.wollny@ibdcon.org.br>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44F5EC3D.1050607@shaw.ca>
In-Reply-To: <44F5EC3D.1050607@shaw.ca>
Subject: Re: [Bluez-users] bash: syntax error near unexpected token `newline'
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

Strip < and > from the command... it shoud be:  sudo hidd --connect
00:03:89:53:EC:7F

>
> ## running: >>sudo hidd --connect <00:03:89:53:EC:7F>
> ## bash: syntax error near unexpected token `newline'        ## gah!
>
> can someone where to look to address this error? thanks in advance.
>
>   


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
