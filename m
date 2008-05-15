Return-Path: <cyrus@holtmann.org>
Message-ID: <482CB297.7060706@earthlink.net>
Date: Thu, 15 May 2008 17:00:55 -0500
From: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <482AB4AD.50803@earthlink.net>	<1210844479.7025.35.camel@violet.holtmann.net>	<482C1DEE.8000405@earthlink.net>
	<1210858654.7025.48.camel@violet.holtmann.net>
In-Reply-To: <1210858654.7025.48.camel@violet.holtmann.net>
Subject: Re: [Bluez-users] Anycom USB-250 unseen by hcitool
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 05/15/2008 08:37 AM, Marcel Holtmann wrote:
> 
> hciconfig hci0 up :)
> 
> Regards
> 
> Marcel
> 

Thanks very much Marcel. That gets me much closer, but when I start dund 
like so:

hcid
sdpd
dund --nodetach --listen --persist --msdun call palm

and when I tell my Palm E2 to search for a bluetooth network connection, 
nothing appears on my computer screen, and the Palm doesn't find 
anything to connect to.

"Hcitool scan" can find my Palm, but my Palm cannot find
my computer's bluetooth adapter.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
