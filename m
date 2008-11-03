Return-Path: <cyrus@holtmann.org>
Message-Id: <25212CE9-C718-4603-BAED-78135D280633@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: hoene@uni-tuebingen.de,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000601c93d02$b06e0900$114a1b00$@hoene@gmx.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Mon, 3 Nov 2008 02:15:19 +0100
References: <001301c93b42$0366d140$0a3473c0$@de>
	<93FCE176-8E54-4DB1-9F6E-F93FF921E4ED@holtmann.org>
	<000601c93d02$b06e0900$114a1b00$@hoene@gmx.net>
Subject: Re: [Bluez-devel] Patch to correct SBC gain mismatch and to
	test	the encoding performance
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Christian,

>> So what is wrong with using sbctester program?
>
> The sbctester program is fine with me. Of course, I will do some  
> indeed
> tests with PEAQ and I will complain until every things works  
> perfect ;-)

yes please. Keep sending patches so we get the SBC encoder and decoder  
passing the SBC conformance tests. I do prefer if we base it around  
sbctester program so that we have a full open source solution (besides  
the reference encoder/decoder).

Regards

Marcel


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
