Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <EE780E457BC23344B61438FE3608F16E022CA392@MCLNEXVS07.resource.ds.bah.com>
References: <EE780E457BC23344B61438FE3608F16E022CA392@MCLNEXVS07.resource.ds.bah.com>
Date: Fri, 13 Apr 2007 15:07:54 +0200
Message-Id: <1176469674.7049.74.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Sdptool: how to add a UUID value
	to	theservice	class ID list
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

> To clarify things, I'd like to know how to change/add
> a UUID to the service class ID list and I strictly do not want to change
> the code.  Can you please help me understand how to change/add a UUID to
> the service class ID list.  My research pointed me to using the Linux
> application "sdptool".  The command I am using is:  "sdptool -i hci0
> setattr 0x10001
> 0x0001 UUID_Address" but to no avail.  
> 
> Q1:  Is "0x0001" the right handle for a service class ID list?

at least bluetooth/sdp.h says so.

> Q2:  What is the format for the "UUID_Address" listed above, is it-
>      1.  {7C45BBBC-55C0-11D9-A188-0050BAEB61CD}
>      2.  7C45BBBC-55C0-11D9-A188-0050BAEB61CD
>      3.  7C45BBBC55C011D9A1880050BAEB61CD

No idea.

> Q3:  Any other suggestions about how I can accomplish changing the value
> of the service class ID list? (I am trying to add a UUID)

Write a program that actually create the record from scratch.

> Q4:  Is there a better tool/command to use than "sdptool"?

No. Write your own one.

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
