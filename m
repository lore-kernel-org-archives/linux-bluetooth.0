Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4550EB07.4030106@vasmac.com>
Date: Tue, 07 Nov 2006 15:22:31 -0500
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4550A345.8040809@vasmac.com>	<1162913214.21754.1.camel@aeonflux.holtmann.net>	<4550BF57.4030205@vasmac.com>	<1162923908.4793.2.camel@aeonflux.holtmann.net>	<4550E039.2070400@vasmac.com>	<1162932072.4793.5.camel@aeonflux.holtmann.net>	<4550E377.7010007@vasmac.com>
	<1162933029.4793.7.camel@aeonflux.holtmann.net>
In-Reply-To: <1162933029.4793.7.camel@aeonflux.holtmann.net>
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
>>>>>>>> I see that the dbus message RemoveBonding clears the link key
>>>>>>>> on the bluetooth adapter but does not remove the entry from the
>>>>>>>> linkkeys file. Afterwards ListBondings still shows a bonding and
>>>>>>>> CreateBonding reports that a bonding already exists. Is this the
>>>>>>>> correct behavior?
>>>>>>>>         
>>>>>>>>             
>>>>>>>>                 
>>>>>>> actually it should remove the entry from the linkkeys file. Otherwise
>>>>>>> this is a bug. Can you check the log files for errors.
>>>>>>>       
>>>>>>>           
>>>>>>>               
>>>>>> I don't see any error message in syslog or anywhere else.
>>>>>> The commands themselves don't seem to report anything
>>>>>> unusual.
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> I am pretty sure that it works as expected. What distro do you have
>>>>> running. Maybe SELinux is restricting access to /var/lib/bluetooth/
>>>>>       
>>>>>           
>>>> OK, I did a little bit of digging and here's a better description:
>>>> Removing a device that has lower case hex numbers does not
>>>> remove it from the linkkeys file. You must use upper case.
>>>>     
>>>>         
>>> that should have been fixed. What version of bluez-utils are you
>>> running.
>>>   
>>>       
>> I'm running the latest, version 3.7 on Ubuntu 6.06.
>>     
>
> check the CVS when it was fixed (if we didn't forget it). I am pretty
> sure that if was fixed before 3.7, but I might be mistaken here. If it
> is still broken or the patch was incomplete, please fix it and send in a
> patch for it.
>
> Regards
>
> Marcel
>   
Looks like the problem is that the function textfile_del in 
common/textfile.c
calls write_key with the icase parameter set to 0. This is NOT fixed in CVS.

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
