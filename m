Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050217135456.6070.qmail@web60907.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] rfcomm question 3
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4214975C.7000808@gmx.ch>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-42504244-1108648495=:4638"
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
Date: Thu, 17 Feb 2005 21:54:55 +0800 (CST)

--0-42504244-1108648495=:4638
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Marco!
    I've put some functions you posted before into my main program. As I wish to write the program to act as server, I wrote like this:
int main (int argc, char **argv)
{
 //variable declaration...
 addr.rc_family = AF_BLUETOOTH;
 bacpy(&addr.rc_bdaddr, BDADDR_ANY);
 addr.rc_channel = 4;
 alen = sizeof(addr);
 //mysql initialization....
 while (1)
 {
  // request a socket from the operating system
  if((sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0)
  {
   printf("socket(...) failed");
   exit(1);
   }
  // bind the socket to the system
  if(bind(sock, (struct sockaddr *)&addr, alen) < 0)
  {
   printf("bind(...) failed\n");
   exit(2);
   }
  // set the socket into listen mode. handle 10 (QUEUE) connections.
  if(listen(sock, 10) < 0)
  {
   printf("listen(...) failed\n");
   exit(3);
   }
  while(client = accept(sock, (struct sockaddr *)&addr, &alen))
  {
   char remoteAddr[18];
   ba2str(&addr.rc_bdaddr, remoteAddr);
   printf("connection from %s:\n", remoteAddr);
   // send a "hello from server" to client
   char out[] = "hello from server";
   send(client, out, strlen(out), 0);
   printf("> %s\n", out);
   // read the answer
   char buffer[101]; // buffer size 100, 1 for '\0'
   int noReadChars = recv(client, buffer, sizeof(buffer)-1, 0);
   buffer[noReadChars] = '\0'; // here the received answer ends
   printf("< %s\n", buffer);
   while (1)
   {
          .......
 
After I ran it, the sock, bind and listen functions were all passed. But after that, I couldn't see any result about it. Then I wish to fiind out how to connect SE T610 to bluez in my PC, but I couldn't find the method. And the strange thing is that the phone could search my PC and then added it on the "My device" list, I was wondering why couldn't the phone initialize the connection to PC. I'm very surprising that Jay Summet said that T610 cannot connect to bluez in Linux PC. So I wish Jay also to explain why, and does it mean that there is no method that T610 can really initialize the connection to PC?
By the way, after I looked at the specification of the bluetooth system, I could not find any way to write sdp program. So, can you and other mail users suggest a method for me to do? I really thank you very much for your kindness.
Michael
 
Marco Trudel <mtrudel@gmx.ch> wrote:
Ka Kin Cheung wrote:
> Hi all!
> I'm still doing my project. Now I face a problem
> that the T610 still cannot connect to PC. Then my
> tutor said that I have to write a sdp program to let
> the phone to connect to PC.

this has nothing to do with it. i think you tutor is wrong...
if your pc is listening on a rfcomm channel, then you can connect with a
url like btspp://0123456789AB:4
the first part is the protocol, the second the mac address, the last one
the channel number.
have you tried/understood my last post to you:
http://sourceforge.net/mailarchive/message.php?msg_id=10756581

you need a sdp-entry only if the mobile phone wants to do a service search
(paging) what's not needed. a inquiry could get you the mac address and you
then can connect to the listening port in your program.

if it still doesn't work, please send a description of what you exactly do
and what the exact results are. please use hcidump as well...

regards
Marco


> I wish to know that is
> there any guideline or even the source code for sdp
> programming? It is urgent as my tutor said he used two
> months to do it before. 
> Thank you very much for your kindness.
> Michael
> 
> 
> _______________________________________________________________________
> 新年願望第一位 : 找到友緣人
> http://personals.yahoo.com.hk
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



---------------------------------
新年願望第一位 :  找到友緣人 

--0-42504244-1108648495=:4638
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Marco!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; I've put some functions you posted before into my main program. As I wish to write the program to act as server, I wrote like this:</DIV>
<DIV>int main (int argc, char **argv)<BR>{<BR>&nbsp;//variable declaration...</DIV>
<DIV>&nbsp;addr.rc_family = AF_BLUETOOTH;<BR>&nbsp;bacpy(&amp;addr.rc_bdaddr, BDADDR_ANY);<BR>&nbsp;addr.rc_channel = 4;<BR>&nbsp;alen = sizeof(addr);<BR>&nbsp;//mysql initialization....</DIV>
<DIV>&nbsp;while (1)<BR>&nbsp;{<BR>&nbsp;&nbsp;// request a socket from the operating system<BR>&nbsp;&nbsp;if((sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) &lt; 0)<BR>&nbsp;&nbsp;{<BR>&nbsp;&nbsp;&nbsp;printf("socket(...) failed");<BR>&nbsp;&nbsp;&nbsp;exit(1);<BR>&nbsp;&nbsp;&nbsp;}<BR>&nbsp;&nbsp;// bind the socket to the system<BR>&nbsp;&nbsp;if(bind(sock, (struct sockaddr *)&amp;addr, alen) &lt; 0)<BR>&nbsp;&nbsp;{<BR>&nbsp;&nbsp;&nbsp;printf("bind(...) failed\n");<BR>&nbsp;&nbsp;&nbsp;exit(2);<BR>&nbsp;&nbsp;&nbsp;}<BR>&nbsp;&nbsp;// set the socket into listen mode. handle 10 (QUEUE) connections.<BR>&nbsp;&nbsp;if(listen(sock, 10) &lt; 0)<BR>&nbsp;&nbsp;{<BR>&nbsp;&nbsp;&nbsp;printf("listen(...) failed\n");<BR>&nbsp;&nbsp;&nbsp;exit(3);<BR>&nbsp;&nbsp;&nbsp;}<BR>&nbsp;&nbsp;while(client = accept(sock, (struct sockaddr *)&amp;addr, &amp;alen))<BR>&nbsp;&nbsp;{<BR>&nbsp;&nbsp;&nbsp;char remoteAddr[18];<BR>&nbsp;&nbsp;&nbsp;ba2str(&amp;addr.rc_bdaddr,
 remoteAddr);<BR>&nbsp;&nbsp;&nbsp;printf("connection from %s:\n", remoteAddr);<BR>&nbsp;&nbsp;&nbsp;// send a "hello from server" to client<BR>&nbsp;&nbsp;&nbsp;char out[] = "hello from server";<BR>&nbsp;&nbsp;&nbsp;send(client, out, strlen(out), 0);<BR>&nbsp;&nbsp;&nbsp;printf("&gt; %s\n", out);<BR>&nbsp;&nbsp;&nbsp;// read the answer<BR>&nbsp;&nbsp;&nbsp;char buffer[101]; // buffer size 100, 1 for '\0'<BR>&nbsp;&nbsp;&nbsp;int noReadChars = recv(client, buffer, sizeof(buffer)-1, 0);<BR>&nbsp;&nbsp;&nbsp;buffer[noReadChars] = '\0'; // here the received answer ends<BR>&nbsp;&nbsp;&nbsp;printf("&lt; %s\n", buffer);<BR>&nbsp;&nbsp;&nbsp;while (1)<BR>&nbsp;&nbsp;&nbsp;{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .......</DIV>
<DIV>&nbsp;</DIV>
<DIV>After I ran it, the sock, bind and listen functions were all passed. But after that, I couldn't see any result about it. Then I wish to fiind out how to connect SE T610 to bluez in my PC, but I couldn't find the method. And the strange thing is that the phone could search my PC and then added it on the "My device" list, I was wondering why couldn't the phone initialize the connection to PC. I'm very surprising that Jay Summet said that T610 cannot connect to bluez in Linux PC. So I wish Jay also to explain why, and does it mean that there is no method that T610 can really initialize the connection to PC?</DIV>
<DIV>By the way, after I looked at the specification of the bluetooth system, I could not find any way to write sdp program. So, can you and other mail users suggest a method for me to do? I really thank you very much for your kindness.</DIV>
<DIV>Michael</DIV>
<DIV>&nbsp;</DIV>
<DIV><B><I>Marco Trudel &lt;mtrudel@gmx.ch&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Ka Kin Cheung wrote:<BR>&gt; Hi all!<BR>&gt; I'm still doing my project. Now I face a problem<BR>&gt; that the T610 still cannot connect to PC. Then my<BR>&gt; tutor said that I have to write a sdp program to let<BR>&gt; the phone to connect to PC.<BR><BR>this has nothing to do with it. i think you tutor is wrong...<BR>if your pc is listening on a rfcomm channel, then you can connect with a<BR>url like btspp://0123456789AB:4<BR>the first part is the protocol, the second the mac address, the last one<BR>the channel number.<BR>have you tried/understood my last post to you:<BR>http://sourceforge.net/mailarchive/message.php?msg_id=10756581<BR><BR>you need a sdp-entry only if the mobile phone wants to do a service search<BR>(paging) what's not needed. a inquiry could get you the mac address and you<BR>then can connect to the listening port in your program.<BR><BR>if it still doesn'
 t work,
 please send a description of what you exactly do<BR>and what the exact results are. please use hcidump as well...<BR><BR>regards<BR>Marco<BR><BR><BR>&gt; I wish to know that is<BR>&gt; there any guideline or even the source code for sdp<BR>&gt; programming? It is urgent as my tutor said he used two<BR>&gt; months to do it before. <BR>&gt; Thank you very much for your kindness.<BR>&gt; Michael<BR>&gt; <BR>&gt; <BR>&gt; _______________________________________________________________________<BR>&gt; 新年願望第一位 : 找到友緣人<BR>&gt; http://personals.yahoo.com.hk<BR>&gt; <BR>&gt; <BR>&gt; -------------------------------------------------------<BR>&gt; SF email is sponsored by - The IT Product Guide<BR>&gt; Read honest &amp; candid reviews on hundreds of IT Products from real users.<BR>&gt; Discover which products truly live up to the hype. Start reading now.<BR>&gt; http://ads.osdn.com/?ad_id=6595&amp;alloc_id=14396&amp;op=click<BR>&gt;
 _______________________________________________<BR>&gt; Bluez-users mailing list<BR>&gt; Bluez-users@lists.sourceforge.net<BR>&gt; https://lists.sourceforge.net/lists/listinfo/bluez-users<BR>&gt; <BR>&gt; <BR><BR><BR>-------------------------------------------------------<BR>SF email is sponsored by - The IT Product Guide<BR>Read honest &amp; candid reviews on hundreds of IT Products from real users.<BR>Discover which products truly live up to the hype. Start reading now.<BR>http://ads.osdn.com/?ad_id=6595&amp;alloc_id=14396&amp;op=click<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p><br><hr size=1>新年願望第一位 :  <a href=http://hk.personals.yahoo.com>找到友緣人 </a><br>
--0-42504244-1108648495=:4638--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
