Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] security mode 3 and hcid.conf
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7.0.1.0.0.20060216104256.019e29c0@unizar.es>
References: <7.0.1.0.0.20060216104256.019e29c0@unizar.es>
Content-Type: text/plain
Message-Id: <1140189814.4850.2.camel@aeonflux.holtmann.net>
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
Date: Fri, 17 Feb 2006 16:23:34 +0100

Ni Nacho,

> I have a question about security modes 2 and 3 
> and the configuration of hcid.conf file.
> 
> In security mode 2 the security procedures begin 
> when a L2CAP_ConnectReq takes place.
> 
> In security mode 3, the security procedures begin 
> before the LMP_Link_Setup_Complete command.
> 
> The Bluetooth specification says that in security 
> mode 2 the following attributes are defined:
> 
>          - Authorization required
>          - Authentication required
>          - Encryption required
> 
> In the BlueZ documentation I read that when "auth 
> enable" and (or?) ("encrypt enable") is set, security level 3 is enforced.
> 
> My question is: Is possible to set security level 
> 2 with authorization, authentication and encyption?

look at the l2test.c and rctest.c source code. You will find examples on
how to use the security mode 2.

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
