Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050505142642.27426.qmail@web54706.mail.yahoo.com>
From: Hiren Mandalia <hir100@yahoo.com>
Subject: RE: [Bluez-users] bluetooth audio control
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1463907760-1115303202=:26597"
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
Date: Thu, 5 May 2005 07:26:42 -0700 (PDT)

--0-1463907760-1115303202=:26597
Content-Type: text/plain; charset=us-ascii


hi Brad,

 

Could you give me a simple example of that? 

i tried something like this in ~/.btscorc but didn't work.

 

AT+CKPD=200

xmms test.wav

 

is this correct?

 

thanks,

Hiren

 

 

> -----Original Message-----

> From: bluez-users-admin@lists.sourceforge.net [mailto:bluez-users-

> admin@lists.sourceforge.net] On Behalf Of Brad Midgley

> Sent: Wednesday, May 04, 2005 12:36 PM

> To: bluez-users@lists.sourceforge.net

> Subject: Re: [Bluez-users] bluetooth audio control

> 

> Hiren,

> 

> This has been missing from the docs. I added it, but here it is as well:

> 

>      *  Put alternating lines of regexes and shell commands in

> ~/.btscorc and when something that the headset sends matches these

> regexes, the shell command is run (with any back references replaced).

> This, of course, is primarily intended to "do stuff" when the headset

> button(s) are pressed.

>      * Send SIGHUP to the userspace program to make it re-read the

> config file.

>      * Send SIGUSR1 to the userspace program to make the headset ring.

> 

> If anyone has examples of .btscorc lines that do things like start and

> stop a recording, I'd like to add it to the docs.

> 

> Brad

> 

> Hiren Mandalia wrote:

> > hi all,

> >

> > i have the btsco installed and working with my Motorola headset HS850.

> > I'm able to play audio from a linux machine to the headset. I'm looking

> > for a program that will start/stop audio playback/record only when I

> > press the 'Connect' button on my headset. does handsfree profile

> > implement this functionality?

> >

> > thanks,

> > hiren

> >

> > __________________________________________________

> > Do You Yahoo!?

> > Tired of spam? Yahoo! Mail has the best spam protection around

> > http://mail.yahoo.com

> >

> 

> 

> -------------------------------------------------------

> This SF.Net email is sponsored by: NEC IT Guy Games.

> Get your fingers limbered up and give it your best shot. 4 great events, 4

> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to

> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20

> _______________________________________________

> Bluez-users mailing list

> Bluez-users@lists.sourceforge.net

> https://lists.sourceforge.net/lists/listinfo/bluez-users


		
---------------------------------
Yahoo! Mail
 Stay connected, organized, and protected. Take the tour
--0-1463907760-1115303202=:26597
Content-Type: text/html; charset=us-ascii

<DIV>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p><FONT face="Courier New">hi Brad,</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New"></FONT></o:p>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New">Could you give me a simple example of that? </FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New">i tried something like this in ~/.btscorc but didn't work.</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New"></FONT></o:p>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New">AT+CKPD=200</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New">xmms test.wav</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New"></FONT></o:p>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New">is this correct?</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New"></FONT></o:p>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New">thanks,</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New">Hiren</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New"></FONT></o:p>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><o:p><FONT face="Courier New">&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; -----Original Message-----</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; From: bluez-users-admin@lists.sourceforge.net [mailto:bluez-users-</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; admin@lists.sourceforge.net] On Behalf Of Brad Midgley</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Sent: Wednesday, May 04, 2005 12:36 PM</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; To: bluez-users@lists.sourceforge.net</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Subject: Re: [Bluez-users] bluetooth audio control</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Hiren,</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; This has been missing from the docs. I added it, but here it is as well:</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; <SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN>*<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>Put alternating lines of regexes and shell commands in</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; ~/.btscorc and when something that the headset sends matches these</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; regexes, the shell command is run (with any back references replaced).</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; This, of course, is primarily intended to "do stuff" when the headset</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; button(s) are pressed.</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; <SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN>* Send SIGHUP to the userspace program to make it re-read the</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; config file.</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; <SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN>* Send SIGUSR1 to the userspace program to make the headset ring.</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; If anyone has examples of .btscorc lines that do things like start and</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; stop a recording, I'd like to add it to the docs.</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Brad</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Hiren Mandalia wrote:</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; hi all,</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; i have the btsco installed and working with my Motorola headset HS850.</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; I'm able to play audio from a linux machine to the headset. I'm looking</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; for a program that will start/stop audio playback/record only when I</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; press the 'Connect' button on my headset. does handsfree profile</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; implement this functionality?</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; thanks,</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; hiren</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; __________________________________________________</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; Do You Yahoo!?</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; Tired of spam? Yahoo! Mail has the best spam protection around</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; http://mail.yahoo.com</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; -------------------------------------------------------</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; This SF.Net email is sponsored by: NEC IT Guy Games.</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Get your fingers limbered up and give it your best shot. 4 great events, 4</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; opportunities to win big! Highest score wins.NEC IT Guy Games. Play to</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; _______________________________________________</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Bluez-users mailing list</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Bluez-users@lists.sourceforge.net</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; https://lists.sourceforge.net/lists/listinfo/bluez-users</FONT></P></DIV><p>
		<hr size=1>Yahoo! Mail<br> 
Stay connected, organized, and protected. <a href="http://tour.mail.yahoo.com/mailtour.html">Take the tour</a>
--0-1463907760-1115303202=:26597--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
