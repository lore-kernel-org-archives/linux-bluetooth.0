Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060830033014.31616.qmail@web51409.mail.yahoo.com>
Date: Tue, 29 Aug 2006 20:30:14 -0700 (PDT)
From: manojt ambe <mp_tambe@yahoo.com>
To: Linux@feline-soul.com, bluez-users@lists.sourceforge.net
In-Reply-To: <200608291908.52176.Linux@feline-soul.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] How do I reset a pairing?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1463522694=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1463522694==
Content-Type: multipart/alternative; boundary="0-1849471022-1156908614=:31614"
Content-Transfer-Encoding: 8bit

--0-1849471022-1156908614=:31614
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I performed following steps.
  1 ) I modified /usr/local/etc/dbus-1/system.conf as below. 
  <!-- This is included last so local configuration can override what's 
  in this standard file -->
  <include ignore_missing="yes">/etc/dbus-1/system.d/bluez-hcid.conf</include>
   
  2) I created a user "messagebus" and restarted dbus,hcid and passkey-agent.
   
  After this the error "can't get on system bus" went away. 

  thanks, Manoj
  
"Bearcat M. Sandor" <Linux@feline-soul.com> wrote:
  Marcel,

Ok, the passkey-agent runs. But i get errors. Here's what i'm doing:

1. Switch to root.
1. put headset into paring mode.
2. run "btsco 00:0D:44:4F:37:72"
3. run "passkey-agent 0000 00:0D:44:4F:37:72"

I get "Can't get on system bus" from passkey-agent. Is dbus misconfigured?

I know dbus is running. The "00:0D:44:4F:37:72" is the address of my 
headset. "0:07:61:1C:9F:D3" is the address of my hub. I've tried that as 
well. I've also tried encapsulating the 0000 with quotes in case it is a 
string. I am running passkey-agent as root.

What am i doing wrong. Is there a way to create the file 
in /var/lib/bluetooth\00:07:61:1C:9F:D3 by hand? What should the file be 
called and what should it contain.

I am very confused by the configuration of all this. I have seen documentation 
that states that i need:

1. passkey "0000" in my hcid.conf file
2. a /etc/bluetooth/passkeys/default file.
3. A script to be called in the config file
4. and now a passkey agent.

I know that the bluez site states that there is good documentation on the web, 
but that's simply *not* true. Most of it conflicts and is apparently outdated 
if only #4 is true now.

What am i doing wrong with this passkey-agent. If my headset device is 
00:0D:44:4F:37:72 and my hub is 00:07:61:1C:9F:D3 what should the command be?

Simply, if you were me, what steps would you take to get this working.

Thank you for your help so far.

My hcidump is as follows:
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: Inquiry (0x01|0x0001) plen 5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Complete (0x01) plen 1
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6

The "btsco 00:0D:44:4F:37:72" command gives me:
Error: Failed to connect to SDP server: Function not implemented
Assuming channel 2

Can't connect RFCOMM channel: Resource temporarily unavailable


Bearcat




On Tuesday 29 August 2006 17:46 in an email titled "Re: [Bluez-users] How do I 
reset a pairing?" Marcel Holtmann wrote:
>Hi Bearcat,
>
>> I looked it over. I am only just starting to learn C so this is a little
>> daunting. I tried a "gcc -Wall -o passkey-agent -passkey-agent.c" and that
>> didn't work (i didn't really expect it to). I didn't see a configure
>> script that would create a make file for the agent.
>
>after ./configure you can run make and it will compile passkey-agent for
>you. It will always be compiled, but never be installed.
>
>> If my X system goes down, all of my paring devices will go down with it,
>> since i would need gnome up to get them working. How can i get this agent
>> working?
>
>Once the devices are paired. You have a link key. The hcid handles this
>for you. You need the passkey agent only for entering the PIN code.
>
>> I'm just confused. Since the bluez-gnome is a new release, what did people
>> do before it arrived to get pairing devices working?
>
>Actually I expected that someone else will write the appropriate passkey
>agents for their desktop systems. So in the end I did for the one that I
>use. Only the Nokia 770 Maemo platform had its own passkey agent.
>
>Regards
>
>Marcel

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
Jabber: bearcat@jabber.feline-soul.net
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 		
---------------------------------
How low will we go? Check out Yahoo! Messenger’s low  PC-to-Phone call rates.
--0-1849471022-1156908614=:31614
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>I performed following steps.</DIV>  <DIV>1 ) I modified /usr/local/etc/dbus-1/system.conf as below. </DIV>  <DIV>&lt;!-- This is included last so local configuration can override what's </DIV>  <DIV>in this standard file --&gt;</DIV>  <DIV>&lt;include ignore_missing="yes"&gt;/etc/dbus-1/system.d/bluez-hcid.conf&lt;/include&gt;</DIV>  <DIV>&nbsp;</DIV>  <DIV>2) I created&nbsp;a user "messagebus" and restarted dbus,hcid and passkey-agent.</DIV>  <DIV>&nbsp;</DIV>  <DIV>After this&nbsp;the error "can't get on system bus" went away. <BR></DIV>  <DIV>thanks, Manoj</DIV>  <DIV><BR><B><I>"Bearcat M. Sandor" &lt;Linux@feline-soul.com&gt;</I></B> wrote:</DIV>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Marcel,<BR><BR>Ok, the passkey-agent runs. But i get errors. Here's what i'm doing:<BR><BR>1. Switch to root.<BR>1. put headset into paring mode.<BR>2. run "btsco 00:0D:44:4F:37:72"<BR>3. run "passkey-agent 0000
 00:0D:44:4F:37:72"<BR><BR>I get "Can't get on system bus" from passkey-agent. Is dbus misconfigured?<BR><BR>I know dbus is running. The "00:0D:44:4F:37:72" is the address of my <BR>headset. "0:07:61:1C:9F:D3" is the address of my hub. I've tried that as <BR>well. I've also tried encapsulating the 0000 with quotes in case it is a <BR>string. I am running passkey-agent as root.<BR><BR>What am i doing wrong. Is there a way to create the file <BR>in /var/lib/bluetooth\00:07:61:1C:9F:D3 by hand? What should the file be <BR>called and what should it contain.<BR><BR>I am very confused by the configuration of all this. I have seen documentation <BR>that states that i need:<BR><BR>1. passkey "0000" in my hcid.conf file<BR>2. a /etc/bluetooth/passkeys/default file.<BR>3. A script to be called in the config file<BR>4. and now a passkey agent.<BR><BR>I know that the bluez site states that there is good documentation on the web, <BR>but that's simply *not* true. Most of it conflicts
 and is apparently outdated <BR>if only #4 is true now.<BR><BR>What am i doing wrong with this passkey-agent. If my headset device is <BR>00:0D:44:4F:37:72 and my hub is 00:07:61:1C:9F:D3 what should the command be?<BR><BR>Simply, if you were me, what steps would you take to get this working.<BR><BR>Thank you for your help so far.<BR><BR>My hcidump is as follows:<BR>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<BR>&gt; HCI Event: Command Status (0x0f) plen 4<BR>&gt; HCI Event: PIN Code Request (0x16) plen 6<BR>&lt; HCI Command: Inquiry (0x01|0x0001) plen 5<BR>&gt; HCI Event: Command Status (0x0f) plen 4<BR>&gt; HCI Event: Inquiry Result (0x02) plen 15<BR>&gt; HCI Event: Inquiry Complete (0x01) plen 1<BR>&gt; HCI Event: Mode Change (0x14) plen 6<BR>&gt; HCI Event: Mode Change (0x14) plen 6<BR>&gt; HCI Event: Connect Complete (0x03) plen 11<BR>&lt; HCI Command: Read Voice Setting (0x03|0x0025) plen 0<BR>&gt; HCI Event: Command Complete (0x0e) plen 6<BR>&lt; HCI
 Command: Create Connection (0x01|0x0005) plen 13<BR>&gt; HCI Event: Command Status (0x0f) plen 4<BR>&gt; HCI Event: PIN Code Request (0x16) plen 6<BR><BR>The "btsco 00:0D:44:4F:37:72" command gives me:<BR>Error: Failed to connect to SDP server: Function not implemented<BR>Assuming channel 2<BR><BR>Can't connect RFCOMM channel: Resource temporarily unavailable<BR><BR><BR>Bearcat<BR><BR><BR><BR><BR>On Tuesday 29 August 2006 17:46 in an email titled "Re: [Bluez-users] How do I <BR>reset a pairing?" Marcel Holtmann wrote:<BR>&gt;Hi Bearcat,<BR>&gt;<BR>&gt;&gt; I looked it over. I am only just starting to learn C so this is a little<BR>&gt;&gt; daunting. I tried a "gcc -Wall -o passkey-agent -passkey-agent.c" and that<BR>&gt;&gt; didn't work (i didn't really expect it to). I didn't see a configure<BR>&gt;&gt; script that would create a make file for the agent.<BR>&gt;<BR>&gt;after ./configure you can run make and it will compile passkey-agent for<BR>&gt;you. It will always be
 compiled, but never be installed.<BR>&gt;<BR>&gt;&gt; If my X system goes down, all of my paring devices will go down with it,<BR>&gt;&gt; since i would need gnome up to get them working. How can i get this agent<BR>&gt;&gt; working?<BR>&gt;<BR>&gt;Once the devices are paired. You have a link key. The hcid handles this<BR>&gt;for you. You need the passkey agent only for entering the PIN code.<BR>&gt;<BR>&gt;&gt; I'm just confused. Since the bluez-gnome is a new release, what did people<BR>&gt;&gt; do before it arrived to get pairing devices working?<BR>&gt;<BR>&gt;Actually I expected that someone else will write the appropriate passkey<BR>&gt;agents for their desktop systems. So in the end I did for the one that I<BR>&gt;use. Only the Nokia 770 Maemo platform had its own passkey agent.<BR>&gt;<BR>&gt;Regards<BR>&gt;<BR>&gt;Marcel<BR><BR>-- <BR>Bearcat M. Sandor<BR>Bearcat@feline-soul.com<BR>Jabber: bearcat@jabber.feline-soul.net<BR>ICQ: 6628727<BR>MSN:
 bearcatsandor@hotmail.com<BR>Yahoo: bearcatsandor<BR>AIM: bearcatmsandor<BR><BR><BR><BR>-------------------------------------------------------------------------<BR>Using Tomcat but need to do more? Need to support web services, security?<BR>Get stuff done quickly with pre-integrated technology to make your job easier<BR>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<BR>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><BR><p>&#32;
		<hr size=1>How low will we go? Check out Yahoo! Messenger’s low <a href="http://us.rd.yahoo.com/mail_us/taglines/postman8/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com"> PC-to-Phone call rates.
--0-1849471022-1156908614=:31614--


--===============1463522694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1463522694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1463522694==--
