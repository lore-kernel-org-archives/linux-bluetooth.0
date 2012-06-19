Return-Path: <cyrus@holtmann.org>
From: "Zhang, Jingke" <jingke.zhang@intel.com>
To: Dean Jenkins <djenkins@mvista.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: BT DUN Server fails to work (seems blocked in RFCOMM)
Date: Tue, 19 Jun 2012 09:48:23 +0000
Message-ID: <8C91AD8ED4077A4786B341540858992510269B87@SHSMSX102.ccr.corp.intel.com>
References: <8C91AD8ED4077A4786B341540858992510269B2E@SHSMSX102.ccr.corp.intel.com>
 <CAJ2qBzax4SvTfS-tykhh7UAYzqxKuXfhpfYS97n4=w2BcutkVw@mail.gmail.com>
In-Reply-To: <CAJ2qBzax4SvTfS-tykhh7UAYzqxKuXfhpfYS97n4=w2BcutkVw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jenkins,
I saw first SABM interaction seems ok in the hcidump log. Do not know why it has problem in second arrival SABM. 

2012-06-20 17:52:13.037312 > ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
2012-06-20 17:52:13.037473 < ACL data: handle 12 flags 0x00 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
2012-06-20 17:52:13.064287 > ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8

-----Original Message-----
From: Dean Jenkins [mailto:djenkins@mvista.com] 
Sent: Tuesday, June 19, 2012 5:39 PM
To: Zhang, Jingke
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BT DUN Server fails to work (seems blocked in RFCOMM)

On 19 June 2012 10:11, Zhang, Jingke <jingke.zhang@intel.com> wrote:
> Hi all,
> Does any guys try DUN server with bluez?
>
> My telephone stack is ofono and its DUN server code should be ready in its commit. However, the problem is my DUN activation request almost did not come to ofono side (only to bluez RFCOMM). On the DUN Client, I can use same validation step to active a mobile phone (Sony-Ericson C905) to connect to 2G/3G network.
>
> I filed a bug https://bugs.meego.com/show_bug.cgi?id=25303 to track all logs.
>
> Could you help to see what's the problem?
>
Your hcidump shows:

2012-06-20 17:52:13.092287 > ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
2012-06-20 17:52:15.033302 > ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

rfcomm host side is sending is sending a SABM on DLCI 2. I guess this for the DUN rfcomm channel.

However it can be seen that a L2CAP disconnect request comes from the remote device so requests termination of the L2CAP link. I guess the remote device disconnected the connection for some reason.

> Thanks
> Jingke
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-bluetooth" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Dean Jenkins
Embedded Software Engineer
Professional Services UK/EMEA
MontaVista Software, LLC
