Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4214A5E1.4090207@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm question 3
References: <20050217135456.6070.qmail@web60907.mail.yahoo.com>
In-Reply-To: <20050217135456.6070.qmail@web60907.mail.yahoo.com>
Content-Type: text/plain; charset=Big5
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
Date: Thu, 17 Feb 2005 15:10:41 +0100

Ka Kin Cheung wrote:
> Hi Marco!
>     I've put some functions you posted before into my main program. As I 
> wish to write the program to act as server, I wrote like this:
> int main (int argc, char **argv)
> {
>  //variable declaration...
>  addr.rc_family = AF_BLUETOOTH;
>  bacpy(&addr.rc_bdaddr, BDADDR_ANY);
>  addr.rc_channel = 4;
>  alen = sizeof(addr);
>  //mysql initialization....
>  while (1)
>  {
>   // request a socket from the operating system
>   if((sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0)
>   {
>    printf("socket(...) failed");
>    exit(1);
>    }
>   // bind the socket to the system
>   if(bind(sock, (struct sockaddr *)&addr, alen) < 0)
>   {
>    printf("bind(...) failed\n");
>    exit(2);
>    }
>   // set the socket into listen mode. handle 10 (QUEUE) connections.
>   if(listen(sock, 10) < 0)
>   {
>    printf("listen(...) failed\n");
>    exit(3);
>    }
>   while(client = accept(sock, (struct sockaddr *)&addr, &alen))
>   {
>    char remoteAddr[18];
>    ba2str(&addr.rc_bdaddr, remoteAddr);
>    printf("connection from %s:\n", remoteAddr);
>    // send a "hello from server" to client
>    char out[] = "hello from server";
>    send(client, out, strlen(out), 0);
>    printf("> %s\n", out);
>    // read the answer
>    char buffer[101]; // buffer size 100, 1 for '\0'
>    int noReadChars = recv(client, buffer, sizeof(buffer)-1, 0);
>    buffer[noReadChars] = '\0'; // here the received answer ends
>    printf("< %s\n", buffer);
>    while (1)
>    {
>           .......
>  
> After I ran it, the sock, bind and listen functions were all passed. But 
> after that, I couldn't see any result about it.

question: what do you expect? my pc usually starts a britney spears mp3 and
makes a couple of somersaults...
no, serious: what do you expect??? nothing will happen after that because
the pc waits for a client connection.

please - really -  read a couple of tutorials about socket programming and
try to understand what the codes does that you write.
as already was said: this list is not here to explain you how socket
programming works...

> Then I wish to fiind out
> how to connect SE T610 to bluez in my PC, but I couldn't find the 
> method.

you've to write a client program for that runs on the mobile phone.
if i remember right, the T610 hasn't support for jsr82. I don't know if
you're able to do c programming on it and have access to the bluetooth system.
i use a nokia 6230, there you have mdip2.0 and jsr83. so it's no problem at
all...

regards
Marco


> And the strange thing is that the phone could search my PC and
> then added it on the "My device" list, I was wondering why couldn't the 
> phone initialize the connection to PC. I'm very surprising that Jay 
> Summet said that T610 cannot connect to bluez in Linux PC. So I wish Jay 
> also to explain why, and does it mean that there is no method that T610 
> can really initialize the connection to PC?
> By the way, after I looked at the specification of the bluetooth system, 
> I could not find any way to write sdp program. So, can you and other 
> mail users suggest a method for me to do? I really thank you very much 
> for your kindness.
> Michael
>  
> */Marco Trudel <mtrudel@gmx.ch>/* wrote:
> 
>     Ka Kin Cheung wrote:
>      > Hi all!
>      > I'm still doing my project. Now I face a problem
>      > that the T610 still cannot connect to PC. Then my
>      > tutor said that I have to write a sdp program to let
>      > the phone to connect to PC.
> 
>     this has nothing to do with it. i think you tutor is wrong...
>     if your pc is listening on a rfcomm channel, then you can connect with a
>     url like btspp://0123456789AB:4
>     the first part is the protocol, the second the mac address, the last one
>     the channel number.
>     have you tried/understood my last post to you:
>     http://sourceforge.net/mailarchive/message.php?msg_id=10756581
> 
>     you need a sdp-entry only if the mobile phone wants to do a service
>     search
>     (paging) what's not needed. a inquiry could get you the mac address
>     and you
>     then can connect to the listening port in your program.
> 
>     if it still doesn' t work, please send a description of what you
>     exactly do
>     and what the exact results are. please use hcidump as well...
> 
>     regards
>     Marco
> 
> 
>      > I wish to know that is
>      > there any guideline or even the source code for sdp
>      > programming? It is urgent as my tutor said he used two
>      > months to do it before.
>      > Thank you very much for your kindness.
>      > Michael
>      >
>      >
>      >
>     _______________________________________________________________________
>      > 新年願望第一位 : 找到友緣人
>      > http://personals.yahoo.com.hk
>      >
>      >
>      > -------------------------------------------------------
>      > SF email is sponsored by - The IT Product Guide
>      > Read honest & candid reviews on hundreds of IT Products from real
>     users.
>      > Discover which products truly live up to the hype. Start reading now.
>      > http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>      > _______________________________________________
>      > Bluez-users mailing list
>      > Bluez-users@lists.sourceforge.net
>      > https://lists.sourceforge.net/lists/listinfo/bluez-users
>      >
>      >
> 
> 
>     -------------------------------------------------------
>     SF email is sponsored by - The IT Product Guide
>     Read honest & candid reviews on hundreds of IT Products from real users.
>     Discover which products truly live up to the hype. Start reading now.
>     http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>     _______________________________________________
>     Bluez-users mailing list
>     Bluez-users@lists.sourceforge.net
>     https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> ------------------------------------------------------------------------
> 新年願望第一位 : 找到友緣人 <http://hk.personals.yahoo.com>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
