Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FFAE36.4070400@student.ethz.ch>
From: Patrick Stuedi <stuedip@student.ethz.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bnep/Broadcast
References: <41FF8E7E.9000509@student.ethz.ch>	 <1107267619.9652.31.camel@pegasus>  <41FFA828.9050109@student.ethz.ch> <1107274227.9652.52.camel@pegasus>
In-Reply-To: <1107274227.9652.52.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 01 Feb 2005 17:28:38 +0100

...thank you for the answer marce. The reason I ask all this stuff is 
because I heard in Bluetooth is there is some pico-wide broadcast 
mechanism called ASB or Active Slave Broadcast and I wondered how this 
is mapped to Bnep.

Regards,
Patrick

Marcel Holtmann wrote:

>Hi Patrick,
>
>  
>
>>..so that means it doesn't work unless I bridge things on the master?
>>    
>>
>
>if you don't bridge on the master you have two virtual networks cards,
>named bnep0 and bnep1. How would you broadcast on two different devices?
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
>Tool for open source databases. Create drag-&-drop reports. Save time
>by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
>Download a FREE copy at http://www.intelliview.com/go/osdn_nl
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
