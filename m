Return-Path: <cyrus@holtmann.org>
From: "Brian Gix" <bgix@codeaurora.org>
To: <linux-bluetooth@vger.kernel.org>
References: <1291305728-3463-1-git-send-email-ext-jablonski.radoslaw@nokia.com> <20101202162236.GA1291@jh-x301>
In-Reply-To: <20101202162236.GA1291@jh-x301>
Subject: Are LE connections possible yet?
Date: Thu, 2 Dec 2010 15:45:42 -0800
Message-ID: <000001cb927b$08458e80$18d0ab80$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am bringing up an LE capable (BR/EDR/LE) baseband, and attempting to use
it to establish a
GATT/ATT connection over an LE link.  However when executing the command:

% ./tools/hcitool lecc 00:14:BB:55:66:77

I get a very rapid failure of:

"Could not create connection: Operation not permitted"

The correct HCI command does not appear to be making it to the BR/EDR/LE
baseband.

It appears to be a socket issue of some sort.  I can cause this error, when
attached to the baseband, and:
"Could not create connection: File descriptor in bad state"

if I have not yet run hciattach.

Other (BR/EDR) hcitool commands work as expected, such as "hcitool scan" and
"hcitool inq"

Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum



