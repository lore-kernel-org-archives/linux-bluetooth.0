Return-Path: <cyrus@holtmann.org>
From: Mike Tsai <Mike.Tsai@Atheros.com>
To: Brian Gix <bgix@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 2 Dec 2010 17:21:32 -0800
Subject: RE: Are LE connections possible yet?
Message-ID: <35B17FE5076C7040809188FBE7913F98406D794075@SC1EXMB-MBCL.global.atheros.com>
References: <1291305728-3463-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
 <20101202162236.GA1291@jh-x301> <000001cb927b$08458e80$18d0ab80$@org>
In-Reply-To: <000001cb927b$08458e80$18d0ab80$@org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Brian Gix
Sent: Thursday, December 02, 2010 3:46 PM
To: linux-bluetooth@vger.kernel.org
Subject: Are LE connections possible yet?

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
[MTsai]which kernel driver you are using? It seems the kernel does not know the LE create connection OpCode?


Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum



--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
