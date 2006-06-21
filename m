Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <20060621091250.43316.qmail@web15809.mail.cnb.yahoo.com>
Date: Wed, 21 Jun 2006 17:12:50 +0800 (CST)
From: Mingfan lu <lucharse@yahoo.com.cn>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150880390.3950.25.camel@localhost>
MIME-Version: 1.0
Subject: [Bluez-devel]
 =?gb2312?q?=BB=D8=B8=B4=A3=BA=20Re:=20=20=BB=D8=B8=B4=A3=BA?=
 =?gb2312?q?=20Re:=20=BB=D8=B8=B4=A3=BA=20Re:=20=20RE=A3=BA=20RE:=20FWD=A3?=
 =?gb2312?q?=BA=20Re:=20Re:Request=20with=09RSSI?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0386789502=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0386789502==
Content-Type: multipart/alternative; boundary="0-1327117145-1150881170=:43001"
Content-Transfer-Encoding: 8bit

--0-1327117145-1150881170=:43001
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi,
   I reviewed the hciconfig.c.
   If you set mode 5, it just output like you test. I can see any limitation of the mode num, 5 it can be dealt with. So, I don't think it can give such a conclusion you claimed.
   
  static void cmd_inq_mode(int ctl, int hdev, char *opt)
{
 int dd;
   dd = hci_open_dev(hdev);
 if (dd < 0) {
  fprintf(stderr, "Can't open device hci%d: %s (%d)\n",
      hdev, strerror(errno), errno);
  exit(1);
 }
   if (opt) {
  uint8_t mode = atoi(opt);
    if (hci_write_inquiry_mode(dd, mode, 2000) < 0) {
   fprintf(stderr, "Can't set inquiry mode on hci%d: %s (%d)\n",
      hdev, strerror(errno), errno);
   exit(1);
  }
 } else {
  uint8_t mode;
    if (hci_read_inquiry_mode(dd, &mode, 1000) < 0) {
   fprintf(stderr, "Can't read inquiry mode on hci%d: %s (%d)\n",
      hdev, strerror(errno), errno);
   exit(1);
  }
    print_dev_hdr(&di);
  printf("\tInquiry mode: ");
  switch (mode) {
  case 0:
   printf("Standard Inquiry\n");
   break;
  case 1:
   printf("Inquiry with RSSI\n");
   break;
  case 2:
   printf("Inquiry with RSSI or Extended Inquiry\n");
   break;
  default:
   printf("Unknown (0x%02x)\n", mode);
   break;
  }
 }
   hci_close_dev(dd);
}

Marcel Holtmann <marcel@holtmann.org> Ð´µÀ£º
  Hi,

> I can't understand your test , why you set the mode 5? 
> what is the relation between your result and the problem? 

it means that they support the inquiry mode command, but don't do
actually anything with it. Setting it to 5 is not allowed. So this
command should fail and later on it should retrieve only 0 or 1 as valid
values, but it doesn't. This leads to the conclusion that they only
store the inquiry mode value somewhere, but never evaluate it. And this
means they will never switch to Inquiry with RSSI as you have seen
before.

Regards

Marcel

> 



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



With respects,
        Mingfan.Lu 

 		
---------------------------------
 ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ
--0-1327117145-1150881170=:43001
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp;I reviewed the hciconfig.c.</div>  <div>&nbsp;If you set mode 5, it just output like you test. I can see any limitation&nbsp;of the mode num, 5 it&nbsp;can be&nbsp;dealt with.&nbsp;So, I don't think it can give&nbsp;such a&nbsp;conclusion you claimed.</div>  <div>&nbsp;</div>  <div><FONT color=#c00000>static void cmd_inq_mode(int ctl, int hdev, char *opt)<BR>{<BR>&nbsp;int dd;</FONT></div>  <div><FONT color=#c00000>&nbsp;dd = hci_open_dev(hdev);<BR>&nbsp;if (dd &lt; 0) {<BR>&nbsp;&nbsp;fprintf(stderr, "Can't open device hci%d: %s (%d)\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hdev, strerror(errno), errno);<BR>&nbsp;&nbsp;exit(1);<BR>&nbsp;}</FONT></div>  <div><FONT color=#c00000>&nbsp;if (opt) {<BR>&nbsp;&nbsp;uint8_t mode = atoi(opt);</FONT></div>  <div><FONT color=#c00000>&nbsp;&nbsp;if (hci_write_inquiry_mode(dd, mode, 2000) &lt; 0) {<BR>&nbsp;&nbsp;&nbsp;fprintf(stderr, "Can't set inquiry mode on hci%d: %s
 (%d)\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hdev, strerror(errno), errno);<BR>&nbsp;&nbsp;&nbsp;exit(1);<BR>&nbsp;&nbsp;}<BR>&nbsp;} else {<BR>&nbsp;&nbsp;uint8_t mode;</FONT></div>  <div><FONT color=#c00000>&nbsp;&nbsp;if (hci_read_inquiry_mode(dd, &amp;mode, 1000) &lt; 0) {<BR>&nbsp;&nbsp;&nbsp;fprintf(stderr, "Can't read inquiry mode on hci%d: %s (%d)\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hdev, strerror(errno), errno);<BR>&nbsp;&nbsp;&nbsp;exit(1);<BR>&nbsp;&nbsp;}</FONT></div>  <div><FONT color=#c00000>&nbsp;&nbsp;print_dev_hdr(&amp;di);<BR>&nbsp;&nbsp;printf("\tInquiry mode: ");<BR>&nbsp;&nbsp;switch (mode) {<BR>&nbsp;&nbsp;case 0:<BR>&nbsp;&nbsp;&nbsp;printf("Standard Inquiry\n");<BR>&nbsp;&nbsp;&nbsp;break;<BR>&nbsp;&nbsp;case 1:<BR>&nbsp;&nbsp;&nbsp;printf("Inquiry with RSSI\n");<BR>&nbsp;&nbsp;&nbsp;break;<BR>&nbsp;&nbsp;case 2:<BR>&nbsp;&nbsp;&nbsp;printf("Inquiry with RSSI or Extended Inquiry\n");<BR>&nbsp;&nbsp;&nbsp;break;<BR><FONT
 style="BACKGROUND-COLOR: #ffff00">&nbsp;&nbsp;default:<BR>&nbsp;&nbsp;&nbsp;printf("Unknown (0x%02x)\n", mode);<BR>&nbsp;&nbsp;&nbsp;break;</FONT><BR>&nbsp;&nbsp;}<BR>&nbsp;}</FONT></div>  <div><FONT color=#c00000>&nbsp;hci_close_dev(dd);<BR>}</FONT><BR><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> Ð´µÀ£º</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi,<BR><BR>&gt; I can't understand your test , why you set the mode 5? <BR>&gt; what is the relation between your result and the problem? <BR><BR>it means that they support the inquiry mode command, but don't do<BR>actually anything with it. Setting it to 5 is not allowed. So this<BR>command should fail and later on it should retrieve only 0 or 1 as valid<BR>values, but it doesn't. This leads to the conclusion that they only<BR>store the inquiry mode value somewhere, but never evaluate it. And this<BR>means they will never switch to Inquiry with RSSI
 as you have seen<BR>before.<BR><BR>Regards<BR><BR>Marcel<BR><BR>&gt; <BR><BR><BR><BR>_______________________________________________<BR>Bluez-devel mailing list<BR>Bluez-devel@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-devel<BR></BLOCKQUOTE><BR><BR><BR><DIV id=RTEContent><FONT face="comic sans ms" color=#bc6e6e size=5>With respects,</FONT></DIV>  <DIV>&nbsp;<FONT size=4>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff0000>&nbsp;<FONT face="comic sans ms">Mingfan.Lu</FONT></FONT></FONT> <IMG src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/01.gif"></DIV><p>&#32;
		<hr size=1><a href="http://cn.mail.yahoo.com/" target=blank> 
ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ
</a>
--0-1327117145-1150881170=:43001--


--===============0386789502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0386789502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0386789502==--
