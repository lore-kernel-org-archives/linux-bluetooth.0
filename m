Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] How do I pair?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200510061820.28005.sf.net@booths.org.uk>
References: <200510060042.36966.sf.net@booths.org.uk>
	 <1128592717.5492.20.camel@localhost.localdomain>
	 <200510061820.28005.sf.net@booths.org.uk>
Content-Type: text/plain
Message-Id: <1128668332.8750.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 07 Oct 2005 08:58:52 +0200

Hi Ken,

> Thanks for the diagnostic tips. I found the a hcid.conf.rpmsave file with the 
> corrects settings. It appears the upgrade changed the following parameters in 
> the hcid.conf file
>         pscan disable;
>         iscan disable;
>         pin_helper /usr/bin/bluepin;
> 
> I fixed the problem by restoring them to
>         pscan enable;
>         iscan enable;
>         pin_helper /bin/bluepincat;
> (the PC identifying itself as "Unknown" is just a signal quality problem - too 
> many walls between computer and phone)
> 
> PS: What do pscan and iscan do?

the page scan (pscan) sets your device to connectable and inquiry scan
(iscan) makes your device discoverable.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
