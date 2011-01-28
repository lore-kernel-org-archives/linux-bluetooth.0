Return-Path: <cyrus@holtmann.org>
From: "Inga Stotland" <ingas@codeaurora.org>
To: "'Vinicius Costa Gomes'" <vinicius.gomes@openbossa.org>
Cc: <linux-bluetooth@vger.kernel.org>
References: <001c01cb931d$dc4cb3a0$94e61ae0$@org> <20101203220534.GA16709@eris> <1295895817.2656.26.camel@ubuntuLab1> <20110124213429.GA15121@piper>
In-Reply-To: <20110124213429.GA15121@piper>
Subject: GATT and D-Bus
Date: Fri, 28 Jan 2011 15:19:22 -0800
Message-ID: <000101cbbf41$cc0cee10$6426ca30$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicus,

Not sure who to ask, but it seems that you are the active contributor to the
part of the code that I am interested in :)
I am looking at using D-Bus to talk to GATT just over BR/EDR. The support
for that seems to be partially there ( I am working off the current bluez
tip). However, in the current code it does not seem possible to get GATT
over D-Bus working if the device is not LE. Am I missing something here?
Also, I can see that you were sending GATT patches upstream: "[PATCH 00/18]
Making GATT a first class citizen", not all of them have been pushed
through. Are you planning on re-submitting the changes?

Thank you,

Inga Stotland

ingas@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum




