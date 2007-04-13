Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 12 Apr 2007 23:40:55 -0400
Message-ID: <EE780E457BC23344B61438FE3608F16E022CA392@MCLNEXVS07.resource.ds.bah.com>
In-Reply-To: <1176418213.7049.42.camel@violet>
From: "Scott, Anthony" <scott_anthony@bah.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Sdptool: how to add a UUID value to
	theservice	class ID list
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

Howdy Marcel/all:  To clarify things, I'd like to know how to change/add
a UUID to the service class ID list and I strictly do not want to change
the code.  Can you please help me understand how to change/add a UUID to
the service class ID list.  My research pointed me to using the Linux
application "sdptool".  The command I am using is:  "sdptool -i hci0
setattr 0x10001
0x0001 UUID_Address" but to no avail.  

Q1:  Is "0x0001" the right handle for a service class ID list?
Q2:  What is the format for the "UUID_Address" listed above, is it-
     1.  {7C45BBBC-55C0-11D9-A188-0050BAEB61CD}
     2.  7C45BBBC-55C0-11D9-A188-0050BAEB61CD
     3.  7C45BBBC55C011D9A1880050BAEB61CD
Q3:  Any other suggestions about how I can accomplish changing the value
of the service class ID list? (I am trying to add a UUID)
Q4:  Is there a better tool/command to use than "sdptool"?

Warm regards,
Anthony


-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Thursday, April 12, 2007 6:50 PM
To: BlueZ users
Subject: Re: [Bluez-users] Sdptool: how to add a UUID value to
theservice class ID list

Hi Anthony,

> I am trying to figure out how to change/add a UUID to the service 
> class ID list.  My research pointed me to using the Linux application 
> "sdptool".  The command I am using is:  "sdptool -i hci0 setattr 
> 0x10001
> 0x0001 UUID_Address" but to no avail.  
> 
> Q1:  Is "0x0001" the right handle for a service class ID list?
> Q2:  What is the format for the "UUID_Address" listed above, is it-
>      1.  {7C45BBBC-55C0-11D9-A188-0050BAEB61CD}
>      2.  7C45BBBC-55C0-11D9-A188-0050BAEB61CD
>      3.  7C45BBBC55C011D9A1880050BAEB61CD
> Q3:  Any other suggestions about how I can accomplish changing the 
> value of the service class ID list? (I am trying to add a UUID)
> Q4:  Is there a better tool/command to use than "sdptool"?

actually you should fix the code that adds the wrong SDP service record
instead of messing around with it later on.

Regards

Marcel



------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT Join
SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
