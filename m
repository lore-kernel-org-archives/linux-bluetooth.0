Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <db89df390607271105h5b11d1afj803c42ef42e3a70b@mail.gmail.com>
Date: Thu, 27 Jul 2006 11:05:01 -0700
From: LAColiseum <lacoliseum@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] bluez usb
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1270649113=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1270649113==
Content-Type: multipart/alternative;
	boundary="----=_Part_22921_14610268.1154023501283"

------=_Part_22921_14610268.1154023501283
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am using HCI RAW socket to communicate with a bluetooth device. I was able
to do cmd/event between the host and the device. I am able to receive ACL
data from the raw socket too. However, I can not send ACL data. I looked
into the hci_usb.c and found that after it submit the ACL data by
usb_submit_urb using bulk mode, it never completed. Any hints?

Thanks,

Henry

------=_Part_22921_14610268.1154023501283
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I am using HCI RAW socket to communicate with a bluetooth device. I was able to do cmd/event between the host and the device. I am able to receive ACL data from the raw socket too. However, I can not send ACL data. I looked into the hci_usb.c and found that after it submit the ACL data by
</div>
<div>usb_submit_urb using bulk mode, it never completed. Any hints?</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>&nbsp;</div>
<div>Henry</div>

------=_Part_22921_14610268.1154023501283--


--===============1270649113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1270649113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1270649113==--
