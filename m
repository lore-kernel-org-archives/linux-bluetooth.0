Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 8 Jun 2006 10:48:32 +0200
Message-ID: <96B7A15232D6CF42836BFD428AD6B6034E574D@deexmb01.de.icap.com>
From: "Guido Reimer" <G.Reimer@de.icap.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users]
	bluetooth-alsa:a2recv	stutteringsound	from	WM5.0AKU2.0
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


Brad

>strange. i don't have the ppc now... could you disable the call to
>hci_switch_role() and try running it as root again?

I will do that, as far as i saw the debug output yesterday, this was the
call, that fails, because of permissioning Errors. Will have a look for
that.

>the role switch is required by one of the a2dp transmitter dongles out
>there but if it causes problems we should at least make it a
>command-line option.

>can you tell us the registry hack for the archives?

----------
Make a new Dword value and name is Priority256 and then for the DWORD
Data value make that 60 save and reboot. Presto no more lag, cuts or
audio drop outs. The registry location is at the following. 

HKEY_LOCAL_MACHINE\Drivers\BuiltIn\BtA2dpSnd
---------

http://forum.xda-developers.com/viewtopic.php?t=46811

thanks
Guido


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
