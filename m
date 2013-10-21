Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Oct 2013 16:06:17 -0400 (EDT)
From: "alexandre@maloteaux.net" <alexandre@maloteaux.net>
Reply-To: "alexandre@maloteaux.net" <alexandre@maloteaux.net>
To: Pavel Machek <pavel@ucw.cz>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: gustavo@padovan.org, marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Message-ID: <1662429706.5434.1382385977339.open-xchange@oxwebmail.registrar-servers.com>
In-Reply-To: <20131021192021.GA19575@x220.p-661hnu-f1>
References: <413864804.130358.1382295198929.open-xchange@oxwebmail.registrar-servers.com> <20131021184839.GA10592@amd.pavel.ucw.cz> <20131021192021.GA19575@x220.p-661hnu-f1>
Subject: Re: Issue with the kernel bluetooth HCI_Delete_Stored_Link_Key
 command patch
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5433_373613556.1382385977285"
List-ID: <linux-bluetooth.vger.kernel.org>

------=_Part_5433_373613556.1382385977285
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi

It seems that i m not the only one in this situation and i managed to fix it by
applying this pending patch :
https://bugzilla.kernel.org/show_bug.cgi?id=60824

Thanks for your answer and time.


> On October 21, 2013 at 3:20 PM Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
>
> Hi,
>
> On Mon, Oct 21, 2013, Pavel Machek wrote:
> > > old 2.0 as it was written "Vista Compatible" on the box : Bus 004
> > > Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> > > Dongle (HCI mode)
> <snip>
> > > < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> > > > HCI Event: Command Complete (0x0e) plen 12
> > > Read Local Version Information (0x04|0x0001) ncmd 1
> > > status 0x00
> > > HCI Version: 2.0 (0x3) HCI Revision: 0x3000
> > > LMP Version: 2.0 (0x3) LMP Subversion: 0x420b
> > > Manufacturer: Broadcom Corporation (15)
> > > < HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> > > > HCI Event: Command Complete (0x0e) plen 10
> > > Read BD ADDR (0x04|0x0009) ncmd 1
> > > status 0x00 bdaddr 00:19:86:00:19:C2
> > > < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > > > HCI Event: Command Complete (0x0e) plen 11
> > > Read Buffer Size (0x04|0x0005) ncmd 1
> > > status 0x00
> > > ACL MTU 1017:8 SCO MTU 64:0
> > > < HCI Command: Read Class of Device (0x03|0x0023) plen 0
> > > > HCI Event: Command Complete (0x0e) plen 7
> > > Read Class of Device (0x03|0x0023) ncmd 1
> > > status 0x00 class 0x000000
> > > < HCI Command: Read Local Name (0x03|0x0014) plen 0
> > > > HCI Event: Command Complete (0x0e) plen 252
> > > Read Local Name (0x03|0x0014) ncmd 1
> > > status 0x00 name 'BCM2045B'
>
> There is something very strange in this hardware if it's reporting
> Broadcom on HCI but CSR over USB. Considering that these two companies
> are competitors I'd be inclined to think this HW is by neither one, i.e.
> possibly counterfeit. This, combined with the fact that it's not
> compliant with the Bluetooth specification, is not very likely to
> inspire efforts to get it fixed.
>
> Johan
------=_Part_5433_373613556.1382385977285
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 
  <style type="text/css">.mceResizeHandle {position: absolute;border: 1px solid black;background: #FFF;width: 5px;height: 5px;z-index: 10000}.mceResizeHandle:hover {background: #000}img[data-mce-selected] {outline: 1px solid black}img.mceClonedResizable, table.mceClonedResizable {position: absolute;outline: 1px dashed black;opacity: .5;z-index: 10000}
</style>
 
 </head><body style="">
 
  <div>
   Hi
  </div> 
  <div>
   &#160;
  </div> 
  <div>
   It seems that i m not the only one in this situation and i managed to fix it by applying this pending patch :
  </div> 
  <div>
   https://bugzilla.kernel.org/show_bug.cgi?id=60824
  </div> 
  <div>
   &#160;
  </div> 
  <div>
   Thanks for your answer and time.
  </div> 
  <div>
   &#160;
  </div> 
  <div>
   <br />&#62; On October 21, 2013 at 3:20 PM Johan Hedberg &#60;johan.hedberg@gmail.com&#62; wrote:
   <br />&#62; 
   <br />&#62; 
   <br />&#62; Hi,
   <br />&#62; 
   <br />&#62; On Mon, Oct 21, 2013, Pavel Machek wrote:
   <br />&#62; &#62; &#62; old 2.0 as it was written &#34;Vista Compatible&#34; on the box : Bus 004
   <br />&#62; &#62; &#62; Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
   <br />&#62; &#62; &#62; Dongle (HCI mode)
   <br />&#62; &#60;snip&#62;
   <br />&#62; &#62; &#62; &#60; HCI Command: Read Local Version Information (0x04|0x0001) plen 0
   <br />&#62; &#62; &#62; &#62; HCI Event: Command Complete (0x0e) plen 12
   <br />&#62; &#62; &#62; Read Local Version Information (0x04|0x0001) ncmd 1
   <br />&#62; &#62; &#62; status 0x00
   <br />&#62; &#62; &#62; HCI Version: 2.0 (0x3) HCI Revision: 0x3000
   <br />&#62; &#62; &#62; LMP Version: 2.0 (0x3) LMP Subversion: 0x420b
   <br />&#62; &#62; &#62; Manufacturer: Broadcom Corporation (15)
   <br />&#62; &#62; &#62; &#60; HCI Command: Read BD ADDR (0x04|0x0009) plen 0
   <br />&#62; &#62; &#62; &#62; HCI Event: Command Complete (0x0e) plen 10
   <br />&#62; &#62; &#62; Read BD ADDR (0x04|0x0009) ncmd 1
   <br />&#62; &#62; &#62; status 0x00 bdaddr 00:19:86:00:19:C2
   <br />&#62; &#62; &#62; &#60; HCI Command: Read Buffer Size (0x04|0x0005) plen 0
   <br />&#62; &#62; &#62; &#62; HCI Event: Command Complete (0x0e) plen 11
   <br />&#62; &#62; &#62; Read Buffer Size (0x04|0x0005) ncmd 1
   <br />&#62; &#62; &#62; status 0x00
   <br />&#62; &#62; &#62; ACL MTU 1017:8 SCO MTU 64:0
   <br />&#62; &#62; &#62; &#60; HCI Command: Read Class of Device (0x03|0x0023) plen 0
   <br />&#62; &#62; &#62; &#62; HCI Event: Command Complete (0x0e) plen 7
   <br />&#62; &#62; &#62; Read Class of Device (0x03|0x0023) ncmd 1
   <br />&#62; &#62; &#62; status 0x00 class 0x000000
   <br />&#62; &#62; &#62; &#60; HCI Command: Read Local Name (0x03|0x0014) plen 0
   <br />&#62; &#62; &#62; &#62; HCI Event: Command Complete (0x0e) plen 252
   <br />&#62; &#62; &#62; Read Local Name (0x03|0x0014) ncmd 1
   <br />&#62; &#62; &#62; status 0x00 name &#39;BCM2045B&#39;
   <br />&#62; 
   <br />&#62; There is something very strange in this hardware if it&#39;s reporting
   <br />&#62; Broadcom on HCI but CSR over USB. Considering that these two companies
   <br />&#62; are competitors I&#39;d be inclined to think this HW is by neither one, i.e.
   <br />&#62; possibly counterfeit. This, combined with the fact that it&#39;s not
   <br />&#62; compliant with the Bluetooth specification, is not very likely to
   <br />&#62; inspire efforts to get it fixed.
   <br />&#62; 
   <br />&#62; Johan
  </div>
 
</body></html>
------=_Part_5433_373613556.1382385977285--
