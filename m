Return-Path: <cyrus@holtmann.org>
Message-ID: <4EE1213F.1090303@codeaurora.org>
Date: Thu, 08 Dec 2011 12:42:39 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: mindentropy <mindentropy@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Regarding setting baud rate for RFCOMM.
References: <2121084.BaNgyA18vB@terranet>
In-Reply-To: <2121084.BaNgyA18vB@terranet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi mindentropy,

On 12/8/2011 12:12 PM, mindentropy wrote:
>    How can I set the baud rate and other tty settings for RFCOMM for data
> sending? The receiving application is a windows application which reads at
> 115200 baud rate via virtual comm port.

Baud rate does not really apply to RFCOMM in bluetooth. Baud rate refers 
to how fast the level shifters on a piece of UART hardware (perhaps 
RS232) transition between one bit to the next, while RFCOMM simply grabs 
data (in the case of bluez, through a pipe or socket) and sends it over 
the BT link at whatever rate the underlying ACL connection currently 
supports, which constantly is changing to based on environmental conditions.

The RFCOMM transport in BT is intended to be a simplified way to migrate 
an existing UART based application to bluetooth.

But in fact, if you were to create a UART abstraction on top of RFCOMM 
which did accept baud rate as a parameter, it would not matter if you 
set the BAUD to 300, 115200, or 921600 -- The data would flow at a rate 
that you would not be able to directly control.  Other than that, it 
would generally mimic "classic" RS-232.  In other words, you shouldn't 
need to do anything to your Windows App, as long as it is currently able 
to send and receive data via the virtual comm port.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
