Return-Path: <bluez-users-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
In-Reply-To: <1139310563.15160.8.camel@localhost>
References: <C51EAF6C-EE61-4B77-BC7F-3FADB91E923B@epfl.ch> <1139310563.15160.8.camel@localhost>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FA0D666C-A3CF-47DE-9297-7E91421840BD@epfl.ch>
From: Thomas Lochmatter <thomas.lochmatter@epfl.ch>
Subject: Re: [Bluez-users] Concurrent access
To: bluez-users@lists.sourceforge.net
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
Date: Tue, 7 Feb 2006 13:15:51 +0100

>> We have several devices (robots) that we want to access at the same
>> time from several processes via bluetooth (rfcomm virtual serial
>> port). Each process first opens a connection to one robot (/dev/
>> rfcommNN), then communicates with the robot for a while and finally
>> disconnects.
>>
>> When I launch several processes (about 3-5) at the same time, usually
>> only one of them succeeds to connect. If I constantly try to open the
>> devices (in a loop, wait a second and call "open" again), a couple of
>> them are connected after a while, but not all. Is there a way to make
>> that work? Does anyone else have experience with concurrent access to
>> the bluetooth libs?
>
> the baseband of a Bluetooth chip is only capable of paging one  
> device at
> a time. We already had this discussion. You should better look at the
> mailing list archive.

I found a thread regarding concurrent access where the solution was  
to switch to kernel 2.6. However, I am already working on kernel 2.6  
(RH).

I don't think it is a chip limitation issue. In between, I modified  
my program to maintain several connections in the same process/thread  
and that works perfectly. To be more specific, the following works

	Process 1:
	open /dev/rfcomm23
	open /dev/rfcomm45
	send something to rfcomm23
	read from rfcomm23
	send something to rfcomm45
	read from rfcomm45
	close rfcomm23
	close rfcomm45

In the multiprocess version, the following two processes run at the  
same time:

	Process 1:
	open /dev/rfcomm23 until success
	send something to rfcomm23
	read from rfcomm23
	close rfcomm23

	Process 2:
	open /dev/rfcomm45 until success
	send something to rfcomm45
	read from rfcomm45
	close rfcomm45

While process 1 is trying to open a connection to rfcomm23, the other  
process obviously has to wait until the connection is established  
(that might be a chip limitation). However, as soon as the connection  
is established, the other process should be able to open rfcomm45  
before process 1 closes rfcomm23 ...? Because with all being done in  
the same process, it works as well ...

Thanks in advance for your help. If you already discussed this, I'm  
happy to get a pointer to the corresponding thread.

Thomas



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
