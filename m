Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] closing a connection: timing
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42347901.9010202@gmx.ch>
References: <42347901.9010202@gmx.ch>
Content-Type: text/plain
Message-Id: <1110795844.8158.50.camel@pegasus>
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
Date: Mon, 14 Mar 2005 11:24:04 +0100

Hi Marco,

> this is my "server-code":
> 
> int client = accept(sock, (struct sockaddr *)&addr, &alen))
> char out[] = "200 100";
> send(client, out, strlen(out), 0);
> // sleep(2);
> close(client);
> 
> 
> I wrote a little client with the avetana library on my laptop and i'm able 
> to receive the message "200 100".
> 
> I tested it with my mobile phone (with exactly the same code as with the 
> avetana library). Here I'm unable to receive the data. as soon as i try to 
> open the inputstream, an exception ("connection already closed") is thrown.
> If I uncommend the sleep, it works an i get "200 100".
> I now don't know where the source of the problem could be. Do I miss 
> something important? Mobile Phone bug?
> 
> 
> btw, I tested it with the bluetooth-terminal from kde and only receive "200 
> 10". -> where is the last "0"?

I have no idea with the Java problem, but if you send only strlen()
bytes then you miss the null byte at the the end. So even for a char
array you should use sizeof(). If this is a text based protocol you
start to run over RFCOMM send add "\r\n" may also be a good idea.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
