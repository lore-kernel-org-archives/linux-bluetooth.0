Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20040309181554.11682.qmail@mail.supereva.it>
From: paolo2278@freemail.it
Reply-To: paolo2278@freemail.it
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] OGF and OCF
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 9 Mar 2004 18:15:54 -0000


Hi!



I am using a commercial USB BT that have a CSR's chip.

I wuold like to extract the native clock from the chip, and I used the hcitool cmd as described in HCI Extention, in BCCMD basic Command and BCCMD Protocol, more over I read the hciconfig source code, where is reported an example of a vendor packet but only for the eicsson chip.

I would like to know wich are the OGF and OCF of the CSR module for vendor specific commands (I used respectively 0x3f and 0x0000, are they correct?).

P.S. the structure of the packet that I realized but I can't send with the hcitool cmd (because the sysem say that 0x3f and0x000 are Unknown commands) is:



OGF    OCF        TYPE       LENGTH      VARID      STATUS



0x3f   0x0000     0x0000     0x0001      0x2c00     0x0000  



and at the end there are 4 packets of 0x0000 to complete the length of the minimum packet that can be realized. There something wrong in it?



Bests regards and thanks in advance Paolo Sperandio

-----------------------------------------------------------
Spazio ILLIMITATO per la tua Email, Scanner Antivirus,
Antispam, Backup e POP3. Prova la nuova Email di superEva:
http://webmail.supereva.it/
-----------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
