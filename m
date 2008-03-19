Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY118-DAV2A9E7DD11DA546948B295C7070@phx.gbl>
From: <ichane@hotmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
References: <BAY118-DAV93F8B33BE33C1D9FAEC00C7070@phx.gbl>
	<47E12208.1050803@aircable.net>
Date: Wed, 19 Mar 2008 23:42:38 +0800
MIME-Version: 1.0
Subject: Re: [Bluez-users] multiple rfcomm listen
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1549962034=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1549962034==
Content-Type: text/plain; format=flowed; charset="big5"; reply-type=original
Content-Transfer-Encoding: 7bit

Hi there:

Sorry for the typo. I did use different rfcomm# to listen:

>rfcomm listen 0 1 &
>rfcomm listen 1 2 &

But 2nd rfcomm client failed to connect as I mentioned earlier.

I wonder if it's USB dongle's problem which is the slave to two masters.
If there is no "role switch",  rfcomm listen should be the slave of 
connecting
rfcomm clients (master).  Can it  be the potential problem (sync) for a 
slave to the
 multiple masters ?

Thanks a lot,

Chane
----- Original Message ----- 
From: "Manuel Naranjo" <manuel@aircable.net>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Sent: Wednesday, March 19, 2008 10:24 PM
Subject: Re: [Bluez-users] multiple rfcomm listen


> Chane,
>> Can "rfcomm listen" accept multiple connections from rfcomm clients? I
>> have tried two rfcomm listen as following:
>> >rfcomm listen 0 1 &
>> >rfcomm listen 0 2 &
> rfcomm listen can listen to up to 7 concurrent connections, but not all
> the connections to the same port (rfcomm# node). You should do:
> rfcomm listen 0 1 &
> rfcomm listen 1 2 &
>
> And when the connection is established you will get:
> /dev/rfcomm0
> /dev/rfcomm1
>
>
>
>


--------------------------------------------------------------------------------


> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/


--------------------------------------------------------------------------------


> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



--===============1549962034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1549962034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1549962034==--
