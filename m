Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems using rfcomm device
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <871xepoit6.fsf@khaberz.net>
References: <87r7mqidhb.fsf@khaberz.net> <1100861511.7213.0.camel@pegasus>
	 <87is82hzp6.fsf@khaberz.net> <1100862575.7213.6.camel@pegasus>
	 <87ekiqyqx4.fsf@khaberz.net>  <871xepoit6.fsf@khaberz.net>
Content-Type: text/plain
Message-Id: <1100898445.7213.66.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 19 Nov 2004 22:07:25 +0100

Hi Kai,

> > That was it. Thanks a lot!
> 
> Well. Almost. I got further. The PIN authentication worked and the key
> is saved in /etc/bluetooth. However, minicom and pppd still don't
> quite work. Here's what I get from minicom:
> 
> arthur:/home/khaberz# minicom
> minicom: cannot open /dev/rfcomm0: No such file or directory
> 
> It's there of course:
> 
> arthur:/home/khaberz# ls -l /dev/rfcomm0
> crw-rw----  1 root dialout 216, 0 Nov 18 19:48 /dev/rfcomm0

does it work when you do a "cat /dev/rfcomm0" first?

> This is in the syslog:
> 
> Nov 19 18:11:38 arthur kernel: hci_cmd_task: hci0 command tx timeout

Actually this is bad and should not happen. What kind of USB host
controller do you use?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
