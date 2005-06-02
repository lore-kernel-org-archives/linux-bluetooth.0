Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Linking to BlueZ from non-GPL code
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <429ED7F0.2030902@gmx.ch>
References: 
	 <EFCD68F7BFDB06468769D4D9EAAA9387077868B0@scsmsx401.amr.corp.intel.com>
	 <429E4F67.1030104@xmission.com>  <429ED7F0.2030902@gmx.ch>
Content-Type: text/plain
Message-Id: <1117707014.31350.71.camel@pegasus>
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
Date: Thu, 02 Jun 2005 12:10:14 +0200

Hi Marco,

>  > but a technical solution is to write a
> > GPL shim that links with -lbluetooth and that you use via APIs across 
> > which the GPL is not required to hold. Again, talk to your lawyer.
> 
> can you explain that further? as I understand it:
> write an own library that includes the bluez .h files and links agains 
> -lbluetooth
> -> so the own library has to be gpl too
> include the own library (.h file(s)) in the not gpl program
> but because the own library is gpl and you include it again, you program 
> still has to be gpl, right?
> the only difference is that you haven't to link against -lbluetooth. but 
> the header files are gpl too.

you go through a self defined Unix Socket API or D-Bus API. Then you
only have to make the shim layer (the daemon) available under GPL.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
