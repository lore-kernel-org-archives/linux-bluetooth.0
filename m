Return-Path: <cyrus@holtmann.org>
Message-ID: <507D7480.6040205@schulz.dk>
Date: Tue, 16 Oct 2012 16:51:44 +0200
From: Kim Schulz <kim@schulz.dk>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: gatttool and multiple devices connected
References: <507D6F26.8040306@schulz.dk> <CAJdJm_NZwNbLwAHNj7JVPVKK2eBe90AeqPRFfqD0Rqr9=bWpNg@mail.gmail.com>
In-Reply-To: <CAJdJm_NZwNbLwAHNj7JVPVKK2eBe90AeqPRFfqD0Rqr9=bWpNg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/16/2012 04:45 PM, Anderson Lizardo wrote:
> Which kernel version are you running? Older kernels had a LE 
> connection routing issue which I believe was fixed long ago. And what 
> do you mean with not being able to get services? which error did you 
> get? Do you have hcidump logs from these sessions? Regards, 

The Bluez code is one taken from git a few days ago. I don't recall 
which kernel version (will have to check at the office tomorrow) but it 
is one of the latest that we compiled for this test.
We do have some logs of the session and I will be looking at those more 
thoroughly tomorrow.

kim
