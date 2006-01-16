Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060116110016.27927.qmail@webmaild.fe1.aruba.it>
References: <20060113090337.27122.qmail@webmaild.fe1.aruba.it>
            <43C842F9.3090409@cs.bgu.ac.il>
In-Reply-To: <43C842F9.3090409@cs.bgu.ac.il>
From: "Peppe Colicchia" <bluez.list@pc-labs.org>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Subject: [Bluez-users] Re: cannot cat /dev/bluetooth/rfcomm/0
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
Date: Mon, 16 Jan 2006 12:00:15 +0100

> what does this do: 
> 
> # l2ping 00:08:1B:8C:3F:A2

root@h3600:~# l2ping 00:08:1B:8C:3F:A2
Ping: 00:08:1B:8C:3F:A2 from 00:02:C7:0C:AA:B5 (data size 20) ...
44 bytes from 00:08:1B:8C:3F:A2 id 0 time 50.98ms
44 bytes from 00:08:1B:8C:3F:A2 id 1 time 38.50ms
44 bytes from 00:08:1B:8C:3F:A2 id 2 time 33.82ms
44 bytes from 00:08:1B:8C:3F:A2 id 3 time 32.46ms
44 bytes from 00:08:1B:8C:3F:A2 id 4 time 31.29ms
5 sent, 5 received, 0% loss 

> I would also look if they actually are paired

I think the devices are paired: isn't it an operation that i have to do only 
once? I say this cause i was able to use the GPS receiver without problems. 
Now i'm trying several version of Familiar (from 0.8.2-stable to 
0.8.3-snapshots and release candidate) without luck. 

How could i pair again the devices? 

> 
> Niv 
> 

Thanks Niv. 

> 
> P.s. 
> 
> First replay to ML 
> 
> 

Regards, Peppe Colicchia


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
