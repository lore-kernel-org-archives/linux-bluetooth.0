Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <468A7BFB.4080401@access-company.com>
Date: Tue, 03 Jul 2007 18:40:27 +0200
From: Frederic Dalleau <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46896137.90202@gmail.com>	<d89ddf300707021858u2e5e8f80k35794595254736f6@mail.gmail.com>
	<468A7156.1050708@gmail.com>
In-Reply-To: <468A7156.1050708@gmail.com>
Subject: Re: [Bluez-devel] A few questions about bluetooth-alsa project
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Rogue,

> I see that there are some alsa-lib modules being built. So, do I still 
> need to specify a custom asoundrc file? Wouldn't the device show up 
> automatically in the applet's preferences?
>   
As far as I know, the device won't show up whether there is an .asoundrc 
or not.
However, when the softvol plugin is declared in .asoundrc, it appears in 
the mixer. So I suspect there is a way to make the plugin appears in the 
players. I have never looked after that for now.

At least the entry must be declared in .asoundrc or 
/usr/share/alsa/alsa.conf. I just found a utility called asoundconf. 
This may be funny to try.

Hope this helps.

Frederic

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
