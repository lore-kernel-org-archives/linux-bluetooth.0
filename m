Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45B4966D.2090207@palmsource.com>
Date: Mon, 22 Jan 2007 11:48:13 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45B4093B.4000901@appstate.edu>
In-Reply-To: <45B4093B.4000901@appstate.edu>
Subject: Re: [Bluez-devel] Still trying to install bluetooth headset on
 Mandriva 2007 for Skype
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,
> A2DPD[596.961]: a2dpd_signal_init: OK
> Segmentation fault
>   
Strange,
could you run it through gdb?
I updated the cvs :
you need to
cvs update
configure --enable-debug=yes
make
make install
gdb a2dpd

press 'r'
when it crashes type  'bt' then give us full output.

Anyone else seeing this?

Thanks,

-- 
Frederic

Without the wind, the grass does not move.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
