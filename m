Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45ACDB79.1060002@idlum.be>
Date: Tue, 16 Jan 2007 15:04:41 +0100
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <200701150802.45350.akohlsmith-bluez@benshaw.com>	<200701151033.37304.akohlsmith-bluez@benshaw.com>	<d23110170701160502l158c445dwd84a5876ce553820@mail.gmail.com>
	<200701160828.37391.akohlsmith-bluez@benshaw.com>
In-Reply-To: <200701160828.37391.akohlsmith-bluez@benshaw.com>
Subject: Re: [Bluez-users] bluez and dbus - how to turn on discovery?
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

Hello Andrew,

> The latest bluez (3.8) does return a grammatically correct XML response now 
> (empty node).  I must ask again though -- how does one see which 
> methods/properties bluez makes available through dbus?  How does one find out 
> which bluetooth interfaces (hci0, hci1, etc.) are available?

For now, have a look at

http://bluez.cvs.sourceforge.net/bluez/utils/hcid/dbus-api.txt?view=markup

You will find that there is a ListAdapters() method in the Manager 
hierarchy which will let you list current adapters, along the list of 
all other methods.

Regards,
Pierre-Yves


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
