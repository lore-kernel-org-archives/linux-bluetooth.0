Return-Path: <cyrus@holtmann.org>
Subject: Re: buffer starvation with multiple ACL link
From: Marcel Holtmann <marcel@holtmann.org>
To: suraj <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Luis.Rodriguez@Atheros.com,
	Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1273131932.2229.9.camel@atheros013-desktop>
References: <1268629296.21425.23.camel@atheros013-desktop>
	 <1271758832.6585.33.camel@atheros013-desktop>
	 <1271845337.15010.1.camel@atheros013-desktop>
	 <1271927414.1409.3.camel@atheros013-desktop>
	 <1272279623.11239.1.camel@atheros013-desktop>
	 <1273062798.19162.6.camel@atheros013-desktop>
	 <1273131932.2229.9.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 20 May 2010 18:02:54 +0200
Message-ID: <1274371374.27220.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

please never start a new thread that hangs of an existing thread. I do
will miss these and ignore. You need to fix your mailer setup.

> I am seeing a strange issue with multiple ACL connection with CSR chip.
> 
> I am having 2 ACL link, one with FTP going on and another streaming
> A2DP. 
> The moment the A2DP link goes out of range ,I see that the FTP also
> stops. It resumes as soon as A2DP comes back in range.
> 
> On further analysis I could verify that since the A2DP link is
> blocked( due to remote being OoR) the controller's ACL buffers with A2DP
> data are stuck. 
> But at the host level this is not considered and Bluez keeps sending
> A2DP data until it blocks all the ACL buffers which in turns blocks FTP
> also.
> 
> I was expecting controller to flush these packets sometime and free the
> A2DP buffers. Not sure, what is the default Flush timeout value.

We don't have anything as of now that could fix this. I would need more
details on this since it might be some outdated firmware or known bug in
the controller. Please start a proper new thread with details about the
hardware you are using and which software versions.

Regards

Marcel


