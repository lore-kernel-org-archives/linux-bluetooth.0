Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FD4D6A.9000107@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] "hcitool dev" shows no devices
References: <41FD3E26.1000401@gmx.ch> <1107116116.8384.4.camel@pegasus>	 <41FD462C.8090001@gmx.ch> <1107118082.8384.10.camel@pegasus>
In-Reply-To: <1107118082.8384.10.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sun, 30 Jan 2005 22:11:06 +0100

Hello Marcel

Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>But another question arised starting hcid:
>>The location of etc/bluetooth/pin. Is it hardcoded?
>>I crosscompiled the bluez libs/utils and hcid now tells me on start:
>>Can't open PIN file /usr/local/arm/2.95.3/arm-linux/etc/bluetooth/pin. No 
>>such file or directory(2)
>>
>>Can I change the location of the pin-file? maybee in the hcid.conf?
> 
> 
> there is no option for that. However you can provide a patch if you
> think such an option is usefull.
 >
> You forgot "--sysconfdir=/etc" when you call configure as it is written
> in the README.

that does exactly what I need (and my c knowledge is very limited, I'd 
require a couple of weeks for a patch :-))!

thanks a lot for your help!

kind regards
Marco


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
