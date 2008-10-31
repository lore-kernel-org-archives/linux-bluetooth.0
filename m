Return-Path: <cyrus@holtmann.org>
Message-Id: <93FCE176-8E54-4DB1-9F6E-F93FF921E4ED@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001301c93b42$0366d140$0a3473c0$@de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Sat, 1 Nov 2008 00:18:34 +0100
References: <001301c93b42$0366d140$0a3473c0$@de>
Cc: 'Frans de Bont' <frans.de.bont@philips.com>
Subject: Re: [Bluez-devel] Patch to correct SBC gain mismatch and to test
	the encoding performance
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

> attached you will find a patch to correct the following issues.
>
> 1.) Gain of the decoder is corrected (before it was 6.02dB or twice  
> too low)
> 2.) Gain of the encoder is corrected (empirical gathered values were  
> used to
> correct the filter tables)
> 3.) "sbcenc" supports more command line options.

it would be nice if you just follow our coding style conventions. I  
fixed this up for you this time. Please compare the result that I  
pushed to the repository and your version.

> 4.) A testing procedure for SBC is added including a script to test  
> and a
> remote interface to PEAQ. It requires the reference version of SBC
> (available at the Bluetooth SIG website) and wine. Please note, that  
> the
> remote access to PEAQ is restricted and only available by request  
> for a
> limited time. Requesty from all unknown IP addresses are blocked by  
> default.

So what is wrong with using sbctester program?

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
