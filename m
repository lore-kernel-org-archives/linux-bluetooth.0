Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <413C3E38.5040801@c-lab.de>
From: Johannes <lintner@c-lab.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] general question on the procedure of BlueZ
References: <413B18F9.6010101@nue.et-inf.uni-siegen.de>	 <1094459425.5145.19.camel@notepaq>	 <413C24C6.1030102@nue.et-inf.uni-siegen.de> <1094462275.5145.22.camel@notepaq>
In-Reply-To: <1094462275.5145.22.camel@notepaq>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 06 Sep 2004 12:38:48 +0200

Hi all,

I would have a question on the general procedure, how BlueZ works.

My problem is, that the video-file, I will send from Server to mobile 
phone, is corrupt. At most, there were transmitted only 9216byte instead 
the origin 12913byte. When I let the server sleep for (e.g.)  60sec. 
after the video-file (over an OutputStream and OutputStream.close()) is 
sent  and before the connection is closed to the phone, it works. But 
this is not really a good implementation.

So, how does the BlueZ-Stack works. Does it has an puffer, smaller than 
13kbyte or how is the connecton-closing realized? Will be the connection 
closed, if such an methode will be called, no matter, whether there are 
data in the puffer?

Greets Johannes


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
