Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051212092649.65060.qmail@web32403.mail.mud.yahoo.com>
From: Arch Sayo <a12chi@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-564153680-1134379609=:57492"
Subject: [Bluez-users] problem adding 1284 ID SDP attribute
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
Date: Mon, 12 Dec 2005 01:26:49 -0800 (PST)

--0-564153680-1134379609=:57492
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,
   
  I am having a problem adding the 1284ID attribute. The 1284ID is of type String. (So I use SDP_TEXT_STR8) However, the first 2 characters of this string are to be interpreted as a 2-byte length field. The length of my string is 80 which is 0x0050 in HEXADECIMAL. So when I add it as a string, the SDP function interprets the 1st byte as a null terminator and sends an empty string.
   
  I tried increasing the length of my string to 0x0101 to avoid a 0x00 byte. However, this cannot be done since the maximum length for an SDP_TEXT_STR8 is only 255 which is 0x00FF.
   
  In this case, how will I be able to add a 1284ID string attribute whose length field contains a 0x00 byte?
   
  Thanks,
  Arch Sayo

			
---------------------------------
Yahoo! Shopping
 Find Great Deals on Holiday Gifts at Yahoo! Shopping 
--0-564153680-1134379609=:57492
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Marcel,</div>  <div>&nbsp;</div>  <div>I am having a problem adding the 1284ID attribute. The 1284ID is of type String. (So I use SDP_TEXT_STR8) However,&nbsp;the first 2&nbsp;characters of this string are to be&nbsp;interpreted as a 2-byte length field. The length of my string is 80 which is 0x0050 in HEXADECIMAL. So when I add it as a string, the SDP function interprets the 1st byte as a null terminator and sends an empty string.</div>  <div>&nbsp;</div>  <div>I tried increasing the length of my string to 0x0101 to avoid a 0x00 byte. However, this cannot be done since the maximum length for an SDP_TEXT_STR8 is only 255 which is 0x00FF.</div>  <div>&nbsp;</div>  <div>In this case, how will I be able to add a 1284ID string attribute whose length field contains a 0x00 byte?</div>  <div>&nbsp;</div>  <div>Thanks,</div>  <div>Arch Sayo</div><p>
	
		<hr size=1>Yahoo! Shopping<br> 
Find Great Deals on Holiday Gifts at <a href="http://us.rd.yahoo.com/mail_us/footer/shopping/*http://shopping.yahoo.com/;_ylc=X3oDMTE2bzVzaHJtBF9TAzk1OTQ5NjM2BHNlYwNtYWlsdGFnBHNsawNob2xpZGF5LTA1 
">Yahoo! Shopping</a> 
--0-564153680-1134379609=:57492--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
