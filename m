Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: BlueLogic Wingkey problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20041114T214429-790@post.gmane.org>
References: <loom.20041114T133356-876@post.gmane.org>
	 <1100449789.21403.47.camel@pegasus>
	 <loom.20041114T204627-795@post.gmane.org>
	 <1100463226.21403.69.camel@pegasus>
	 <loom.20041114T214429-790@post.gmane.org>
Content-Type: text/plain
Message-Id: <1100466023.21403.84.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 14 Nov 2004 22:00:23 +0100

Hi Andres,

> > The -mh3 activates the HID report mode and so the --subclass workaround 
> > shouldn't be needed anymore. 
>  
> Just tested with mh3: It works! Even the mouse does. I still do not know how to 
> make the thing work on boot (without resetting the keyboard and typing hidd 
> --search), but I did not search for that too much yet. I will send you the sdp 
> stuff asap. 

make sure that a "hidd --server" is started at boot. The keyboard will
reconnect by itself.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
