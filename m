Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <416536BA.3080901@corscience.de>
From: Thomas Leidenfrost <leidenfrost@corscience.de>
Reply-To: leidenfrost@corscience.de
MIME-Version: 1.0
To: martin f krafft <madduck@madduck.net>
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
References: <41651D72.7040806@corscience.de> <1097147273.7325.26.camel@pegasus> <20041007114224.GA9849@cirrus.madduck.net>
In-Reply-To: <20041007114224.GA9849@cirrus.madduck.net>
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
Date: Thu, 07 Oct 2004 14:29:46 +0200

Hi Martin,

 > modprobe takes the name of a module, not the filename.

you're right, that was a little mistake by my own. Now it says this:
(I've absolutely no idea what's going wrong here)

# modprobe l2cap
Using /lib/modules/2.4.21/l2cap.o
insmod: unresolved symbol malloc
insmod: unresolved symbol putchar
insmod: unresolved symbol free
insmod: unresolved symbol perror
insmod: unresolved symbol parser
insmod: unresolved symbol get_proto
insmod: unresolved symbol cmtp_dump
insmod: unresolved symbol sdp_dump
insmod: unresolved symbol avdtp_dump
insmod: unresolved symbol stderr
insmod: unresolved symbol hidp_dump
insmod: unresolved symbol bnep_dump
insmod: unresolved symbol hcrp_dump
insmod: unresolved symbol rfcomm_dump
insmod: unresolved symbol raw_dump
insmod: unresolved symbol _gp_disp
insmod: unresolved symbol printf
insmod: unresolved symbol fwrite
modprobe: failed to load module l2cap

the linux-distribution I am using is a specific from mycable.

Regards, Thomas


martin f krafft wrote:
> also sprach Marcel Holtmann <marcel@holtmann.org> [2004.10.07.1307 +0200]:
> 
>>>doing # modprobe l2cap.o in /bin results:
> 
> 
> modprobe takes the name of a module, not the filename.
> 
>   modprobe l2cap
> 
> should work. Otherwise your kernel is not compiler correctly.
> 
> What are you using? Debian?
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
