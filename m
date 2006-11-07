Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4550BF57.4030205@vasmac.com>
Date: Tue, 07 Nov 2006 12:16:07 -0500
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4550A345.8040809@vasmac.com>
	<1162913214.21754.1.camel@aeonflux.holtmann.net>
In-Reply-To: <1162913214.21754.1.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Bonding
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> Hi Jose,
>
>   
>> I see that the dbus message RemoveBonding clears the link key
>> on the bluetooth adapter but does not remove the entry from the
>> linkkeys file. Afterwards ListBondings still shows a bonding and
>> CreateBonding reports that a bonding already exists. Is this the
>> correct behavior?
>>     
>
> actually it should remove the entry from the linkkeys file. Otherwise
> this is a bug. Can you check the log files for errors.
>
> Regards
>
> Marcel
>   

Hi Marcel,

I don't see any error message in syslog or anywhere else.
The commands themselves don't seem to report anything
unusual.

Jose


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
