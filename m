Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <401EA1A0.2070906@nokia.com>
From: Tuomo Tikkanen <Tuomo.Tikkanen@nokia.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] A problem with BlueZ-PAN connection: "Connection
 failed. Inappropriate ioctl for device(25)"
References: <3FC7E1C7.8080104@nokia.com>  <4018F8D3.7040205@nokia.com> <1075575743.2720.71.camel@pegasus>
In-Reply-To: <1075575743.2720.71.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 02 Feb 2004 21:14:40 +0200

ext Marcel Holtmann wrote:

>Hi Tuomo,
>
>  
>
>>This is an rather old thread (from end of November 2003) to which I am 
>>here answering, but because I guess some-one will sooner or later have 
>>similar problems I'd like to give a short report how to solve the problem.
>>
>>We even tried to debug the kernel but never found the real reason why 
>>above error occurs. Clearly though some module was missing or misloaded. 
>>However the solution to the problem was rather simple -- just start all 
>>the bluez-daemons manually using a simple script. Our earlier 
>>configuration was such that these daemons were started from 
>>hotplug-system (/etc/hotplug/bluetooth.agent) which seemed to work 
>>otherwise OK, but as now later we can tell pand seems to be somehow 
>>incompatible with hotplugging.
>>    
>>
>
>I don't know why it now works from the bluetooth.agent script, but the
>daemons are designed to run from an init script. The hotplug script is
>for bringing the device up and/or restoring some specific settings.
>  
>

I was perhaps not too clear in my words, namely I was trying to say that 
we have never managed to get system working with bluetooth.agent and 
that we had earlier tried only with bluetooth.agent. Now we have a init 
script and it working like supposed. I can't anymore remember from where 
we copied the instructions to use bluetooth.agent, but to use it was 
definely not our own invention ;-).

-- 
<< Tuomo-Markus Tikkanen <> Tuomo.Tikkanen@nokia.com >>
<< Nokia Research Center <>  Phone: +358 71 803 6480 >>
<< P.O. Box 407          <> Mobile: +358 50 483 6480 >>
<< FIN-00045 NOKIA GROUP <>    FAX: +358 71 803 6210 >>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
