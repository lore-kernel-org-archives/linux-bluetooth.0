Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 30 May 2008 11:41:59 +0530
Message-ID: <8F72DB7755DD6249B3C46D88BE7F5C0B03EEABCD@bgsmsx411.gar.corp.intel.com>
In-Reply-To: <C1EE57B5-6047-4C5D-9DD7-0A1E6651AD83@holtmann.org>
References: <8F72DB7755DD6249B3C46D88BE7F5C0B03EEA6D5@bgsmsx411.gar.corp.intel.com>
	<C1EE57B5-6047-4C5D-9DD7-0A1E6651AD83@holtmann.org>
From: "Mottadi, Kishore" <kishore.mottadi@intel.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Disable BlueZ profiles
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

Hi Marcel,

Thanks for your reply....
For IOPT testing SDP and L2CAP modules should be enough.
My understanding is that for DUN/HFP/FAX the flow in the stack is
something like the following:
AT Commands--> RFCOMM-->L2CAP--> low level drivers 

And for the FTP and BIP profiles the flow is:

OBEX--> RFCOMM-->L2CAP --> low level drivers

So, in theory if RFCOMM and OBEX modules are removed from the linux
kernel (Eg rmmod rfcomm), the DUN/HSP/FAX/FTP and BIP profiles should be
disabled.

Similarly, removing bnep.ko from the kernel should disable PAN profile.
Is that a correct interpretation??
Also, How do I use bluez-utils-3.32 to disable certain profiles?

Regards
Kishore.


-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Friday, May 30, 2008 2:15 AM
To: BlueZ users
Subject: Re: [Bluez-users] Disable BlueZ profiles

Hi Kishore,

> We found there are some unnecessary profile can be discovered when  
> doing Bluetooth Inter-Op Testing such as  DUN, FTP, FAX, PAN, BIP,  
> HFP. How can I remove/disable these profiles?
>
with bluez-utils-3.32 you have an option to disable certain profiles  
and only test some part. However having all profiles enabled should  
not be a problem at all. So what is your issue regarding inter-op  
testing?

Regards

Marcel


------------------------------------------------------------------------
-
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
