Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: soraberri <421246@posta.unizar.es>
Message-ID: <cvho9p$d24$1@sea.gmane.org>
References: <cuvg8v$6qs$1@sea.gmane.org> <1109027993.7626.41.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <1109027993.7626.41.camel@pegasus>
Subject: [Bluez-users] Re: Profiles and Service publicing
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
Date: Wed, 23 Feb 2005 12:13:23 +0100

Hi,

> if the headset ends up in a loop like this, then the implementation of
> the headset profile inside the headset has a bug. It is that simple,
> because they should be able to handle a non existing audio gateway
> record nicely.
> 
> Regards
> 
> Marcel


Indeed it hangs in the loop and nothing else can be done with it until 
it is powered off.
I have add a "false" AudioGAteway service to my local SDP database so 
when the headset looks for it, she find it. At least now there is no 
loop but, as expected, the headset doesn't work nicely: it won't close 
an ACL connection to the gateway by its own so, in order to connect with 
btsco I should disconnect this ACL myself (hcitool dc bdaddr_)

How did I add AudioGateway service?
The ugliest way:
·copy add_headset(...) function in sdptool.c
·paste the code and rename to add_headset_ag(...)
·with the changes:

  " si->channel: 5;" to " si->channel: 1;"
HEADSET_SVCLASS_ID to HEADSET_AGW_SVCLASS_ID
HEADSET_PROFILE_ID to HEADSET_AGW_PROFILE_ID

·also adding the line:

{ "HSAG",	HEADSET_AGW_SVCLASS_ID,		add_hs_audio_gw	},
in the service[] structure

Certainly I don't understand roughly what I'm doing...

Regards,

Luis



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
