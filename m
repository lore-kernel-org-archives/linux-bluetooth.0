Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001701c50bae$ef65d310$0100a8c0@hppav>
From: "Oliver" <urnenfel@tiscali.es>
To: <bluez-devel@lists.sourceforge.net>
References: <848611830@web.de> <1107618796.6921.156.camel@pegasus> <000e01c50bab$c6c6d600$0100a8c0@hppav> <1107627122.6921.182.camel@pegasus>
Subject: Re: [Bluez-devel] struct usb_iso_packet_descriptor
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
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
Date: Sat, 5 Feb 2005 19:17:17 +0100

:(  yes sorry,
Something was wrong in my "GUIed grep application" I use for finding fast 
these things

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sent: Saturday, February 05, 2005 7:12 PM
Subject: Re: [Bluez-devel] struct usb_iso_packet_descriptor


> Hi Oliver,
>
>> Actually just that:
>>
>> I found this definition into the hci_usb.c source and I don't know where
>> does it come from
>>
>> struct usb_iso_packet_descriptor
>
> you are kidding me, right? You know the utilities find and grep? So grep
> along the includes inside the Linux kernel source. Since the prefix is
> usb_ the first guess would be linux/usb.h.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel 

______________________________________________ 

Renovamos el Correo Yahoo!: ¡250 MB GRATIS! 

Nuevos servicios, más seguridad 

http://correo.yahoo.es



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
