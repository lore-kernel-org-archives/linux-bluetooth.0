Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040318091849.58373.qmail@web40707.mail.yahoo.com>
From: Lalith Chakravarthi <lalithvc@yahoo.com>
Subject: Re: [Bluez-users] Data across Bluetooth Connection - Not file transfer
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: bluez-users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403180939.06022.pavouk@pavouk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 18 Mar 2004 01:18:49 -0800 (PST)

Hi

> I don't know if I exactly understand your needs.
> When you have running PAND server and other side try to make PAN
> connection,
> that kernel calls HOTPLUG with NET ADD action and you can
> automatically 
> configure BNEP0 interface or do some other action, what do you want.

I want the server to wait (you cud say listen) for a command to come
from the client and when that command comes, the server should be able
to do something, like opening an application. 

I dont want it to start up when the bnep interface comes up while the
connection is established. I cant send the command in the file because
I have to pass many such commands to the server in real-time case.

I think there would be a way out for this. But I am not much of a
programmer. If you can give me any ideas, I can have our programmer
implement the same.

Regards
Lalith

__________________________________
Do you Yahoo!?
Yahoo! Mail - More reliable, more storage, less spam
http://mail.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
