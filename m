Return-Path: <cyrus@holtmann.org>
Message-ID: <4FE05A21.9060406@linux.intel.com>
Date: Tue, 19 Jun 2012 12:53:21 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: "Zhang, Jingke" <jingke.zhang@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: BT DUN Server fails to work (seems blocked in RFCOMM)
References: <8C91AD8ED4077A4786B341540858992510269B2E@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <8C91AD8ED4077A4786B341540858992510269B2E@SHSMSX102.ccr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

On 19/06/2012 11:11, Zhang, Jingke wrote:
> Hi all,
> Does any guys try DUN server with bluez?
>
> My telephone stack is ofono and its DUN server code should be ready in its commit. However, the problem is my DUN activation request almost did not come to ofono side (only to bluez RFCOMM). On the DUN Client, I can use same validation step to active a mobile phone (Sony-Ericson C905) to connect to 2G/3G network.
>
> I filed a bug https://bugs.meego.com/show_bug.cgi?id=25303 to track all logs.
>
> Could you help to see what's the problem?
>
> Thanks
> Jingke
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Your hcidump shows 2 SDP records for DUN profile.

Guillaume Zajac and I found the same problem yesterday, and reply about 
it on oFono mailing list (see "Re: oFono DUN server issue" mails).

It seems that BlueZ was compiled with embedded DUN server (configure 
option --enable-pnat).
When both BlueZ and oFono are started, they both listen for incoming 
connection on RFCOMM port 1 (try "sdptool browse local" to check), and 
embedded BlueZ DUN server reply preventing oFono to manage this connection.

If you remove the embedded DUN server by removing --enable-pnat from 
build configuration, it should work.

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

