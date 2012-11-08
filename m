Return-Path: <cyrus@holtmann.org>
Message-id: <509BB56A.80609@samsung.com>
Date: Thu, 08 Nov 2012 14:36:42 +0100
From: Michael Knudsen <m.knudsen@samsung.com>
MIME-version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: CSA2:  User space aspect
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm currently looking into CSA2 and how it should be exposed to user
space applications, so I want to make sure I am not duplicating any
existing effort in this area.

I've been doing some prestudying and my current thought is to expose
this as socket options for the following parameters:

	Transmit_Coding_Format
	Receive_Coding_Format

	Input_Coding_Format
	Output_Coding_Format

	Input_Data_Path
	Output_Data_Path

If anyone else has an ideas or opinions about this, please speak up,
otherwise I'll try coming up with an interface specification with
more details.

-m.
