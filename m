Return-Path: <cyrus@holtmann.org>
Subject: buffer starvation with multiple ACL link
From: suraj <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Luis.Rodriguez@Atheros.com>, <Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <1273062798.19162.6.camel@atheros013-desktop>
References: <1268629296.21425.23.camel@atheros013-desktop>
	 <1271758832.6585.33.camel@atheros013-desktop>
	 <1271845337.15010.1.camel@atheros013-desktop>
	 <1271927414.1409.3.camel@atheros013-desktop>
	 <1272279623.11239.1.camel@atheros013-desktop>
	 <1273062798.19162.6.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 6 May 2010 13:15:32 +0530
Message-ID: <1273131932.2229.9.camel@atheros013-desktop>
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am seeing a strange issue with multiple ACL connection with CSR chip.

I am having 2 ACL link, one with FTP going on and another streaming
A2DP. 
The moment the A2DP link goes out of range ,I see that the FTP also
stops. It resumes as soon as A2DP comes back in range.

On further analysis I could verify that since the A2DP link is
blocked( due to remote being OoR) the controller's ACL buffers with A2DP
data are stuck. 
But at the host level this is not considered and Bluez keeps sending
A2DP data until it blocks all the ACL buffers which in turns blocks FTP
also.

I was expecting controller to flush these packets sometime and free the
A2DP buffers. Not sure, what is the default Flush timeout value.

Do we have any patch for this issue?

Regards
Suraj

