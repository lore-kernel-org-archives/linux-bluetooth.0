Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: Aw: Re: [Bluez-users] Problem Connecting to Logitech HS01-V14
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20920897.1107179456716.JavaMail.ngmail@webmail-01.arcor-online.net>
References: <1107118940.8384.19.camel@pegasus>
	 <200501261244.47898.jschindele@arcor.de>
	 <20920897.1107179456716.JavaMail.ngmail@webmail-01.arcor-online.net>
Content-Type: text/plain
Message-Id: <1107181168.7902.6.camel@pegasus>
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
Date: Mon, 31 Jan 2005 15:19:28 +0100

Hi Juergen,

> > only use "auth" and "encrypt" (which means security mode 3) when you
> > know what you are doing. It is off by default for a reason.
> 
> I thought that "auth" is equal with pairing (giving the PIN)

no it is not. It means that your device will be in security mode 3.
Check the manpage of hcid.conf and read the specification.
 
> > You provide a link key, but it seems that the link key is wrong or
> > oudated (if you used it under Windows). The final result is then an
> > authentication error. This can happen with security mode 3.
>  
> How can i generate such a link Key or where i get a new one from ?
> Can I perhaps reset the device's link key ?

There is no need to. Disable auth and try again.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
