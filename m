Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050131163631.39991.qmail@web53205.mail.yahoo.com>
From: Filipa Duarte <filipa_duarte@yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM socket
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1106939965.10580.0.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Mon, 31 Jan 2005 08:36:31 -0800 (PST)

Hi everyone,

Marcel, many thanks for your help, but I still
couldn't connect to my friend PC. So I decided to
connect to a mobile phone first. It is an Sony
Ericsson Z600.

The 'hcitool scan' shows me the phone and the phone
also recognize my laptop. After this, I did a 'rfcomm
bind' on the laptop.

When I try to connect the mobile phone to my laptop,
the mobile phone asks me the passkey. When I
introduced the PIN (the same I have defined in the
/etc/bluetooth/pin) the reply on the phone is 'passkey
mismatch'.

Here is the output of the 'hcidump -X':
HCIDump - HCI packet analyzer ver 1.16
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  0000: b4 db c9 d9 0a 00 04 02  52 01      ........R.
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
  0000: b4 db c9 d9 0a 00 01                .......
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                         ....
> HCI Event: PIN code Request (0x16)plen6
  0000: b4 db c9 d9 0a 00                   ......
< HCI Command: PIN Code Request Reply (0x01|0x000d)
plen 23
  0000: b4 db c9 d9 0a 00 05 42  6c 75 65 5a 00 00 00
00          .......BlueZ....
  0010: 00 00 00 00 00 00 00                .......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0d 04 00 b4 db c9 d9  0a 00      ..........
< HCI Command: PIN Code Request Reply (0x01|0x000d)
plen 23
  0000: b4 db c9 d9 0a 00 05 42  6c 75 65 5a 00 00 00
00          .......BlueZ....
  0010: 00 00 00 00 00 00 00                .......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0d 04 00 b4 db c9 d9  0a 00      ..........
> HCI Event: Connect Complete (0x03) plen 11
  0000: 05 29 00 b4 db c9 d9 0a  00 01 00  
.).........

Could you please help me with this output? I am not
sure what it means, if the PIN helper is working or
not...

If it is not the PIN helper, could you give any
directions to look for the problem?

Many thanks. Regards,

Filipa

--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Filipa,
> 
> > I am have Linux 2.6.9 in my laptop and an
> Conceptronic
> > CBT 100U USB adapter. I installed bluez-utils-2.14
> and
> > bluez-libs-2.14.
> > 
> > 'hciconfig -a' shows me my device and 'hcitool
> scan'
> > show me the computer of a friend (a windows pc). I
> can
> > do an 'l2ping' and an 'rfcomm bind' to this
> computer
> > without any problem. 
> > 
> > The problems arrive when I try to do 'rfcomm
> connect'.
> > The answer is: "Can't connect RFCOMM socket:
> resource
> > temporarily unavailable". 
> 
> you can't use bind and connect together. Choose one.
> 
> > I saw on the web and on the mailling lists that
> there
> > is a problem with the 'bluepin'. I checked mine
> and it
> > didn't work. So, I created a new file (called pin
> in 
> > /usr/bin/) with:
> > 
> > #!bin/sh
> > # file: /usr/bin/pin
> > echo -n "PIN: "
> > cat /etc/bluetooth/pin
> > 
> > and created a file in /etc/bluetooth/ also called
> pin
> > with a numerical the PIN code.
> > 
> > Still I could not make the 'rfcomm connect' work!
> It
> > appears a window asking for the PIN in my friend's
> > computer, but in my computer I still have the same
> > answer.
> 
> Check with "hcidump -x" as root if it is really a
> PIN helper problem.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW --
> Interactive Reporting
> Tool for open source databases. Create drag-&-drop
> reports. Save time
> by over 75%! Publish reports on the web. Export to
> DOC, XLS, RTF, etc.
> Download a FREE copy at
> http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
