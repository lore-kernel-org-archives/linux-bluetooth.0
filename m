Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4166BC7F.8090104@corscience.de>
From: Thomas Leidenfrost <leidenfrost@corscience.de>
Reply-To: leidenfrost@corscience.de
MIME-Version: 1.0
To: martin f krafft <madduck@madduck.net>
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
References: <41651D72.7040806@corscience.de> <1097147273.7325.26.camel@pegasus> <41652A40.4080209@corscience.de> <1097152912.7325.30.camel@pegasus> <41654062.5050009@corscience.de> <1097154841.7325.36.camel@pegasus> <41654D83.1090306@corscience.de> <1097158664.7325.38.camel@pegasus> <41655C4D.1070206@corscience.de> <20041007154102.GA24256@cirrus.madduck.net>
In-Reply-To: <20041007154102.GA24256@cirrus.madduck.net>
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
Date: Fri, 08 Oct 2004 18:12:47 +0200


Hi Martin, hi Marcel,

used kernel is 2.4.21 with specific modifications to my Mips-System.
But you were absolutely right, it was the wrong rfcomm. Now, modprobing 
rfcomm & bnep is successful! :-)

And guess what, bluetooth is doing fine, too! I thank you very very much 
again for giving all those good advices, the manufactor of could't do...

Greetz & a nice weekend!

Thomas



martin f krafft wrote:
> also sprach Thomas Leidenfrost <leidenfrost@corscience.de> [2004.10.07.1710 +0200]:
> 
>>Now I have depmod installed and I know that my Linux is
>>Debian-based.
>  
> What kernel are you using? Is this the Debian kernel, or a vanilla
> version?
> 




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
