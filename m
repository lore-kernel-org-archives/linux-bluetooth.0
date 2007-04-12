Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <EE780E457BC23344B61438FE3608F16E022CA348@MCLNEXVS07.resource.ds.bah.com>
References: <EE780E457BC23344B61438FE3608F16E022CA348@MCLNEXVS07.resource.ds.bah.com>
Date: Fri, 13 Apr 2007 00:50:13 +0200
Message-Id: <1176418213.7049.42.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Sdptool: how to add a UUID value to the
	service	class ID list
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

Hi Anthony,

> I am trying to figure out how to change/add a UUID to the service class
> ID list.  My research pointed me to using the Linux application
> "sdptool".  The command I am using is:  "sdptool -i hci0 setattr 0x10001
> 0x0001 UUID_Address" but to no avail.  
> 
> Q1:  Is "0x0001" the right handle for a service class ID list?
> Q2:  What is the format for the "UUID_Address" listed above, is it-
>      1.  {7C45BBBC-55C0-11D9-A188-0050BAEB61CD}
>      2.  7C45BBBC-55C0-11D9-A188-0050BAEB61CD
>      3.  7C45BBBC55C011D9A1880050BAEB61CD
> Q3:  Any other suggestions about how I can accomplish changing the value
> of the service class ID list? (I am trying to add a UUID)
> Q4:  Is there a better tool/command to use than "sdptool"?

actually you should fix the code that adds the wrong SDP service record
instead of messing around with it later on.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
