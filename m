Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Question about issuing AT commands via cu when
	rfcomm connected to bluetooth phone
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001f01c5041d$7ac09010$8a8115ac@stu.nus.edu.sg>
References: <001f01c5041d$7ac09010$8a8115ac@stu.nus.edu.sg>
Content-Type: text/plain
Message-Id: <1106846707.3998.12.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 27 Jan 2005 18:25:07 +0100

Hi Teck,

> I desire to issue some AT commands to my bluetooth phone as follows
>  
> # rfcomm bind rfcomm0 00:0a:d9:xx:xx:xx 15
> After this I set the permission of the device rfcomm0 to being able to
> read, write and execute by all users. 
>  
> I have the uucp package installed. Next I issued
>  
> #cu -l rfcomm0 -s 9600
> The terminal reflected "Connected" soon after. 
>  
> However, beyond this point I have tried to issue AT commands to my
> phone without success.
> 
> I understand that to use cu, I have to use % before issuing the
> commands.
> 
> Please do enlighten me on how I may use AT commands via cu.

this is not the cu mailing list ;) Check its manual page.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
