Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <e85851c20605232040h2cb185bp780b724e667fc84d@mail.gmail.com>
From: "Gloria Saripah Patara" <glowz.saripah@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <e85851c20605230329s754c5187sf2528816a0e64d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e85851c20605230329s754c5187sf2528816a0e64d@mail.gmail.com>
Subject: [Bluez-users] Found -undefined reference-
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
Date: Wed, 24 May 2006 10:40:11 +0700

Have u ever met the error messages like these :

undefined reference to 'OBEX_Cleanup'

i used the command line below:

gcc -o code code.c -lbluetooth

it's occur when i try to call certain function or procedure which
declarated in obex.h file (header file in Openobex libraries).

file code.c is attached inside this message.
-----------------------
Thanks in advance....


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
