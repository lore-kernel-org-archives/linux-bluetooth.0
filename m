Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <426E7C67.30902@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] auto pairing between client & server
References: <2621d9af05042213064d0df1dc@mail.gmail.com>	 <426ABEBD.5060701@gmx.ch> <2621d9af0504250729e34a2aa@mail.gmail.com>	 <426D00CB.7060508@gmx.ch>  <2621d9af0504260302e1c13c7@mail.gmail.com> <1114515066.10706.204.camel@pegasus>
In-Reply-To: <1114515066.10706.204.camel@pegasus>
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
Date: Tue, 26 Apr 2005 19:37:43 +0200



Marcel Holtmann wrote:
> Hi,
> 
> 
>>I ran a test with the new configuration and found out the bluetooth
>>devices which has this config modified accepted any device coming. The
>>pairing window is not poped up anymore, but the link_key is not
>>updated (still 0 byte).
>>
>>As my understanding, this config ignores the pairing and pin code. It
>>accepts all devices connecting to my device, no authentication. Is
>>that it?
> 
> 
> check the Bluetooth specification and understand the differences between
> the security modes. Use only security mode 3 if you really know what you
> are doing. Otherwise use the service level security features of L2CAP
> and RFCOMM.
> 
> 
>>What I want is to avoid the pin popup for certain bluetooth devices
>>(know specific BD_ADDR). When those allowed devices connect to my
>>device, then I will try to provide "silently" the PIN (no popups) and
>>the pairing should be done from there. If other device which BD_ADDR
>>does not belong to the list of addresses that my device has, it should
>>not be rejected.
> 
> 
> If you wanna do that with the bluez-utils prior 2.16 you need to write
> your own PIN helper program. With 2.16 you can use a pincodes file for
> these task.

If I understand you right, it's possible to replace the pinhelper so that 
etc/bluetooth/pin is read for outgoing connections?
what's the configuration parameter?
pin_helper auto/file; ?

regards
Marco


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
