Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "Zhang, Jingke" <jingke.zhang@intel.com>,
	Frederic Danis <frederic.danis@linux.intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: BT DUN Server fails to work (seems blocked in RFCOMM)
Date: Wed, 20 Jun 2012 06:49:49 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E0FD778F2@SHSMSX102.ccr.corp.intel.com>
References: <8C91AD8ED4077A4786B341540858992510269B2E@SHSMSX102.ccr.corp.intel.com>
 <4FE05A21.9060406@linux.intel.com>
 <8C91AD8ED4077A4786B34154085899251026A19B@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <8C91AD8ED4077A4786B34154085899251026A19B@SHSMSX102.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I check the issue of DUN response "security block". 

If we set ssp mode to 0, the issue does not exist (hci_conn_check_link_mode return 1 in hci_conn.c).

However, why DUN connect cannot pass hci_conn_check_link_mode and FTP connect can pass hci_conn_check_link_mode?

Best regards
Zheng wu

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org
> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Zhang, Jingke
> Sent: Wednesday, June 20, 2012 1:24 PM
> To: Frederic Danis
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: BT DUN Server fails to work (seems blocked in RFCOMM)
> 
> Hi Danis,
> I rebuild my bluez again without "--enable-pnat" in bootstrap-configure. Now,
> my sdp result shows ONLY ONE "Dial-up Networking" service. It is from ofonod.
> 
> Retest this case. It reports "Security block" after DUN server gets "Dial-up
> Networking" record. The hcidump will be attached in bug ---
> https://bugs.meego.com/show_bug.cgi?id=25303 .
> At this time, I tried a FTP case (to prove pairing is OK), FTP passed.
> 
> So, I suspect DUN response "security block" may be due to DUN service itself,
> which is provided by ofonod. Please help to check it. Thanks!
> 
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org
> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Frederic Danis
> Sent: Tuesday, June 19, 2012 6:53 PM
> To: Zhang, Jingke
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: BT DUN Server fails to work (seems blocked in RFCOMM)
> 
> Hello
> 
> On 19/06/2012 11:11, Zhang, Jingke wrote:
> > Hi all,
> > Does any guys try DUN server with bluez?
> >
> > My telephone stack is ofono and its DUN server code should be ready in its
> commit. However, the problem is my DUN activation request almost did not
> come to ofono side (only to bluez RFCOMM). On the DUN Client, I can use same
> validation step to active a mobile phone (Sony-Ericson C905) to connect to
> 2G/3G network.
> >
> > I filed a bug https://bugs.meego.com/show_bug.cgi?id=25303 to track all
> logs.
> >
> > Could you help to see what's the problem?
> >
> > Thanks
> > Jingke
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> Your hcidump shows 2 SDP records for DUN profile.
> 
> Guillaume Zajac and I found the same problem yesterday, and reply about it on
> oFono mailing list (see "Re: oFono DUN server issue" mails).
> 
> It seems that BlueZ was compiled with embedded DUN server (configure
> option --enable-pnat).
> When both BlueZ and oFono are started, they both listen for incoming
> connection on RFCOMM port 1 (try "sdptool browse local" to check), and
> embedded BlueZ DUN server reply preventing oFono to manage this
> connection.
> 
> If you remove the embedded DUN server by removing --enable-pnat from build
> configuration, it should work.
> 
> Fred
> 
> --
> Frederic Danis                            Open Source Technology
> Center
> frederic.danis@intel.com                              Intel
> Corporation
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
