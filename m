Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2008 15:59:00 +0100
From: Miguel <mc354@tid.es>
In-reply-to: <269801.28820.qm@web8401.mail.in.yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <1201618740.14284.41.camel@McM>
MIME-version: 1.0
References: <269801.28820.qm@web8401.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Permission denied
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0626173878=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0626173878==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_ReEpaVfBHcjXs+bPoBDqCA)"


--Boundary_(ID_ReEpaVfBHcjXs+bPoBDqCA)
Content-type: text/plain
Content-transfer-encoding: 7BIT

sorry Pramond, I haven't worked with audio and bluetooth...

I can't help you any more, sorry...



On Tue, 2008-01-29 at 19:44 +0530, pramod gurav wrote:
> hi miguel sir,
> Need i install ALSA plugins for this....
> But i read in audio servicxe related doc that they are there in
> BLuez....
> Thanks
> Pramod
> 
> 
> 
> ----- Original Message ----
> From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Sent: Tuesday, 29 January, 2008 7:38:31 PM
> Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Permission
> denied
> 
> 
> hi Miguel sir,
> I am able to connect now...
> but the connection lasts for only for few seconds..after it gets
> disconnected,.
> Also the pop up is not comming on the system...it came only once...
> 
> When i try to play audo file using
> [Pramod@localhost ~]$ mplayer_install/usr/local/bin/mplayer -ao
> alsa:device=bluetooth 1.mp3
> this gives me error...
> 
> bt_audio_service_open: connect() failed: Connection refused (111)
> [AO_ALSA] Playback open error: Connection refused
> Could not open/initialize audio device -> no sound.
> Audio: no sound
> Video: no video
> 
> whats are the reason for these...dont i have alsa plugins or what...
> thanks in advance..
> Pramod
> 
> 
> ----- Original Message ----
> From: Miguel <mc354@tid.es>
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Sent: Tuesday, 29 January, 2008 6:55:55 PM
> Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Permission
> denied
> 
> rfcomm creates a devices in /dev/rfcomm0 in your case. Check if you
> have the correct permissions. 
> 
> Try to connect using root user ...
> 
> On Tue, 2008-01-29 at 18:37 +0530, pramod gurav wrote: 
> 
> > hi all, 
> > I am connection my system to Bt headset...
> > But when i try to connect it using 
> > $rfcomm connect 0 00:0F:DE:B1:02:42 
> > error comes......... Can't connect RFCOMM socket: Permission denied
> > The /var/log/messages has following..
> > 
> > Jan 29 18:03:17 localhost hcid[1406]: HCI dev 0 registered
> > Jan 29 18:03:17 localhost hcid[1406]: HCI dev 0 up
> > Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been added
> > Jan 29 18:03:17 localhost hcid[1406]: Starting security manager 0
> > Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been activated
> > Jan 29 18:06:47 localhost hcid[1406]: link_key_request
> > (sba=00:00:00:00:00:00, dba=00:0F:DE:B1:02:42)
> > Jan 29 18:06:47 localhost hcid[1406]: pin_code_request
> > (sba=00:00:00:00:00:00, dba=00:0F:DE:B1:02:42)
> > Jan 29 18:11:13 localhost hcid[1406]: pin_code_request
> > (sba=00:00:00:00:00:00, dba=00:0F:DE:B1:02:42)
> > Jan 29 18:13:25 localhost last message repeated 2 times
> > Jan 29 18:14:03 localhost hcid[15000]: Bluetooth HCI daemon
> > Jan 29 18:14:03 localhost hcid[15000]: Unknown option 'passkey' line
> > 24
> > Jan 29 18:14:03 localhost hcid[15000]: syntax error line 24
> > Jan 29 18:14:03 localhost hcid[15000]: syntax error line 34
> > Jan 29 18:14:03 localhost hcid[15000]: Can't get system message bus
> > name: Connection ":1.34" is not allowed to own the service
> > "org.bluez" due to security policies in the configuration file
> > Jan 29 18:14:03 localhost hcid[15000]: Can't open PIN
> > file /etc/bluetooth/pin: Permission denied (13)
> > Jan 29 18:14:03 localhost hcid[15001]: Can't init device hci0:
> > Permission denied (13)
> > Jan 29 18:14:03 localhost hcid[15002]: Can't set scan mode on hci0:
> > Permission denied (13)
> > Jan 29 18:14:03 localhost hcid[15002]: Can't set auth on hci0:
> > Permission denied (13)
> > Jan 29 18:14:03 localhost hcid[15002]: Can't set encrypt on hci0:
> > Permission denied (13)
> > Jan 29 18:14:03 localhost hcid[15000]: Starting security manager 0
> > Jan 29 18:18:10 localhost hcid[15022]: Bluetooth HCI daemon
> > Jan 29 18:18:10 localhost hcid[15022]: Unknown option 'passkey' line
> > 24
> > Jan 29 18:18:10 localhost hcid[15022]: syntax error line 24
> > Jan 29 18:18:10 localhost hcid[15022]: syntax error line 34
> > Jan 29 18:18:10 localhost hcid[15022]: Can't get system message bus
> > name: Connection ":1.35" is not allowed to own the service
> > "org.bluez" due to security policies in the configuration file
> > Jan 29 18:18:10 localhost hcid[15022]: Can't open PIN
> > file /etc/bluetooth/pin: Permission denied (13)
> > Jan 29 18:18:10 localhost hcid[15023]: Can't init device hci0:
> > Permission denied (13)
> > Jan 29 18:18:10 localhost hcid[15024]: Can't set scan mode on hci0:
> > Permission denied (13)
> > Jan 29 18:18:10 localhost hcid[15024]: Can't set auth on hci0:
> > Permission denied (13)
> > Jan 29 18:18:10 localhost hcid[15024]: Can't set encrypt on hci0:
> > Permission denied (13)
> > Jan 29 18:18:10 localhost hcid[15022]: Starting security manager 0
> > Jan 29 18:18:29 localhost hcid[15000]: Exit.
> > Jan 29 18:18:31 localhost hcid[15022]: Exit.
> > Jan 29 18:20:22 localhost smartd[1554]: Device: /dev/hda, 1
> > Currently unreadable (pending) sectors
> > Jan 29 18:20:22 localhost smartd[1554]: Device: /dev/hda, 1 Offline
> > uncorrectable sectors
> > Jan 29 18:26:19 localhost kernel: usb 2-1: USB disconnect, address 5
> > Jan 29 18:26:19 localhost hcid[1406]: HCI dev 0 down
> > Jan 29 18:26:19 localhost hcid[1406]: Stopping security manager 0
> > Jan 29 18:26:19 localhost hcid[1406]: Device hci0 has been disabled
> > Jan 29 18:26:19 localhost hcid[1406]: HCI dev 0 unregistered
> > Jan 29 18:26:19 localhost hcid[1406]: Unregister
> > path: /org/bluez/hci0
> > Jan 29 18:26:19 localhost hcid[1406]: Device hci0 has been removed
> > Jan 29 18:32:01 localhost hcid[15118]: Bluetooth HCI daemon
> > Jan 29 18:32:01 localhost hcid[15118]: Unknown option 'passkey' line
> > 24
> > Jan 29 18:32:01 localhost hcid[15118]: syntax error line 24
> > Jan 29 18:32:01 localhost hcid[15118]: Can't get system message bus
> > name: Connection ":1.36" is not allowed to own the service
> > "org.bluez" due to security policies in the configuration file
> > Jan 29 18:32:01 localhost hcid[15118]: Can't open PIN
> > file /etc/bluetooth/pin: Permission denied (13)
> > 
> > 
> > Can anyone please help me....
> > 
> > Thanks in Advance...
> > Pramod
> > 
> > 
> > 
> > ____________________________________________________________________
> > 
> > 5, 50, 500, 5000 - Store N number of mails in your inbox. Click
> > here. 
> > 
> > -------------------------------------------------------------------------
> > This SF.net email is sponsored by: Microsoft
> > Defy all challenges. Microsoft(R) Visual Studio 2008.
> > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > _______________________________________________ Bluez-users mailing list Bluez-users@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> 
> 
> 
> 
> ______________________________________________________________________
> Meet people who discuss and share your passions. Join them now.
> 
> 
> 
> 
> 
> 
> ______________________________________________________________________
> Unlimited freedom, unlimited storage. Get it now
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________ Bluez-users mailing list Bluez-users@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/bluez-users

--Boundary_(ID_ReEpaVfBHcjXs+bPoBDqCA)
Content-type: text/html; charset=utf-8
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.14.1">
</HEAD>
<BODY>
sorry Pramond, I haven't worked with audio and bluetooth...<BR>
<BR>
I can't help you any more, sorry...<BR>
<BR>
<BR>
<BR>
On Tue, 2008-01-29 at 19:44 +0530, pramod gurav wrote:
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">hi miguel sir,</FONT><BR>
    <FONT COLOR="#000000">Need i install ALSA plugins for this....</FONT><BR>
    <FONT COLOR="#000000">But i read in audio servicxe related doc that they are there in BLuez....</FONT><BR>
    <FONT COLOR="#000000">Thanks</FONT><BR>
    <FONT COLOR="#000000">Pramod</FONT><BR>
    <BR>
    <BR>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">----- Original Message ----</FONT><BR>
    <FONT COLOR="#000000">From: pramod gurav &lt;pramod_gurav_etc@yahoo.co.in&gt;</FONT><BR>
    <FONT COLOR="#000000">To: BlueZ users &lt;bluez-users@lists.sourceforge.net&gt;</FONT><BR>
    <FONT COLOR="#000000">Sent: Tuesday, 29 January, 2008 7:38:31 PM</FONT><BR>
    <FONT COLOR="#000000">Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Permission denied</FONT><BR>
    <BR>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">hi Miguel sir,</FONT><BR>
    <FONT COLOR="#000000">I am able to connect now...</FONT><BR>
    <FONT COLOR="#000000">but the connection lasts for only for few seconds..after it gets disconnected,.</FONT><BR>
    <FONT COLOR="#000000">Also the pop up is not comming on the system...it came only once...</FONT><BR>
    <BR>
    <FONT COLOR="#000000">When i try to play audo file using</FONT><BR>
    <FONT COLOR="#000000">[Pramod@localhost ~]$ mplayer_install/usr/local/bin/mplayer -ao alsa:device=bluetooth 1.mp3</FONT><BR>
    <FONT COLOR="#000000">this gives me error...</FONT><BR>
    <BR>
    <FONT COLOR="#000000">bt_audio_service_open: connect() failed: Connection refused (111)</FONT><BR>
    <FONT COLOR="#000000">[AO_ALSA] Playback open error: Connection refused</FONT><BR>
    <FONT COLOR="#000000">Could not open/initialize audio device -&gt; no sound.</FONT><BR>
    <FONT COLOR="#000000">Audio: no sound</FONT><BR>
    <FONT COLOR="#000000">Video: no video</FONT><BR>
    <BR>
    <FONT COLOR="#000000">whats are the reason for these...dont i have alsa plugins or what...</FONT><BR>
    <FONT COLOR="#000000">thanks in advance..</FONT><BR>
    <FONT COLOR="#000000">Pramod</FONT><BR>
    <BR>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">----- Original Message ----</FONT><BR>
    <FONT COLOR="#000000">From: Miguel &lt;mc354@tid.es&gt;</FONT><BR>
    <FONT COLOR="#000000">To: BlueZ users &lt;bluez-users@lists.sourceforge.net&gt;</FONT><BR>
    <FONT COLOR="#000000">Sent: Tuesday, 29 January, 2008 6:55:55 PM</FONT><BR>
    <FONT COLOR="#000000">Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Permission denied</FONT><BR>
    <BR>
    <FONT COLOR="#000000">rfcomm creates a devices in /dev/rfcomm0 in your case. Check if you have the correct permissions. </FONT><BR>
    <BR>
    <FONT COLOR="#000000">Try to connect using root user ...</FONT><BR>
    <BR>
    <FONT COLOR="#000000">On Tue, 2008-01-29 at 18:37 +0530, pramod gurav wrote: </FONT><BR>
    <BLOCKQUOTE TYPE=CITE>
        <FONT COLOR="#000000">hi all, </FONT><BR>
        <FONT COLOR="#000000">I am connection my system to Bt headset...</FONT><BR>
        <FONT COLOR="#000000">But when i try to connect it using </FONT><BR>
        <FONT COLOR="#000000">$rfcomm connect 0 00:0F:DE:B1:02:42 </FONT><BR>
        <FONT COLOR="#000000">error comes......... Can't connect RFCOMM socket: Permission denied</FONT><BR>
        <FONT COLOR="#000000">The /var/log/messages has following..</FONT><BR>
        <BR>
        <FONT COLOR="#000000">Jan 29 18:03:17 localhost hcid[1406]: HCI dev 0 registered</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:03:17 localhost hcid[1406]: HCI dev 0 up</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been added</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:03:17 localhost hcid[1406]: Starting security manager 0</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been activated</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:06:47 localhost hcid[1406]: link_key_request (sba=00:00:00:00:00:00, dba=00:0F:DE:B1:02:42)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:06:47 localhost hcid[1406]: pin_code_request (sba=00:00:00:00:00:00, dba=00:0F:DE:B1:02:42)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:11:13 localhost hcid[1406]: pin_code_request (sba=00:00:00:00:00:00, dba=00:0F:DE:B1:02:42)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:13:25 localhost last message repeated 2 times</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:14:03 localhost hcid[15000]: Bluetooth HCI daemon</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:14:03 localhost hcid[15000]: Unknown option 'passkey' line 24</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:14:03 localhost hcid[15000]: syntax error line 24</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:14:03 localhost hcid[15000]: syntax error line 34</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:14:03 localhost hcid[15000]: Can't get system message bus name: Connection &quot;:1.34&quot; is not allowed to own the service &quot;org.bluez&quot; due to security policies in the configuration file</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:14:03 localhost hcid[15000]: Can't open PIN file /etc/bluetooth/pin: Permission denied (13)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:14:03 localhost hcid[15001]: Can't init device hci0: Permission denied (13)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:14:03 localhost hcid[15002]: Can't set scan mode on hci0: Permission denied (13)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:14:03 localhost hcid[15002]: Can't set auth on hci0: Permission denied (13)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:14:03 localhost hcid[15002]: Can't set encrypt on hci0: Permission denied (13)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:14:03 localhost hcid[15000]: Starting security manager 0</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:10 localhost hcid[15022]: Bluetooth HCI daemon</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:10 localhost hcid[15022]: Unknown option 'passkey' line 24</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:10 localhost hcid[15022]: syntax error line 24</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:10 localhost hcid[15022]: syntax error line 34</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:10 localhost hcid[15022]: Can't get system message bus name: Connection &quot;:1.35&quot; is not allowed to own the service &quot;org.bluez&quot; due to security policies in the configuration file</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:10 localhost hcid[15022]: Can't open PIN file /etc/bluetooth/pin: Permission denied (13)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:10 localhost hcid[15023]: Can't init device hci0: Permission denied (13)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:10 localhost hcid[15024]: Can't set scan mode on hci0: Permission denied (13)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:10 localhost hcid[15024]: Can't set auth on hci0: Permission denied (13)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:10 localhost hcid[15024]: Can't set encrypt on hci0: Permission denied (13)</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:10 localhost hcid[15022]: Starting security manager 0</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:29 localhost hcid[15000]: Exit.</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:18:31 localhost hcid[15022]: Exit.</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:20:22 localhost smartd[1554]: Device: /dev/hda, 1 Currently unreadable (pending) sectors</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:20:22 localhost smartd[1554]: Device: /dev/hda, 1 Offline uncorrectable sectors</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:26:19 localhost kernel: usb 2-1: USB disconnect, address 5</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:26:19 localhost hcid[1406]: HCI dev 0 down</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:26:19 localhost hcid[1406]: Stopping security manager 0</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:26:19 localhost hcid[1406]: Device hci0 has been disabled</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:26:19 localhost hcid[1406]: HCI dev 0 unregistered</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:26:19 localhost hcid[1406]: Unregister path: /org/bluez/hci0</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:26:19 localhost hcid[1406]: Device hci0 has been removed</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:32:01 localhost hcid[15118]: Bluetooth HCI daemon</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:32:01 localhost hcid[15118]: Unknown option 'passkey' line 24</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:32:01 localhost hcid[15118]: syntax error line 24</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:32:01 localhost hcid[15118]: Can't get system message bus name: Connection &quot;:1.36&quot; is not allowed to own the service &quot;org.bluez&quot; due to security policies in the configuration file</FONT><BR>
        <FONT COLOR="#000000">Jan 29 18:32:01 localhost hcid[15118]: Can't open PIN file /etc/bluetooth/pin: Permission denied (13)</FONT><BR>
        <BR>
        <BR>
        <FONT COLOR="#000000">Can anyone please help me....</FONT><BR>
        <BR>
        <FONT COLOR="#000000">Thanks in Advance...</FONT><BR>
        <FONT COLOR="#000000">Pramod</FONT><BR>
        <BR>
        <BR>
        
<HR SIZE="1">
<BR>
        <BR>
        <FONT COLOR="#000000">5, 50, 500, 5000 - Store N number of mails in your inbox. <A HREF="http://in.rd.yahoo.com/tagline_mail_4/*http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">Click here.</A> </FONT>
<PRE>
<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">This SF.net email is sponsored by: Microsoft</FONT>
<FONT COLOR="#000000">Defy all challenges. Microsoft(R) Visual Studio 2008.</FONT>
<FONT COLOR="#000000"><A HREF="http://clk.atdmt..com/MRT/go/vse0120000070mrt/direct/01/">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</A></FONT>
<FONT COLOR="#000000">_______________________________________________ Bluez-users mailing list <A HREF="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</A> <A HREF="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</A></FONT>
</PRE>
    </BLOCKQUOTE>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <BR>
    <BR>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <BR>
    
<HR SIZE="1">
<BR>
    <FONT COLOR="#000000">Meet people who discuss and share your passions. <A HREF="http://in.rd.yahoo.com/tagline_groups_7/*http://in.promos.yahoo.com/groups">Join them now.</A></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <BR>
    <BR>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <BR>
    
<HR SIZE="1">
<BR>
    <FONT COLOR="#000000">Unlimited freedom, unlimited storage. <A HREF="http://in.rd.yahoo.com/tagline_mail_2/*http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08..html/">Get it now</A></FONT>
<PRE>
<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">This SF.net email is sponsored by: Microsoft</FONT>
<FONT COLOR="#000000">Defy all challenges. Microsoft(R) Visual Studio 2008.</FONT>
<FONT COLOR="#000000"><A HREF="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</A></FONT>
<FONT COLOR="#000000">_______________________________________________ Bluez-users mailing list <A HREF="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</A> <A HREF="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</A></FONT>
</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--Boundary_(ID_ReEpaVfBHcjXs+bPoBDqCA)--


--===============0626173878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0626173878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0626173878==--
