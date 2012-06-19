Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8C91AD8ED4077A4786B341540858992510269B87@SHSMSX102.ccr.corp.intel.com>
References: <8C91AD8ED4077A4786B341540858992510269B2E@SHSMSX102.ccr.corp.intel.com>
	<CAJ2qBzax4SvTfS-tykhh7UAYzqxKuXfhpfYS97n4=w2BcutkVw@mail.gmail.com>
	<8C91AD8ED4077A4786B341540858992510269B87@SHSMSX102.ccr.corp.intel.com>
Date: Tue, 19 Jun 2012 11:12:31 +0100
Message-ID: <CAJ2qBzaEwdEFxFuUkysN62ago8SELxg8v_FMZkmwoYuNF+Kfsg@mail.gmail.com>
Subject: Re: BT DUN Server fails to work (seems blocked in RFCOMM)
From: Dean Jenkins <djenkins@mvista.com>
To: "Zhang, Jingke" <jingke.zhang@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 19 June 2012 10:48, Zhang, Jingke <jingke.zhang@intel.com> wrote:
> Hi Jenkins,
> I saw first SABM interaction seems ok in the hcidump log. Do not know why it has problem in second arrival SABM.
>
> 2012-06-20 17:52:13.037312 > ACL data: handle 12 flags 0x02 dlen 8
>    L2CAP(d): cid 0x0041 len 4 [psm 3]
>      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> 2012-06-20 17:52:13.037473 < ACL data: handle 12 flags 0x00 dlen 8
>    L2CAP(d): cid 0x0041 len 4 [psm 3]
>      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> 2012-06-20 17:52:13.064287 > ACL data: handle 12 flags 0x02 dlen 18
>    L2CAP(d): cid 0x0041 len 14 [psm 3]
>      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>
This is establishment of the rfcomm control channel. Each rfcomm
session needs a control channel (channel number zero). The DUN
connection will use a rfcomm data channel (channel number not zero).

You can ask question on IRC chat on irc.freenode.net chat room #bluez.

Dean

-- 
Dean Jenkins
Embedded Software Engineer
Professional Services UK/EMEA
MontaVista Software, LLC
