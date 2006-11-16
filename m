Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <009e01c70908$9ab526a0$8ba54256@claudia>
References: <009e01c70908$9ab526a0$8ba54256@claudia>
Date: Thu, 16 Nov 2006 11:30:24 +0100
Message-Id: <1163673024.5169.25.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Signification of the state term
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

Hi,

> I search the signification of the "state" term given for each
> connection
> by the "hcitool con" command.
>  
>  
> 1. First, I have an ACL connection between 2 bluetooth kits    : the
> state of the ACL connection is 1
>  
> 2. I create an SCO connection on this ACL connection           :  the
> state of the ACL connection stills 1
>  
> 3. I make an HCI_disconnect on one side of the connection.     
>  
> With hcidump, after the HCI_disconnect command, I see consecutively
> two events of  complete deconnection :
>  
> - the first one  for the SCO link,
> - the second one for the ACL link.
>  
> But, the "hcitool con" command shows again the ACL connection with 8
> value for the "state".
>  
> When I try to disconnect this link I have a disconnect error.
>  
> Does someone have an idea ? What is the signification of a 8 value for
> the "state" ?

it is the connection state. Check /usr/include/bluetooth/bluetooth.h and
its enum for all possible states.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
