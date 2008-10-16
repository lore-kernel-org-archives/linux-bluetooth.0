Return-Path: <cyrus@holtmann.org>
Message-ID: <48F7BE3D.1020507@powercraft.nl>
Date: Fri, 17 Oct 2008 00:20:45 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4514.83.160.35.87.1224187105.squirrel@webmail.xs4all.nl>	<48F7AEE4.1030305@powercraft.nl>
	<316F0BAC-515D-4FAF-9465-F0F8A75AB058@gmail.com>
In-Reply-To: <316F0BAC-515D-4FAF-9465-F0F8A75AB058@gmail.com>
Subject: Re: [Bluez-users] Bluez 4.XX pincode authorisation HOW can i use
 it??
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
Errors-To: bluez-users-bounces@lists.sourceforge.net

Johan Hedberg wrote:
> Hi,
> 
> If you want to pair devices from the command line you can e.g. use the  
> simple-agent python script (in the test subdirectory of bluez):
> ./simple-agent hci0 <remote address>
> It will ask you for the pin on stdin.
> 
> Johan

Thank you Johan that helped a lot with one of my devices,

python .simple-agent.py hci0 00:1A:80:AB:0A:B1

the simple-agent script can be found at the bluez git in its testing
directory: git://git.kernel.org/pub/scm/bluetooth/bluez.git

Best regards,

Jelle



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
