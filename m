Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm socket and rfcomm tty
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <I9R8AC$D0025DCFFC50085F41F683811995C5C2@uol.com.br>
References: <I9R8AC$D0025DCFFC50085F41F683811995C5C2@uol.com.br>
Content-Type: text/plain
Message-Id: <1104778495.8894.59.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 03 Jan 2005 19:54:55 +0100

Hi,

> First of all i would like to say
> thanks for you previuos help. Well, I
> am having problems on RFCOMM socket too.
> 
> 		if (bind(sock, (struct sockaddr
> *)&addr, alen) < 0)  {
>    			perror("bind");
>     		exit(1);
> 		}
> 
> can you tell me if there is anything
> wrong is this code? I got a run time
> error that says
> 
> bind:Socket operation on non socket

this code as-is looks correct, but the context is missing. Show us the
complete function.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
