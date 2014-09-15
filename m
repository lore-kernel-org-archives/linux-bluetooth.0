Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: 
References: 
Subject: Wrong selection of audio source during handsfree call
From: Vinod Rayapudi <vinod.rayapudi@tcs.com>
To: linux-bluetooth-owner@vger.kernel.org, autoanswer@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Message-ID: <OF5483DA9E.1F5616FD-ON65257D54.0049847E-65257D54.00498481@tcs.com>
Date: Mon, 15 Sep 2014 18:53:00 +0530
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have connected my iPhone with both A2DP and Handsfree profiles.
Whenever there is a, I can't hear audio on speakers.
When I check, pulse audio sources (pacmd list-sources), I can see there is wrong selection audio source.

If both A2DP and HFP profiles are connected, during call always I can see audio streaming parameters instead of SCO related parameters.

I am using Ubuntu 12.04 and OFono 1.0.

Can anyone help me on this ?
Is this an issue with Bluez or OFono ?

Thanks & Regards,
Vinod.
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you



