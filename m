Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Jan 2009 07:04:12 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Reply-To: netdesign_98@yahoo.com
Subject: Is it possible to completely turn off encryption
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <510518.84246.qm@web52608.mail.re2.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Is it possible to completely turn off the encryption (even if the remote device want it).
   hciconfig hcio noencrypt  -- seem to turn off our request of encryption
   But if the remote device request it, we seem to still go through with it.
 Situtation: when we search the BlackBerry's SDP server, they pop up and ask for pin. They seem to be very secure minded. 
   hciconfig hcio noencrypt
   sdptool browse --tree  <BDADDR> 
       will cause the BlackBerry 7290 to pop up the pairing screen (PIN).
   hciconfig hci1 feature  
       shown the dongle (BroadCom chip) support encryption (mandated feature?)
   There seem no way (e.g. hciconfig hci1 feature set) to fool the other side that we don't have encryption capabilities (not sure if it is "legal" as this might be an mandated feature).
   
  Any suggestion? Anyone?

Edwin

 


      
