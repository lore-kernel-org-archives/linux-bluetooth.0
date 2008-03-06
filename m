Return-Path: <cyrus@holtmann.org>
Message-ID: <75FAE26125E34CEBB2A6589F506A6784@iMe>
From: "Eng. Waleed Al-Rashoud" <iwaleed@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
References: <fqnfkk$9np$1@ger.gmane.org> <1521D68760504C61837D70AA89588A3E@iMe>
	<A3582650-894E-4E59-A156-42D2C5D973C0@holtmann.org>
Date: Fri, 7 Mar 2008 02:11:58 +0300
MIME-Version: 1.0
Subject: Re: [Bluez-users] How to change the Hci packet size?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Thanks.. but I remember something in the Bluetooth standard like 'continue' 
flag in each HCI packet.. Who is responsible to fill this?
Thanks again marcel..


--------------------------------------------------
From: "Marcel Holtmann" <marcel@holtmann.org>
Sent: Thursday, March 06, 2008 5:53 PM
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to change the Hci packet size?

> Hi,
>
>> Hi, what it the largest packet size for the Hci?
>> Is it a configuration in the BlueZ or is it a configuration in the
>> adapter?
>
> don't bother in trying. The firmware inside the Bluetooth chip is
> responsible for doing this job. It will pick the packet type that is
> best suitable.
>
> Regards
>
> Marcel
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
