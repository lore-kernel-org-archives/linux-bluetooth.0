Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051213092433.81132.qmail@web32401.mail.mud.yahoo.com>
From: Arch Sayo <a12chi@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1246805064-1134465873=:79156"
Subject: [Bluez-users] Adding Additional Protocol Descriptor List
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
Date: Tue, 13 Dec 2005 01:24:33 -0800 (PST)

--0-1246805064-1134465873=:79156
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,
   
  Thank you with that information on adding the 1284ID attribute.
   
  Now, I am trying to add the Additional Protocol Descriptor List to my sdp record. The Additional Protocol Descriptor List is almost similar to the Protocol Descriptor List. The only difference is that while the Protocol Descriptor List is a sequence of a sequence of data (2 levels),  the Additional Protocol Descriptor List is a sequence of a sequence of a sequence of data (3 levels) .I tried doing this using the function sdp_set_access_protos() and just substituting the Attribute ID in the function from SDP_ATTR_PROTO_DESC_LIST to SDP_ATTR_ADD_PROTO_DESC_LIST. However, as you may already know, this will not solve it since the Protocol Descriptor List is only a sequence of a sequence.
   
  In this regard, I would like to ask how I will be able to add a sequence of a sequence of a sequence of data to my sdp record. Or in other words, how will I add the Additional Protocol Descriptor List to my sdp record.
   
  Thank you for your time and effort.
   
  Sincerely,
  Arch Sayo

			
---------------------------------
Yahoo! Shopping
 Find Great Deals on Holiday Gifts at Yahoo! Shopping 
--0-1246805064-1134465873=:79156
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Marcel,</div>  <div>&nbsp;</div>  <div>Thank you with that information on adding the 1284ID attribute.</div>  <div>&nbsp;</div>  <div>Now, I am trying to add the Additional Protocol Descriptor List to my sdp record. The Additional Protocol Descriptor List is almost similar to the Protocol Descriptor&nbsp;List.&nbsp;The only difference is that while the Protocol Descriptor List is a sequence of a sequence of data (2 levels),&nbsp;&nbsp;the Additional Protocol Descriptor List is a sequence of a sequence of a sequence of data (3 levels)&nbsp;.I tried doing this using the function sdp_set_access_protos() and just substituting the Attribute ID in the function from SDP_ATTR_PROTO_DESC_LIST&nbsp;to SDP_ATTR_ADD_PROTO_DESC_LIST. However, as you may already know, this will not solve it since the Protocol Descriptor List is only a sequence of a sequence.</div>  <div>&nbsp;</div>  <div>In this regard, I would like to ask how&nbsp;I will be able to add a sequence of a sequence of
  a
 sequence of data to my sdp record. Or in other words, how will I add the Additional Protocol Descriptor List to my sdp record.</div>  <div>&nbsp;</div>  <div>Thank you for your time and effort.</div>  <div>&nbsp;</div>  <div>Sincerely,</div>  <div>Arch Sayo</div><p>
	
		<hr size=1>Yahoo! Shopping<br> 
Find Great Deals on Holiday Gifts at <a href="http://us.rd.yahoo.com/mail_us/footer/shopping/*http://shopping.yahoo.com/;_ylc=X3oDMTE2bzVzaHJtBF9TAzk1OTQ5NjM2BHNlYwNtYWlsdGFnBHNsawNob2xpZGF5LTA1 
">Yahoo! Shopping</a> 
--0-1246805064-1134465873=:79156--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
