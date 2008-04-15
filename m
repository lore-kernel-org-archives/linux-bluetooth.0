Return-Path: <cyrus@holtmann.org>
Message-ID: <454aa2ad0804150046l5930b4b0r153d30ed08633d45@mail.gmail.com>
Date: Tue, 15 Apr 2008 15:46:33 +0800
From: "=?GB2312?B?0O3V1NTG?=" <proteus2002@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] How can I use the console for input of pin code
	instead of the window "/usr/bin/bluez-pin"?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1936357388=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1936357388==
Content-Type: multipart/alternative;
	boundary="----=_Part_3745_26474728.1208245593596"

------=_Part_3745_26474728.1208245593596
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

when we use "hcitool cc [mac]",
a windows "/usr/bin/bluez-pin" pops up , and requires us to input pin code
for paring.

Now I want to use console for input of pin code, because I want to use it in
embedded system which has no GUI.

So I debugged the code to find out which sentence pops up
/usr/bin/bluez-pin.
It turned out to be this sentence in bluez-lib-3.30:

hci.c

int hci_send_cmd(int dd, uint16_t ogf, uint16_t ocf, uint8_t plen, void
*param)
{
  .........

  /*****************************here pops up
/usr/bin/bluez-pin***********************************************/
    while (writev(dd, iv, ivn) < 0) {
        if (errno == EAGAIN || errno == EINTR)
            continue;
        return -1;
    }
    return 0;
}


I don't know why it is this sentence that pops up /usr/bin/bluez-pin.
Can anyone tell me the reason?
And how should I change source codes so that I can use the console for input
of pin code?

Thanks!

Proteus

------=_Part_3745_26474728.1208245593596
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>when we use &quot;hcitool cc [mac]&quot;, <br>a windows &quot;/usr/bin/bluez-pin&quot; pops up , and requires us to input pin code for paring.<br><br>Now I want to use console for input of pin code, because I want to use it in embedded system which has no GUI.<br>

<br>So I debugged the code to find out which sentence pops up /usr/bin/bluez-pin.<br>It turned out to be this sentence in bluez-lib-3.30:<br><br>hci.c<br><br>int hci_send_cmd(int dd, uint16_t ogf, uint16_t ocf, uint8_t plen, void *param)<br>

{<br>&nbsp; .........<br><br>&nbsp; /****************************<div id="mb_0">*here pops up /usr/bin/bluez-pin***********************************************/<br>&nbsp;&nbsp;&nbsp; while (<span style="color: rgb(51, 51, 153);">writev(dd, iv, ivn) &lt; 0</span>) { <br>

&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (errno == EAGAIN || errno == EINTR)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; continue;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br><br>I don&#39;t know why it is this sentence that pops up /usr/bin/bluez-pin.<br>Can anyone tell me the reason?<br>

And how should I change source codes so that I can use the console for input of pin code?<br><br>Thanks!<br><br>Proteus</div>

------=_Part_3745_26474728.1208245593596--


--===============1936357388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1936357388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1936357388==--
