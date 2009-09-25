Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Sep 2009 08:38:21 +0100 (BST)
To: Nick Davies <nickavies@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Volume control for headset
In-Reply-To: <418098.94079.qm@web112804.mail.gq1.yahoo.com>
References: <418098.94079.qm@web112804.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1253864301.981724.225.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 24 Sep 2009, Nick Davies wrote:

>    I've tried to control the headset's volume via the volume control on
> my platform. I am curious about how the headset's volume is controlled?
> Just send some special bluetooth packets to the headset, and then change
> some registers related with volume control of the headset?

Yes, it uses a straight serial (over RFCOMM) link with commands/responses
being sent each way in plaintext. eg from Audio Gateway (computer) to
Headset:

+VGS=n

set headset speaker volume (0-15)

+VGM=n

set headset microphone gain (0-15)

>       Any explanations are welcome!

You can find more information in the "Headset Profile" specification at
www.bluetooth.com

regards,
iain


