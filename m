Return-Path: <cyrus@holtmann.org>
Message-ID: <488BC233.8070905@earthlink.net>
Date: Sat, 26 Jul 2008 19:32:51 -0500
From: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4885B849.7040201@wurmsdobler.org>	<1216730752.31819.28.camel@californication>
	<4885E395.8090109@wurmsdobler.org>
	<BLU117-W424BD43283F81BA6D5CF67DF810@phx.gbl>
In-Reply-To: <BLU117-W424BD43283F81BA6D5CF67DF810@phx.gbl>
Subject: Re: [Bluez-users] compile error: bluetooth/bluetooth.h: No such
 file or	directory
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

On 07/26/2008 04:35 PM, thanit sara wrote:
> [...] $ gcc -g -o simplescan simplescan.c -lblutooth "
> As result, below is what I got.
>  
> simplescan.c:5:33: error: bluetooth/bluetooth.h: No such file or directory
> simplescan.c:6:27: error: bluetooth/hci.h: No such file or directory
> simplescan.c:7:31: error: bluetooth/hci_lib.h: No such file or directory
> [...]

It looks like you need the development packages for bluetooth installed. 
For Debian Etch, libbluetooth2-dev contains these files. No doubt it 
will be slightly different for Fedora.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
