Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] implementing security mode 2 or 3
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <426E6F60.2020000@gmx.ch>
References: <426E0C5A.8060203@gmx.ch>
	 <200504261153.08434.bluez-user@schaettgen.de>  <426E5CCC.2030108@gmx.ch>
	 <1114530540.10706.301.camel@pegasus>  <426E6516.3010403@gmx.ch>
	 <1114532376.10706.310.camel@pegasus>  <426E6F60.2020000@gmx.ch>
Content-Type: text/plain
Message-Id: <1114534837.10706.320.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 26 Apr 2005 19:00:37 +0200

Hi Marco,

> >>>the 2.6.7 will fail. The needed security hooks are introduced with
> >>>2.6.10 and the RFCOMM service level security with 2.6.11 according to my
> >>>patch logs.
> >>> 
> >>>>If not, which part of the kernel has to be fixed? Is it a part of bluez?
> >>>
> >>>It is inside the BlueZ core and the RFCOMM layer.
> >>
> >>How long would you have to backport that to kernel 2.6.7?
> >>Maybe we can arrainge something with a donation...
> > 
> > tell me what interfaces are you going to use. Is it always USB? What
> > kernel layers are involved? RFCOMM, BNEP, CMTP, HIDP?
> 
> always USB. RFCOMM services.
> 
> authentication/encryption enabled as suggested on the list:
>     int opt = RFCOMM_LM_AUTH|RFCOMM_LM_ENCRYPT;
>     setsockopt(sock, SOL_RFCOMM, RFCOMM_LM, &opt, sizeof(opt));

this means HCI, L2CAP, RFCOMM and hci_usb driver updates up to
2.6.12-rc2 should be included.

> > You will need more than this two patches for a 2.6.7 based kernel,
> > because there are some serious problems, too.
> 
> actually I never run into problems with the 2.4 kernel. But I think it 
> would definitely make sense to have this things fixed too...

Some of them were hard to trigger and there is still one RFCOMM thing
that is unresolved. Btw do you need a SMP or HT kernel?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
