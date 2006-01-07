Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060107113253.24049.qmail@web53106.mail.yahoo.com>
From: ermal mino <ermalmino1004@yahoo.it>
Subject: Re: [Bluez-devel] open obex multisession
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1136558831.31793.17.camel@panic>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1107888488-1136633573=:23582"
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
Date: Sat, 7 Jan 2006 12:32:53 +0100 (CET)

--0-1107888488-1136633573=:23582
Content-Type: text/plain; charset=iso-8859-1



"Collin R. Mulliner" <collin@betaversion.net> ha scritto:     Hi,

> I tried to send a file to two cellphones at the same time using
> ussp-push.
long time ago since I used ussp-push, try some other tool like btobex or
obexftp
   
  Ermal: obexftp doesnt work at all.

> I excecuted it in two different consoles. By this time the conections
> freeze and i can't disconnect them anynmore, even using "hcitool dc".
> The only way to disconnect is restart the pc or disconnect the usb
> dongle.
mmh did you get a kernel ups?
   
  Ermal: I have a slackware 10.1 kernel 2.4.29 and it has native support for bluetooth.

> It gives me the same problem when using two dongles at the same time.
the second dongle musst be used explecite otherwise only the first
dongle is used (right Marcel?)
   
  Ermal: I do. I use ussp-push 0.5 , i explicitly give it the dongle id as a parameter but still nothing.

> I saw that in the ussp-push code it binds the local socket in 0
> channel.
> I modified it and tried with diffrent channels for each connection but
> still nothing changed.
there is not local channel on outgoing connections
   
  Ermal: whatever it was it always binds the socket to 0

> Is it possible what i am trying to do ?
yes

> Acording to bluetooth specification i can make 7 connections
> simultaneously being the master. I controled the connections and i was
> the master.
are you sure? maybe on of the devices tryed a role switch
   
  Ermal: Yes, i saw it with "hcitool con" and it showed me two master outgoing connections.

> is it bluez or open obex responsible for this error?
I guess you/ussp-push are/is the problem
   
  Ermal: when you mean "ussp-push" you mean also "openobex"?
  

> what can i do to fi x it and send files to more than one phone at the
> same time?

run hcidump and see what happens on the lower layers when you send the
files.
   
  Ermal: I'll do it.
  Thank you very much.

... Collin

--
Collin R. Mulliner 
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Commander, there is no careful way to question a Klingon. --Odo



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems? Stop! Download the new AJAX search engine that makes
searching your log files as easy as surfing the web. DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel




Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
--0-1107888488-1136633573=:23582
Content-Type: text/html; charset=iso-8859-1

<DIV id=RTEContent><BR><BR><B><I>"Collin R. Mulliner" &lt;collin@betaversion.net&gt;</I></B> ha scritto:   <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">  <div>Hi,<BR><BR>&gt; I tried to send a file to two cellphones at the same time using<BR>&gt; ussp-push.<BR>long time ago since I used ussp-push, try some other tool like btobex or<BR>obexftp</div>  <div>&nbsp;</div>  <div>Ermal: obexftp doesnt work at all.<BR><BR>&gt; I excecuted it in two different consoles. By this time the conections<BR>&gt; freeze and i can't disconnect them anynmore, even using "hcitool dc".<BR>&gt; The only way to disconnect is restart the pc or disconnect the usb<BR>&gt; dongle.<BR>mmh did you get a kernel ups?</div>  <div>&nbsp;</div>  <div>Ermal: I have a slackware 10.1 kernel 2.4.29 and it has native support for bluetooth.<BR><BR>&gt; It gives me the same problem when using two dongles at the same time.<BR>the second dongle musst be used exple
 cite
 otherwise only the first<BR>dongle is used (right Marcel?)</div>  <div>&nbsp;</div>  <div>Ermal: I do. I use ussp-push 0.5 , i explicitly give it the dongle id as a parameter but still nothing.<BR><BR>&gt; I saw that in the ussp-push code it binds the local socket in 0<BR>&gt; channel.<BR>&gt; I modified it and tried with diffrent channels for each connection but<BR>&gt; still nothing changed.<BR>there is not local channel on outgoing connections</div>  <div>&nbsp;</div>  <div>Ermal: whatever it was it always binds the socket to 0<BR><BR>&gt; Is it possible what i am trying to do ?<BR>yes<BR><BR>&gt; Acording to bluetooth specification i can make 7 connections<BR>&gt; simultaneously being the master. I controled the connections and i was<BR>&gt; the master.<BR>are you sure? maybe on of the devices tryed a role switch</div>  <div>&nbsp;</div>  <div>Ermal: Yes, i saw it with "hcitool con" and it showed me two master outgoing connections.<BR><BR>&gt; is it bluez or open obex
 responsible for this error?<BR>I guess you/ussp-push are/is the problem</div>  <div>&nbsp;</div>  <div>Ermal: when you mean "ussp-push" you mean also "openobex"?</div>  <div><BR><BR>&gt; what can i do to fi x it and send files to more than one phone at the<BR>&gt; same time?<BR><BR>run hcidump and see what happens on the lower layers when you send the<BR>files.</div>  <div>&nbsp;</div>  <div>Ermal: I'll do it.</div>  <div>Thank you very much.<BR><BR>... Collin<BR><BR>--<BR>Collin R. Mulliner <COLLIN@BETAVERSION.NET><BR>BETAVERSiON Systems [www.betaversion.net]<BR>info/pgp: finger collin@betaversion.net<BR>Commander, there is no careful way to question a Klingon. --Odo<BR><BR><BR><BR>-------------------------------------------------------<BR>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files<BR>for problems? Stop! Download the new AJAX search engine that makes<BR>searching your log files as easy as surfing the web. DOWNLOAD
 SPLUNK!<BR>http://ads.osdn.com/?ad_id=7637&amp;alloc_id=16865&amp;op=click<BR>_______________________________________________<BR>Bluez-devel mailing list<BR>Bluez-devel@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-devel<BR></div></BLOCKQUOTE><BR></DIV><p>Chiacchiera con i tuoi amici in tempo reale! <br> http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
--0-1107888488-1136633573=:23582--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
