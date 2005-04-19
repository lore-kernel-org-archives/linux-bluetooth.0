Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050419204937.50772.qmail@web54704.mail.yahoo.com>
From: Hiren Mandalia <hir100@yahoo.com>
Subject: RE: [Bluez-users] Bluetooth audio support
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-878966085-1113943776=:50758"
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
Date: Tue, 19 Apr 2005 13:49:36 -0700 (PDT)

--0-878966085-1113943776=:50758
Content-Type: text/plain; charset=us-ascii


i have downloaded & installed the pskey utility. however when i do a 

pskey -d /dev/ttySB0, it gives me an error. the exact message is like this

 

$ pskey -d /dev/ttySB0

Physical device: /dev/ttSB0

Speed          : 115200

Use BCSP       : NO

Initiating read thread

Now trying to read firmware info

Timeout!!!

Error in reading firmware info

 

Can any1 guide why this error? Also if any1 could direct me to a 'pskey' manual. I couldn't find it online anywhere. for those of you don't recollect i'm trying to get bluetooth audio working (via SCO) on my ipaq 3870 with Familiar Linux v0.8.1

 

 

regards,

Hiren

 

> -----Original Message-----

> From: bluez-users-admin@lists.sourceforge.net [mailto:bluez-users-

> admin@lists.sourceforge.net] On Behalf Of Marcel Holtmann

> Sent: Monday, April 11, 2005 4:05 PM

> To: bluez-users@lists.sourceforge.net

> Subject: RE: [Bluez-users] Bluetooth audio support

> 

> Hi Hiren,

> 

> > Ok. Where/How can I get the pskey tool for my iPAQ with Familiar 0.8.1?

> 

> you know that using Google etc. helps in this cases. However you might

> wanna check:

> 

> http://www.handhelds.org/download/packages/pskey/

> 

> Regards

> 

> Marcel

> 

 

> -----Original Message-----

> From: bluez-users-admin@lists.sourceforge.net [mailto:bluez-users-

> admin@lists.sourceforge.net] On Behalf Of Marcel Holtmann

> Sent: Monday, April 11, 2005 9:40 AM

> To: bluez-users@lists.sourceforge.net

> Subject: RE: [Bluez-users] Bluetooth audio support

> 

> Hi Hiren,

> 

> > I understand what you mean. Any other way out? Please help!

> 

> not that I know of. However you can give the pskey tool a chance and

> then read the PS value for 0x01ab. If the result is 0 then the SCO data

> travels over the HCI and it should work.

> 

> Regards

> 

> Marcel

> 

 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-878966085-1113943776=:50758
Content-Type: text/html; charset=us-ascii

<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">i have downloaded &amp; installed the pskey utility. however when i do a </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">pskey -d /dev/ttySB0, it gives me an error. the exact message is like this</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New"></FONT>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">$ pskey -d /dev/ttySB0</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">Physical device: /dev/ttSB0</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">Speed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 115200</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">Use BCSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: NO</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">Initiating read thread</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">Now trying to read firmware info</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">Timeout!!!</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">Error in reading firmware info</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New"></FONT>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">Can any1 guide why this error? Also if any1 could direct me to a 'pskey' manual. I couldn't find it online anywhere. for those of you don't recollect i'm trying to get bluetooth audio working (via SCO) on my ipaq 3870 with Familiar Linux v0.8.1</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt">&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New"></FONT>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">regards,</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">Hiren</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New"></FONT>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; -----Original Message-----</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; From: bluez-users-admin@lists.sourceforge.net [mailto:bluez-users-</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; admin@lists.sourceforge.net] On Behalf Of Marcel Holtmann</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Sent: Monday, April 11, 2005 4:05 PM</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; To: bluez-users@lists.sourceforge.net</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Subject: RE: [Bluez-users] Bluetooth audio support</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Hi Hiren,</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; Ok. Where/How can I get the pskey tool for my iPAQ with Familiar 0.8.1?</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; you know that using Google etc. helps in this cases. However you might</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; wanna check:</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; http://www.handhelds.org/download/packages/pskey/</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Regards</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Marcel</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p><FONT face="Courier New">&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; -----Original Message-----</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; From: bluez-users-admin@lists.sourceforge.net [mailto:bluez-users-</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; admin@lists.sourceforge.net] On Behalf Of Marcel Holtmann</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Sent: Monday, April 11, 2005 9:40 AM</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; To: bluez-users@lists.sourceforge.net</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Subject: RE: [Bluez-users] Bluetooth audio support</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Hi Hiren,</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; &gt; I understand what you mean. Any other way out? Please help!</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; not that I know of. However you can give the pskey tool a chance and</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; then read the PS value for 0x01ab. If the result is 0 then the SCO data</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; travels over the HCI and it should work.</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Regards</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; Marcel</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">&gt; </FONT></P>
<P>&nbsp;</P><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-878966085-1113943776=:50758--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
