Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050129053222.47103.qmail@web60910.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] rfcomm question 1
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1106933775.9644.0.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
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
Date: Sat, 29 Jan 2005 13:32:22 +0800 (CST)

Hi Marcel!
    Of course, hcid is running. Then when I typed
"hcidump -x", and then choose the computer in mobile
phone, after I entered the PIN, the following occurs:
[root@cm218-253-8-120 root]# hcidump -x
HCIDump - HCI packet analyzer ver 1.16
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  A8 D8 DD D9 0A 00 04 02 52 01
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
  A8 D8 DD D9 0A 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: PIN Code Request (0x16) plen 6
  A8 D8 DD D9 0A 00
< HCI Command: PIN Code Request Reply (0x01|0x000d)
plen 23
  A8 D8 DD D9 0A 00 05 42 6C 75 65 5A 00 00 00 00 00
00 00 00
  00 00 00
> HCI Event: Command Complete (0x0e) plen 10
  01 0D 04 00 A8 D8 DD D9 0A 00
> HCI Event: Connect Complete (0x03) plen 11
  05 29 00 A8 D8 DD D9 0A 00 01 00
But the mobile shows "PIN not match". So how can I do?
Michael

 --- Marcel Holtmann <marcel@holtmann.org> 內容：
> Hi Michael,
> 
> > I'm doing a project using bluetooth. But I have
> something to ask.
> > Now, I make the connection between Linux PC and
> Sony Ericsson T610 by
> > typing "rfcomm connect 0 <adress>", and it was
> success. Then, I wish
> > to make the connection in this way: let T610 be
> the client and PC be
> > the server. When T610 searched the PC, I wish to
> connect them by
> > selecting the PC in the mobile. But when I entered
> the PIN, the mobile
> > always showed "PIN not match". Why is that? And
> how can I do so that
> > the connection can be created by mobile phone?
> 
> do you have hcid running? What does "hcidump -x" as
> root shows when you
> connect from the mobile phone?
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

_______________________________________________________________________
新年願望第一位 : 找到友緣人
http://personals.yahoo.com.hk


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
