Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: jirka@dopis.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200312171020.50300.jirka@dopis.cz>
Subject: [Bluez-users] rfcomm failing after PIN is entered on nokia 6310i
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
Date: Wed, 17 Dec 2003 10:20:50 +0100

Hi all.

I'm setting up a bluetooth connection between
my server and Nokia 6310i phone. This connection
was working (phone and server was paired), but now
I'm asked by phone for entering a PIN (maybe i've
changed USB bluetooth dongle, because i have
2 units).

After typing

# rfcomm connect rfcomm0

(i'm sure that rfcomm0 is well configured in a rfcomm.conf)
i must confirm the conection on the phone and then
i'm asked by the phone for a PIN number. After inserting 
the same PIN as in /etc/bluetooth/pin i see:

uran:/home/kodoub# rfcomm connect rfcomm0
Can't connect RFCOMM socket: Resource temporarily unavailable

My pin_helper is a bash script with echo "PIN:XXXXX".
The same problem i have also on my second computer.
I'm using Debian with different kernels on these
computers (patched Linux version 2.4.20-k7-mh8 and
Linux version 2.4.22). I'm sure that i solved this
problem in the past after a days, but i've forget
the solution. Please, can anybody help me remember
what is bad?

Thanx, Jirka.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
