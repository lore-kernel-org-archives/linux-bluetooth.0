Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multi-Thread Problem with BlueZ
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Dev <alwaysgone@seznam.cz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <45805.135566-18161-1963570206-1091789060@email.seznam.cz>
References: <45805.135566-18161-1963570206-1091789060@email.seznam.cz>
Content-Type: text/plain
Message-Id: <1091791592.20839.97.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 06 Aug 2004 13:26:32 +0200

Hi Dave,

> To refresh your memory:

sorry for that ;)

> We have a Server side Java application that utilizes Rococo's Bluetooth stack to connect to the underlining Bluez stack.  This server has different services that are used by clients side devices (at this time only symbian phones- Nokia, Siemens, etc.).
>  
> The problem seems to appear when server/RFCOMMservice (SERVICE registered as a service to SDPD.) is trying to send data ( size  more then  10k ) to client1 and then another client -- client2 -- tries to connect to it at the same time (while client1 is connected), all this using RFCOMM layer. (Note:  If only one phone is connected, it works perfectly)
> 
> When two phones try to connect at the same time, sometimes it completly frezes or phone-client2 is not even able to --> discover <-- the Server while the Server is sending data to client1.  For both clients, I'm handling them by using separates threads and just use the API from Rococo to send data to the connected clients...
>  
> Not really sure how to test this and find out what the problem might be.  Rococo says they dont use anything else, they just call BlueZ layer -- and the last time we asked you, you said it works without problems.  But when i am not even able to discover the Server when it's busy, then it cant be on the application layer nor Rococo. (USB hardware?  We have tried many different ones!)
>  
> We were previously trying to solve this before, but have been unlucky thus far.  By using hcidump we found that the Server doesnt act like a master as it should, but it switches between slave and master modes. And Symbian phones don't want to switch themself into slave while they're connected to the Server. So when sending data to a phone, during that time those two device switch between master and slave, fighing who will be master.
>  
> Bluez is set up as follow :
>  
> device {
>         # Local device name
>         #   %d - device id
>         #   %h - host name
>         name "Jellingspot";
> 
>         # Local device class
>         class 0x100;
> 
>         # Default packet type
>         pkt_type DM5;  *****************  We have tried all packet types, others just crash -- this is the most stable one...

Please don't do this, because the link manager must be able to choose
the best packet type and so enabling every packet type should be fine.

>         # Default link mode
>         #   none   - no specific policy 
>         #   accept - always accept incoming connections
>         #   master - become master on incoming connections,
>         #            deny role switch on outgoing connections
>         #
>         #lm accept,master;
>         #
>         lm accept;          ************** CANT do master otherwise it wont work with symbian phones..

If you don't enable rswitch below, the master setting can't work.

>         # Default link policy
>         #   none    - no specific policy
>         #   rswitch - allow role switch
>         #   hold    - allow hold mode
>         #   sniff   - allow sniff mode
>         #   park    - allow park mode
>         #
>         #lp hold,sniff;
>         #
>         lp hold,sniff,park;

Why don't you activate the rswitch option to allow the role switch?

What kind of USB Bluetooth dongles did you tried? Actually a CSR based
with at least HCI 16.4 or HCI 16.14 firmware should work fine. This is
not about the RFCOMM connections. This is about the ACL links and the
problems with scatternets. Check with "hcitool info" the features of
your mobile phones. If they don't support hold or rswitch that can be of
course troubles.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
