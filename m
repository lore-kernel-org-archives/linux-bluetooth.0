Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] what API to use to disconnect an rfcomm
	connection
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412110213.37305.wim.delvaux@adaptiveplanet.com>
References: <200412110213.37305.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1102756108.19086.1.camel@pegasus>
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
Date: Sat, 11 Dec 2004 10:08:28 +0100

Hi Wim,

> if you started 
> 
> rfcomm x XXXXXXXXXX y &
> and the connection to XXXXXXXXXXX is running,
> 
> How can other application terminate that connection  (much like pand -k addr)
> 
> What API (ioctl ?) should be used ? Code samples ?>

the use of ACL connections is tracked with reference counting and as
long as there is a upper layer connection using the ACL link it is not
closed. If the last one is gone, the disconnect timer is started and
after the timeout the ACL link is terminated.

I hope you asked for this otherwise I don't understand your question.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
