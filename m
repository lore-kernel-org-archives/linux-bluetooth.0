Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth - 6310i - iBook
From: Marcel Holtmann <marcel@holtmann.org>
To: Jan Sobek <honza@sis.vutbr.cz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040702105653.GF13439@sis.vutbr.cz>
References: <20040702105653.GF13439@sis.vutbr.cz>
Content-Type: text/plain
Message-Id: <1088766165.2803.0.camel@pegasus>
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
Date: Fri, 02 Jul 2004 13:02:46 +0200

Hi Jan,

> I'm trying to connect ibook and nokia 6310 using bluetooth adapter by
> microcom.
> 
> same configuration works for me on my desktop, but on ibook works
> only.
> 	hcitool scan
> 	hcitool info xx.xx.xx.xx.xx.xx
> 
> gnokii --monitor
> GNOKII 0.6.1
> Couldn't open PHONET device: No such file or directory
> Telephone interface init failed: Command failed.
> Quitting
> 
> rfcomm connect rfcomm0 xx.xx.xx.xx.xx.xx
> Can't connect RFCOMM socket: Connection refused

run "hcidump -x" as root while your are trying to connect with Gnokii
and show it to us.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
