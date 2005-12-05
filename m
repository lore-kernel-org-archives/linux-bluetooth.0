Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051205083440.79581.qmail@web32414.mail.mud.yahoo.com>
From: Arch Sayo <a12chi@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-578106633-1133771680=:79534"
Subject: [Bluez-users] Did not proceed with 2nd OBEX Connect request
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
Date: Mon, 5 Dec 2005 00:34:40 -0800 (PST)

--0-578106633-1133771680=:79534
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,
   
  Yes, you're right. There was no OBEX Connect request following the SDP service request. What I was trying to ask is that supposed to be, there is another OBEX Connect request following the SDP service request. However as you have seen in the hcidump trace, this did not happen. The normal flow of the Bluetooth transaction on the client side is that after the SDP service request, there will be a 2nd OBEX Connect request (without a prior OBEX Disconnect request for the 1st OBEX Connect request). In this regard, is there something in BlueZ that prevents this from happening?
   
  Thank you so much,
  Arch
   
  > Supposedly, after the L2CAP disconnection, the 
Bluetooth device
> (mobile phone) will issue another OBEX Connect 
Request. However, as
> you may see in this trace, the 2nd OBEX Connect 
Request was not
> issued. I hope to know more about what happened to 
the connection and
> why doesn't the transaction proceed.

the first L2CAP is to PSM 3 to establish the RFCOMM 
connection and then
it establishes the OBEX connection on channel 5. The 
second L2CAP is to
PSM 1 for an SDP service request. There are no 
multiple OBEX connection
requests.

Regards

Marcel
  
 

		
---------------------------------
 Yahoo! Personals
 Skip the bars and set-ups and start using Yahoo! Personals for free
--0-578106633-1133771680=:79534
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Marcel,</div>  <div>&nbsp;</div>  <div>Yes, you're right. There was no OBEX&nbsp;Connect request&nbsp;following the SDP service request. What I was trying to ask is that <STRONG>supposed to be</STRONG>, there is another OBEX Connect request following the SDP service request. However as you have seen in the hcidump trace, this did not happen. The normal flow of the Bluetooth transaction on the client side is that after the SDP service request, there will be a 2nd OBEX Connect request (without a prior OBEX Disconnect request for the 1st OBEX Connect request). In this regard, is there something in BlueZ that prevents this from happening?</div>  <div>&nbsp;</div>  <div>Thank you so much,</div>  <div>Arch</div>  <div>&nbsp;</div>  <div>&gt; Supposedly, after the L2CAP disconnection, the <BR>Bluetooth device<BR>&gt; (mobile phone) will issue another OBEX Connect <BR>Request. However, as<BR>&gt; you may see in this trace, the 2nd OBEX Connect <BR>Request was not<BR>&gt; issu
 ed. I
 hope to know more about what happened to <BR>the connection and<BR>&gt; why doesn't the transaction proceed.<BR><BR>the first L2CAP is to PSM 3 to establish the RFCOMM <BR>connection and then<BR>it establishes the OBEX connection on channel 5. The <BR>second L2CAP is to<BR>PSM 1 for an SDP service request. There are no <BR>multiple OBEX connection<BR>requests.<BR><BR>Regards<BR><BR>Marcel</div>  <div><BR>&nbsp;</div><p>
		<hr size=1> <B>Yahoo! Personals</B><BR> 
Skip the bars and set-ups and <a href="http://us.rd.yahoo.com/evt=36107/*http://personals.yahoo.com/us/reg/free7days 
">start using Yahoo! Personals for free</a>
--0-578106633-1133771680=:79534--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
