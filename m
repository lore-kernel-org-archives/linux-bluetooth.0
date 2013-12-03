Return-Path: <cyrus@holtmann.org>
Message-ID: <529E18ED.3040701@laurendeau.net>
Date: Tue, 03 Dec 2013 18:46:21 +0100
From: Mathieu Laurendeau <mathieu@laurendeau.net>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Missing BT_POWER option for l2cap sockets in bluetooth.h?
References: <529CEC22.60107@laurendeau.net> <20131203092228.GA9498@x220.p-661hnu-f1>
In-Reply-To: <20131203092228.GA9498@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 03, 2013, Johan Hedberg wrote:
> What are you planning to use this for?
I'm working on a software [1] that can make a PC take the identity of a 
Sixaxis and control a PS3 over bluetooth. It worked fine until kernel 
3.1 from which there was a connection issue (a variable latency of at 
least 4s). I tried tweaking the flush timeout, but it was not 
concluding. Lately I took a look at the kernel source code and saw the 
BT_POWER option was introduced in kernel 3.1. I turned it off and the 
latency disappeared.

Thanks for the patch,

Mathieu

[1] https://github.com/matlo/GIMX
