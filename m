Return-Path: <cyrus@holtmann.org>
Message-ID: <4B3220D1.3000107@csr.com>
Date: Wed, 23 Dec 2009 13:53:21 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Getting/setting Inquiry trasmit power level unsolved
References: <c6e9632c0911131047s565cc191w84d22bc1dff710a0@mail.gmail.com>	 <1258286232.3299.27.camel@violet>	 <c6e9632c0911170853g5ef4061cr75c42c71a1a87b7d@mail.gmail.com>	 <1258491418.2003.37.camel@violet>	 <c6e9632c0911171318l1b60fa85h55b3e6083777d516@mail.gmail.com>	 <c6e9632c0911180959p3e56668aqc298a673baea7350@mail.gmail.com>	 <1258568114.2003.128.camel@violet>	 <c6e9632c0911271011p1268ee8ek16e389fc779e0d77@mail.gmail.com>	 <c6e9632c0912140824m5650d242w8296dd756943993f@mail.gmail.com> <1260813314.4041.17.camel@localhost.localdomain>
In-Reply-To: <1260813314.4041.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> Natale Vinto wrote:
>> I finally got the Belkin F8T016, linked from CSR website (
>> http://www.csr.com/applications/qual-mod.php?catID=14 ) as qualified
>> end product with CSR's BlueCore chip.
[...]
>> The output is always the same:
>>
>> # hciconfig hci0
>> hci0:   Type: USB
>>         BD Address: 00:0A:3A:xx:xx:xx ACL MTU: 1021:8 SCO MTU: 64:1

I can tell from the ACL MTU that's not one of ours.

I have heard rumours (probably on this mailing list) that OEMs
sometimes change the chipset they use in devices without telling
anyone.

Isn't there some option to hciconfig that dumps the manufacturer ID
and firmware version (maybe hciconfig hci0 version)?
-- 
Steven Singer
Software Engineer
Cambridge Silicon Radio Ltd. Tel: +44 (0)1223 692000 Fax: +44 (0)1223 692001
Churchill House, Cambridge Business Park, Cowley Road, Cambridge CB4 0WZ, UK


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
