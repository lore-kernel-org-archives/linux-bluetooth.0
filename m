Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: RFCOMM service level security testing
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20041115T183351-61@post.gmane.org>
References: <1099151759.16247.18.camel@pegasus>
	 <1099433039.7125.13.camel@pegasus>
	 <1099495689.3265.44.camel@baroque.rococosoft.com>
	 <1099496238.6330.2.camel@notepaq>
	 <1099497364.3261.64.camel@baroque.rococosoft.com>
	 <41890BFF.8040501@csr.com> <1099504367.7125.131.camel@pegasus>
	 <4189272C.4080306@csr.com> <1099508519.7125.153.camel@pegasus>
	 <loom.20041115T183351-61@post.gmane.org>
Content-Type: text/plain
Message-Id: <1100542211.7208.66.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Nov 2004 19:10:11 +0100

Hi David,

> Please keep in mind that a device that has been authenticated and even 
> authorized does not necessarily mean it is trusted.  I believe that trusted 
> means that the user does not need to "ok" a secure connection using 
> Authorization for each time it connects.  Some services may wish to have a 
> device be authorized each time it connects to a particular service (profile), 
> even though the device has been previously paired.

this is correct, but this is another topic and for that we need a policy
manager that will take care of it.

> also, regarding enabling/disabling encrypted links...there are a few 
> controllers out there that REQUIRE encyption to be disabled before allowing a 
> Role Switch.  So being able to disable encrption and reenable it Must be an 
> option (without disconnecting RFCOMM and/or L2CAP channels).  There is 
> currently a Bluetooth design proposal to require the controllers to perform 
> this logic...but it is still at an early revision phase, and therefore won't 
> be a requirement for a long time.  This also shows that an application WILL 
> need to be able to talk directly to HCI when it has l2cap and/or rfcomm 
> channels that are active.  When apps start getting more sophisticated and need 
> to allow lots of profiles (Such as phones, PCs, and PDAs), they need to manage 
> the Controller for roles, power management, eSCO, etc.

In general there should be no need to switch the role more than once. I
only must make sure that the role switch is finished before we enable
the encryption.

According to the HCI I really like to avoid that any profile related
applications talk directly to it. This shouldn't be needed.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
