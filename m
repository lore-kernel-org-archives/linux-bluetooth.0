Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42347901.9010202@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] closing a connection: timing
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
Date: Sun, 13 Mar 2005 18:31:45 +0100

Hello everybody

this is my "server-code":

int client = accept(sock, (struct sockaddr *)&addr, &alen))
char out[] = "200 100";
send(client, out, strlen(out), 0);
// sleep(2);
close(client);


I wrote a little client with the avetana library on my laptop and i'm able 
to receive the message "200 100".

I tested it with my mobile phone (with exactly the same code as with the 
avetana library). Here I'm unable to receive the data. as soon as i try to 
open the inputstream, an exception ("connection already closed") is thrown.
If I uncommend the sleep, it works an i get "200 100".
I now don't know where the source of the problem could be. Do I miss 
something important? Mobile Phone bug?


btw, I tested it with the bluetooth-terminal from kde and only receive "200 
10". -> where is the last "0"?

kind regards
Marco Trudel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
