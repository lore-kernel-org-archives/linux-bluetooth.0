Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41C71F9D.7000902@cc.gatech.edu>
From: Jay Summet <summetj@cc.gatech.edu>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] File Transfer via Bluetooth
References: <loom.20041220T180020-785@post.gmane.org>
In-Reply-To: <loom.20041220T180020-785@post.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 20 Dec 2004 10:53:17 -0800

If you have the network already working, the hard part is done.

You just have to set up a server daemon on the computer you want to 
"serve" files, and use the correct client on the "client" computer to 
retrieve (or push) files. Each of your computers should have a static IP 
(on the private PAN network). If you don't want to use IP addresses, you 
can edit your /etc/hosts file to give them "real" names.

If you just want to be able to transfer a file here or there, I would 
suggest using scp (secure copy, part of the SSH suite of tools). Make 
sure that at least one of your computers (the server) is running sshd. 
On the other computer (client) use scp to cpy files. (e.g. scp 
"username@server.hostname:~/file_in_users_home_dir.txt ." will copy a 
file from the server into the current directory (the trailing dot 
specifies the current directory).

If you want to mount a filesystem, NSF (or Samba/SMB) would work as 
well, but is a lot harder to setup/configure than scp.

Jay

Hannes Reiff wrote:

>Hi All,
>
>I'm using two pcs to create a pan connection so that both have access to the
>web. No problems. But when it comes to exchange files between the the two pcs -
>what has to be done? Is it possible to establish NFS over bluetooth? (I know
>there are some threads - but no solutions).
>
>Hope you can help me!
>
>Thanks,
>
>Hannes
>
>
>
>  
>




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
