Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050203182345.4839.qmail@web26409.mail.ukl.yahoo.com>
From: benbouzid imad <imad_benb@yahoo.fr>
Subject: Re: [Bluez-users] USING PAN: PANU(desktop1) ->NAP(desktop2)->internet
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107451291.11944.96.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Thu, 3 Feb 2005 19:23:45 +0100 (CET)

Hi, 
>>then check with sdptool what is running on your NAP
machine.
all is funny. 
I did 
#sdptool add NAP
and I was able to find it and to connect to it.
but if it's the sdptool which sets the services, what
does it mean --role NAP in thes line :
# pand --listen --role NAP

and, other thing, annother computer which is in
windows XP needs a PIN identifier to connect itself to
my NAP.
where I can find this PIN whereas the PANU in linux
connected successfuly to my NAP without asking for any
PIN.
In windows I tried 0000 and and without any number but
it did't connect.

regards, 

ps:Marcel you are the best i read a lot of mail by
you. and sincerly, I admire you.


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
