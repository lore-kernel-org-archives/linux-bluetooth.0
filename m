Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040930161652.GA10170@spring.luon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: sjoerd@spring.luon.net (Sjoerd Simons)
Subject: [Bluez-users] Sending files from phone to ppc machine fails
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 30 Sep 2004 18:16:52 +0200

Hi,

  Since some time i've got an Ericsson T630. Sending files via obex from both
  my ppc and x86 machine to the phone works fine. But from the phone i can only
  send stuff to the x86. When sending to my powerbook the phone almost 
  immediatly indicates ``connection failed''. 

  Both machines have the exact same hcid.conf and are running debian unstable.
  Both run kernel 2.6.8, trying 2.6.8-mh2 on the ppc didn't make a difference
  (although my bluetooth mouse started to work a lot better, very nice).

  hcidump -x shows the following when trying to send from the phone to the ppc:
  > HCI Event: Connect Request (0x04) plen 10
    75 3F 1D DE 0F 00 04 02 52 01 
  < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    75 3F 1D DE 0F 00 00 
  > HCI Event: Command Status (0x0f) plen 4
    00 01 09 04 
  > HCI Event: Connect Complete (0x03) plen 11
    1A 2C 00 75 3F 1D DE 0F 00 01 00 

  Then the phone shows  ``connetion failed'' and that's all there is :(

  Doing the same on the x86 box starts with:
  > HCI Event: Connect Request (0x04) plen 10
    75 3F 1D DE 0F 00 04 02 52 01 
  < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    75 3F 1D DE 0F 00 01 
  > HCI Event: Command Status (0x0f) plen 4
    00 01 09 04 
  > HCI Event: Link Key Request (0x17) plen 6
    75 3F 1D DE 0F 00 
  < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    75 3F 1D DE 0F 00 0E 42 18 96 9C 4D 11 8A 5D 73 1B 58 3F 07 
    4C BF 
  > HCI Event: Command Complete (0x0e) plen 10
    01 0B 04 00 75 3F 1D DE 0F 00 
  > HCI Event: Connect Complete (0x03) plen 11
    00 29 00 75 3F 1D DE 0F 00 01 01 


  Any ideas what could be going wrong here ?

  Sjoerd
-- 
Why don't you fix your little problem... and light this candle?
		-- Alan Shepherd, the first man into space, Gemini program


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
