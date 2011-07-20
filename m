Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Gustavo Padovan <padovan@profusion.mobi>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 20 Jul 2011 07:03:50 +0200
Subject: RE: [PATCH] Bluetooth : Added more testing options to l2test
Message-ID: <7769C83744F2C34A841232EF77AEA20C01D3E545D1@dnce01.ent.ti.com>
References: <1311080951-15820-1-git-send-email-chen.ganir@ti.com>
 <20110719143403.GA9194@joana>
In-Reply-To: <20110719143403.GA9194@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Gustavo,


> -----Original Message-----
> From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of
> Gustavo Padovan
> Sent: Tuesday, July 19, 2011 5:34 PM
> To: chen.ganir@gmail.com
> Cc: linux-bluetooth@vger.kernel.org; Ganir, Chen
> Subject: Re: [PATCH] Bluetooth : Added more testing options to l2test
> 
> Hi Chen,
> 
> * chen.ganir@gmail.com <chen.ganir@gmail.com> [2011-07-19 16:09:11
> +0300]:
> 
> > From: Chen Ganir <chen.ganir@ti.com>
> >
> > Added more options to allow passing ERTM L2CAP PTS tests. The
> > options allow to delay between a connection is made and the
> > first sent frame,a delay between the last sent frame and
> > disocnnection,and the ability to run as "one-shot" instead of
> > listening for more connections.
> 
> I never needed such change to pass all ERTM PTS tests. Check if the -D
> and -C
> options can help you.
> 
> 	Gustavo

The PTS expects the IUT to behave exactly as required by the test scenario.
This means that if doing something out of the ordinary, it will fail the test.

For example, if after the connection we start sending messages directly, it
will fail, because the script is not yet ready for incoming packets. If we 
disconnect the link too early, the test will also fail. If we keep listening
for more incoming connections, we will not close the channel correctly, and
the test will also fail.
To be more specific - for example, the following tests required the delay :
TC_ERM_BV_01_C
TC_ERM_BV_08_C
TC_ERM_BV_18_C
TC_ERM_BV_19_C
TC_ERM_BV_20_C
TC_ERM_BV_21_C
These tests required the IUT to start sending data after the connection was
established. Starting to send too early caused the tests to fail.

The one shot option was required to allow the IUT to disconnect the ACL at the 
end of the test (as required by the PTS tests TC_ERM_BV_11_C and TC_ERM_BV_12_C).
For this, I needed the l2test to exit upon completion, so I can disconnect the 
link using the hcitool (in a simple shell script).

If you have any other ideas or recommendation on how to pass these tests, I 
would be happy to hear.
 

Thanks,
Chen Ganir

