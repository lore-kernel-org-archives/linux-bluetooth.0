Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm bind : Address already in use
From: Marcel Holtmann <marcel@holtmann.org>
To: Tetsuo Shiraishi <tetsu@s-direct.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
References: <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
Content-Type: text/plain
Message-Id: <1089396790.22528.6.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 09 Jul 2004 20:13:11 +0200

Hi Tetsuo,

> I'm developing an application waiting for a RFCOMM connection, like following.
> 
> - socket()
> - bind()
> - listen()
> - accept()
>     :
>     :
> 
> I'm in trouble that bind() function fails saying "Address already in use".
> 
> It occurs when waiting for RFCOMM connection from an only special corrupt peer
> once in awhile.
> It works fine to accept from almost peers using bluez, widcomm(for 
> windows)and etc.
> 
> The special corrupt peer sends RFCOMM frames like following sequence.
> (I attached the hcidump log)
> 
>  - RFCOMM_SABM
>  - RFCOMM_PN
>  - RFCOMM_DISC
>  - RFCOMM_DISC
>  - RFCOMM_DISC
>         :
>       repeat
>         :
> 
> Of course, it cannot establish a RFCOMM connection, so I disconnect the ACL
> connection using hcitool utility manually.
> 
> And then I terminate the application, and see /proc/bluetooth/rfcomm information.
> 
> ~ # cat /proc/bluetooth/rfcomm
> sk  E6:D7:1E:96:A0:00 F3:78:51:CF:07:00 9 1
> 
> Is it a garbage ???
> (Probably this causes me the trouble...)
> 
> And I start the application, then the application fails to do bind() 
> saying "Address already in use".
> 
> So I need to reboot...
> 
> I'm working to avoid rebooting in that matter, but cannot find a key to 
> solve it yet.

what kind of peer is this? Why don't you try to fix the problem in the
peer device? The BlueZ RFCOMM part is working correct.

The left over socket you see in /proc is from your application and it is
in the closed state. Do you really terminate your application? Try to
repdroduce this with rctest.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
