Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Jan 2011 21:07:52 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: GATT and D-Bus
Message-ID: <20110129000752.GA23931@piper>
References: <001c01cb931d$dc4cb3a0$94e61ae0$@org>
 <20101203220534.GA16709@eris>
 <1295895817.2656.26.camel@ubuntuLab1>
 <20110124213429.GA15121@piper>
 <000101cbbf41$cc0cee10$6426ca30$@org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000101cbbf41$cc0cee10$6426ca30$@org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On 15:19 Fri 28 Jan, Inga Stotland wrote:
> Hi Vinicus,
> 
> Not sure who to ask, but it seems that you are the active contributor to the
> part of the code that I am interested in :)
> I am looking at using D-Bus to talk to GATT just over BR/EDR. The support
> for that seems to be partially there ( I am working off the current bluez
> tip). However, in the current code it does not seem possible to get GATT
> over D-Bus working if the device is not LE. Am I missing something here?
> Also, I can see that you were sending GATT patches upstream: "[PATCH 00/18]
> Making GATT a first class citizen", not all of them have been pushed
> through. Are you planning on re-submitting the changes?

Those patches are already upstream, it was just that the "applied" message 
came via IRC.

What is missing for the BR/EDR case is that we need to trigger GATT Service
Discovery after the SDP Browse, if the Device has the GATT Service Record.

SMP is still taking a lot of my time, that I didn't have the time to go back
and solve this issue, but it is still on the top of my todo list ;-)

> 
> Thank you,
> 
> Inga Stotland
> 
> ingas@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> 
> 
> 

Cheers,
-- 
Vinicius
